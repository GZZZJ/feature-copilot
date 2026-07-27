import sqlite3

import pytest

from feature_copilot.service import FeatureService


@pytest.fixture
def managed_service(tmp_path):
    database = tmp_path / "managed-web.sqlite"
    connection = sqlite3.connect(database)
    connection.executescript(
        """
        CREATE TABLE managed_features (
            feature_code TEXT PRIMARY KEY,
            feature_column_name TEXT NOT NULL,
            feature_name TEXT NOT NULL,
            feature_category TEXT NOT NULL,
            business_subcategory_code TEXT NOT NULL,
            business_subcategory_name TEXT NOT NULL,
            business_subcategory_sort_order INTEGER NOT NULL,
            group_code TEXT NOT NULL,
            group_name TEXT,
            table_name TEXT NOT NULL,
            domain_code TEXT,
            include_today_flag TEXT,
            time_range TEXT,
            source_path TEXT NOT NULL
        );
        CREATE TABLE managed_feature_scopes (
            feature_code TEXT NOT NULL,
            package_name TEXT NOT NULL,
            feature_category TEXT NOT NULL,
            PRIMARY KEY(feature_code, package_name)
        );
        CREATE TABLE group_logic (
            group_code TEXT PRIMARY KEY,
            logic_version TEXT,
            modify_time TEXT,
            last_modifier TEXT,
            logic_content TEXT NOT NULL,
            source_path TEXT NOT NULL,
            source_hash TEXT NOT NULL
        );
        CREATE TABLE column_derivations (
            feature_code TEXT PRIMARY KEY,
            status TEXT NOT NULL,
            expression TEXT,
            snippet TEXT,
            line_start INTEGER,
            line_end INTEGER
        );
        CREATE TABLE logic_coverage (
            feature_code TEXT PRIMARY KEY,
            logic_source TEXT NOT NULL,
            coverage_status TEXT NOT NULL,
            missing_dp_tables TEXT
        );
        CREATE TABLE table_dependencies (
            downstream_table TEXT NOT NULL,
            upstream_table TEXT NOT NULL,
            node_key TEXT NOT NULL,
            source_type TEXT NOT NULL,
            PRIMARY KEY(downstream_table, upstream_table, node_key, source_type)
        );
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
        CREATE TABLE features (feature_id TEXT PRIMARY KEY);
        """
    )
    features = [
        ("ftr.Alpha.001", "alpha_col", "Alpha用户", "A类", "customer_profile_qualification", "用户基础与资质信息", 100, "g1", "用户组", "dm.user", "usr", "Y", "30d", "features.json"),
        ("ftr.alpha.002", "risk_col", "Alpha风险", "A类", "delinquency_pressure", "逾期与偿债压力", 60, "g1", "用户组", "dm.risk", "risk", "N", "7d", "features.json"),
        ("ftr.beta.003", "beta_col", "Beta用户", "B类", "customer_profile_qualification", "用户基础与资质信息", 100, "g2", "用户组", "dm.beta", "usr", "N", "90d", "features.json"),
        ("ftr.percent%key", "percent_col", "占比100%", "S类", "transaction_payment", "交易与支付行为", 40, "g3", "特殊组", "dm.special", "misc", "N", "", "features.json"),
        ("ftr.under_score", "under_col", "下划_线", "S类", "transaction_payment", "交易与支付行为", 40, "g3", "特殊组", "dm.special", "misc", "N", "", "features.json"),
    ]
    connection.executemany("INSERT INTO managed_features VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", features)
    connection.executemany(
        "INSERT INTO managed_feature_scopes VALUES (?, ?, ?)",
        [
            ("ftr.Alpha.001", "package-a", "A类"),
            ("ftr.alpha.002", "package-a", "A类"),
            ("ftr.beta.003", "package-b", "B类"),
            ("ftr.percent%key", "package-s", "S类"),
            ("ftr.under_score", "package-s", "S类"),
        ],
    )
    connection.executemany(
        "INSERT INTO group_logic VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
            ("g1", "v2", "2026-07-17", "owner-a", "select alpha_col from upstream_ok", "logic/g1.sql", "hash-g1"),
            ("g2", "v1", "2026-07-16", "owner-b", "select beta_col from upstream_missing", "logic/g2.sql", "hash-g2"),
            ("g3", "v1", "2026-07-15", "owner-c", "select 1", "logic/g3.sql", "hash-g3"),
        ],
    )
    connection.executemany(
        "INSERT INTO column_derivations VALUES (?, ?, ?, ?, ?, ?)",
        [(item[0], "parsed", item[1], "select " + item[1], 1, 1) for item in features],
    )
    connection.executemany(
        "INSERT INTO logic_coverage VALUES (?, ?, ?, ?)",
        [(item[0], "group_logic", "recursive", "") for item in features],
    )
    connection.executemany(
        "INSERT INTO table_dependencies VALUES (?, ?, ?, ?)",
        [
            ("dm.user", "dw.upstream_ok", "group-g1", "group_logic"),
            ("dm.risk", "dw.upstream_ok", "group-g1", "group_logic"),
            ("dm.beta", "dw.upstream_missing", "group-g2", "group_logic"),
        ],
    )
    connection.execute(
        "INSERT INTO dp_logic_nodes VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        ("node-ok", "upstream_ok", "1", "task-ok", "owner", "select alpha_col from ods.source", "dp/upstream_ok.sql", "hash-node"),
    )
    connection.commit()
    connection.close()

    service = FeatureService(database)
    yield service
    service.close()


def test_list_managed_features_empty_query_is_stable_and_paginated(managed_service):
    first = managed_service.list_managed_features(limit=2)
    second = managed_service.list_managed_features(limit=2, offset=2)

    assert first == {
        "status": "OK",
        "total": 5,
        "limit": 2,
        "offset": 0,
        "items": first["items"],
    }
    codes = [item["feature_code"] for item in first["items"] + second["items"]]
    assert codes == sorted(codes)
    assert set(codes[:2]).isdisjoint(codes[2:])


def test_list_managed_features_filters_key_name_and_combines_with_and(managed_service):
    by_key = managed_service.list_managed_features(feature_key="ALPHA")
    by_name = managed_service.list_managed_features(feature_name="用户")
    both = managed_service.list_managed_features(feature_key="alpha", feature_name="风险")
    no_cross_match = managed_service.list_managed_features(feature_key="beta", feature_name="风险")

    assert [item["feature_code"] for item in by_key["items"]] == ["ftr.Alpha.001", "ftr.alpha.002"]
    assert [item["feature_code"] for item in by_name["items"]] == ["ftr.Alpha.001", "ftr.beta.003"]
    assert [item["feature_code"] for item in both["items"]] == ["ftr.alpha.002"]
    assert no_cross_match["total"] == 0
    assert no_cross_match["items"] == []


def test_list_managed_features_filters_category_subcategory_and_all_conditions(managed_service):
    category = managed_service.list_managed_features(feature_category="A类")
    subcategory = managed_service.list_managed_features(feature_subcategory="g1")
    combined = managed_service.list_managed_features(
        feature_key="alpha",
        feature_name="风险",
        feature_category="A类",
        feature_subcategory="g1",
    )
    mismatch = managed_service.list_managed_features(
        feature_category="B类", feature_subcategory="g1"
    )

    assert [item["feature_code"] for item in category["items"]] == [
        "ftr.Alpha.001",
        "ftr.alpha.002",
    ]
    assert [item["feature_code"] for item in subcategory["items"]] == [
        "ftr.Alpha.001",
        "ftr.alpha.002",
    ]
    assert [item["feature_code"] for item in combined["items"]] == [
        "ftr.alpha.002"
    ]
    assert mismatch["total"] == 0
    assert mismatch["items"] == []


def test_list_managed_features_filters_business_subcategory_and_feature_group_with_and(managed_service):
    subcategory = managed_service.list_managed_features(
        business_subcategory="customer_profile_qualification"
    )
    group = managed_service.list_managed_features(feature_group="g1")
    combined = managed_service.list_managed_features(
        business_subcategory="customer_profile_qualification", feature_group="g1"
    )
    conflict = managed_service.list_managed_features(
        business_subcategory="transaction_payment", feature_group="g1"
    )

    assert [item["feature_code"] for item in subcategory["items"]] == [
        "ftr.Alpha.001", "ftr.beta.003"
    ]
    assert [item["feature_code"] for item in group["items"]] == [
        "ftr.Alpha.001", "ftr.alpha.002"
    ]
    assert [item["feature_code"] for item in combined["items"]] == ["ftr.Alpha.001"]
    assert conflict["total"] == 0


def test_list_managed_feature_taxonomy_is_stable_and_counted(managed_service):
    result = managed_service.list_managed_feature_taxonomy()

    assert result == {
        "status": "OK",
        "categories": [
            {
                "value": "A类",
                "label": "A类",
                "count": 2,
                "subcategories": [
                    {
                        "value": "delinquency_pressure",
                        "label": "逾期与偿债压力",
                        "count": 1,
                        "groups": [{"value": "g1", "label": "用户组", "count": 1}],
                    },
                    {
                        "value": "customer_profile_qualification",
                        "label": "用户基础与资质信息",
                        "count": 1,
                        "groups": [{"value": "g1", "label": "用户组", "count": 1}],
                    },
                ],
            },
            {
                "value": "B类",
                "label": "B类",
                "count": 1,
                "subcategories": [
                    {
                        "value": "customer_profile_qualification",
                        "label": "用户基础与资质信息",
                        "count": 1,
                        "groups": [{"value": "g2", "label": "用户组", "count": 1}],
                    }
                ],
            },
            {
                "value": "S类",
                "label": "S类",
                "count": 2,
                "subcategories": [
                    {
                        "value": "transaction_payment",
                        "label": "交易与支付行为",
                        "count": 2,
                        "groups": [{"value": "g3", "label": "特殊组", "count": 2}],
                    }
                ],
            },
        ],
    }


def test_cross_package_feature_is_counted_once_within_each_category(managed_service):
    managed_service.repository.connection.execute(
        "INSERT INTO managed_feature_scopes VALUES (?, ?, ?)",
        ("ftr.Alpha.001", "package-b-shared", "B类"),
    )

    listing = managed_service.list_managed_features(feature_category="B类")
    taxonomy = managed_service.list_managed_feature_taxonomy()
    category = next(item for item in taxonomy["categories"] if item["value"] == "B类")
    subcategory = next(
        item for item in category["subcategories"]
        if item["value"] == "customer_profile_qualification"
    )

    assert [item["feature_code"] for item in listing["items"]] == [
        "ftr.Alpha.001", "ftr.beta.003"
    ]
    assert all(item["feature_category"] == "B类" for item in listing["items"])
    assert category["count"] == 2
    assert subcategory["count"] == 2


def test_list_managed_feature_taxonomy_rejects_conflicting_group_names(managed_service):
    managed_service.repository.connection.execute(
        "UPDATE managed_features SET business_subcategory_code=?, business_subcategory_name=?, "
        "business_subcategory_sort_order=? WHERE feature_code=?",
        ("customer_profile_qualification", "用户基础与资质信息", 100, "ftr.alpha.002"),
    )
    managed_service.repository.connection.execute(
        "UPDATE managed_features SET group_name=? WHERE feature_code=?",
        ("风险组", "ftr.alpha.002"),
    )

    with pytest.raises(ValueError, match="A类/customer_profile_qualification/g1 has multiple group names"):
        managed_service.list_managed_feature_taxonomy()


def test_list_managed_features_treats_like_special_characters_literally(managed_service):
    percent = managed_service.list_managed_features(feature_key="%")
    underscore = managed_service.list_managed_features(feature_name="_")

    assert [item["feature_code"] for item in percent["items"]] == ["ftr.percent%key"]
    assert [item["feature_code"] for item in underscore["items"]] == ["ftr.under_score"]


@pytest.mark.parametrize(
    "arguments",
    [
        {"limit": 0},
        {"limit": -1},
        {"limit": 101},
        {"limit": "50"},
        {"offset": -1},
        {"offset": 1 << 63},
    ],
)
def test_list_managed_features_rejects_unbounded_pagination(managed_service, arguments):
    with pytest.raises(ValueError):
        managed_service.list_managed_features(**arguments)


def test_get_managed_feature_detail_separates_resource_and_logic_status(managed_service):
    complete = managed_service.get_managed_feature_detail("FTR.ALPHA.001")
    partial = managed_service.get_managed_feature_detail("ftr.beta.003")

    assert complete["status"] == "OK"
    assert complete["verified"] is False
    assert complete["feature"]["feature_code"] == "ftr.Alpha.001"
    assert complete["feature"]["packages"] == ["package-a"]
    assert complete["logic"]["status"] == "OK"
    assert complete["logic"]["direct_logic"]["modify_time"] == "2026-07-17"
    assert complete["logic"]["direct_logic"]["last_modifier"] == "owner-a"
    assert complete["logic"]["upstream_layers"][0]["tables"][0]["logic_nodes"][0]["sql"]

    assert partial["status"] == "OK"
    assert partial["logic"]["status"] == "PARTIAL"
    assert partial["logic"]["diagnostics"] == ["logic_not_downloaded:dw.upstream_missing"]


def test_get_managed_feature_detail_not_found_does_not_infer(managed_service):
    assert managed_service.get_managed_feature_detail("unknown") == {
        "status": "NOT_FOUND",
        "feature_key": "unknown",
    }


def test_get_managed_feature_detail_marks_depth_truncation_as_partial(managed_service):
    managed_service.repository.connection.execute(
        "INSERT INTO table_dependencies VALUES (?, ?, ?, ?)",
        ("dw.upstream_ok", "ods.deep_source", "node-ok", "dp_task_logic"),
    )
    result = managed_service.get_managed_feature_detail("ftr.Alpha.001", max_depth=1)

    assert result["logic"]["status"] == "PARTIAL"
    assert result["logic"]["diagnostics"] == ["max_depth_reached:dw.upstream_ok"]
