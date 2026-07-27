"""Build the managed feature-and-logic catalog from local feature and SQL assets."""
import datetime as dt
import hashlib
import json
import re
from pathlib import Path
from typing import Any, Dict, Iterable, List, Tuple

from .errors import ValidationError


TABLE_REFERENCE = re.compile(r"(?i)\b(?:from|join)\s+([a-z][a-z0-9_]*\.[a-z][a-z0-9_]*)")
SQL_NODE_BEGIN = re.compile(r"(?m)^-- feature-copilot:node-begin ordinal=(\d+)\s*$")
SQL_NODE_END = re.compile(r"(?m)^-- feature-copilot:node-end ordinal=(\d+)\s*$")
SQL_HEADER = re.compile(r"(?m)^-- ([a-z_]+): ?(.*)$")
SQL_LOGIC_UNAVAILABLE = re.compile(r"(?m)^-- feature-copilot:logic-unavailable\s*$")
DP_SQL_DIRECTORIES = ("", "pdm_risk_upstream", "dwa_risk_upstream", "dwa_risk_first_upstream", "dwa_risk_internal_upstream")
SEMANTIC_DIMENSIONS_V1 = ("business", "metric", "time", "derivation")
SEMANTIC_DIMENSIONS_V2 = (
    "feature_role", "business_stage", "business", "metric", "time", "derivation",
)
SEMANTIC_SOURCE_TYPES = ("model_inferred", "manual_confirmed", "logic_verified", "rule_inferred")
SEMANTIC_CONFIDENCES = ("high", "medium", "low")
CHINESE_CHAR = re.compile(r"[\u3400-\u9fff]")


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _relative(path: Path, root: Path) -> str:
    return str(path.resolve().relative_to(root.resolve()))


def _read_json(path: Path) -> Any:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def _standard_warehouse_policy(root: Path, scope: Dict[str, Any]) -> Dict[str, Any]:
    relative_path = str(scope.get("standard_warehouse_config", "")).strip()
    if not relative_path:
        raise ValidationError("missing standard_warehouse_config in maintenance scope")
    path = root / relative_path
    if not path.is_file():
        raise ValidationError("missing standard warehouse config: " + relative_path)
    payload = _read_json(path)
    if not isinstance(payload, dict) or payload.get("schema_version") != 1:
        raise ValidationError("unsupported standard warehouse config: " + relative_path)
    standard = payload.get("standard_schemas", [])
    excluded = payload.get("excluded_schemas", [])
    metadata = payload.get("table_metadata", {})
    if not isinstance(standard, list) or not isinstance(excluded, list) or not isinstance(metadata, dict):
        raise ValidationError("invalid standard warehouse config: " + relative_path)
    standard_schemas = sorted({str(item).strip().lower() for item in standard if str(item).strip()})
    excluded_schemas = sorted({str(item).strip().lower() for item in excluded if str(item).strip()})
    if set(standard_schemas) & set(excluded_schemas):
        raise ValidationError("standard and excluded schemas overlap: " + relative_path)
    normalized_metadata: Dict[str, Dict[str, Any]] = {}
    for table_name, detail in metadata.items():
        if not isinstance(detail, dict):
            raise ValidationError("invalid table metadata for " + str(table_name))
        normalized_metadata[str(table_name).strip().lower()] = detail
    return {
        "source_path": relative_path,
        "source_hash": _sha256(path),
        "standard_schemas": standard_schemas,
        "excluded_schemas": excluded_schemas,
        "table_metadata": normalized_metadata,
    }


def _managed_feature_taxonomy(
    root: Path, scope: Dict[str, Any], features: List[Dict[str, Any]], source_feature_rows: int
) -> Dict[str, Any]:
    """Validate and apply the governed business-subcategory taxonomy."""
    relative_path = str(scope.get("managed_feature_taxonomy_config", "")).strip()
    if not relative_path:
        raise ValidationError("missing managed_feature_taxonomy_config in maintenance scope")
    path = root / relative_path
    if not path.is_file():
        raise ValidationError("missing managed feature taxonomy config: " + relative_path)
    payload = _read_json(path)
    if not isinstance(payload, dict) or payload.get("schema_version") != 1:
        raise ValidationError("unsupported managed feature taxonomy config: " + relative_path)

    raw_subcategories = payload.get("subcategories", [])
    raw_group_defaults = payload.get("group_defaults", [])
    raw_feature_overrides = payload.get("feature_overrides", [])
    if not all(isinstance(value, list) for value in (raw_subcategories, raw_group_defaults, raw_feature_overrides)):
        raise ValidationError("invalid managed feature taxonomy collections: " + relative_path)

    subcategories: List[Dict[str, Any]] = []
    by_code: Dict[str, Dict[str, Any]] = {}
    sort_orders = set()
    for item in raw_subcategories:
        if not isinstance(item, dict):
            raise ValidationError("invalid business subcategory entry")
        code = str(item.get("code", "")).strip()
        name = str(item.get("name", "")).strip()
        sort_order = item.get("sort_order")
        if not re.fullmatch(r"[a-z][a-z0-9_]*", code):
            raise ValidationError("invalid business subcategory code: " + code)
        if code in by_code:
            raise ValidationError("duplicate business subcategory code: " + code)
        if not name:
            raise ValidationError("empty business subcategory name: " + code)
        if isinstance(sort_order, bool) or not isinstance(sort_order, int) or sort_order <= 0:
            raise ValidationError("business subcategory sort_order must be a positive integer: " + code)
        if sort_order in sort_orders:
            raise ValidationError("duplicate business subcategory sort_order: " + str(sort_order))
        normalized = {
            "code": code,
            "name": name,
            "description": str(item.get("description", "")).strip(),
            "sort_order": sort_order,
        }
        by_code[code] = normalized
        sort_orders.add(sort_order)
        subcategories.append(normalized)
    if not subcategories:
        raise ValidationError("managed feature taxonomy declares no business subcategories")
    subcategories.sort(key=lambda item: (item["sort_order"], item["code"]))

    feature_by_code = {item["feature_code"]: item for item in features}
    managed_groups = {item["group_code"] for item in features}
    group_defaults: Dict[str, str] = {}
    for item in raw_group_defaults:
        if not isinstance(item, dict):
            raise ValidationError("invalid group default entry")
        group_code = str(item.get("group_code", "")).strip()
        subcategory_code = str(item.get("subcategory_code", "")).strip()
        if not group_code:
            raise ValidationError("empty group_code in taxonomy group default")
        if group_code in group_defaults:
            raise ValidationError("duplicate taxonomy group default: " + group_code)
        if group_code not in managed_groups:
            raise ValidationError("taxonomy group default is outside maintenance scope: " + group_code)
        if subcategory_code not in by_code:
            raise ValidationError("unknown business subcategory for group " + group_code + ": " + subcategory_code)
        group_defaults[group_code] = subcategory_code

    missing_groups = sorted(managed_groups - set(group_defaults))
    if missing_groups:
        raise ValidationError("managed feature groups lack taxonomy defaults: " + ", ".join(missing_groups))

    feature_overrides: Dict[str, Dict[str, str]] = {}
    override_reason_counts: Dict[str, int] = {}
    override_details: List[Dict[str, str]] = []
    for item in raw_feature_overrides:
        if not isinstance(item, dict):
            raise ValidationError("invalid feature override entry")
        feature_code = str(item.get("feature_code", "")).strip()
        subcategory_code = str(item.get("subcategory_code", "")).strip()
        reason = str(item.get("reason", "")).strip()
        if not feature_code:
            raise ValidationError("empty feature_code in taxonomy feature override")
        if feature_code in feature_overrides:
            raise ValidationError("duplicate taxonomy feature override: " + feature_code)
        feature = feature_by_code.get(feature_code)
        if feature is None:
            raise ValidationError("taxonomy feature override is outside maintenance scope: " + feature_code)
        if feature["group_code"] not in managed_groups:
            raise ValidationError("taxonomy feature override has unknown group: " + feature_code)
        if subcategory_code not in by_code:
            raise ValidationError("unknown business subcategory for feature " + feature_code + ": " + subcategory_code)
        if not reason:
            raise ValidationError("empty taxonomy feature override reason: " + feature_code)
        normalized_override = {
            "feature_code": feature_code,
            "subcategory_code": subcategory_code,
            "reason": reason,
        }
        feature_overrides[feature_code] = normalized_override
        override_reason_counts[reason] = override_reason_counts.get(reason, 0) + 1
        override_details.append(normalized_override)

    group_default_hits = 0
    feature_override_hits = 0
    unclassified: List[str] = []
    for feature in features:
        override = feature_overrides.get(feature["feature_code"])
        subcategory_code = override["subcategory_code"] if override else group_defaults.get(feature["group_code"])
        if not subcategory_code:
            unclassified.append(feature["feature_code"])
            continue
        if override:
            feature_override_hits += 1
        else:
            group_default_hits += 1
        subcategory = by_code[subcategory_code]
        feature["business_subcategory_code"] = subcategory_code
        feature["business_subcategory_name"] = subcategory["name"]
        feature["business_subcategory_sort_order"] = subcategory["sort_order"]
    if unclassified:
        raise ValidationError("managed feature taxonomy coverage is incomplete: " + ", ".join(unclassified[:20]))

    audit = {
        "source_feature_rows": source_feature_rows,
        "unique_feature_count": len(features),
        "unique_group_count": len(managed_groups),
        "group_default_count": len(group_defaults),
        "group_default_hit_count": group_default_hits,
        "feature_override_count": len(feature_overrides),
        "feature_override_hit_count": feature_override_hits,
        "classified_feature_count": len(features) - len(unclassified),
        "unclassified_count": len(unclassified),
        "coverage_rate": 1.0 if features else 0.0,
        "override_reason_counts": override_reason_counts,
        "feature_overrides": sorted(override_details, key=lambda item: item["feature_code"]),
    }
    return {
        "source_path": relative_path,
        "source_hash": _sha256(path),
        "schema_version": 1,
        "subcategories": subcategories,
        "group_defaults": [
            {"group_code": group_code, "subcategory_code": subcategory_code}
            for group_code, subcategory_code in sorted(group_defaults.items())
        ],
        "feature_overrides": sorted(override_details, key=lambda item: item["feature_code"]),
        "audit": audit,
    }


def _managed_feature_usage_governance(
    root: Path, scope: Dict[str, Any], features: List[Dict[str, Any]]
) -> Dict[str, Any]:
    """Load feature-use decisions without altering feature metadata or SQL facts."""
    relative_path = str(scope.get("managed_feature_usage_governance_config", "")).strip()
    if not relative_path:
        return {"source_path": "", "source_hash": "", "records": [], "unmatched_records": [], "audit": {}}
    path = root / relative_path
    if not path.is_file():
        raise ValidationError("missing managed feature usage governance config: " + relative_path)
    payload = _read_json(path)
    if not isinstance(payload, dict) or payload.get("schema_version") != 1:
        raise ValidationError("unsupported managed feature usage governance config: " + relative_path)
    rules = payload.get("rules", [])
    if not isinstance(rules, list) or not rules:
        raise ValidationError("managed feature usage governance rules must be a non-empty array")

    by_group: Dict[str, List[Dict[str, Any]]] = {}
    by_column: Dict[str, List[Dict[str, Any]]] = {}
    for feature in features:
        by_group.setdefault(feature["group_code"], []).append(feature)
        by_column.setdefault(feature["feature_column_name"], []).append(feature)
    records: List[Dict[str, str]] = []
    unmatched_records: List[Dict[str, str]] = []
    assigned_codes, assigned_columns, reason_codes = set(), set(), set()
    allowed_statuses = {"invalid", "not_recommended"}

    for rule in rules:
        if not isinstance(rule, dict):
            raise ValidationError("invalid managed feature usage governance rule")
        reason_code = str(rule.get("reason_code", "")).strip()
        reason_label = str(rule.get("reason_label", "")).strip()
        usage_status = str(rule.get("usage_status", "")).strip()
        usage_label = str(rule.get("usage_label", "")).strip()
        message = str(rule.get("message", "")).strip()
        source_ref = str(rule.get("source_ref", "")).strip()
        selectors = rule.get("selectors", [])
        if (not re.fullmatch(r"[a-z][a-z0-9_]*", reason_code) or reason_code in reason_codes
                or usage_status not in allowed_statuses or not all((reason_label, usage_label, message, source_ref))
                or not isinstance(selectors, list) or not selectors):
            raise ValidationError("invalid managed feature usage governance rule: " + reason_code)
        reason_codes.add(reason_code)
        for selector in selectors:
            if not isinstance(selector, dict):
                raise ValidationError("invalid managed feature usage selector: " + reason_code)
            group_code = str(selector.get("group_code", "")).strip()
            column_name = str(selector.get("feature_column_name", "")).strip()
            if bool(group_code) == bool(column_name):
                raise ValidationError("usage selector must contain exactly one target: " + reason_code)
            matched: List[Dict[str, Any]]
            if group_code:
                matched = by_group.get(group_code, [])
                expected = selector.get("expected_feature_count")
                if isinstance(expected, bool) or not isinstance(expected, int) or expected < 1 or len(matched) != expected:
                    raise ValidationError("usage governance group selector count mismatch: " + group_code)
            else:
                matched = by_column.get(column_name, [])
                if not matched:
                    if selector.get("allow_unmatched") is not True:
                        raise ValidationError("usage governance feature is outside maintenance scope: " + column_name)
                    if column_name in assigned_columns:
                        raise ValidationError("duplicate unmatched usage governance feature: " + column_name)
                    assigned_columns.add(column_name)
                    unmatched_records.append({
                        "feature_column_name": column_name, "usage_status": usage_status,
                        "usage_label": usage_label, "reason_code": reason_code,
                        "reason_label": reason_label, "message": message, "source_ref": source_ref,
                    })
                    continue
            for feature in matched:
                if feature["feature_code"] in assigned_codes:
                    raise ValidationError("feature has multiple usage governance rules: " + feature["feature_code"])
                assigned_codes.add(feature["feature_code"])
                records.append({
                    "feature_code": feature["feature_code"], "usage_status": usage_status,
                    "usage_label": usage_label, "reason_code": reason_code,
                    "reason_label": reason_label, "message": message, "source_ref": source_ref,
                })
    audit = {
        "governed_feature_count": len(records), "unmatched_feature_count": len(unmatched_records),
        "reason_counts": {code: sum(row["reason_code"] == code for row in records) for code in sorted(reason_codes)},
    }
    return {
        "source_path": relative_path, "source_hash": _sha256(path),
        "records": sorted(records, key=lambda item: item["feature_code"]),
        "unmatched_records": sorted(unmatched_records, key=lambda item: item["feature_column_name"]),
        "audit": audit,
    }


def _managed_feature_semantics(
    root: Path, scope: Dict[str, Any], features: List[Dict[str, Any]]
) -> Dict[str, Any]:
    """Validate the optional, governed Chinese semantic-search snapshot."""
    relative_path = str(scope.get("managed_feature_semantics_config", "")).strip()
    if not relative_path:
        return {
            "source_path": "", "source_hash": "", "schema_version": 1,
            "generation": {}, "dimensions": [], "tags": [], "tag_aliases": [],
            "feature_semantics": [], "feature_tags": [],
            "pilot": {"code": "", "candidate_feature_codes": []},
            "audit": {
                "vocabulary_count": 0, "pilot_candidate_count": 0,
                "tagged_feature_count": 0, "feature_semantics_count": 0,
                "tag_relation_count": 0, "alias_count": 0,
                "dimension_tag_counts": {}, "dimension_feature_counts": {},
                "confidence_counts": {}, "source_type_counts": {}, "conflict_count": 0,
            },
        }
    path = root / relative_path
    if not path.is_file():
        raise ValidationError("missing managed feature semantics config: " + relative_path)
    payload = _read_json(path)
    schema_version = payload.get("schema_version") if isinstance(payload, dict) else None
    if schema_version not in (1, 2):
        raise ValidationError("unsupported managed feature semantics config: " + relative_path)
    expected_dimensions = SEMANTIC_DIMENSIONS_V2 if schema_version == 2 else SEMANTIC_DIMENSIONS_V1

    generation = payload.get("generation", {})
    if not isinstance(generation, dict):
        raise ValidationError("invalid semantic generation metadata: " + relative_path)
    required_generation = ("model", "prompt_version", "generated_at", "input_hash")
    for key in required_generation:
        if not str(generation.get(key, "")).strip():
            raise ValidationError("missing semantic generation field: " + key)
    try:
        generated_at = dt.datetime.fromisoformat(
            str(generation["generated_at"]).replace("Z", "+00:00")
        )
    except ValueError as exc:
        raise ValidationError(
            "semantic generation generated_at must be an ISO-8601 datetime"
        ) from exc
    if generated_at.utcoffset() is None:
        raise ValidationError(
            "semantic generation generated_at must include a timezone offset"
        )
    semantic_inputs = [
        {
            key: str(feature.get(key, "")).strip()
            for key in ("feature_code", "feature_name", "feature_column_name", "group_code")
        }
        for feature in sorted(features, key=lambda item: item["feature_code"])
    ]
    actual_input_hash = hashlib.sha256(
        json.dumps(
            semantic_inputs,
            ensure_ascii=False,
            sort_keys=True,
            separators=(",", ":"),
        ).encode("utf-8")
    ).hexdigest()
    if str(generation.get("input_hash", "")).strip() != actual_input_hash:
        raise ValidationError("semantic generation input_hash does not match current managed features")

    raw_dimensions = payload.get("dimensions", [])
    raw_tags = payload.get("tags", [])
    raw_semantics = payload.get("feature_semantics", [])
    pilot = payload.get("pilot", {})
    if not isinstance(raw_dimensions, list) or not isinstance(raw_tags, list) or not isinstance(raw_semantics, list):
        raise ValidationError("invalid managed feature semantics collections: " + relative_path)
    if not isinstance(pilot, dict):
        raise ValidationError("invalid semantic pilot metadata: " + relative_path)

    dimensions: List[Dict[str, str]] = []
    dimension_codes = set()
    for item in raw_dimensions:
        if not isinstance(item, dict):
            raise ValidationError("invalid semantic dimension entry")
        code = str(item.get("code", "")).strip()
        name_zh = str(item.get("name_zh", "")).strip()
        if code not in expected_dimensions:
            raise ValidationError("invalid semantic dimension: " + code)
        if code in dimension_codes:
            raise ValidationError("duplicate semantic dimension: " + code)
        if not name_zh or not CHINESE_CHAR.search(name_zh):
            raise ValidationError("empty Chinese semantic dimension name: " + code)
        dimension_codes.add(code)
        dimensions.append({"code": code, "name_zh": name_zh})
    if dimension_codes != set(expected_dimensions):
        missing = sorted(set(expected_dimensions) - dimension_codes)
        extra = sorted(dimension_codes - set(expected_dimensions))
        raise ValidationError("semantic dimensions do not match schema v{}; missing={} extra={}".format(schema_version, missing, extra))

    tags: List[Dict[str, Any]] = []
    tag_by_code: Dict[str, Dict[str, Any]] = {}
    tag_aliases: List[Dict[str, str]] = []
    aliases_by_dimension: Dict[Tuple[str, str], str] = {}
    for item in raw_tags:
        if not isinstance(item, dict):
            raise ValidationError("invalid semantic tag entry")
        code = str(item.get("code", "")).strip()
        dimension = str(item.get("dimension", "")).strip()
        name_zh = str(item.get("name_zh", "")).strip()
        if not re.fullmatch(r"[a-z][a-z0-9_]*(?:\.[a-z][a-z0-9_]*)*", code):
            raise ValidationError("invalid semantic tag code: " + code)
        if code in tag_by_code:
            raise ValidationError("duplicate semantic tag code: " + code)
        if dimension not in dimension_codes:
            raise ValidationError("unknown semantic tag dimension for " + code + ": " + dimension)
        if not code.startswith(dimension + "."):
            raise ValidationError("semantic tag code must use its dimension namespace: " + code)
        if not name_zh or not CHINESE_CHAR.search(name_zh):
            raise ValidationError("empty Chinese semantic tag name: " + code)
        aliases_zh = item.get("aliases_zh", [])
        aliases_technical = item.get("aliases_technical", [])
        if not isinstance(aliases_zh, list) or not isinstance(aliases_technical, list):
            raise ValidationError("semantic tag aliases must be lists: " + code)
        normalized = {"code": code, "dimension": dimension, "name_zh": name_zh}
        tag_by_code[code] = normalized
        tags.append(normalized)
        for alias_type, values in (("name_zh", [name_zh]), ("zh", aliases_zh), ("technical", aliases_technical)):
            local_seen = set()
            for value in values:
                alias = str(value).strip()
                if not alias:
                    raise ValidationError("empty semantic tag alias: " + code)
                if alias_type == "zh" and not CHINESE_CHAR.search(alias):
                    raise ValidationError(
                        "Chinese semantic tag alias must contain Chinese text: "
                        + code
                    )
                folded = alias.casefold()
                if folded in local_seen:
                    raise ValidationError("duplicate semantic tag alias for " + code + ": " + alias)
                local_seen.add(folded)
                previous = aliases_by_dimension.get((dimension, folded))
                if previous and previous != code:
                    raise ValidationError("conflicting semantic tag alias in dimension {}: {} ({}, {})".format(dimension, alias, previous, code))
                aliases_by_dimension[(dimension, folded)] = code
                tag_aliases.append({"tag_code": code, "alias": alias, "alias_type": alias_type})

    feature_codes = {item["feature_code"] for item in features}
    if schema_version == 1:
        pilot_code = str(pilot.get("code", "")).strip()
        if not pilot_code:
            raise ValidationError("semantic pilot code must be non-empty")
        raw_candidates = pilot.get("candidate_feature_codes", [])
        if not isinstance(raw_candidates, list):
            raise ValidationError("semantic pilot candidate_feature_codes must be a list")
        if not 200 <= len(raw_candidates) <= 300:
            raise ValidationError("semantic pilot must contain between 200 and 300 candidates")
        candidate_codes: List[str] = []
        candidate_seen = set()
        for value in raw_candidates:
            code = str(value).strip()
            if not code or code in candidate_seen:
                raise ValidationError("empty or duplicate semantic pilot candidate: " + code)
            if code not in feature_codes:
                raise ValidationError("semantic pilot candidate is outside maintenance scope: " + code)
            candidate_seen.add(code)
            candidate_codes.append(code)
    else:
        coverage = payload.get("coverage", {})
        if not isinstance(coverage, dict) or coverage.get("mode") != "full_catalog":
            raise ValidationError("semantic schema v2 must declare coverage.mode=full_catalog")
        pilot_code = "full_catalog_v2"
        candidate_codes = sorted(feature_codes)
        candidate_seen = set(candidate_codes)

    feature_semantics: List[Dict[str, str]] = []
    feature_tags: List[Dict[str, str]] = []
    semantic_seen = set()
    relation_seen = set()
    confidence_counts: Dict[str, int] = {}
    source_type_counts: Dict[str, int] = {}
    dimension_feature_sets: Dict[str, set] = {code: set() for code in expected_dimensions}
    for item in raw_semantics:
        if not isinstance(item, dict):
            raise ValidationError("invalid feature semantics entry")
        feature_code = str(item.get("feature_code", "")).strip()
        alias = str(item.get("alias_zh", "")).strip()
        alias_source = str(item.get("alias_source_type", "")).strip()
        alias_confidence = str(item.get("alias_confidence", "")).strip()
        alias_evidence = str(item.get("alias_evidence_ref", "")).strip()
        summary = str(item.get("semantic_summary_zh", "")).strip()
        summary_source = str(item.get("summary_source_type", "")).strip()
        summary_confidence = str(item.get("summary_confidence", "")).strip()
        summary_evidence = str(item.get("summary_evidence_ref", "")).strip()
        if feature_code not in feature_codes:
            raise ValidationError("semantic feature is outside maintenance scope: " + feature_code)
        if feature_code in semantic_seen:
            raise ValidationError("duplicate feature semantics: " + feature_code)
        if candidate_seen and feature_code not in candidate_seen:
            raise ValidationError("semantic feature is outside pilot candidates: " + feature_code)
        # v2 is the full managed catalogue.  Its readable alias is a required
        # navigation field; v1 fixtures remain backward compatible.
        if schema_version >= 2:
            if not alias or not CHINESE_CHAR.search(alias):
                raise ValidationError("empty Chinese feature alias: " + feature_code)
            if alias_source not in SEMANTIC_SOURCE_TYPES:
                raise ValidationError("invalid feature alias source_type: " + feature_code)
            if alias_confidence not in SEMANTIC_CONFIDENCES:
                raise ValidationError("invalid feature alias confidence: " + feature_code)
            if not alias_evidence:
                raise ValidationError("empty feature alias evidence_ref: " + feature_code)
        else:
            alias, alias_source, alias_confidence, alias_evidence = summary, summary_source, summary_confidence, summary_evidence
        if not summary:
            raise ValidationError("empty Chinese semantic summary: " + feature_code)
        if summary_source not in SEMANTIC_SOURCE_TYPES:
            raise ValidationError("invalid semantic summary source_type: " + feature_code)
        if summary_confidence not in SEMANTIC_CONFIDENCES:
            raise ValidationError("invalid semantic summary confidence: " + feature_code)
        if not summary_evidence:
            raise ValidationError("empty semantic summary evidence_ref: " + feature_code)
        raw_relations = item.get("tags", [])
        if not isinstance(raw_relations, list) or not raw_relations:
            raise ValidationError("feature semantics declares no tag relations: " + feature_code)
        semantic_seen.add(feature_code)
        feature_semantics.append({
            "feature_code": feature_code, "alias_zh": alias,
            "alias_source_type": alias_source, "alias_confidence": alias_confidence,
            "alias_evidence_ref": alias_evidence, "semantic_summary_zh": summary,
            "source_type": summary_source, "confidence": summary_confidence,
            "evidence_ref": summary_evidence, "search_text_zh": "",
        })
        for relation in raw_relations:
            if not isinstance(relation, dict):
                raise ValidationError("invalid semantic tag relation: " + feature_code)
            tag_code = str(relation.get("tag_code", "")).strip()
            metric_scope = str(relation.get("metric_scope", "")).strip()
            source_type = str(relation.get("source_type", "")).strip()
            confidence = str(relation.get("confidence", "")).strip()
            evidence_ref = str(relation.get("evidence_ref", "")).strip()
            tag = tag_by_code.get(tag_code)
            if tag is None:
                raise ValidationError("unknown semantic tag for feature {}: {}".format(feature_code, tag_code))
            valid_scopes = {"primary", "related"} if tag["dimension"] == "metric" else {""}
            if metric_scope not in valid_scopes:
                raise ValidationError("invalid metric_scope for feature {}/tag {}: {}".format(feature_code, tag_code, metric_scope))
            if source_type not in SEMANTIC_SOURCE_TYPES:
                raise ValidationError("invalid semantic tag source_type: " + source_type)
            if confidence not in SEMANTIC_CONFIDENCES:
                raise ValidationError("invalid semantic tag confidence: " + confidence)
            if not evidence_ref:
                raise ValidationError("empty semantic tag evidence_ref: {}/{}".format(feature_code, tag_code))
            relation_key = (feature_code, tag_code)
            if relation_key in relation_seen:
                raise ValidationError("duplicate semantic tag relation: {}/{}".format(feature_code, tag_code))
            relation_seen.add(relation_key)
            feature_tags.append({
                "feature_code": feature_code, "tag_code": tag_code,
                "metric_scope": metric_scope, "source_type": source_type,
                "confidence": confidence, "evidence_ref": evidence_ref,
            })
            confidence_counts[confidence] = confidence_counts.get(confidence, 0) + 1
            source_type_counts[source_type] = source_type_counts.get(source_type, 0) + 1
            dimension_feature_sets[tag["dimension"]].add(feature_code)

    if semantic_seen != candidate_seen:
        missing = sorted(candidate_seen - semantic_seen)
        extra = sorted(semantic_seen - candidate_seen)
        detail = missing[0] if missing else extra[0]
        raise ValidationError(
            "semantic feature coverage must exactly match pilot candidates: " + detail
        )

    aliases_by_tag: Dict[str, List[str]] = {}
    for item in tag_aliases:
        aliases_by_tag.setdefault(item["tag_code"], []).append(item["alias"])
    relations_by_feature: Dict[str, List[str]] = {}
    for item in feature_tags:
        tag = tag_by_code[item["tag_code"]]
        relations_by_feature.setdefault(item["feature_code"], []).extend(
            [tag["name_zh"], *aliases_by_tag.get(item["tag_code"], [])]
        )
    for item in feature_semantics:
        values = [item["alias_zh"], item["semantic_summary_zh"], *relations_by_feature.get(item["feature_code"], [])]
        item["search_text_zh"] = " ".join(dict.fromkeys(value for value in values if value))

    dimension_tag_counts = {code: sum(1 for tag in tags if tag["dimension"] == code) for code in expected_dimensions}
    audit = {
        "vocabulary_count": len(tags),
        "pilot_candidate_count": len(candidate_codes),
        "tagged_feature_count": len(semantic_seen),
        "feature_semantics_count": len(feature_semantics),
        "feature_alias_count": len([item for item in feature_semantics if item["alias_zh"]]),
        "tag_relation_count": len(feature_tags),
        "alias_count": len(tag_aliases),
        "dimension_tag_counts": dimension_tag_counts,
        "dimension_feature_counts": {code: len(values) for code, values in dimension_feature_sets.items()},
        "confidence_counts": confidence_counts,
        "source_type_counts": source_type_counts,
        "conflict_count": 0,
        "pilot_coverage_rate": (len(semantic_seen) / len(candidate_codes)) if candidate_codes else 0.0,
    }
    return {
        "source_path": relative_path, "source_hash": _sha256(path), "schema_version": schema_version,
        "generation": {key: str(generation.get(key, "")).strip() for key in required_generation},
        "dimensions": dimensions, "tags": tags, "tag_aliases": tag_aliases,
        "feature_semantics": feature_semantics, "feature_tags": feature_tags,
        "pilot": {"code": pilot_code, "candidate_feature_codes": candidate_codes},
        "audit": audit,
    }


def _table_from_feature_code(code: str) -> str:
    parts = code.split(".")
    # ftr.off.usr.<table>.<column>; table names can contain dots in future,
    # hence retain every component between the fixed prefix and the column.
    if len(parts) < 5 or parts[:3] != ["ftr", "off", "usr"]:
        raise ValidationError("unsupported featureCode: " + code)
    return ".".join(parts[3:-1])


def _group_logic(root: Path, directory: str) -> Dict[str, Dict[str, Any]]:
    result: Dict[str, Dict[str, Any]] = {}
    source = root / directory
    if not source.is_dir():
        raise ValidationError("missing group logic directory: " + directory)
    for path in sorted(source.glob("*.json")):
        payload = _read_json(path)
        data = payload.get("data") if isinstance(payload, dict) else None
        if not isinstance(data, dict) or not data.get("groupCode"):
            raise ValidationError("invalid group logic file: " + _relative(path, root))
        code = data["groupCode"]
        if code in result:
            raise ValidationError("duplicate group logic: " + code)
        content = data.get("logicContent", "")
        if not content.strip():
            raise ValidationError("empty group logic: " + code)
        result[code] = {
            "group_code": code,
            "logic_version": str(data.get("logicVersion", "")),
            "modify_time": str(data.get("modifyTime", "")),
            "last_modifier": data.get("lastModifier", ""),
            "logic_content": content,
            "source_path": _relative(path, root),
            "source_hash": _sha256(path),
        }
    return result


def _derivations_for_group(sql: str, columns: Iterable[str]) -> Dict[str, Dict[str, Any]]:
    """Locate all requested columns in one pass through a group SQL script."""
    requested = {column.casefold(): column for column in columns if column}
    lines = sql.splitlines()
    last_line: Dict[str, int] = {}
    for number, line in enumerate(lines, 1):
        for token in re.findall(r"[A-Za-z_][A-Za-z0-9_]*", line):
            if token.casefold() in requested:
                last_line[token.casefold()] = number
    result: Dict[str, Dict[str, Any]] = {}
    for folded, column in requested.items():
        line_number = last_line.get(folded, 0)
        if not line_number:
            result[column] = {"status": "unresolved", "expression": "", "snippet": "", "line_start": 0, "line_end": 0}
            continue
        line = lines[line_number - 1].strip()
        if re.search(r"\bas\s+[`\"]?" + re.escape(column) + r"[`\"]?\b", line, re.I):
            status = "resolved"
        elif re.search(r"(?:\.|^)" + re.escape(column) + r"(?:\s|,|$)", line, re.I):
            status = "pass_through"
        else:
            status = "located"
        start, end = max(1, line_number - 2), min(len(lines), line_number + 2)
        result[column] = {"status": status, "expression": line.rstrip(","), "snippet": "\n".join(lines[start - 1:end]), "line_start": start, "line_end": end}
    return result


def _sql_sections(path: Path, table_name: str) -> List[Dict[str, Any]]:
    content = path.read_text(encoding="utf-8")
    if SQL_LOGIC_UNAVAILABLE.search(content):
        return []
    begins = list(SQL_NODE_BEGIN.finditer(content))
    if not begins:
        raise ValidationError("no SQL node marker in " + str(path))
    sections: List[Dict[str, Any]] = []
    for ordinal, begin in enumerate(begins):
        if int(begin.group(1)) != ordinal:
            raise ValidationError("unexpected node ordinal in SQL export: " + str(path))
        end = SQL_NODE_END.search(content, begin.end())
        if end and int(end.group(1)) != ordinal:
            raise ValidationError("missing node end marker in SQL export: " + str(path))
        if not end and len(begins) != 1:
            raise ValidationError("missing node end marker in multi-node SQL export: " + str(path))
        section_end = end.start() if end else len(content)
        header, separator, sql = content[begin.end():section_end].strip().partition("\n\n")
        if not separator or not sql.strip():
            raise ValidationError("missing SQL body in " + str(path))
        metadata: Dict[str, Any] = {"upstream_table": []}
        for key, value in SQL_HEADER.findall(header):
            if key == "upstream_table":
                metadata[key].append(value)
            else:
                metadata[key] = value
        if metadata.get("table_name") != table_name:
            raise ValidationError("SQL table header does not match file name: " + str(path))
        sections.append({"node_id": metadata.get("node_id", str(ordinal)), "task_name": metadata.get("task_name", ""),
                         "owner_name": metadata.get("owner_name", ""), "upstream_tables": metadata["upstream_table"],
                         "sql_content": sql.strip()})
    return sections


def _declared_table_name(path: Path) -> str:
    match = re.search(r"(?m)^-- table_name: (.+)$", path.read_text(encoding="utf-8"))
    return match.group(1) if match else ""


def _read_dp_nodes(root: Path, table_name: str, path: Path) -> Tuple[List[Dict[str, Any]], List[Dict[str, str]]]:
    data = _sql_sections(path, table_name)
    nodes, dependencies = [], []
    source_path, source_hash = _relative(path, root), _sha256(path)
    for ordinal, item in enumerate(data):
        node_id = str(item["node_id"] or ordinal)
        # A DP response can contain repeated node identifiers for one logical
        # output table.  Preserve every snapshot entry deterministically.
        node_key = table_name + ":" + node_id + ":" + str(ordinal)
        nodes.append({
            "node_key": node_key,
            "table_name": table_name,
            "node_id": node_id,
            "task_name": item["task_name"],
            "owner_name": item["owner_name"],
            "sql_content": item["sql_content"],
            "source_path": source_path,
            "source_hash": source_hash,
        })
        for upstream in item["upstream_tables"]:
            dependencies.append({
                "downstream_table": table_name,
                "upstream_table": upstream,
                "node_key": node_key,
                "source_type": "dp_task_logic",
            })
    return nodes, dependencies


def _dp_logic(root: Path, directory: str) -> Tuple[List[Dict[str, Any]], List[Dict[str, str]]]:
    base = root / directory
    nodes: List[Dict[str, Any]] = []
    dependencies: List[Dict[str, str]] = []
    seen_tables: Dict[str, Tuple[List[Dict[str, Any]], List[Dict[str, str]]]] = {}
    for relative_directory in DP_SQL_DIRECTORIES:
        source_dir = base / relative_directory
        if not source_dir.is_dir():
            raise ValidationError("missing DP SQL directory: " + _relative(source_dir, root))
        for logic_path in sorted(source_dir.glob("*.sql")):
            table_name = logic_path.stem
            # Never attach an export to the wrong table.  Surface the mismatch
            # during validation instead of silently treating its logic as absent.
            if _declared_table_name(logic_path) != table_name:
                raise ValidationError("SQL table header does not match file name: " + _relative(logic_path, root))
            item_nodes, item_dependencies = _read_dp_nodes(root, table_name, logic_path)
            previous = seen_tables.get(table_name)
            if previous:
                previous_signature = [(item["node_id"], item["task_name"], item["owner_name"], item["sql_content"]) for item in previous[0]]
                current_signature = [(item["node_id"], item["task_name"], item["owner_name"], item["sql_content"]) for item in item_nodes]
                if previous_signature != current_signature:
                    raise ValidationError("conflicting SQL exports for table: " + table_name)
                continue
            seen_tables[table_name] = (item_nodes, item_dependencies)
            nodes.extend(item_nodes); dependencies.extend(item_dependencies)
    return nodes, dependencies


def load_managed_catalog(
    project_root: Path, scope_path: Path, validate_semantics: bool = True,
) -> Dict[str, Any]:
    """Load selected features, direct group SQL, and recursive DP task SQL."""
    scope = _read_json(scope_path)
    if scope.get("schema_version") != 1:
        raise ValidationError("unsupported maintenance scope schema")
    standard_warehouse_policy = _standard_warehouse_policy(project_root, scope)
    groups = _group_logic(project_root, scope["group_logic_directory"])
    feature_by_code: Dict[str, Dict[str, Any]] = {}
    feature_scopes: List[Dict[str, str]] = []
    seen_scopes = set()
    source_feature_rows = 0
    manifest_files: Dict[str, str] = {
        _relative(scope_path, project_root): _sha256(scope_path),
        standard_warehouse_policy["source_path"]: standard_warehouse_policy["source_hash"],
    }
    for package in scope.get("packages", []):
        feature_category = package.get("feature_category", "").strip()
        if not feature_category:
            raise ValidationError("empty feature_category for " + package.get("name", "unnamed package"))
        business_stage = str(package.get("business_stage", "")).strip()
        if not business_stage:
            raise ValidationError("empty business_stage for " + package.get("name", "unnamed package"))
        path = project_root / package["feature_file"]
        if not path.is_file():
            raise ValidationError("missing package feature file: " + package["feature_file"])
        rows = _read_json(path)
        if not isinstance(rows, list) or len(rows) != package["expected_feature_count"]:
            raise ValidationError("unexpected feature count for " + package["name"])
        source_feature_rows += len(rows)
        manifest_files[_relative(path, project_root)] = _sha256(path)
        for row in rows:
            code = row.get("featureCode", "")
            if not code:
                raise ValidationError("empty featureCode in " + package["name"])
            group_code = row.get("groupCode", "")
            if group_code not in groups:
                raise ValidationError("feature lacks group logic: " + code)
            feature = {
                "feature_code": code,
                "feature_column_name": row.get("featureColumnName", ""),
                "feature_name": row.get("featureName", ""),
                "feature_category": feature_category,
                "business_stage": business_stage,
                "group_code": group_code,
                "group_name": row.get("groupName", ""),
                "table_name": _table_from_feature_code(code),
                "domain_code": row.get("domainCode", ""),
                "include_today_flag": str(row.get("includeTodayFlag", "")),
                "time_range": str(row.get("timeRange", "")),
                "source_path": _relative(path, project_root),
            }
            current = feature_by_code.get(code)
            if current and any(current[key] != feature[key] for key in ("feature_column_name", "feature_name", "business_stage", "group_code", "table_name")):
                raise ValidationError("conflicting feature metadata for " + code)
            feature_by_code.setdefault(code, feature)
            membership = (code, package["name"])
            if membership not in seen_scopes:
                feature_scopes.append({
                    "feature_code": code,
                    "package_name": package["name"],
                    "feature_category": feature_category,
                })
                seen_scopes.add(membership)
    features = list(feature_by_code.values())
    taxonomy = _managed_feature_taxonomy(project_root, scope, features, source_feature_rows)
    manifest_files[taxonomy["source_path"]] = taxonomy["source_hash"]
    usage_governance = _managed_feature_usage_governance(project_root, scope, features)
    if usage_governance["source_path"]:
        manifest_files[usage_governance["source_path"]] = usage_governance["source_hash"]
    semantics = _managed_feature_semantics(project_root, scope, features) if validate_semantics else {
        "source_path": "", "source_hash": "", "schema_version": 2,
        "generation": {}, "dimensions": [], "tags": [], "tag_aliases": [],
        "feature_semantics": [], "feature_tags": [],
        "pilot": {"code": "", "candidate_feature_codes": []},
        "audit": {
            "vocabulary_count": 0, "pilot_candidate_count": 0,
            "tagged_feature_count": 0, "feature_semantics_count": 0,
            "tag_relation_count": 0, "alias_count": 0,
            "dimension_tag_counts": {}, "dimension_feature_counts": {},
            "confidence_counts": {}, "source_type_counts": {}, "conflict_count": 0,
        },
    }
    if semantics["source_path"]:
        manifest_files[semantics["source_path"]] = semantics["source_hash"]
    dp_nodes, dp_dependencies = _dp_logic(project_root, scope["dp_logic_directory"])
    for row in groups.values():
        manifest_files[row["source_path"]] = row["source_hash"]
    for row in dp_nodes:
        manifest_files[row["source_path"]] = row["source_hash"]
    features_by_group: Dict[str, List[Dict[str, Any]]] = {}
    for feature in features:
        features_by_group.setdefault(feature["group_code"], []).append(feature)
    group_dependencies = []
    derivations = []
    group_references: Dict[str, List[str]] = {}
    for group_code, group_features in features_by_group.items():
        logic = groups[group_code]
        extracted = _derivations_for_group(logic["logic_content"], (item["feature_column_name"] for item in group_features))
        upstreams = sorted(set(TABLE_REFERENCE.findall(logic["logic_content"])))
        group_references[group_code] = upstreams
        for feature in group_features:
            derivations.append({"feature_code": feature["feature_code"], **extracted[feature["feature_column_name"]]})
        for upstream in upstreams:
            for table_name in sorted({item["table_name"] for item in group_features}):
                group_dependencies.append({
                    "downstream_table": table_name,
                    "upstream_table": upstream,
                    "node_key": group_code,
                    "source_type": "group_logic",
                })
    dp_tables = {row["table_name"] for row in dp_nodes}
    tracked_projects = {"pdm_risk", "dwa_risk", "dwa_risk_model"}
    coverage = []
    for feature in features:
        upstreams = group_references[feature["group_code"]]
        dp_upstreams = [upstream for upstream in upstreams if upstream.split(".", 1)[0] in tracked_projects]
        available = [upstream for upstream in dp_upstreams if upstream.rsplit(".", 1)[-1] in dp_tables]
        missing = [upstream for upstream in dp_upstreams if upstream.rsplit(".", 1)[-1] not in dp_tables]
        coverage.append({
            "feature_code": feature["feature_code"],
            "logic_source": "group_logic",
            "coverage_status": "partial" if missing else ("recursive" if available else "direct"),
            "missing_dp_tables": "|".join(sorted(set(missing))),
        })
    dependency_by_key = {}
    for row in dp_dependencies + group_dependencies:
        dependency_by_key[(row["downstream_table"], row["upstream_table"], row["node_key"], row["source_type"])] = row
    return {
        "features": features,
        "feature_scopes": feature_scopes,
        "source_feature_rows": source_feature_rows,
        "group_logic": list(groups.values()),
        "dp_nodes": dp_nodes,
        "dependencies": list(dependency_by_key.values()),
        "derivations": derivations,
        "coverage": coverage,
        "standard_warehouse_policy": standard_warehouse_policy,
        "managed_feature_taxonomy": taxonomy,
        "taxonomy_audit": taxonomy["audit"],
        "managed_feature_usage_governance": usage_governance,
        "usage_governance_records": usage_governance["records"],
        "usage_governance_unmatched_records": usage_governance["unmatched_records"],
        "usage_governance_audit": usage_governance["audit"],
        "managed_feature_semantics": semantics,
        "semantic_dimensions": semantics["dimensions"],
        "semantic_tags": semantics["tags"],
        "semantic_tag_aliases": semantics["tag_aliases"],
        "feature_semantics": semantics["feature_semantics"],
        "feature_tags": semantics["feature_tags"],
        "semantic_audit": semantics["audit"],
        "manifest_files": manifest_files,
    }
