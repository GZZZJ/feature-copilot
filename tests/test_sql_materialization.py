import sqlite3

from feature_copilot.service import FeatureService
from feature_copilot.sql_materialization import find_materializations


def test_materialization_parser_supports_writes_and_ignores_comments():
    sql = """
-- create table dwa_risk.comment_only as select 1;
/*
insert overwrite table dwa_risk.block_comment_only select 1;
*/
CREATE EXTERNAL TABLE IF NOT EXISTS `dwa_risk`.`Created_Table` AS SELECT 1;
create temporary table ${dm}.variable_table as select 1;
INSERT OVERWRITE TABLE dwa_risk.inserted_table SELECT 1;
select '-- create table dwa_risk.string_only' as literal;
"""
    found = find_materializations(sql)
    assert [(item["type"], item["table_name"]) for item in found] == [
        ("create_table", "dwa_risk.created_table"),
        ("create_table", "${dm}.variable_table"),
        ("insert_overwrite", "dwa_risk.inserted_table"),
    ]
    assert [item["line_start"] for item in found] == [6, 7, 8]


def test_inline_lookup_prefers_full_table_and_rejects_ambiguous_fallback(tmp_path):
    database = tmp_path / "inline.sqlite"
    connection = sqlite3.connect(database)
    connection.executescript("""
        CREATE TABLE metadata (key TEXT PRIMARY KEY, value TEXT NOT NULL);
        INSERT INTO metadata(key, value) VALUES ('standard_warehouse_policy', '{}');
        CREATE TABLE dp_logic_nodes (
            node_key TEXT PRIMARY KEY,
            table_name TEXT NOT NULL,
            node_id TEXT,
            task_name TEXT,
            owner_name TEXT,
            sql_content TEXT NOT NULL,
            source_path TEXT NOT NULL,
            source_hash TEXT NOT NULL
        );
    """)
    rows = [
        ("a", "host_a", "create table schema_a.same_name as select 1", "a.sql"),
        ("b", "host_b", "create table schema_b.same_name as select 1", "b.sql"),
        ("v", "host_v", "create table ${dm}.same_name as select 1", "v.sql"),
        ("u", "host_u", "create table ${dm}.unique_name as select 1", "u.sql"),
    ]
    connection.executemany(
        "INSERT INTO dp_logic_nodes VALUES (?, ?, '', '', '', ?, ?, '')",
        rows,
    )
    connection.commit()
    connection.close()

    service = FeatureService(database)
    try:
        assert [item["node"]["node_key"] for item in service._inline_nodes_for_table("schema_a.same_name")] == ["a"]
        assert [item["node"]["node_key"] for item in service._inline_nodes_for_table("schema_b.same_name")] == ["b"]
        assert service._inline_nodes_for_table("schema_c.same_name") == []
        assert [item["node"]["node_key"] for item in service._inline_nodes_for_table("schema_c.unique_name")] == ["u"]
    finally:
        service.close()

