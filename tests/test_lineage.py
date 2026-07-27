from pathlib import Path

from feature_copilot.index_builder import build_index
from feature_copilot.service import FeatureService


ROOT = Path(__file__).parents[1]


def _managed_service(tmp_path):
    database = tmp_path / "lineage.sqlite"
    build_index(ROOT / "knowledge", database, ROOT)
    return FeatureService(database)


def test_forward_and_reverse_lineage(tmp_path):
    service = _managed_service(tmp_path)
    feature_table = "dwa_risk.dwa_risk_tnd_feature_di"
    try:
        forward = service.lineage(feature_table, "forward")
        assert forward["status"] in {"OK", "PARTIAL"}
        assert any(edge["source_type"] == "group_logic" for edge in forward["edges"])

        direct_upstream = forward["edges"][0]["upstream_table"]
        reverse = service.lineage(direct_upstream, "reverse")
        assert any(node["table_name"] == "dwa_risk_tnd_feature_di" for node in reverse["nodes"])
    finally:
        service.close()


def test_depth_limit_is_reported_for_real_table_lineage(tmp_path):
    service = _managed_service(tmp_path)
    try:
        result = service.lineage("dwa_risk.dwa_risk_tnd_feature_di", "forward", max_depth=1)
        assert result["status"] == "PARTIAL"
        assert any(item.startswith("max_depth_reached:") for item in result["diagnostics"])
    finally:
        service.close()
