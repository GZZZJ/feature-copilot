import json
from pathlib import Path

import pytest

from feature_copilot.errors import ValidationError
from feature_copilot.index_builder import build_index
from feature_copilot.logic_catalog import DP_SQL_DIRECTORIES, _dp_logic, _managed_feature_taxonomy, load_managed_catalog
from feature_copilot.service import FeatureService


ROOT = Path(__file__).resolve().parents[1]


def _first_code(package: str) -> str:
    path = next((ROOT / "goal" / package).glob("*_all_features.json"))
    return json.loads(path.read_text(encoding="utf-8"))[0]["featureCode"]


def _taxonomy_fixture(tmp_path, payload, features=None):
    config = tmp_path / "taxonomy.json"
    config.write_text(json.dumps(payload, ensure_ascii=False), encoding="utf-8")
    return _managed_feature_taxonomy(
        tmp_path,
        {"managed_feature_taxonomy_config": "taxonomy.json"},
        features or [
            {"feature_code": "f1", "group_code": "g1"},
            {"feature_code": "f2", "group_code": "g2"},
        ],
        2,
    )


def _taxonomy_payload():
    return {
        "schema_version": 1,
        "subcategories": [
            {"code": "alpha", "name": "甲", "description": "", "sort_order": 10},
            {"code": "beta", "name": "乙", "description": "", "sort_order": 20},
        ],
        "group_defaults": [
            {"group_code": "g1", "subcategory_code": "alpha"},
            {"group_code": "g2", "subcategory_code": "beta"},
        ],
        "feature_overrides": [],
    }


def test_managed_taxonomy_requires_every_current_group(tmp_path):
    payload = _taxonomy_payload()
    payload["group_defaults"].pop()

    with pytest.raises(ValidationError, match="groups lack taxonomy defaults: g2"):
        _taxonomy_fixture(tmp_path, payload)


def test_managed_taxonomy_rejects_invalid_code_and_duplicate_override(tmp_path):
    invalid = _taxonomy_payload()
    invalid["subcategories"][0]["code"] = "Alpha-invalid"
    with pytest.raises(ValidationError, match="invalid business subcategory code"):
        _taxonomy_fixture(tmp_path, invalid)

    duplicate = _taxonomy_payload()
    duplicate["feature_overrides"] = [
        {"feature_code": "f1", "subcategory_code": "beta", "reason": "明确指标"},
        {"feature_code": "f1", "subcategory_code": "alpha", "reason": "另一条"},
    ]
    with pytest.raises(ValidationError, match="duplicate taxonomy feature override: f1"):
        _taxonomy_fixture(tmp_path, duplicate)


def test_managed_taxonomy_feature_override_wins_and_is_audited(tmp_path):
    payload = _taxonomy_payload()
    payload["feature_overrides"] = [
        {"feature_code": "f1", "subcategory_code": "beta", "reason": "指标明确表达乙类信号"}
    ]
    features = [
        {"feature_code": "f1", "group_code": "g1"},
        {"feature_code": "f2", "group_code": "g2"},
    ]

    taxonomy = _taxonomy_fixture(tmp_path, payload, features)

    assert features[0]["business_subcategory_code"] == "beta"
    assert taxonomy["audit"]["group_default_hit_count"] == 1
    assert taxonomy["audit"]["feature_override_hit_count"] == 1
    assert taxonomy["audit"]["unclassified_count"] == 0


def test_managed_catalog_deduplicates_same_feature_across_package_categories(tmp_path):
    (tmp_path / "knowledge/config").mkdir(parents=True)
    (tmp_path / "goal/groups").mkdir(parents=True)
    dp_root = tmp_path / "goal/dp"
    for relative_directory in DP_SQL_DIRECTORIES:
        (dp_root / relative_directory).mkdir(parents=True, exist_ok=True)
    feature = {
        "featureCode": "ftr.off.usr.example_table.example_column",
        "featureColumnName": "example_column",
        "featureName": "示例特征",
        "groupCode": "g1",
        "groupName": "示例加工组",
    }
    for name in ("package-a", "package-b"):
        path = tmp_path / f"goal/{name}.json"
        path.write_text(json.dumps([feature], ensure_ascii=False), encoding="utf-8")
    (tmp_path / "goal/groups/g1.json").write_text(
        json.dumps({"data": {"groupCode": "g1", "logicContent": "select 1 as example_column"}}),
        encoding="utf-8",
    )
    (tmp_path / "knowledge/config/warehouse.json").write_text(
        json.dumps({"schema_version": 1, "standard_schemas": [], "excluded_schemas": [], "table_metadata": {}}),
        encoding="utf-8",
    )
    taxonomy = _taxonomy_payload()
    taxonomy["group_defaults"] = [{"group_code": "g1", "subcategory_code": "alpha"}]
    (tmp_path / "knowledge/config/taxonomy.json").write_text(
        json.dumps(taxonomy, ensure_ascii=False), encoding="utf-8"
    )
    scope = {
        "schema_version": 1,
        "packages": [
            {"name": "package-a", "feature_category": "A类", "business_stage": "in_loan", "feature_file": "goal/package-a.json", "expected_feature_count": 1},
            {"name": "package-b", "feature_category": "B类", "business_stage": "in_loan", "feature_file": "goal/package-b.json", "expected_feature_count": 1},
        ],
        "group_logic_directory": "goal/groups",
        "dp_logic_directory": "goal/dp",
        "standard_warehouse_config": "knowledge/config/warehouse.json",
        "managed_feature_taxonomy_config": "knowledge/config/taxonomy.json",
    }
    scope_path = tmp_path / "knowledge/config/scope.json"
    scope_path.write_text(json.dumps(scope, ensure_ascii=False), encoding="utf-8")

    catalog = load_managed_catalog(tmp_path, scope_path)

    assert len(catalog["features"]) == 1
    assert catalog["source_feature_rows"] == 2
    assert catalog["feature_scopes"] == [
        {"feature_code": feature["featureCode"], "package_name": "package-a", "feature_category": "A类"},
        {"feature_code": feature["featureCode"], "package_name": "package-b", "feature_category": "B类"},
    ]
    assert catalog["taxonomy_audit"]["unique_feature_count"] == 1


def test_managed_catalog_builds_only_the_four_approved_packages(tmp_path):
    database = tmp_path / "managed.sqlite"
    report = build_index(ROOT / "knowledge", database, ROOT)
    assert report["managed_assets"] is True
    # The refreshed package snapshots contain 23,702 distinct featureCodes.
    # Each featureCode is represented once in the query catalog.
    assert report["managed_feature_count"] == 23702
    assert report["managed_source_feature_rows"] == 23702
    assert report["managed_taxonomy_audit"]["unique_group_count"] == 88
    assert report["managed_taxonomy_audit"]["classified_feature_count"] == 23702
    assert report["managed_taxonomy_audit"]["feature_override_count"] == 2
    assert report["managed_taxonomy_audit"]["unclassified_count"] == 0
    service = FeatureService(database)
    try:
        stats = service.stats()
        assert stats["managed_features"] == 23702
        assert service.repository.row("SELECT COUNT(*) AS count FROM managed_feature_scopes")["count"] == 23702
        assert service.repository.row(
            "SELECT COUNT(DISTINCT group_code) AS count FROM managed_features"
        )["count"] == 88
        assert service.repository.row(
            "SELECT COUNT(*) AS count FROM managed_features WHERE business_subcategory_code=''"
        )["count"] == 0
    finally:
        service.close()


def test_dp_sql_header_filename_mismatch_is_a_validation_error(tmp_path):
    logic_root = tmp_path / "logic"
    for relative_directory in DP_SQL_DIRECTORIES:
        (logic_root / relative_directory).mkdir(parents=True, exist_ok=True)
    (logic_root / "requested_table.sql").write_text(
        "-- table_name: actual_table\n",
        encoding="utf-8",
    )
    with pytest.raises(ValidationError, match="SQL table header does not match file name"):
        _dp_logic(tmp_path, "logic")


def test_group_logic_answers_direct_feature_and_pdm_logic_recurses(tmp_path):
    database = tmp_path / "logic.sqlite"; build_index(ROOT / "knowledge", database, ROOT)
    service = FeatureService(database)
    try:
        tnd_code = _first_code("package_5_04tnd")
        direct = service.explain_logic(tnd_code)
        # 标准数仓表是受支持的血缘终点，不应再被判定为逻辑缺失。
        assert direct["status"] == "OK"
        assert direct["coverage"]["coverage_status"] == "recursive"
        assert direct["pdm_risk_upstream_chain"]
        assert direct["direct_logic"]["derivation"]["line_start"] > 0
        assert direct["requested_upstream_depth"] == 3
        assert direct["upstream_layers"][0]["tables"][0]["table_name"] == "dwa_risk.dwa_risk_tnd_feature_di"
        assert direct["upstream_layers"][0]["tables"][0]["state"] == "indexed"
        compact_sql = direct["upstream_layers"][0]["tables"][0]["logic_nodes"][0]["sql"]
        assert len(compact_sql) < 1400
        assert "request --full for complete SQL" in compact_sql
        assert "sql" not in direct["pdm_risk_upstream_chain"][0]

        complete = service.explain_logic(tnd_code, full=True)
        complete_sql = complete["upstream_layers"][0]["tables"][0]["logic_nodes"][0]["sql"]
        assert complete["full_requested"] is True
        assert len(complete_sql) > len(compact_sql)
        assert "request --full for complete SQL" not in complete_sql

        dwa_code = "ftr.off.usr.dwa_risk_dz_model_30light_cross_heavy_inner_behaviour_df.d360_light_limit_divide_btch_adt_limit"
        dwa = service.explain_logic(dwa_code)
        assert dwa["coverage"]["coverage_status"] == "recursive"
        assert [layer["depth"] for layer in dwa["upstream_layers"]] == [1, 2, 3]
        assert dwa["upstream_layers"][0]["tables"][0]["state"] == "indexed"
        assert any(item["state"] == "indexed" for item in dwa["upstream_layers"][1]["tables"])

        br_code = _first_code("package_3_br")
        recursive = service.explain_logic(br_code)
        assert recursive["coverage"]["coverage_status"] == "recursive"
        assert recursive["pdm_risk_upstream_chain"]
        assert recursive["direct_logic"]["source_path"].startswith("goal/_metadata/group_logic/")
        assert [layer["depth"] for layer in recursive["upstream_layers"]] == [1, 2, 3]
        first_table = recursive["upstream_layers"][0]["tables"][0]
        assert first_table["state"] == "indexed"
        assert first_table["logic_nodes"][0]["source_path"].endswith(".sql")
    finally:
        service.close()


def test_managed_feature_code_is_exact_and_searchable(tmp_path):
    database = tmp_path / "search.sqlite"; build_index(ROOT / "knowledge", database, ROOT)
    service = FeatureService(database)
    try:
        code = _first_code("package_5_04tnd")
        assert service.get(code)["record_type"] == "managed_feature"
        results = service.search([code.rsplit(".", 1)[1]])
        assert results["counts"]["managed"] >= 1
        assert any(item.get("feature_code") == code for item in results["items"])
    finally:
        service.close()


def test_inline_intermediate_tables_and_standard_warehouse_terminals_are_distinguished(tmp_path):
    database = tmp_path / "lineage.sqlite"; build_index(ROOT / "knowledge", database, ROOT)
    service = FeatureService(database)
    try:
        code = "ftr.off.usr.dwa_risk_dz_final_2tqhk_reptim_360d_con_feature.ddf_mdl_max_con_not_ovd_tqhk_rep_tim_12m"
        result = service.explain_logic(code)
        inline_tables = [
            table for layer in result["upstream_layers"] for table in layer["tables"]
            if table["table_name"] == "dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary"
        ]
        assert inline_tables and inline_tables[0]["state"] == "inline_materialized"
        assert inline_tables[0]["host_tasks"]
        assert all("create table" in item["sql"].lower() for item in inline_tables[0]["logic_nodes"])
        assert "logic_not_downloaded:dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary" not in result["diagnostics"]
        assert {item["table_name"] for item in result["standard_warehouse_terminals"]} >= {
            "dwt.dwt_heavy_order_df", "cdmx.cdmx_fct_heavy_stage_plan_df"
        }
        continued_branches = [
            table for layer in result["upstream_layers"] for table in layer["tables"]
            if table["table_name"] == "dwa_risk.dwa_risk_f_heavy_order_info_basic"
        ]
        assert continued_branches and continued_branches[0]["state"] == "indexed"
        assert all(item["classification"] == "standard_warehouse_table" for item in result["standard_warehouse_terminals"])
        assert all(item["metadata_status"] == "not_maintained" for item in result["standard_warehouse_terminals"])
    finally:
        service.close()


def test_literal_schema_create_and_insert_overwrite_are_inline_materializations(tmp_path):
    database = tmp_path / "materializations.sqlite"; build_index(ROOT / "knowledge", database, ROOT)
    service = FeatureService(database)
    try:
        create_code = service.repository.row(
            "SELECT MIN(feature_code) AS feature_code FROM managed_features "
            "WHERE table_name='dwa_risk_dz_model_final_25_cross_inner_behaviour_df'"
        )["feature_code"]
        created = service.explain_logic(create_code)
        created_table = next(
            table for layer in created["upstream_layers"] for table in layer["tables"]
            if table["table_name"] == "dwa_risk.dwa_risk_dz_model_final_25_1_repay_behaviour_inner_cross_df"
        )
        assert created_table["state"] == "inline_materialized"
        assert {item["type"] for node in created_table["logic_nodes"] for item in node["materializations"]} == {"create_table"}
        assert all(node["sql"].lstrip().lower().startswith("create table") for node in created_table["logic_nodes"])

        insert_code = service.repository.row(
            "SELECT MIN(feature_code) AS feature_code FROM managed_features "
            "WHERE table_name='dwa_risk_dz_model_account_lmt_feature_sample_all_final_df'"
        )["feature_code"]
        inserted = service.explain_logic(insert_code)
        target_names = {
            "dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_tmp",
            "dwa_risk.dwa_risk_dz_model_lmt_list_lft_rep_tmp",
        }
        insert_tables = [
            table for layer in inserted["upstream_layers"] for table in layer["tables"]
            if table["table_name"] in target_names
        ]
        assert {table["table_name"] for table in insert_tables} == target_names
        for table in insert_tables:
            assert table["state"] == "inline_materialized"
            assert {item["type"] for node in table["logic_nodes"] for item in node["materializations"]} == {"insert_overwrite"}
            assert all(node["sql"].lstrip().lower().startswith("insert overwrite table") for node in table["logic_nodes"])
            assert len({node["source_path"] for node in table["logic_nodes"]}) == len(table["logic_nodes"])
    finally:
        service.close()


def test_logic_audit_is_compact_and_leaves_only_unavailable_source_tables(tmp_path):
    database = tmp_path / "audit.sqlite"; build_index(ROOT / "knowledge", database, ROOT)
    service = FeatureService(database)
    try:
        result = service.audit_logic(max_depth=20)
        assert result["representative_feature_tables"] == 96
        assert result["affected_feature_tables"] == 2
        assert {item["table_name"] for item in result["missing_nonstandard_tables"]} == {
            "ads_app_collect.dp_dmining_f_user_behavior_tracker",
            "pdm_risk_ftr.blue_customer_group_df",
        }
        assert result["inline_materializations"]["create_table"] >= 46
        assert result["inline_materializations"]["insert_overwrite"] >= 2
        assert isinstance(result["max_depth_reached"], int)
        assert isinstance(result["cycle_detected"], int)
    finally:
        service.close()


def test_managed_features_return_configured_feature_category(tmp_path):
    database = tmp_path / "categories.sqlite"; build_index(ROOT / "knowledge", database, ROOT)
    service = FeatureService(database)
    expected = {
        "package_3_br": "贷中百融变量特征包",
        "package_4_nuggets": "贷中掘金特征包",
        "package_5_04tnd": "贷中同盾特征包",
        "package_7_02inner": "贷中内部变量特征包",
    }
    try:
        for package, category in expected.items():
            code = _first_code(package)
            detail = service.get(code)
            assert detail["feature"]["feature_category"] == category
            search = service.search([code.rsplit(".", 1)[1]])
            item = next(item for item in search["items"] if item.get("feature_code") == code)
            assert item["feature_category"] == category
            filtered = service.search(["ftr.off.usr"], {"category": category}, limit=5)
            assert filtered["counts"]["managed"] > 0
            assert all(item["feature_category"] == category for item in filtered["items"])
    finally:
        service.close()
