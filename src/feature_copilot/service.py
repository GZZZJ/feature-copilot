import json
import re
import sqlite3
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

from .errors import NotFoundError, ValidationError
from .normalizers import name_inference
from .repository import Repository
from .sql_materialization import find_materializations


class FeatureService:
    def __init__(self, database_path: Path):
        self.repository = Repository(database_path)
        try:
            policy = self.repository.row("SELECT value FROM metadata WHERE key='standard_warehouse_policy'").get("value", "{}")
        except sqlite3.OperationalError as error:
            if "no such table: metadata" not in str(error).lower():
                raise
            # Older read-only indexes and small embedded clients predate policy
            # metadata.  Preserve their query compatibility with an empty policy.
            policy = "{}"
        try:
            self._standard_warehouse_policy = json.loads(policy)
        except (TypeError, ValueError):
            self._standard_warehouse_policy = {}
        try:
            taxonomy_value = self.repository.row(
                "SELECT value FROM metadata WHERE key='managed_feature_taxonomy'"
            ).get("value", "{}")
        except sqlite3.OperationalError as error:
            if "no such table: metadata" not in str(error).lower():
                raise
            taxonomy_value = "{}"
        try:
            self._managed_feature_taxonomy = json.loads(taxonomy_value)
        except (TypeError, ValueError):
            self._managed_feature_taxonomy = {}
        self._semantic_tables_available = bool(self.repository.row(
            "SELECT 1 AS found FROM sqlite_master WHERE type='table' AND name='managed_feature_semantics'"
        )) and bool(self.repository.row(
            "SELECT 1 AS found FROM sqlite_master WHERE type='table' AND name='managed_feature_tags'"
        )) and "feature_id" in {row["name"] for row in self.repository.rows("PRAGMA table_info(managed_feature_semantics)")}
        self._semantic_metadata_cache: Optional[Dict[str, Dict[str, Any]]] = None
        self._semantic_search_texts_cache: Optional[List[str]] = None
        self._usage_governance_tables_available = bool(self.repository.row(
            "SELECT 1 AS found FROM sqlite_master WHERE type='table' AND name='managed_feature_usage_governance'"
        ))
        self._unmatched_usage_governance_tables_available = bool(self.repository.row(
            "SELECT 1 AS found FROM sqlite_master WHERE type='table' AND name='managed_unmatched_usage_governance'"
        ))
        self._usage_governance_cache: Optional[Dict[str, Dict[str, Any]]] = None
        self._inline_nodes_by_table: Optional[Dict[str, Any]] = None

    def close(self) -> None:
        self.repository.close()

    @staticmethod
    def _version_key(value: str) -> Tuple[int, ...]:
        values = []
        for part in (value or "").split("."):
            try: values.append(int(part))
            except ValueError: values.append(0)
        return tuple(values)

    def _feature_candidates(self, name: str, version: Optional[str] = None) -> List[Dict[str, Any]]:
        rows = self.repository.rows("SELECT * FROM features WHERE lower(feature_name)=lower(?)" + (" AND version=?" if version else ""), (name, version) if version else (name,))
        return sorted(rows, key=lambda item: (item["status"] == "active", self._version_key(item["version"])), reverse=True)

    def get(self, feature_name: str, version: Optional[str] = None) -> Dict[str, Any]:
        managed = self._managed_candidates(feature_name)
        if managed:
            if len(managed) > 1:
                return {"status": "AMBIGUOUS", "feature_name": feature_name, "candidates": managed, "resolution": "provide featureCode for an exact result"}
            return self._managed_detail(managed[0])
        candidates = self._feature_candidates(feature_name, version)
        if not candidates:
            return {"status": "NOT_FOUND", "feature_name": feature_name, "verified": False, "formal_definition": None, "inferred_from_name": name_inference(feature_name), "usage_governance": self._unmatched_usage_governance(feature_name)}
        if version is None:
            active = [item for item in candidates if item["status"] == "active"]
            if active: candidates = active
        highest = self._version_key(candidates[0]["version"])
        tied = [item for item in candidates if self._version_key(item["version"]) == highest]
        if len(tied) > 1 or (version is None and len([item for item in candidates if item["status"] == "active"]) > 1):
            return {"status": "AMBIGUOUS", "feature_name": feature_name, "candidates": candidates}
        feature = candidates[0]
        return self._detail(feature)

    def _managed_candidates(self, value: str) -> List[Dict[str, Any]]:
        exact = self.repository.rows("SELECT * FROM managed_features WHERE lower(feature_code)=lower(?)", (value,))
        if exact:
            return exact
        return self.repository.rows("SELECT * FROM managed_features WHERE lower(feature_column_name)=lower(?) OR lower(feature_name)=lower(?) ORDER BY feature_code", (value, value))

    def _managed_detail(self, feature: Dict[str, Any]) -> Dict[str, Any]:
        logic = self.repository.row("SELECT group_code, logic_version, modify_time, last_modifier, source_path, source_hash FROM group_logic WHERE group_code=?", (feature["group_code"],))
        coverage = self.repository.row("SELECT * FROM logic_coverage WHERE feature_code=?", (feature["feature_code"],))
        derivation = self.repository.row("SELECT * FROM column_derivations WHERE feature_code=?", (feature["feature_code"],))
        scopes = self.repository.rows("SELECT package_name, feature_category FROM managed_feature_scopes WHERE feature_code=? ORDER BY package_name", (feature["feature_code"],))
        semantic = self._semantic_metadata(feature["feature_code"])
        return {"status": "OK", "verified": False, "record_type": "managed_feature", "feature": {**feature, "packages": [item["package_name"] for item in scopes], "feature_categories": sorted({item["feature_category"] for item in scopes})},
                "logic": {"coverage": coverage, "derivation": derivation, "group_logic": logic},
                "evidence": {"feature_source": feature["source_path"], "group_logic_source": logic.get("source_path", "")},
                "semantic_metadata": semantic, "usage_governance": self._usage_governance(feature["feature_code"]), "matched_tags": [], "match_sources": ["exact_feature"]}

    @staticmethod
    def _recommended_usage_governance() -> Dict[str, Any]:
        return {"usage_status": "recommended", "usage_label": "可使用", "is_recommended": True, "reason_code": "", "reason_label": "", "message": "", "source_ref": ""}

    def _usage_governance(self, feature_code: str) -> Dict[str, Any]:
        if not self._usage_governance_tables_available:
            return self._recommended_usage_governance()
        if self._usage_governance_cache is None:
            self._usage_governance_cache = {
                row.pop("feature_code"): {**row, "is_recommended": False}
                for row in self.repository.rows("SELECT * FROM managed_feature_usage_governance")
            }
        return self._usage_governance_cache.get(feature_code, self._recommended_usage_governance())

    def _unmatched_usage_governance(self, feature_column_name: str) -> Dict[str, Any]:
        if not self._unmatched_usage_governance_tables_available:
            return self._recommended_usage_governance()
        row = self.repository.row(
            "SELECT * FROM managed_unmatched_usage_governance WHERE lower(feature_column_name)=lower(?)",
            (feature_column_name,),
        )
        if not row:
            return self._recommended_usage_governance()
        row.pop("feature_column_name", None)
        return {**row, "is_recommended": False}

    @staticmethod
    def _empty_semantic_metadata() -> Dict[str, Any]:
        return {"alias_zh": "", "alias_source_type": "", "alias_confidence": "", "alias_evidence_ref": "", "summary_zh": "", "coverage": "untagged", "tags": [], "source_type": "", "confidence": "", "evidence_ref": ""}

    def _semantic_metadata(self, feature_code: str) -> Dict[str, Any]:
        if not self._semantic_tables_available:
            return self._empty_semantic_metadata()
        if self._semantic_metadata_cache is None:
            self._load_semantic_metadata_cache()
        return self._semantic_metadata_cache.get(feature_code, self._empty_semantic_metadata())

    def _load_semantic_metadata_cache(self) -> None:
        summaries = self.repository.rows(
            "SELECT features.feature_code, semantic.alias_zh, semantic.alias_source_type, semantic.alias_confidence, semantic.alias_evidence_ref, semantic.semantic_summary_zh, semantic.source_type, semantic.confidence, semantic.evidence_ref "
            "FROM managed_feature_semantics semantic JOIN managed_features features ON features.rowid=semantic.feature_id"
        )
        cache = {
            item["feature_code"]: {
                "alias_zh": item["alias_zh"], "alias_source_type": item["alias_source_type"],
                "alias_confidence": item["alias_confidence"], "alias_evidence_ref": item["alias_evidence_ref"],
                "summary_zh": item["semantic_summary_zh"], "coverage": "tagged", "tags": [],
                "source_type": item["source_type"], "confidence": item["confidence"],
                "evidence_ref": item["evidence_ref"],
            }
            for item in summaries
        }
        aliases_by_code: Dict[str, Dict[str, List[str]]] = {}
        for item in self.repository.rows(
            "SELECT tags.code, aliases.alias, aliases.alias_type FROM managed_tag_aliases aliases "
            "JOIN managed_tags tags ON tags.tag_id=aliases.tag_id ORDER BY tags.code, aliases.alias_type, aliases.alias"
        ):
            values = aliases_by_code.setdefault(item["code"], {"zh": [], "technical": []})
            if item["alias_type"] in values:
                values[item["alias_type"]].append(item["alias"])
        tags = self.repository.rows(
            "SELECT features.feature_code, tags.code, dimensions.code AS dimension, tags.name_zh, relations.metric_scope, "
            "relations.source_type, relations.confidence, relations.evidence_ref "
            "FROM managed_feature_tags relations "
            "JOIN managed_features features ON features.rowid=relations.feature_id "
            "JOIN managed_tags tags ON tags.tag_id=relations.tag_id "
            "JOIN managed_tag_dimensions dimensions ON dimensions.dimension_id=tags.dimension_id "
            "ORDER BY features.feature_code, dimensions.code, "
            "CASE relations.metric_scope WHEN 'primary' THEN 0 WHEN 'related' THEN 1 ELSE 2 END, tags.code"
        )
        for tag in tags:
            feature_code = tag.pop("feature_code")
            aliases = aliases_by_code.get(tag["code"], {"zh": [], "technical": []})
            tag["aliases_zh"] = aliases["zh"]
            tag["aliases_technical"] = aliases["technical"]
            if feature_code in cache:
                cache[feature_code]["tags"].append(tag)
        self._semantic_metadata_cache = cache

    def _resolve_tags(self, values: Iterable[str]) -> List[Dict[str, Any]]:
        requested = [str(value).strip() for value in values if str(value).strip()]
        if not requested:
            return []
        if not self._semantic_tables_available:
            raise ValidationError("semantic tags are unavailable in this index; rebuild the index")
        resolved: List[Dict[str, Any]] = []
        seen = set()
        for value in requested:
            rows = self.repository.rows(
                "SELECT tags.tag_id, tags.code, tags.name_zh, dimensions.code AS dimension "
                "FROM managed_tags tags JOIN managed_tag_dimensions dimensions "
                "ON dimensions.dimension_id=tags.dimension_id "
                "WHERE lower(tags.code)=lower(?) OR tags.name_zh=? ORDER BY tags.code",
                (value, value),
            )
            if not rows:
                raise ValidationError("unknown semantic tag (use code or Chinese standard name): " + value)
            if len(rows) > 1:
                raise ValidationError("ambiguous Chinese semantic tag name; use tag code: " + value)
            if rows[0]["code"] not in seen:
                seen.add(rows[0]["code"])
                resolved.append(rows[0])
        return resolved

    def list_tags(self, keywords: Iterable[str] = (), dimension: str = "", limit: int = 20, offset: int = 0) -> Dict[str, Any]:
        if not self._semantic_tables_available:
            return {"status": "OK", "total": 0, "limit": limit, "offset": offset, "items": [], "semantic_index": "unavailable"}
        if dimension and dimension not in {"feature_role", "business_stage", "business", "metric", "time", "derivation"}:
            raise ValidationError("invalid semantic dimension: " + dimension)
        terms = [str(value).strip() for value in keywords if str(value).strip()]
        where, params = [], []
        if dimension:
            where.append("dimensions.code=?"); params.append(dimension)
        for term in terms:
            where.append(
                "(lower(tags.code) LIKE lower(?) ESCAPE '\\' OR tags.name_zh LIKE ? ESCAPE '\\' "
                "OR EXISTS (SELECT 1 FROM managed_tag_aliases matching_alias "
                "WHERE matching_alias.tag_id=tags.tag_id AND lower(matching_alias.alias) LIKE lower(?) ESCAPE '\\'))"
            )
            pattern = self._like_contains(term); params.extend((pattern, pattern, pattern))
        clause = " WHERE " + " AND ".join(where) if where else ""
        base = " FROM managed_tags tags JOIN managed_tag_dimensions dimensions ON dimensions.dimension_id=tags.dimension_id"
        total = self.repository.row("SELECT COUNT(*) AS count" + base + clause, params)["count"]
        items = self.repository.rows(
            "SELECT tags.tag_id, tags.code, tags.name_zh, dimensions.code AS dimension, "
            "COUNT(DISTINCT relations.feature_id) AS feature_count" + base +
            " LEFT JOIN managed_feature_tags relations ON relations.tag_id=tags.tag_id" + clause +
            " GROUP BY tags.tag_id, tags.code, tags.name_zh, dimensions.code "
            "ORDER BY dimensions.code, tags.code LIMIT ? OFFSET ?", tuple(params) + (limit, offset),
        )
        for item in items:
            aliases = self.repository.rows(
                "SELECT alias, alias_type FROM managed_tag_aliases WHERE tag_id=? ORDER BY alias_type, alias",
                (item.pop("tag_id"),),
            )
            item["aliases_zh"] = [row["alias"] for row in aliases if row["alias_type"] == "zh"]
            item["aliases_technical"] = [row["alias"] for row in aliases if row["alias_type"] == "technical"]
        return {"status": "OK", "total": total, "limit": limit, "offset": offset, "items": items, "semantic_index": "available"}

    @staticmethod
    def _like_contains(value: str) -> str:
        """Return a LIKE pattern whose wildcard characters are treated literally."""
        escaped = (value or "").replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_")
        return "%" + escaped + "%"

    def list_managed_features(
        self,
        feature_key: str = "",
        feature_name: str = "",
        feature_category: str = "",
        business_subcategory: str = "",
        feature_group: str = "",
        feature_subcategory: str = "",
        limit: int = 50,
        offset: int = 0,
    ) -> Dict[str, Any]:
        """List only managed catalog features with stable, bounded pagination."""
        if isinstance(limit, bool) or not isinstance(limit, int) or not 1 <= limit <= 100:
            raise ValueError("limit must be an integer between 1 and 100")
        if isinstance(offset, bool) or not isinstance(offset, int) or not 0 <= offset <= (1 << 63) - 1:
            raise ValueError("offset must be a non-negative SQLite integer")
        where: List[str] = []
        params: List[Any] = []
        if feature_key:
            where.append("lower(feature_code) LIKE lower(?) ESCAPE '\\'")
            params.append(self._like_contains(feature_key))
        if feature_name:
            where.append("lower(feature_name) LIKE lower(?) ESCAPE '\\'")
            params.append(self._like_contains(feature_name))
        if feature_category:
            where.append(
                "EXISTS (SELECT 1 FROM managed_feature_scopes scope "
                "WHERE scope.feature_code=managed_features.feature_code "
                "AND scope.feature_category=?)"
            )
            params.append(feature_category)
        if business_subcategory:
            where.append("business_subcategory_code = ?")
            params.append(business_subcategory)
        if feature_group:
            where.append("group_code = ?")
            params.append(feature_group)
        if feature_subcategory:
            where.append("group_code = ?")
            params.append(feature_subcategory)
        clause = " WHERE " + " AND ".join(where) if where else ""
        total = self.repository.row("SELECT COUNT(*) AS count FROM managed_features" + clause, params)["count"]
        items = self.repository.rows(
            "SELECT * FROM managed_features" + clause + " ORDER BY feature_code ASC LIMIT ? OFFSET ?",
            tuple(params) + (limit, offset),
        )
        if feature_category:
            for item in items:
                item["feature_category"] = feature_category
        for item in items:
            item["usage_governance"] = self._usage_governance(item["feature_code"])
        return {"status": "OK", "total": total, "limit": limit, "offset": offset, "items": items}

    def list_managed_feature_taxonomy(self) -> Dict[str, Any]:
        """Return category/business-subcategory/group options and unique counts."""
        rows = self.repository.rows(
            """
            SELECT
                scope.feature_category,
                business_subcategory_code,
                MIN(business_subcategory_name) AS business_subcategory_name,
                MIN(business_subcategory_sort_order) AS business_subcategory_sort_order,
                COUNT(DISTINCT business_subcategory_name) AS business_subcategory_name_count,
                COUNT(DISTINCT business_subcategory_sort_order) AS business_subcategory_sort_order_count,
                group_code,
                MIN(CASE
                    WHEN group_name IS NOT NULL
                         AND trim(group_name) NOT IN ('', '-')
                    THEN group_name
                END) AS group_name,
                COUNT(DISTINCT managed_features.feature_code) AS count,
                COUNT(DISTINCT CASE
                    WHEN group_name IS NOT NULL
                         AND trim(group_name) NOT IN ('', '-')
                    THEN trim(group_name)
                END) AS group_name_count
            FROM managed_features
            JOIN managed_feature_scopes scope
              ON scope.feature_code=managed_features.feature_code
            GROUP BY scope.feature_category, business_subcategory_code, group_code
            ORDER BY scope.feature_category ASC, business_subcategory_sort_order ASC,
                     business_subcategory_code ASC, group_code ASC
            """
        )
        categories: List[Dict[str, Any]] = []
        categories_by_value: Dict[str, Dict[str, Any]] = {}
        subcategories_by_key: Dict[Tuple[str, str], Dict[str, Any]] = {}
        subcategory_facts: Dict[str, Tuple[str, int]] = {}
        group_names: Dict[str, str] = {}
        for row in rows:
            if int(row["business_subcategory_name_count"]) != 1:
                raise ValueError(
                    "inconsistent taxonomy: "
                    f"{row['feature_category']}/{row['business_subcategory_code']} has multiple names"
                )
            if int(row["business_subcategory_sort_order_count"]) != 1:
                raise ValueError(
                    "inconsistent taxonomy: "
                    f"{row['feature_category']}/{row['business_subcategory_code']} has multiple sort orders"
                )
            if int(row["group_name_count"]) > 1:
                raise ValueError(
                    "inconsistent taxonomy: "
                    f"{row['feature_category']}/{row['business_subcategory_code']}/{row['group_code']} has multiple group names"
                )
            subcategory_fact = (
                row["business_subcategory_name"],
                int(row["business_subcategory_sort_order"]),
            )
            previous_subcategory_fact = subcategory_facts.get(row["business_subcategory_code"])
            if previous_subcategory_fact and previous_subcategory_fact != subcategory_fact:
                raise ValueError(
                    "inconsistent taxonomy: "
                    f"{row['business_subcategory_code']} has conflicting name or sort order"
                )
            subcategory_facts[row["business_subcategory_code"]] = subcategory_fact
            valid_group_name = (row.get("group_name") or "").strip()
            previous_group_name = group_names.get(row["group_code"])
            if valid_group_name and previous_group_name and previous_group_name != valid_group_name:
                raise ValueError(
                    "inconsistent taxonomy: "
                    f"{row['group_code']} has multiple group names"
                )
            if valid_group_name:
                group_names[row["group_code"]] = valid_group_name
            category_value = row["feature_category"]
            category = categories_by_value.get(category_value)
            if category is None:
                category = {
                    "value": category_value,
                    "label": category_value,
                    "count": 0,
                    "subcategories": [],
                }
                categories_by_value[category_value] = category
                categories.append(category)
            count = int(row["count"])
            category["count"] += count
            subcategory_key = (category_value, row["business_subcategory_code"])
            subcategory = subcategories_by_key.get(subcategory_key)
            if subcategory is None:
                subcategory = {
                    "value": row["business_subcategory_code"],
                    "label": row["business_subcategory_name"],
                    "count": 0,
                    "groups": [],
                    "_sort_order": int(row["business_subcategory_sort_order"]),
                }
                subcategories_by_key[subcategory_key] = subcategory
                category["subcategories"].append(subcategory)
            subcategory["count"] += count
            subcategory["groups"].append({
                "value": row["group_code"],
                "label": row.get("group_name") or row["group_code"],
                "count": count,
            })
        for category in categories:
            category["subcategories"].sort(
                key=lambda item: (item["_sort_order"], item["value"])
            )
            for subcategory in category["subcategories"]:
                subcategory.pop("_sort_order", None)
        return {"status": "OK", "categories": categories}

    def business_subcategory_exists(self, code: str) -> bool:
        configured = {
            item.get("code") for item in self._managed_feature_taxonomy.get("subcategories", [])
            if isinstance(item, dict)
        }
        if configured:
            return code in configured
        return bool(self.repository.row(
            "SELECT 1 AS found FROM managed_features WHERE business_subcategory_code=? LIMIT 1",
            (code,),
        ))

    def feature_group_exists(self, group_code: str) -> bool:
        return bool(self.repository.row(
            "SELECT 1 AS found FROM managed_features WHERE group_code=? LIMIT 1",
            (group_code,),
        ))

    def feature_group_belongs_to_category(self, group_code: str, feature_category: str) -> bool:
        return bool(self.repository.row(
            "SELECT 1 AS found FROM managed_features "
            "JOIN managed_feature_scopes scope ON scope.feature_code=managed_features.feature_code "
            "WHERE managed_features.group_code=? AND scope.feature_category=? LIMIT 1",
            (group_code, feature_category),
        ))

    def get_managed_feature_detail(self, feature_key: str, max_depth: int = 3) -> Dict[str, Any]:
        """Return managed metadata and bounded logic evidence for one exact key."""
        explanation = self.explain_logic(feature_key, max_depth=max_depth, full=False)
        if explanation["status"] == "NOT_FOUND":
            return {"status": "NOT_FOUND", "feature_key": feature_key}

        feature = explanation["feature"]
        logic = {key: value for key, value in explanation.items() if key not in {"status", "feature"}}
        logic["status"] = explanation["status"]
        return {
            "status": "OK",
            "verified": False,
            "record_type": "managed_feature",
            "feature": feature,
            "logic": logic,
            "evidence": {
                "feature_source": feature["source_path"],
                "group_logic_source": logic["direct_logic"].get("source_path", ""),
            },
            "semantic_metadata": self._semantic_metadata(feature["feature_code"]),
            "usage_governance": self._usage_governance(feature["feature_code"]),
            "matched_tags": [],
            "match_sources": ["exact_feature"],
        }

    def _detail(self, feature: Dict[str, Any]) -> Dict[str, Any]:
        performance = self.repository.rows("SELECT * FROM performance WHERE feature_id=? ORDER BY eval_date DESC", (feature["feature_id"],))
        availability = self.repository.rows("SELECT * FROM availability WHERE feature_id=? ORDER BY updated_at DESC", (feature["feature_id"],))
        return {"status": "OK", "verified": feature["definition_source"] != "name_inference", "feature": feature,
                "performance": performance, "availability_records": availability,
                "evidence": {"logic_ref": feature["logic_ref"], "definition_source": feature["definition_source"], "synced_at": feature["synced_at"]},
                "semantic_metadata": self._empty_semantic_metadata(), "usage_governance": self._recommended_usage_governance(), "matched_tags": [], "match_sources": ["exact_feature"]}

    def _annotate_semantic_match(
        self, item: Dict[str, Any], terms: List[str], resolved_tags: List[Dict[str, Any]]
    ) -> Dict[str, Any]:
        if item.get("record_type") != "managed_feature":
            item["semantic_metadata"] = self._empty_semantic_metadata()
            item["usage_governance"] = self._recommended_usage_governance()
            item["matched_tags"] = []
            item["match_sources"] = ["keyword"] if terms else []
            return item
        item["verified"] = False
        item["usage_governance"] = self._usage_governance(item["feature_code"])
        metadata = self._semantic_metadata(item["feature_code"])
        matched: List[Dict[str, Any]] = []
        requested_codes = {tag["code"] for tag in resolved_tags}
        folded_terms = [term.casefold() for term in terms]
        for tag in metadata["tags"]:
            searchable = [tag["code"], tag["name_zh"], *tag["aliases_zh"], *tag["aliases_technical"]]
            if tag["code"] in requested_codes or any(
                term in str(value).casefold() or str(value).casefold() in term
                for term in folded_terms for value in searchable if value
            ):
                matched.append({key: tag[key] for key in ("code", "dimension", "name_zh", "metric_scope")})
        base_text = " ".join(str(item.get(key, "") or "") for key in (
            "feature_code", "feature_column_name", "feature_name", "feature_category",
            "business_subcategory_name", "group_name", "table_name",
        )).casefold()
        semantic_text = (metadata.get("summary_zh", "") + " " + " ".join(
            value for tag in metadata["tags"]
            for value in [tag["name_zh"], *tag["aliases_zh"], *tag["aliases_technical"]]
        )).casefold()
        sources = []
        if resolved_tags:
            sources.append("tag_filter")
        base_matches = [term.casefold() in base_text for term in terms]
        semantic_matches = [term.casefold() in semantic_text for term in terms]
        combined_match = terms and all(
            base_match or semantic_match
            for base_match, semantic_match in zip(base_matches, semantic_matches)
        )
        if combined_match and any(base_matches):
            sources.append("keyword_metadata")
        if combined_match and any(semantic_matches):
            sources.append("semantic_text_zh")
        item["semantic_metadata"] = metadata
        item["matched_tags"] = matched
        item["match_sources"] = sources or (["keyword"] if terms else [])
        return item

    def _semantic_lexical_match_exists(self, terms: List[str]) -> bool:
        """Probe only the small pilot table before changing the legacy query plan."""
        if not terms or not self._semantic_tables_available:
            return False
        if self._semantic_search_texts_cache is None:
            self._semantic_search_texts_cache = [
                row["search_text_zh"].casefold()
                for row in self.repository.rows("SELECT search_text_zh FROM managed_feature_semantics")
            ]
        folded_terms = [term.casefold() for term in terms]
        # One term may be a semantic alias while the remaining terms match the
        # governed base metadata (for example, table name + "逾期时长").
        # Enable the semantic join whenever any term can contribute a semantic
        # match; terms with no semantic hit still stay on the legacy fast path.
        return any(
            term in text
            for term in folded_terms
            for text in self._semantic_search_texts_cache
        )

    @staticmethod
    def _can_search_managed_fields_separately(terms: List[str]) -> bool:
        """Return whether field-wise LIKE is equivalent to legacy concatenation.

        Managed metadata is concatenated with a single ASCII space in the legacy
        query.  A literal term without whitespace or LIKE wildcards cannot cross
        one of those separators, so searching each field independently preserves
        the exact result set while avoiding construction of a large temporary
        string for every managed feature.  Queries that rely on the historical
        wildcard/phrase behaviour deliberately stay on the legacy SQL path.
        """
        return bool(terms) and all(
            not any(character.isspace() or character in "%_" for character in term)
            for term in terms
        )

    def search(self, keywords: Iterable[str], filters: Optional[Dict[str, Any]] = None, limit: int = 20, offset: int = 0) -> Dict[str, Any]:
        filters = filters or {}
        where, params = [], []
        terms = [str(item).strip() for item in keywords if str(item).strip()]
        raw_tags = filters.get("tag", []) or []
        if isinstance(raw_tags, str):
            raw_tags = [raw_tags]
        resolved_tags = self._resolve_tags(raw_tags)
        metric_scope = str(filters.get("metric_scope", "any") or "any").strip()
        if metric_scope not in {"primary", "related", "any"}:
            raise ValidationError("metric-scope must be primary, related, or any")
        if not terms and not resolved_tags:
            raise ValidationError("search requires at least one keyword or --tag")
        fts5 = self.repository.row("SELECT value FROM metadata WHERE key='fts5'").get("value") == "true"
        # Fixture records have no governed tag relations.  Once an explicit tag
        # constraint is present they must not leak into the managed result set.
        use_fts = bool(terms) and not resolved_tags and metric_scope == "any" and fts5 and all(re.fullmatch(r"[A-Za-z0-9_]+", term) for term in terms)
        source = " FROM features JOIN feature_search ON features.feature_id=feature_search.feature_id" if use_fts else " FROM features"
        fields = "features.feature_name || ' ' || features.cn_meaning || ' ' || features.technical_definition || ' ' || features.category || ' ' || features.source_table"
        if use_fts:
            where.append("feature_search MATCH ?")
            params.append(" AND ".join('"' + term + '"' for term in terms))
        else:
            for keyword in terms:
                where.append("lower(" + fields + ") LIKE lower(?)"); params.append("%" + keyword + "%")
        if resolved_tags or metric_scope != "any":
            where.append("0")
        mapping = {"category": "features.category", "table": "features.source_table", "owner": "features.owner_team", "status": "features.status", "window": "features.time_window", "derive_type": "features.derive_type"}
        for argument, column in mapping.items():
            if filters.get(argument): where.append("lower(" + column + ")=lower(?)"); params.append(filters[argument])
        for argument, column in (("scene", "features.applicable_scene"), ("population", "features.population")):
            if filters.get(argument): where.append("('|' || lower(" + column + ") || '|') LIKE ?"); params.append("%|" + filters[argument].lower() + "|%")
        clause = " WHERE " + " AND ".join(where) if where else ""
        count = self.repository.row("SELECT COUNT(*) AS count" + source + clause, params)["count"]
        ordering = "bm25(feature_search), features.status='active' DESC, features.feature_name, features.version DESC" if use_fts else "features.status='active' DESC, features.feature_name, features.version DESC"
        rows = self.repository.rows("SELECT features.*" + source + clause + " ORDER BY " + ordering + " LIMIT ? OFFSET ?", tuple(params) + (limit, offset))
        for row in rows:
            row["record_type"] = row.get("record_type", "fixture_feature")
            self._annotate_semantic_match(row, terms, resolved_tags)
        managed_where, managed_params = [], []
        managed_source = " FROM managed_features"
        use_semantic_lexical = self._semantic_lexical_match_exists(terms)
        search_managed_fields_separately = self._can_search_managed_fields_separately(terms)
        split_semantic_lexical = (
            use_semantic_lexical
            and search_managed_fields_separately
            and not resolved_tags
            and metric_scope == "any"
            and not any(filters.get(key) for key in ("table", "category", "package", "group"))
        )
        if use_semantic_lexical and not search_managed_fields_separately:
            managed_source += " LEFT JOIN managed_feature_semantics semantic ON semantic.feature_id=managed_features.rowid"
        managed_search_columns = (
            "feature_code", "feature_column_name", "feature_name", "feature_category",
            "business_subcategory_name", "group_name", "table_name",
        )
        managed_fields = " || ' ' || ".join(
            f"coalesce(managed_features.{column},'')" for column in managed_search_columns
        )
        if use_semantic_lexical and not search_managed_fields_separately:
            managed_fields += " || ' ' || coalesce(semantic.search_text_zh,'')"
        semantic_supplemental_where, semantic_supplemental_params = [], []
        for keyword in terms:
            pattern = "%" + keyword + "%"
            if search_managed_fields_separately:
                predicates = [
                    f"lower(coalesce(managed_features.{column},'')) LIKE lower(?)"
                    for column in managed_search_columns
                ]
                managed_params.extend(pattern for _ in managed_search_columns)
                if use_semantic_lexical and not split_semantic_lexical:
                    predicates.append(
                        "EXISTS (SELECT 1 FROM managed_feature_semantics semantic_term "
                        "WHERE semantic_term.feature_id=managed_features.rowid "
                        "AND lower(coalesce(semantic_term.search_text_zh,'')) LIKE lower(?))"
                    )
                    managed_params.append(pattern)
                managed_where.append("(" + " OR ".join(predicates) + ")")
                if split_semantic_lexical:
                    supplemental_predicates = [*predicates,
                        "lower(coalesce(semantic_term.search_text_zh,'')) LIKE lower(?)"
                    ]
                    semantic_supplemental_where.append(
                        "(" + " OR ".join(supplemental_predicates) + ")"
                    )
                    semantic_supplemental_params.extend(
                        pattern for _ in range(len(managed_search_columns) + 1)
                    )
            else:
                managed_where.append("lower(" + managed_fields + ") LIKE lower(?)")
                managed_params.append(pattern)
        if filters.get("table"):
            managed_where.append("lower(managed_features.table_name)=lower(?)"); managed_params.append(filters["table"])
        if filters.get("category"):
            managed_where.append(
                "EXISTS (SELECT 1 FROM managed_feature_scopes category_scope "
                "WHERE category_scope.feature_code=managed_features.feature_code "
                "AND lower(category_scope.feature_category)=lower(?))"
            ); managed_params.append(filters["category"])
        if filters.get("package"):
            managed_source += " JOIN managed_feature_scopes ON managed_features.feature_code=managed_feature_scopes.feature_code"
            managed_where.append("lower(managed_feature_scopes.package_name)=lower(?)"); managed_params.append(filters["package"])
        if filters.get("group"):
            managed_where.append("lower(managed_features.group_code)=lower(?)"); managed_params.append(filters["group"])
        for tag in resolved_tags:
            scope_clause = " AND relation.metric_scope=?" if tag["dimension"] == "metric" and metric_scope != "any" else ""
            managed_where.append(
                "EXISTS (SELECT 1 FROM managed_feature_tags relation "
                "WHERE relation.feature_id=managed_features.rowid AND relation.tag_id=?" + scope_clause + ")"
            )
            managed_params.append(tag["tag_id"])
            if scope_clause:
                managed_params.append(metric_scope)
        if metric_scope != "any" and not any(tag["dimension"] == "metric" for tag in resolved_tags):
            managed_where.append(
                "EXISTS (SELECT 1 FROM managed_feature_tags relation "
                "JOIN managed_tags scoped_tag ON scoped_tag.tag_id=relation.tag_id "
                "JOIN managed_tag_dimensions scoped_dimension ON scoped_dimension.dimension_id=scoped_tag.dimension_id "
                "WHERE relation.feature_id=managed_features.rowid "
                "AND scoped_dimension.code='metric' AND relation.metric_scope=?)"
            )
            managed_params.append(metric_scope)
        managed_clause = " WHERE " + " AND ".join(managed_where) if managed_where else ""
        semantic_supplemental_rows: List[Dict[str, Any]] = []
        if split_semantic_lexical:
            # The pilot table is tiny (currently 250 rows).  Scan it first and
            # retain only rows not already found by the legacy metadata query.
            # This avoids a semantic lookup for every one of the 16k managed
            # rows while keeping the two result sets disjoint for exact counts.
            semantic_supplemental_rows = self.repository.rows(
                "SELECT managed_features.*, 'managed_feature' AS record_type "
                "FROM managed_feature_semantics semantic_term "
                "CROSS JOIN managed_features "
                "ON managed_features.rowid=semantic_term.feature_id WHERE "
                + " AND ".join(semantic_supplemental_where)
                + " AND NOT ("
                + " AND ".join(managed_where)
                + ") ORDER BY managed_features.feature_name, managed_features.feature_code",
                tuple(semantic_supplemental_params) + tuple(managed_params),
            )
        managed_count = self.repository.row(
            "SELECT COUNT(*) AS count" + managed_source + managed_clause, managed_params
        )["count"] + len(semantic_supplemental_rows)
        remaining = max(0, limit - len(rows))
        managed_offset = max(0, offset - count)
        if remaining and split_semantic_lexical:
            supplemental_count = len(semantic_supplemental_rows)
            base_offset = max(0, managed_offset - supplemental_count)
            base_rows = self.repository.rows(
                "SELECT managed_features.*, 'managed_feature' AS record_type"
                + managed_source
                + managed_clause
                + " ORDER BY managed_features.feature_name, managed_features.feature_code LIMIT ? OFFSET ?",
                tuple(managed_params) + (remaining + supplemental_count, base_offset),
            )
            merged_rows = sorted(
                [*base_rows, *semantic_supplemental_rows],
                key=lambda item: (item["feature_name"], item["feature_code"]),
            )
            merged_offset = managed_offset - base_offset
            managed_rows = merged_rows[merged_offset:merged_offset + remaining]
        else:
            managed_rows = self.repository.rows("SELECT managed_features.*, 'managed_feature' AS record_type" + managed_source + managed_clause + " ORDER BY managed_features.feature_name, managed_features.feature_code LIMIT ? OFFSET ?", tuple(managed_params) + (remaining, managed_offset)) if remaining else []
        for row in managed_rows:
            self._annotate_semantic_match(row, terms, resolved_tags)
        items = rows + managed_rows
        match_sources = list(dict.fromkeys(source_name for item in items for source_name in item.get("match_sources", [])))
        return {
            "status": "OK", "total": count + managed_count, "limit": limit, "offset": offset,
            "items": items, "fts5": str(fts5).lower(), "search_mode": "fts5" if use_fts else "like",
            "counts": {"fixture": count, "managed": managed_count},
            "matched_tags": [{key: tag[key] for key in ("code", "dimension", "name_zh")} for tag in resolved_tags],
            "match_sources": match_sources,
        }

    @staticmethod
    def _sql_excerpt(sql: str, needle: str = "", limit: int = 1200) -> str:
        excerpt = sql
        if needle:
            found = re.search(r"(?<![A-Za-z0-9_])" + re.escape(needle) + r"(?![A-Za-z0-9_])", sql, re.I)
            if found:
                lines = sql.splitlines()
                number = sql[:found.start()].count("\n") + 1
                start, end = max(1, number - 3), min(len(lines), number + 3)
                excerpt = "\n".join(lines[start - 1:end])
        if len(excerpt) <= limit:
            return excerpt
        match = re.search(re.escape(needle), excerpt, re.I) if needle else None
        center = match.start() if match else 0
        window_start = max(0, min(center - limit // 3, len(excerpt) - limit))
        window = excerpt[window_start:window_start + limit]
        prefix = "-- excerpt starts mid-SQL\n" if window_start else ""
        suffix = "\n-- excerpt truncated; request --full for complete SQL"
        return prefix + window + suffix

    def _standard_warehouse_terminal(self, full_table: str) -> Dict[str, Any]:
        parts = full_table.split(".", 1)
        if len(parts) != 2:
            return {}
        schema = parts[0].lower()
        policy = self._standard_warehouse_policy
        if schema not in set(policy.get("standard_schemas", [])) or schema in set(policy.get("excluded_schemas", [])):
            return {}
        detail = policy.get("table_metadata", {}).get(full_table.lower(), {})
        return {
            "table_name": full_table,
            "schema": schema,
            "classification": "standard_warehouse_table",
            "description": detail.get("description", ""),
            "metadata": detail,
            "metadata_status": "maintained" if detail else "not_maintained",
            "policy_source_path": policy.get("source_path", ""),
        }

    def _table_lineage_source(self) -> str:
        """Return the governed edge table, preserving read compatibility for old indexes."""
        if self.repository.row(
            "SELECT 1 AS found FROM sqlite_master WHERE type='table' AND name='table_lineage_edges'"
        ):
            return "table_lineage_edges"
        return "table_dependencies"

    def _inline_nodes_for_table(self, full_table: str) -> List[Dict[str, Any]]:
        if self._inline_nodes_by_table is None:
            exact: Dict[str, List[Dict[str, Any]]] = {}
            fallback: Dict[str, List[Dict[str, Any]]] = {}
            literal_targets: Dict[str, set] = {}
            nodes = self.repository.rows("SELECT * FROM dp_logic_nodes ORDER BY source_path, node_key")
            for node in nodes:
                for materialization in find_materializations(node["sql_content"]):
                    record = {"node": node, "materialization": materialization}
                    target = materialization["table_name"]
                    short = materialization["short_table_name"]
                    if "." in target and not materialization["schema_variable"]:
                        exact.setdefault(target, []).append(record)
                        literal_targets.setdefault(short, set()).add(target)
                    else:
                        fallback.setdefault(short, []).append(record)
            self._inline_nodes_by_table = {
                "exact": exact,
                "fallback": fallback,
                "literal_targets": literal_targets,
            }
        target = full_table.lower().replace("`", "")
        short = target.rsplit(".", 1)[-1]
        selected = self._inline_nodes_by_table["exact"].get(target, [])
        if not selected and not self._inline_nodes_by_table["literal_targets"].get(short):
            selected = self._inline_nodes_by_table["fallback"].get(short, [])
        grouped: Dict[str, Dict[str, Any]] = {}
        for record in selected:
            node = record["node"]
            item = grouped.setdefault(node["node_key"], {"node": node, "materializations": []})
            item["materializations"].append(record["materialization"])
        result = list(grouped.values())
        for item in result:
            item["materializations"].sort(key=lambda value: (value["line_start"], value["type"]))
        return sorted(result, key=lambda value: (value["node"]["source_path"], value["node"]["node_key"]))

    @staticmethod
    def _inline_sql_excerpt(sql: str, materializations: List[Dict[str, Any]], limit: int = 1200) -> str:
        if not materializations:
            return FeatureService._sql_excerpt(sql, limit=limit)
        lines = sql.splitlines()
        number = min(item["line_start"] for item in materializations)
        excerpt = "\n".join(lines[number - 1:min(len(lines), number + 15)])
        if len(excerpt) <= limit:
            return excerpt
        return excerpt[:limit] + "\n-- excerpt truncated; request --full for complete SQL"

    def _logic_node_item(self, node: Dict[str, Any], needle: str, full: bool, inline: bool = False,
                         materializations: Optional[List[Dict[str, Any]]] = None) -> Dict[str, Any]:
        item = {key: node[key] for key in ("table_name", "node_id", "task_name", "owner_name", "source_path", "source_hash")}
        if full:
            item["sql"] = node["sql_content"]
        elif inline:
            item["sql"] = self._inline_sql_excerpt(node["sql_content"], materializations or [])
        else:
            item["sql"] = self._sql_excerpt(node["sql_content"], needle)
        if inline:
            item["logic_origin"] = "inline_materialized_same_task"
            item["materializations"] = [
                {key: materialization[key] for key in ("type", "line_start", "table_name")}
                for materialization in (materializations or [])
            ]
        return item

    def explain_logic(self, feature_code: str, max_depth: int = 3, full: bool = False) -> Dict[str, Any]:
        feature = self.repository.row("SELECT * FROM managed_features WHERE lower(feature_code)=lower(?)", (feature_code,))
        if not feature:
            return {"status": "NOT_FOUND", "feature_code": feature_code, "note": "logic explanations require an exact managed featureCode", "usage_governance": self._unmatched_usage_governance(feature_code)}
        scopes = self.repository.rows("SELECT package_name, feature_category FROM managed_feature_scopes WHERE feature_code=? ORDER BY package_name", (feature["feature_code"],))
        feature["packages"] = [item["package_name"] for item in scopes]
        feature["feature_categories"] = sorted({item["feature_category"] for item in scopes})
        group_logic = self.repository.row("SELECT * FROM group_logic WHERE group_code=?", (feature["group_code"],))
        derivation = self.repository.row("SELECT * FROM column_derivations WHERE feature_code=?", (feature["feature_code"],))
        coverage = self.repository.row("SELECT * FROM logic_coverage WHERE feature_code=?", (feature["feature_code"],))
        lineage_source = self._table_lineage_source()
        starts = self.repository.rows(
            "SELECT DISTINCT upstream_table FROM " + lineage_source
            + " WHERE downstream_table=? AND source_type='group_logic' ORDER BY upstream_table",
            (feature["table_name"],),
        )
        diagnostics: List[str] = []
        chain: List[Dict[str, Any]] = []
        layers: List[Dict[str, Any]] = []
        standard_terminals: List[Dict[str, Any]] = []
        queued = [(item["upstream_table"], 1, feature["table_name"], (feature["table_name"],)) for item in starts]
        seen = set()
        while queued:
            full_table, depth, parent, path = queued.pop(0)
            layer_key = (depth, full_table)
            if layer_key in seen:
                for layer in layers:
                    if layer["depth"] == depth:
                        for item in layer["tables"]:
                            if item["table_name"] == full_table and parent not in item["parents"]:
                                item["parents"].append(parent)
                continue
            seen.add(layer_key)
            while len(layers) < depth:
                layers.append({"depth": len(layers) + 1, "tables": []})
            table = full_table.rsplit(".", 1)[-1]
            standard_terminal = self._standard_warehouse_terminal(full_table)
            if standard_terminal:
                item = {"table_name": full_table, "parents": [parent], "state": "standard_warehouse_terminal", "logic_nodes": [], "terminal": standard_terminal}
                layers[depth - 1]["tables"].append(item)
                standard_terminals.append(standard_terminal)
                continue
            nodes = self.repository.rows("SELECT * FROM dp_logic_nodes WHERE table_name=? ORDER BY node_key", (table,))
            inline_nodes = self._inline_nodes_for_table(full_table) if not nodes else []
            state = "indexed" if nodes else ("inline_materialized" if inline_nodes else "not_downloaded")
            item: Dict[str, Any] = {"table_name": full_table, "parents": [parent], "state": state, "logic_nodes": []}
            for node in nodes:
                node_item = self._logic_node_item(node, feature["feature_column_name"], full)
                item["logic_nodes"].append(node_item)
                chain.append({key: node_item[key] for key in ("table_name", "node_id", "task_name", "owner_name", "source_path", "source_hash")})
            layers[depth - 1]["tables"].append(item)
            if inline_nodes:
                item["host_tasks"] = []
                for inline_node in inline_nodes:
                    node = inline_node["node"]
                    node_item = self._logic_node_item(
                        node, table, full, inline=True,
                        materializations=inline_node["materializations"],
                    )
                    item["logic_nodes"].append(node_item)
                    item["host_tasks"].append({key: node_item[key] for key in ("table_name", "node_id", "task_name", "owner_name", "source_path", "source_hash")})
                continue
            if not nodes:
                diagnostics.append("logic_not_downloaded:" + full_table)
                continue
            for node in nodes:
                upstreams = self.repository.rows(
                    "SELECT upstream_table FROM " + lineage_source
                    + " WHERE node_key=? ORDER BY upstream_table",
                    (node["node_key"],),
                )
                if depth >= max_depth:
                    unresolved = []
                    for upstream in upstreams:
                        terminal = self._standard_warehouse_terminal(upstream["upstream_table"])
                        if terminal:
                            standard_terminals.append(terminal)
                        else:
                            unresolved.append(upstream)
                    if unresolved:
                        diagnostics.append("max_depth_reached:" + full_table)
                    continue
                for upstream in upstreams:
                    upstream_name = upstream["upstream_table"]
                    if upstream_name in path:
                        diagnostics.append("cycle_detected:" + upstream_name)
                        continue
                    queued.append((upstream_name, depth + 1, full_table, path + (full_table,)))

        status = "PARTIAL" if diagnostics else "OK"
        direct = {"group_code": group_logic["group_code"], "logic_version": group_logic["logic_version"], "modify_time": group_logic["modify_time"], "last_modifier": group_logic["last_modifier"], "source_path": group_logic["source_path"], "source_hash": group_logic["source_hash"], "derivation": derivation}
        direct["sql"] = group_logic["logic_content"] if full else (derivation.get("snippet") or self._sql_excerpt(group_logic["logic_content"]))
        return {"status": status, "feature": feature, "direct_logic": direct, "coverage": coverage,
                "upstream_layers": layers, "pdm_risk_upstream_chain": chain,
                "standard_warehouse_policy": {key: value for key, value in self._standard_warehouse_policy.items() if key != "table_metadata"},
                "standard_warehouse_terminals": list({item["table_name"]: item for item in standard_terminals}.values()),
                "diagnostics": list(dict.fromkeys(diagnostics)), "requested_upstream_depth": max_depth,
                "full_requested": full}

    def audit_logic(self, max_depth: int = 20) -> Dict[str, Any]:
        """Return a compact, SQL-free completeness audit across feature tables."""
        representatives = self.repository.rows(
            "SELECT table_name, MIN(feature_code) AS feature_code "
            "FROM managed_features GROUP BY table_name ORDER BY table_name"
        )
        missing: Dict[str, set] = {}
        max_depth_reached = set()
        cycles = set()
        inline_by_type: Dict[str, set] = {"create_table": set(), "insert_overwrite": set()}
        standard_terminals = set()
        affected = set()
        for representative in representatives:
            result = self.explain_logic(representative["feature_code"], max_depth=max_depth, full=False)
            feature_table = representative["table_name"]
            for diagnostic in result["diagnostics"]:
                if diagnostic.startswith("logic_not_downloaded:"):
                    table_name = diagnostic.split(":", 1)[1]
                    missing.setdefault(table_name, set()).add(feature_table)
                    affected.add(feature_table)
                elif diagnostic.startswith("max_depth_reached:"):
                    max_depth_reached.add(diagnostic.split(":", 1)[1])
                elif diagnostic.startswith("cycle_detected:"):
                    cycles.add(diagnostic.split(":", 1)[1])
            for terminal in result["standard_warehouse_terminals"]:
                standard_terminals.add(terminal["table_name"])
            for layer in result["upstream_layers"]:
                for table_item in layer["tables"]:
                    if table_item["state"] != "inline_materialized":
                        continue
                    for node in table_item["logic_nodes"]:
                        for materialization in node.get("materializations", []):
                            inline_by_type.setdefault(materialization["type"], set()).add(table_item["table_name"])
        partial = bool(missing or max_depth_reached or cycles)
        return {
            "status": "PARTIAL" if partial else "OK",
            "representative_feature_tables": len(representatives),
            "max_depth": max_depth,
            "missing_nonstandard_tables": [
                {"table_name": table_name, "affected_feature_tables": sorted(feature_tables)}
                for table_name, feature_tables in sorted(missing.items())
            ],
            "affected_feature_tables": len(affected),
            "inline_materializations": {
                key: len(values) for key, values in sorted(inline_by_type.items())
            },
            "standard_warehouse_terminals": len(standard_terminals),
            "max_depth_reached": len(max_depth_reached),
            "cycle_detected": len(cycles),
        }

    def table(self, table_name: str, limit: int = 8, offset: int = 0) -> Dict[str, Any]:
        table = self.repository.row("SELECT * FROM tables_kb WHERE lower(table_name)=lower(?)", (table_name,))
        if not table: return {"status": "NOT_FOUND", "table_name": table_name}
        categories = self.repository.rows("SELECT category, COUNT(*) AS count FROM features WHERE source_table=? GROUP BY category ORDER BY count DESC", (table["table_name"],))
        windows = self.repository.rows("SELECT time_window, COUNT(*) AS count FROM features WHERE source_table=? GROUP BY time_window ORDER BY count DESC", (table["table_name"],))
        methods = self.repository.rows("SELECT stat_method, COUNT(*) AS count FROM features WHERE source_table=? GROUP BY stat_method ORDER BY count DESC", (table["table_name"],))
        samples = self.repository.rows("SELECT feature_id, feature_name, cn_meaning, category, time_window, stat_method, status FROM features WHERE source_table=? ORDER BY status='active' DESC, feature_name LIMIT ? OFFSET ?", (table["table_name"], limit, offset))
        return {"status": "OK", "table": table, "feature_count": sum(x["count"] for x in categories), "limit": limit, "offset": offset, "aggregates": {"category": categories, "time_window": windows, "stat_method": methods}, "representative_features": samples}

    @staticmethod
    def _short_table_name(table_name: str) -> str:
        return table_name.strip().lower().replace("`", "").rsplit(".", 1)[-1]

    def _forward_lineage_edges(self, table_name: str) -> Tuple[List[Dict[str, Any]], bool]:
        """Resolve a table's direct inputs, recording an explicit short-name fallback."""
        source = self._table_lineage_source()
        exact = self.repository.rows(
            "SELECT * FROM " + source + " WHERE lower(downstream_table)=lower(?) ORDER BY upstream_table, node_key",
            (table_name,),
        )
        if exact:
            return exact, False
        short_name = self._short_table_name(table_name)
        return self.repository.rows(
            "SELECT * FROM " + source + " WHERE lower(downstream_table)=lower(?) ORDER BY upstream_table, node_key",
            (short_name,),
        ), bool("." in table_name)

    def lineage(self, table_name: str, direction: str = "forward", max_depth: int = 3) -> Dict[str, Any]:
        """Traverse generated table-level lineage, never using legacy fixture edges."""
        requested = table_name.strip()
        if not requested:
            return {"status": "NOT_FOUND", "table_name": table_name, "edges": [], "nodes": [], "diagnostics": ["empty table name"]}
        source = self._table_lineage_source()
        forward, used_short_name = self._forward_lineage_edges(requested)
        reverse = self.repository.rows(
            "SELECT * FROM " + source + " WHERE lower(upstream_table)=lower(?) ORDER BY downstream_table, node_key",
            (requested,),
        )
        if not forward and not reverse:
            return {"status": "NOT_FOUND", "table_name": requested, "edges": [], "nodes": [], "diagnostics": ["table is not indexed in table lineage"]}

        result_edges: List[Dict[str, Any]] = []
        nodes, diagnostics, terminals = {requested}, [], []
        if used_short_name:
            diagnostics.append("start_resolved_by_short_table_name:" + self._short_table_name(requested))
        frontier = [(requested, 0, (requested,))]
        while frontier:
            current, depth, path = frontier.pop(0)
            if depth >= max_depth:
                terminal = self._standard_warehouse_terminal(current)
                if terminal:
                    terminals.append(terminal)
                else:
                    diagnostics.append("max_depth_reached:" + current)
                continue
            current_edges: List[Tuple[Dict[str, Any], str]] = []
            if direction in ("forward", "both"):
                edges, fallback = self._forward_lineage_edges(current)
                if fallback:
                    diagnostics.append("resolved_by_short_table_name:" + self._short_table_name(current))
                current_edges.extend((edge, edge["upstream_table"]) for edge in edges)
            if direction in ("reverse", "both"):
                edges = self.repository.rows(
                    "SELECT * FROM " + source + " WHERE lower(upstream_table)=lower(?) ORDER BY downstream_table, node_key",
                    (current,),
                )
                current_edges.extend((edge, edge["downstream_table"]) for edge in edges)
            if not current_edges and direction == "forward":
                terminal = self._standard_warehouse_terminal(current)
                if terminal:
                    terminals.append(terminal)
                elif current != requested:
                    diagnostics.append("unresolved_terminal:" + current)
            for edge, next_table in current_edges:
                if edge not in result_edges:
                    result_edges.append(edge)
                nodes.add(next_table)
                if next_table in path:
                    if direction != "both":
                        diagnostics.append("cycle_detected:" + next_table)
                    continue
                frontier.append((next_table, depth + 1, path + (next_table,)))
        diagnostics = list(dict.fromkeys(diagnostics))
        return {
            "status": "PARTIAL" if any(item.startswith(("max_depth_reached:", "cycle_detected:", "unresolved_terminal:")) for item in diagnostics) else "OK",
            "table_name": requested,
            "direction": direction,
            "max_depth": max_depth,
            "nodes": [{"table_name": item} for item in sorted(nodes)],
            "edges": result_edges,
            "standard_warehouse_terminals": list({item["table_name"]: item for item in terminals}.values()),
            "diagnostics": diagnostics,
        }

    def compare(self, names: Iterable[str]) -> Dict[str, Any]:
        requested = list(names); results = [self.get(name) for name in requested]
        items = [result["feature"] for result in results if result["status"] == "OK"]
        fields = ["technical_definition", "formula", "time_window", "stat_method", "grain", "source_table", "applicable_scene", "population", "status"]
        differences = {field: {item["feature_name"] + "@" + item["version"]: item[field] for item in items} for field in fields}
        shared = [field for field, values in differences.items() if len(set(values.values())) == 1]
        hint = {"method": "exact equality over selected structured fields", "shared_fields": shared, "identical_selected_fields": len(shared) == len(fields), "note": "提示不等同于重复特征结论。"}
        historical_performance = {item["feature_name"] + "@" + item["version"]: self.repository.rows("SELECT * FROM performance WHERE feature_id=? ORDER BY eval_date DESC", (item["feature_id"],)) for item in items}
        null_handling = {item["feature_name"] + "@" + item["version"]: {"status": "not_recorded", "value": None, "evidence": "features.csv 未定义空值口径字段；不能从公式或名称推断。"} for item in items}
        differences["null_handling"] = null_handling
        return {"status": "OK" if items else "NOT_FOUND", "items": items, "not_found": [r["feature_name"] for r in results if r["status"] != "OK"], "differences": differences, "historical_performance": historical_performance, "null_value_convention": "空值表示未记录或未知，不等同于零；无表现记录明确返回空列表。", "logic_similarity_hint": hint}

    def perf(self, filters: Optional[Dict[str, Any]] = None, limit: int = 20, offset: int = 0) -> Dict[str, Any]:
        filters = filters or {}; where, params = [], []
        fields = {"project": "p.project", "model_version": "p.model_version", "population": "p.population", "conclusion": "p.conclusion", "category": "f.category"}
        for key, column in fields.items():
            if filters.get(key): where.append(column + "=?"); params.append(filters[key])
        for key, operator, column in (("min_iv", ">=", "p.iv"), ("max_psi", "<=", "p.psi"), ("min_tail_lift", ">=", "p.tail_1pct_lift")):
            if filters.get(key) is not None: where.append(column + operator + "?"); params.append(float(filters[key]))
        if filters.get("date_from"): where.append("p.eval_date>=?"); params.append(filters["date_from"])
        if filters.get("date_to"): where.append("p.eval_date<=?"); params.append(filters["date_to"])
        clause = " WHERE " + " AND ".join(where) if where else ""
        sql = " FROM performance p LEFT JOIN features f ON p.feature_id=f.feature_id" + clause
        count = self.repository.row("SELECT COUNT(*) AS count" + sql, params)["count"]
        items = self.repository.rows("SELECT p.*, f.category AS feature_category" + sql + " ORDER BY p.eval_date DESC LIMIT ? OFFSET ?", tuple(params) + (limit, offset))
        return {"status": "OK", "total": count, "items": items, "limit": limit, "offset": offset}

    def availability(self, feature_name: str, scene: Optional[str] = None, population: Optional[str] = None, product: Optional[str] = None, observation_timing: Optional[str] = None, as_of: Optional[str] = None) -> Dict[str, Any]:
        detail = self.get(feature_name)
        if detail["status"] != "OK": return detail
        feature = detail["feature"]
        records = self.repository.rows("SELECT * FROM availability WHERE feature_id=?", (feature["feature_id"],))
        missing = [name for name, value in (("scene", scene), ("population", population), ("observation_timing", observation_timing)) if not value]
        def within_interval(record: Dict[str, Any]) -> bool:
            return not as_of or (record["available_from"] <= as_of and (not record["available_to"] or as_of <= record["available_to"]))
        matching = [r for r in records if (not scene or r["scene"] == scene) and (not population or r["population"] == population) and (not product or r["product"] == product) and (not observation_timing or r["observation_timing"] == observation_timing) and within_interval(r)]
        if missing:
            conclusion = "conditional" if records else "unknown"
            return {"status": "OK", "feature_name": feature_name, "conclusion": conclusion, "information_insufficient": missing, "evidence": records, "note": "仅 applicable_scene 不能证明在指定观察时点可用。"}
        if not matching:
            return {"status": "OK", "feature_name": feature_name, "conclusion": "unknown", "information_insufficient": ["matching availability evidence"], "evidence": records}
        priority = {"unavailable": 3, "conditional": 2, "available": 1, "unknown": 0}
        record = sorted(matching, key=lambda r: priority[r["availability_status"]], reverse=True)[0]
        return {"status": "OK", "feature_name": feature_name, "conclusion": record["availability_status"], "conditions": record["restriction"], "data_timing": record["available_from"], "observation_timing": record["observation_timing"], "evidence": [record], "information_insufficient": []}

    def stats(self) -> Dict[str, Any]:
        lineage_source = self._table_lineage_source()
        return {"status": "OK", "features": self.repository.row("SELECT COUNT(*) AS count FROM features")["count"], "managed_features": self.repository.row("SELECT COUNT(*) AS count FROM managed_features")["count"], "tables": self.repository.row("SELECT COUNT(*) AS count FROM tables_kb")["count"], "logic_nodes": self.repository.row("SELECT COUNT(*) AS count FROM dp_logic_nodes")["count"], "table_lineage_edges": self.repository.row("SELECT COUNT(*) AS count FROM " + lineage_source)["count"], "metadata": self.repository.rows("SELECT * FROM metadata")}
