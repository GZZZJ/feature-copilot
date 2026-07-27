import hashlib
import json
import os
import sqlite3
import tempfile
import uuid
from contextlib import contextmanager
from datetime import datetime, timezone
from pathlib import Path
from typing import Callable, Dict, Iterator, List, Optional

try:  # POSIX cache locations need a cross-process commit guard.
    import fcntl
except ImportError:  # pragma: no cover - Windows keeps the existing safe rollback path.
    fcntl = None

from .errors import ValidationError
from .cache import _managed_source_paths
from .logic_catalog import load_managed_catalog
from .models import AVAILABILITY_COLUMNS, FEATURE_COLUMNS, PERFORMANCE_COLUMNS, TABLE_COLUMNS, Finding
from .validators import load_csv, validate_knowledge


def _hash(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _managed_source_snapshot(project_root: Path) -> Dict[str, str]:
    """Hash every governed managed input so mid-build changes cannot be published."""
    snapshot = {}
    for path in _managed_source_paths(project_root):
        if path.is_file():
            snapshot[path.resolve().relative_to(project_root.resolve()).as_posix()] = _hash(path)
    return snapshot


def _create_schema(connection: sqlite3.Connection, force_fts_unavailable: bool = False) -> bool:
    connection.executescript("""
    CREATE TABLE features (feature_id TEXT PRIMARY KEY, feature_name TEXT NOT NULL, cn_meaning TEXT, technical_definition TEXT, formula TEXT, source_table TEXT, category TEXT, owner_team TEXT, applicable_scene TEXT, population TEXT, sample_scope TEXT, grain TEXT, time_window TEXT, stat_method TEXT, derive_type TEXT, logic_ref TEXT, status TEXT, version TEXT, synced_at TEXT, definition_source TEXT, definition_confidence TEXT);
    CREATE TABLE tables_kb (table_id TEXT PRIMARY KEY, table_name TEXT UNIQUE, cn_name TEXT, description TEXT, category TEXT, grain TEXT, update_frequency TEXT, owner_team TEXT, applicable_scene TEXT, population TEXT, derive_type TEXT, logic_ref TEXT, status TEXT, synced_at TEXT);
    CREATE TABLE performance (record_id TEXT PRIMARY KEY, feature_id TEXT, feature_name TEXT, project TEXT, model_version TEXT, population TEXT, label_definition TEXT, observation_period TEXT, performance_period TEXT, eval_date TEXT, iv REAL, importance REAL, psi REAL, auc_delta REAL, ks_delta REAL, tail_1pct_lift REAL, tail_5pct_lift REAL, tail_10pct_lift REAL, conclusion TEXT, exclusion_reason TEXT, source_ref TEXT);
    CREATE TABLE availability (record_id TEXT PRIMARY KEY, feature_id TEXT, feature_name TEXT, scene TEXT, population TEXT, product TEXT, available_from TEXT, available_to TEXT, observation_timing TEXT, availability_status TEXT, restriction TEXT, evidence_ref TEXT, updated_at TEXT);
    CREATE TABLE managed_features (feature_code TEXT PRIMARY KEY, feature_column_name TEXT NOT NULL, feature_name TEXT NOT NULL, feature_category TEXT NOT NULL, business_subcategory_code TEXT NOT NULL, business_subcategory_name TEXT NOT NULL, business_subcategory_sort_order INTEGER NOT NULL, group_code TEXT NOT NULL, group_name TEXT, table_name TEXT NOT NULL, domain_code TEXT, include_today_flag TEXT, time_range TEXT, source_path TEXT NOT NULL);
    CREATE TABLE managed_feature_scopes (feature_code TEXT NOT NULL, package_name TEXT NOT NULL, feature_category TEXT NOT NULL, PRIMARY KEY(feature_code, package_name));
    CREATE TABLE managed_feature_usage_governance (feature_code TEXT PRIMARY KEY, usage_status TEXT NOT NULL, usage_label TEXT NOT NULL, reason_code TEXT NOT NULL, reason_label TEXT NOT NULL, message TEXT NOT NULL, source_ref TEXT NOT NULL, FOREIGN KEY(feature_code) REFERENCES managed_features(feature_code));
    CREATE TABLE managed_unmatched_usage_governance (feature_column_name TEXT PRIMARY KEY, usage_status TEXT NOT NULL, usage_label TEXT NOT NULL, reason_code TEXT NOT NULL, reason_label TEXT NOT NULL, message TEXT NOT NULL, source_ref TEXT NOT NULL);
    CREATE TABLE managed_tag_dimensions (dimension_id INTEGER PRIMARY KEY AUTOINCREMENT, code TEXT NOT NULL UNIQUE, name_zh TEXT NOT NULL);
    CREATE TABLE managed_tags (tag_id INTEGER PRIMARY KEY AUTOINCREMENT, code TEXT NOT NULL UNIQUE, dimension_id INTEGER NOT NULL, name_zh TEXT NOT NULL, FOREIGN KEY(dimension_id) REFERENCES managed_tag_dimensions(dimension_id));
    CREATE TABLE managed_tag_aliases (alias_id INTEGER PRIMARY KEY AUTOINCREMENT, tag_id INTEGER NOT NULL, alias TEXT NOT NULL, alias_type TEXT NOT NULL, UNIQUE(tag_id, alias, alias_type), FOREIGN KEY(tag_id) REFERENCES managed_tags(tag_id));
    CREATE TABLE managed_feature_semantics (feature_id INTEGER PRIMARY KEY, alias_zh TEXT NOT NULL, alias_source_type TEXT NOT NULL, alias_confidence TEXT NOT NULL, alias_evidence_ref TEXT NOT NULL, semantic_summary_zh TEXT NOT NULL, search_text_zh TEXT NOT NULL, source_type TEXT NOT NULL, confidence TEXT NOT NULL, evidence_ref TEXT NOT NULL, FOREIGN KEY(feature_id) REFERENCES managed_features(rowid));
    CREATE TABLE managed_feature_tags (feature_id INTEGER NOT NULL, tag_id INTEGER NOT NULL, metric_scope TEXT NOT NULL, source_type TEXT NOT NULL, confidence TEXT NOT NULL, evidence_ref TEXT NOT NULL, PRIMARY KEY(feature_id, tag_id), FOREIGN KEY(feature_id) REFERENCES managed_features(rowid), FOREIGN KEY(tag_id) REFERENCES managed_tags(tag_id));
    CREATE TABLE group_logic (group_code TEXT PRIMARY KEY, logic_version TEXT, modify_time TEXT, last_modifier TEXT, logic_content TEXT NOT NULL, source_path TEXT NOT NULL, source_hash TEXT NOT NULL);
    CREATE TABLE dp_logic_nodes (node_key TEXT PRIMARY KEY, table_name TEXT NOT NULL, node_id TEXT, task_name TEXT, owner_name TEXT, sql_content TEXT NOT NULL, source_path TEXT NOT NULL, source_hash TEXT NOT NULL);
    CREATE TABLE table_lineage_edges (downstream_table TEXT NOT NULL, upstream_table TEXT NOT NULL, node_key TEXT NOT NULL, source_type TEXT NOT NULL, PRIMARY KEY(downstream_table, upstream_table, node_key, source_type));
    CREATE TABLE column_derivations (feature_code TEXT PRIMARY KEY, status TEXT NOT NULL, expression TEXT, snippet TEXT, line_start INTEGER, line_end INTEGER);
    CREATE TABLE logic_coverage (feature_code TEXT PRIMARY KEY, logic_source TEXT NOT NULL, coverage_status TEXT NOT NULL, missing_dp_tables TEXT);
    CREATE TABLE metadata (key TEXT PRIMARY KEY, value TEXT NOT NULL);
    CREATE INDEX idx_features_name ON features(feature_name COLLATE NOCASE);
    CREATE INDEX idx_features_filters ON features(category, source_table, status, owner_team, time_window, derive_type);
    CREATE INDEX idx_tables_name ON tables_kb(table_name COLLATE NOCASE);
    CREATE INDEX idx_perf_filter ON performance(project, model_version, population, eval_date);
    CREATE INDEX idx_availability_feature ON availability(feature_id, scene, population);
    CREATE INDEX idx_managed_features_column ON managed_features(feature_column_name COLLATE NOCASE);
    CREATE INDEX idx_managed_features_category ON managed_features(feature_category);
    CREATE INDEX idx_managed_features_business_subcategory ON managed_features(business_subcategory_code, business_subcategory_sort_order);
    CREATE INDEX idx_managed_features_group ON managed_features(group_code);
    CREATE INDEX idx_managed_features_taxonomy ON managed_features(feature_category, business_subcategory_code, group_code);
    CREATE INDEX idx_managed_features_table ON managed_features(table_name);
    CREATE INDEX idx_managed_feature_scopes_package ON managed_feature_scopes(package_name, feature_code);
    CREATE INDEX idx_managed_feature_scopes_category ON managed_feature_scopes(feature_category, feature_code);
    CREATE INDEX idx_managed_feature_usage_governance_status ON managed_feature_usage_governance(usage_status, feature_code);
    CREATE INDEX idx_managed_tags_dimension ON managed_tags(dimension_id, code);
    CREATE INDEX idx_managed_tag_aliases_lookup ON managed_tag_aliases(alias COLLATE NOCASE, tag_id);
    CREATE INDEX idx_managed_feature_tags_tag ON managed_feature_tags(tag_id, metric_scope, feature_id);
    CREATE INDEX idx_dp_logic_nodes_table ON dp_logic_nodes(table_name);
    CREATE INDEX idx_table_lineage_downstream ON table_lineage_edges(downstream_table, source_type);
    CREATE INDEX idx_table_lineage_upstream ON table_lineage_edges(upstream_table, source_type);
    """)
    if force_fts_unavailable:
        return False
    try:
        connection.execute("CREATE VIRTUAL TABLE feature_search USING fts5(feature_id UNINDEXED, feature_name, cn_meaning, technical_definition, category, source_table)")
        connection.execute("CREATE VIRTUAL TABLE managed_feature_search USING fts5(feature_code UNINDEXED, feature_column_name, feature_name, business_subcategory_name, group_name, table_name)")
        return True
    except sqlite3.OperationalError:
        return False


def _insert(connection: sqlite3.Connection, table: str, columns: List[str], rows: List[Dict[str, str]]) -> None:
    statement = "INSERT INTO {} ({}) VALUES ({})".format(table, ", ".join(columns), ", ".join("?" for _ in columns))
    connection.executemany(statement, [tuple(row.get(column, "") for column in columns) for row in rows])


def _insert_managed_catalog(connection: sqlite3.Connection, catalog: Dict[str, object], fts5: bool) -> None:
    columns = {
        "managed_features": ["feature_code", "feature_column_name", "feature_name", "feature_category", "business_subcategory_code", "business_subcategory_name", "business_subcategory_sort_order", "group_code", "group_name", "table_name", "domain_code", "include_today_flag", "time_range", "source_path"],
        "managed_feature_scopes": ["feature_code", "package_name", "feature_category"],
        "managed_feature_usage_governance": ["feature_code", "usage_status", "usage_label", "reason_code", "reason_label", "message", "source_ref"],
        "managed_unmatched_usage_governance": ["feature_column_name", "usage_status", "usage_label", "reason_code", "reason_label", "message", "source_ref"],
        "group_logic": ["group_code", "logic_version", "modify_time", "last_modifier", "logic_content", "source_path", "source_hash"],
        "dp_logic_nodes": ["node_key", "table_name", "node_id", "task_name", "owner_name", "sql_content", "source_path", "source_hash"],
        "table_lineage_edges": ["downstream_table", "upstream_table", "node_key", "source_type"],
        "column_derivations": ["feature_code", "status", "expression", "snippet", "line_start", "line_end"],
        "logic_coverage": ["feature_code", "logic_source", "coverage_status", "missing_dp_tables"],
    }
    mapping = {"managed_features": "features", "managed_feature_scopes": "feature_scopes", "managed_feature_usage_governance": "usage_governance_records", "managed_unmatched_usage_governance": "usage_governance_unmatched_records", "group_logic": "group_logic", "dp_logic_nodes": "dp_nodes", "table_lineage_edges": "dependencies", "column_derivations": "derivations", "logic_coverage": "coverage"}
    for table, key in mapping.items():
        _insert(connection, table, columns[table], catalog[key])
    _insert_managed_semantics(connection, catalog)
    if fts5:
        connection.execute("INSERT INTO managed_feature_search SELECT feature_code, feature_column_name, feature_name, business_subcategory_name, group_name, table_name FROM managed_features")


def _insert_managed_semantics(connection: sqlite3.Connection, catalog: Dict[str, object]) -> None:
    """Insert normalized semantic rows after their managed-feature parents."""
    _insert(connection, "managed_tag_dimensions", ["code", "name_zh"], catalog.get("semantic_dimensions", []))
    dimension_ids = {
        row[1]: row[0]
        for row in connection.execute("SELECT dimension_id, code FROM managed_tag_dimensions")
    }
    tag_rows = [
        {"code": row["code"], "dimension_id": dimension_ids[row["dimension"]], "name_zh": row["name_zh"]}
        for row in catalog.get("semantic_tags", [])
    ]
    _insert(connection, "managed_tags", ["code", "dimension_id", "name_zh"], tag_rows)
    tag_ids = {
        row[1]: row[0]
        for row in connection.execute("SELECT tag_id, code FROM managed_tags")
    }
    alias_rows = [
        {"tag_id": tag_ids[row["tag_code"]], "alias": row["alias"], "alias_type": row["alias_type"]}
        for row in catalog.get("semantic_tag_aliases", [])
    ]
    _insert(connection, "managed_tag_aliases", ["tag_id", "alias", "alias_type"], alias_rows)
    feature_ids = {row[1]: row[0] for row in connection.execute("SELECT rowid, feature_code FROM managed_features")}
    semantic_rows = [
        {**row, "feature_id": feature_ids[row["feature_code"]]}
        for row in catalog.get("feature_semantics", [])
    ]
    _insert(
        connection, "managed_feature_semantics",
        ["feature_id", "alias_zh", "alias_source_type", "alias_confidence", "alias_evidence_ref", "semantic_summary_zh", "search_text_zh", "source_type", "confidence", "evidence_ref"],
        semantic_rows,
    )
    relation_rows = [
        {
            "feature_id": feature_ids[row["feature_code"]], "tag_id": tag_ids[row["tag_code"]],
            "metric_scope": row["metric_scope"], "source_type": row["source_type"],
            "confidence": row["confidence"], "evidence_ref": row["evidence_ref"],
        }
        for row in catalog.get("feature_tags", [])
    ]
    _insert(
        connection, "managed_feature_tags",
        ["feature_id", "tag_id", "metric_scope", "source_type", "confidence", "evidence_ref"],
        relation_rows,
    )


def _write_manifest(
    database_path: Path,
    catalog: Optional[Dict[str, object]],
    knowledge_source_hashes: Optional[Dict[str, str]] = None,
    build_id: str = "",
) -> str:
    manifest_path = database_path.with_suffix(".manifest.json")
    payload = {
        "schema_version": 3,
        "managed_assets": bool(catalog),
        "knowledge_source_hashes": knowledge_source_hashes or {},
        "build_id": build_id,
    }
    if catalog:
        payload.update({"managed_feature_count": len(catalog["features"]), "source_feature_rows": catalog["source_feature_rows"], "source_file_count": len(catalog["manifest_files"]), "source_hashes": catalog["manifest_files"], "semantic_audit": catalog.get("semantic_audit", {})})
    descriptor, temporary_name = tempfile.mkstemp(prefix="feature_copilot_manifest_", suffix=".json", dir=str(database_path.parent))
    os.close(descriptor)
    temporary = Path(temporary_name)
    try:
        temporary.write_text(json.dumps(payload, ensure_ascii=False, sort_keys=True, indent=2) + "\n", encoding="utf-8")
        os.replace(str(temporary), str(manifest_path))
    except Exception:
        temporary.unlink(missing_ok=True)
        raise
    return str(manifest_path)


def _unused_backup_path(directory: Path, suffix: str) -> Path:
    descriptor, name = tempfile.mkstemp(
        prefix="feature_copilot_previous_", suffix=suffix, dir=str(directory)
    )
    os.close(descriptor)
    path = Path(name)
    path.unlink()
    return path


@contextmanager
def _index_commit_lock(database_path: Path) -> Iterator[None]:
    """Serialize publication of a database/manifest pair across CLI processes."""
    lock_path = database_path.with_suffix(database_path.suffix + ".lock")
    descriptor = os.open(str(lock_path), os.O_CREAT | os.O_RDWR, 0o600)
    try:
        if fcntl is not None:
            fcntl.flock(descriptor, fcntl.LOCK_EX)
        yield
    finally:
        try:
            if fcntl is not None:
                fcntl.flock(descriptor, fcntl.LOCK_UN)
        finally:
            os.close(descriptor)


def _replace_index_pair(
    temp_database: Path,
    temp_manifest: Path,
    database_path: Path,
    precommit_check: Optional[Callable[[], None]] = None,
) -> None:
    """Commit database and manifest together, restoring the old pair on failure."""
    with _index_commit_lock(database_path):
        if precommit_check:
            precommit_check()
        _replace_index_pair_locked(temp_database, temp_manifest, database_path)


def _replace_index_pair_locked(
    temp_database: Path, temp_manifest: Path, database_path: Path
) -> None:
    """Publish an index pair while preserving recoverable backups on rollback failure."""
    manifest_path = database_path.with_suffix(".manifest.json")
    database_backup: Optional[Path] = None
    manifest_backup: Optional[Path] = None
    database_existed = database_path.exists()
    manifest_existed = manifest_path.exists()
    database_installed = False
    manifest_installed = False
    try:
        if database_existed:
            database_backup = _unused_backup_path(database_path.parent, ".sqlite.bak")
            os.link(str(database_path), str(database_backup))
        if manifest_existed:
            manifest_backup = _unused_backup_path(database_path.parent, ".manifest.json.bak")
            os.link(str(manifest_path), str(manifest_backup))
        os.replace(str(temp_database), str(database_path))
        database_installed = True
        os.replace(str(temp_manifest), str(manifest_path))
        manifest_installed = True
    except Exception as install_error:
        rollback_errors = []
        for target, backup, existed, installed in (
            (database_path, database_backup, database_existed, database_installed),
            (manifest_path, manifest_backup, manifest_existed, manifest_installed),
        ):
            try:
                if not installed:
                    if backup and backup.exists():
                        backup.unlink()
                elif existed and backup and backup.exists():
                    os.replace(str(backup), str(target))
                elif not existed and target.exists():
                    target.unlink()
                else:
                    raise OSError(f"missing rollback backup for {target}")
            except OSError as rollback_error:
                rollback_errors.append(f"{target}: {rollback_error}")
        if rollback_errors:
            preserved = [
                str(backup)
                for backup in (database_backup, manifest_backup)
                if backup and backup.exists()
            ]
            raise RuntimeError(
                "index publication failed and rollback was incomplete; "
                f"preserved_backups={preserved}; errors={rollback_errors}"
            ) from install_error
        raise
    else:
        for backup in (database_backup, manifest_backup):
            if backup:
                try:
                    backup.unlink(missing_ok=True)
                except OSError:
                    pass


def build_index(knowledge_dir: Path, database_path: Path, project_root: Path, force_fts_unavailable: bool = False, include_managed_assets: Optional[bool] = None) -> Dict[str, object]:
    findings = validate_knowledge(knowledge_dir, project_root)
    errors = [finding for finding in findings if finding.severity == "ERROR"]
    if errors:
        raise ValidationError(json.dumps([item.to_dict() for item in errors], ensure_ascii=False))
    source_files = ["features.csv", "tables.csv", "performance.csv", "availability.csv"]
    source_hashes = {filename: _hash(knowledge_dir / filename) for filename in source_files}
    build_id = uuid.uuid4().hex
    # A copied knowledge fixture in unit tests must remain small and isolated.
    # Normal production builds use the repository's canonical knowledge folder.
    if include_managed_assets is None:
        include_managed_assets = knowledge_dir.resolve() == (project_root / "knowledge").resolve()
    managed_source_hashes = _managed_source_snapshot(project_root) if include_managed_assets else {}
    catalog = load_managed_catalog(project_root, project_root / "knowledge" / "config" / "maintenance_scope.json") if include_managed_assets else None
    managed_manifest_hash = hashlib.sha256(json.dumps(catalog["manifest_files"], sort_keys=True).encode("utf-8")).hexdigest() if catalog else ""
    database_path.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temporary_name = tempfile.mkstemp(prefix="feature_copilot_", suffix=".sqlite", dir=str(database_path.parent))
    os.close(descriptor)
    temp_path = Path(temporary_name)
    temp_manifest_path: Optional[Path] = None
    try:
        connection = sqlite3.connect(str(temp_path))
        try:
            fts5 = _create_schema(connection, force_fts_unavailable)
            _insert(connection, "features", FEATURE_COLUMNS, load_csv(knowledge_dir / "features.csv"))
            _insert(connection, "tables_kb", TABLE_COLUMNS, load_csv(knowledge_dir / "tables.csv"))
            _insert(connection, "performance", PERFORMANCE_COLUMNS, load_csv(knowledge_dir / "performance.csv"))
            _insert(connection, "availability", AVAILABILITY_COLUMNS, load_csv(knowledge_dir / "availability.csv"))
            if fts5:
                connection.execute("INSERT INTO feature_search SELECT feature_id, feature_name, cn_meaning, technical_definition, category, source_table FROM features")
            if catalog:
                _insert_managed_catalog(connection, catalog, fts5)
            taxonomy = catalog["managed_feature_taxonomy"] if catalog else {}
            audit = catalog["taxonomy_audit"] if catalog else {}
            semantics = catalog["managed_feature_semantics"] if catalog else {}
            semantic_audit = catalog["semantic_audit"] if catalog else {}
            usage_governance = catalog["managed_feature_usage_governance"] if catalog else {}
            usage_governance_audit = catalog["usage_governance_audit"] if catalog else {}
            metadata = {"build_id": build_id, "built_at": datetime.now(timezone.utc).isoformat(), "source_hashes": json.dumps(source_hashes, sort_keys=True), "fts5": json.dumps(fts5), "managed_assets": json.dumps(bool(catalog)), "managed_feature_count": str(len(catalog["features"]) if catalog else 0), "managed_source_feature_rows": str(catalog["source_feature_rows"] if catalog else 0), "managed_manifest_sha256": managed_manifest_hash,
                        "standard_warehouse_policy": json.dumps(catalog["standard_warehouse_policy"] if catalog else {}, ensure_ascii=False, sort_keys=True),
                        "managed_feature_taxonomy": json.dumps(taxonomy, ensure_ascii=False, sort_keys=True),
                        "managed_taxonomy_audit": json.dumps(audit, ensure_ascii=False, sort_keys=True),
                        "managed_subcategory_count": str(len(taxonomy.get("subcategories", []))),
                        "managed_group_count": str(audit.get("unique_group_count", 0)),
                        "managed_taxonomy_classified_count": str(audit.get("classified_feature_count", 0)),
                        "managed_taxonomy_override_count": str(audit.get("feature_override_count", 0)),
                        "managed_taxonomy_unclassified_count": str(audit.get("unclassified_count", 0)),
                        "managed_feature_usage_governance": json.dumps(usage_governance, ensure_ascii=False, sort_keys=True),
                        "managed_usage_governance_audit": json.dumps(usage_governance_audit, ensure_ascii=False, sort_keys=True),
                        "managed_usage_governance_count": str(usage_governance_audit.get("governed_feature_count", 0)),
                        "managed_usage_governance_unmatched_count": str(usage_governance_audit.get("unmatched_feature_count", 0)),
                        "managed_feature_semantics": json.dumps({
                            "schema_version": semantics.get("schema_version", 1),
                            "generation": semantics.get("generation", {}),
                            "pilot": semantics.get("pilot", {}),
                        }, ensure_ascii=False, sort_keys=True),
                        "managed_semantic_audit": json.dumps(semantic_audit, ensure_ascii=False, sort_keys=True),
                        "managed_semantic_tag_count": str(semantic_audit.get("vocabulary_count", 0)),
                        "managed_semantic_feature_count": str(semantic_audit.get("tagged_feature_count", 0)),
                        "managed_semantic_relation_count": str(semantic_audit.get("tag_relation_count", 0))}
            connection.executemany("INSERT INTO metadata(key, value) VALUES (?, ?)", metadata.items())
            connection.commit()
        finally:
            connection.close()
        temp_manifest_path = Path(
            _write_manifest(temp_path, catalog, source_hashes, build_id=build_id)
        )

        def verify_inputs_unchanged() -> None:
            current_knowledge_hashes = {
                filename: _hash(knowledge_dir / filename) for filename in source_files
            }
            if current_knowledge_hashes != source_hashes:
                raise ValidationError("knowledge sources changed during index build")
            if include_managed_assets and _managed_source_snapshot(project_root) != managed_source_hashes:
                raise ValidationError("managed sources changed during index build")

        _replace_index_pair(
            temp_path,
            temp_manifest_path,
            database_path,
            precommit_check=verify_inputs_unchanged,
        )
    except Exception:
        temp_path.unlink(missing_ok=True)
        if temp_manifest_path:
            temp_manifest_path.unlink(missing_ok=True)
        raise
    manifest = str(database_path.with_suffix(".manifest.json"))
    return {"database": str(database_path), "manifest": manifest, "source_hashes": source_hashes, "fts5": fts5, "managed_assets": bool(catalog), "managed_feature_count": len(catalog["features"]) if catalog else 0, "managed_source_feature_rows": catalog["source_feature_rows"] if catalog else 0, "managed_source_file_count": len(catalog["manifest_files"]) if catalog else 0, "managed_taxonomy_audit": catalog["taxonomy_audit"] if catalog else {}, "managed_semantic_audit": catalog["semantic_audit"] if catalog else {}, "findings": [f.to_dict() for f in findings]}
