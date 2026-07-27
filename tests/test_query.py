def test_get_current_version_and_not_found(service):
    result = service.get("FIXTURE_INCOME_AVG_30D")
    assert result["status"] == "OK" and result["feature"]["version"] == "2.0.0"
    missing = service.get("no_such_fixture_feature")
    assert missing["status"] == "NOT_FOUND" and missing["inferred_from_name"]["verified"] is False


def test_search_and_table_aggregates(service):
    result = service.search(["示例", "30日"], {"table": "fixture_customer_wide"})
    assert result["total"] >= 3
    assert all(item["source_table"] == "fixture_customer_wide" for item in result["items"])
    table = service.table("fixture_customer_wide")
    assert table["feature_count"] >= 4 and table["aggregates"]["category"]


def test_search_fts_and_like_fallback(service):
    fts = service.search(["fixture_income_avg_30d"])
    assert fts["search_mode"] == "fts5"
    service.repository.connection.execute("UPDATE metadata SET value='false' WHERE key='fts5'")
    fallback = service.search(["fixture_income_avg_30d"])
    assert fallback["search_mode"] == "like" and fallback["total"] == 2


def test_performance_filters(service):
    result = service.perf({"project": "fixture_project_beta", "min_iv": 0.1, "max_psi": 0.06})
    assert result["total"] == 1 and result["items"][0]["feature_id"] == "feat_pboc_util"
