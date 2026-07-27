from pathlib import Path

from feature_copilot.logic_catalog import load_managed_catalog


ROOT = Path(__file__).resolve().parents[1]


def test_dp_sql_exports_are_complete_and_current():
    directories = ("", "pdm_risk_upstream", "dwa_risk_upstream", "dwa_risk_first_upstream", "dwa_risk_internal_upstream")
    sql_files = [path for directory in directories for path in (ROOT / "goal" / "dp_table_logic" / directory).glob("*.sql")]
    json_files = [path for directory in directories for path in (ROOT / "goal" / "dp_table_logic" / directory).glob("*.json")]
    assert len(sql_files) == 266
    assert json_files == []
    assert sum("-- feature-copilot:logic-unavailable" in path.read_text(encoding="utf-8") for path in sql_files) == 0
    assert all("-- table_name: " + path.stem in path.read_text(encoding="utf-8") for path in sql_files)
    sql_path = ROOT / "goal" / "dp_table_logic" / "pdm_risk_dz_model_final_order_info_df.sql"
    assert sql_path.is_file()
    assert "-- feature-copilot:node-begin ordinal=0" in sql_path.read_text(encoding="utf-8")


def test_sql_header_matches_are_attached_to_the_requested_table():
    catalog = load_managed_catalog(ROOT, ROOT / "knowledge" / "config" / "maintenance_scope.json")
    paths = {node["source_path"] for node in catalog["dp_nodes"]}
    assert "goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_heavy_order_info_detail.sql" in paths
    assert any(node["table_name"] == "dwa_risk_f_heavy_stage_plan_detail_new" for node in catalog["dp_nodes"])
