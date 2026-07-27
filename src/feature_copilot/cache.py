"""Resolve and validate the generated query-index cache."""
import hashlib
import json
import os
import sqlite3
from pathlib import Path
from typing import Iterable, List


KNOWLEDGE_FILES = (
    "features.csv",
    "tables.csv",
    "performance.csv",
    "availability.csv",
)


def default_database(project_root: Path) -> Path:
    """Return the package-owned index unless a caller explicitly overrides it."""
    explicit_database = os.environ.get("FEATURE_COPILOT_DB")
    if explicit_database:
        return Path(explicit_database).expanduser()

    explicit_directory = os.environ.get("FEATURE_COPILOT_CACHE_DIR")
    if explicit_directory:
        return Path(explicit_directory).expanduser() / "feature_copilot.sqlite"
    return project_root / "knowledge" / "feature_copilot.sqlite"


def cache_location_is_explicit(argv: Iterable[str]) -> bool:
    return bool(
        os.environ.get("FEATURE_COPILOT_DB")
        or os.environ.get("FEATURE_COPILOT_CACHE_DIR")
        or any(argument == "--db" or argument.startswith("--db=") for argument in argv)
    )


def _managed_source_paths(project_root: Path) -> List[Path]:
    scope_path = project_root / "knowledge" / "config" / "maintenance_scope.json"
    paths = [scope_path]
    try:
        scope = json.loads(scope_path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return paths
    paths.extend(project_root / item["feature_file"] for item in scope.get("packages", []))
    standard_config = project_root / scope.get("standard_warehouse_config", "")
    if standard_config.is_file():
        paths.append(standard_config)
    taxonomy_config = project_root / scope.get("managed_feature_taxonomy_config", "")
    if taxonomy_config.is_file():
        paths.append(taxonomy_config)
    semantics_config = project_root / scope.get("managed_feature_semantics_config", "")
    if semantics_config.is_file():
        paths.append(semantics_config)
    usage_governance_config = project_root / scope.get("managed_feature_usage_governance_config", "")
    if usage_governance_config.is_file():
        paths.append(usage_governance_config)
    group_directory = project_root / scope.get("group_logic_directory", "")
    dp_directory = project_root / scope.get("dp_logic_directory", "")
    if group_directory.is_dir():
        paths.append(group_directory)
        paths.extend(sorted(group_directory.glob("*.json")))
    if dp_directory.is_dir():
        paths.append(dp_directory)
        paths.extend(path for path in sorted(dp_directory.rglob("*")) if path.is_dir() or path.suffix == ".sql")
    return paths


def index_needs_rebuild(database: Path, knowledge_dir: Path, project_root: Path) -> bool:
    if not database.is_file():
        return True
    manifest = database.with_suffix(".manifest.json")
    if not manifest.is_file():
        return True
    try:
        payload = json.loads(manifest.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return True
    if payload.get("schema_version") != 3:
        return True
    expected_build_id = payload.get("build_id")
    if not isinstance(expected_build_id, str) or not expected_build_id:
        return True
    try:
        connection = sqlite3.connect(database.resolve().as_uri() + "?mode=ro", uri=True)
        try:
            row = connection.execute(
                "SELECT value FROM metadata WHERE key = 'build_id'"
            ).fetchone()
        finally:
            connection.close()
    except sqlite3.Error:
        return True
    if not row or row[0] != expected_build_id:
        return True

    source_paths = [knowledge_dir / name for name in KNOWLEDGE_FILES]
    if knowledge_dir.resolve() == (project_root / "knowledge").resolve():
        source_paths.extend(_managed_source_paths(project_root))
    try:
        database_mtime = database.stat().st_mtime_ns
        if any(path.stat().st_mtime_ns > database_mtime for path in source_paths):
            return True
        # Governed JSON configs are small but operationally significant.  Compare
        # their recorded content hashes as well as mtimes so restored/copied files
        # cannot silently reuse an index built from different semantics.
        recorded_hashes = payload.get("source_hashes", {})
        if isinstance(recorded_hashes, dict):
            for relative_path, expected_hash in recorded_hashes.items():
                path = project_root / relative_path
                if str(relative_path).lower().endswith(".json"):
                    if not path.is_file():
                        return True
                    if path.stat().st_size <= 1_000_000 and hashlib.sha256(path.read_bytes()).hexdigest() != expected_hash:
                        return True
        knowledge_hashes = payload.get("knowledge_source_hashes", {})
        if not isinstance(knowledge_hashes, dict):
            return True
        for filename in KNOWLEDGE_FILES:
            expected_hash = knowledge_hashes.get(filename)
            path = knowledge_dir / filename
            if not expected_hash or hashlib.sha256(path.read_bytes()).hexdigest() != expected_hash:
                return True
        return False
    except OSError:
        return True
