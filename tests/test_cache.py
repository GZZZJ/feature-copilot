import json
import os
import sqlite3
from pathlib import Path

from feature_copilot import cache
from feature_copilot.index_builder import build_index


ROOT = Path(__file__).resolve().parents[1]


def test_explicit_cache_directory_controls_default_database(tmp_path, monkeypatch):
    monkeypatch.delenv("FEATURE_COPILOT_DB", raising=False)
    monkeypatch.setenv("FEATURE_COPILOT_CACHE_DIR", str(tmp_path))
    assert cache.default_database(ROOT) == tmp_path / "feature_copilot.sqlite"
    assert cache.cache_location_is_explicit([]) is True


def test_default_database_is_packaged_with_the_skill(tmp_path, monkeypatch):
    monkeypatch.delenv("FEATURE_COPILOT_DB", raising=False)
    monkeypatch.delenv("FEATURE_COPILOT_CACHE_DIR", raising=False)
    assert cache.default_database(tmp_path) == tmp_path / "knowledge" / "feature_copilot.sqlite"
    assert cache.cache_location_is_explicit([]) is False


def test_source_change_marks_index_stale(tmp_path):
    knowledge = tmp_path / "knowledge"
    import shutil
    shutil.copytree(ROOT / "knowledge", knowledge)
    database = tmp_path / "feature_copilot.sqlite"
    build_index(knowledge, database, ROOT)
    assert cache.index_needs_rebuild(database, knowledge, ROOT) is False
    source = knowledge / "features.csv"
    future = database.stat().st_mtime_ns + 1_000_000_000
    os.utime(source, ns=(future, future))
    assert cache.index_needs_rebuild(database, knowledge, ROOT) is True


def test_database_manifest_build_id_mismatch_marks_index_stale(tmp_path):
    knowledge = tmp_path / "knowledge"
    import shutil
    shutil.copytree(ROOT / "knowledge", knowledge)
    database = tmp_path / "feature_copilot.sqlite"
    build_index(knowledge, database, ROOT)
    manifest_path = database.with_suffix(".manifest.json")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest["build_id"] = "different-build"
    manifest_path.write_text(json.dumps(manifest), encoding="utf-8")

    assert cache.index_needs_rebuild(database, knowledge, ROOT) is True


def test_standard_warehouse_policy_change_marks_index_stale(tmp_path):
    import shutil
    knowledge = tmp_path / "knowledge"
    shutil.copytree(ROOT / "knowledge", knowledge)
    database = tmp_path / "feature_copilot.sqlite"
    build_index(knowledge, database, ROOT)
    policy = ROOT / "knowledge" / "config" / "standard_warehouse_tables.json"
    original = policy.stat()
    try:
        future = database.stat().st_mtime_ns + 1_000_000_000
        os.utime(policy, ns=(future, future))
        assert cache.index_needs_rebuild(database, ROOT / "knowledge", ROOT) is True
    finally:
        os.utime(policy, ns=(original.st_atime_ns, original.st_mtime_ns))


def test_new_dp_sql_file_marks_index_stale(tmp_path):
    project = tmp_path / "project"
    knowledge = project / "knowledge"
    config = knowledge / "config"
    dp_logic = project / "goal" / "dp_table_logic"
    group_logic = project / "goal" / "group_logic"
    config.mkdir(parents=True)
    dp_logic.mkdir(parents=True)
    group_logic.mkdir(parents=True)
    for filename in cache.KNOWLEDGE_FILES:
        (knowledge / filename).write_text("", encoding="utf-8")
    (config / "standard.json").write_text("{}", encoding="utf-8")
    (config / "maintenance_scope.json").write_text(json.dumps({
        "packages": [],
        "group_logic_directory": "goal/group_logic",
        "dp_logic_directory": "goal/dp_table_logic",
        "standard_warehouse_config": "knowledge/config/standard.json",
    }), encoding="utf-8")
    database = tmp_path / "feature_copilot.sqlite"
    connection = sqlite3.connect(database)
    connection.execute("CREATE TABLE metadata(key TEXT PRIMARY KEY, value TEXT NOT NULL)")
    connection.execute("INSERT INTO metadata VALUES ('build_id', 'test-build')")
    connection.commit()
    connection.close()
    database.with_suffix(".manifest.json").write_text(
        json.dumps({
            "schema_version": 3,
            "build_id": "test-build",
            "knowledge_source_hashes": {
                filename: __import__("hashlib").sha256(b"").hexdigest()
                for filename in cache.KNOWLEDGE_FILES
            },
        }),
        encoding="utf-8",
    )
    assert cache.index_needs_rebuild(database, knowledge, project) is False
    (dp_logic / "new_table.sql").write_text("-- new asset", encoding="utf-8")
    future = database.stat().st_mtime_ns + 1_000_000_000
    os.utime(dp_logic / "new_table.sql", ns=(future, future))
    assert cache.index_needs_rebuild(database, knowledge, project) is True

