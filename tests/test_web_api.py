import sqlite3

import pytest

flask = pytest.importorskip("flask")

from feature_copilot_web.app import create_app
from feature_copilot_web.runtime import WebRuntime, bootstrap_runtime


class FakeService:
    instances = []
    list_result = {
        "status": "OK",
        "total": 1,
        "limit": 50,
        "offset": 0,
        "items": [{"feature_code": "CUSTOMER_AGE", "feature_name": "客户年龄"}],
    }
    detail_result = {
        "status": "OK",
        "feature": {"feature_code": "CUSTOMER_AGE"},
        "logic": {
            "status": "PARTIAL",
            "direct_logic": {},
            "coverage": {},
            "upstream_layers": [],
            "diagnostics": ["logic_not_downloaded:upstream_table"],
        },
        "evidence": {},
    }
    taxonomy_result = {
        "status": "OK",
        "categories": [
            {
                "value": "用户特征",
                "label": "用户特征",
                "count": 1,
                "subcategories": [
                    {
                        "value": "customer_profile_qualification",
                        "label": "用户基础与资质信息",
                        "count": 1,
                        "groups": [
                            {"value": "user_base", "label": "用户基础", "count": 1}
                        ],
                    }
                ],
            }
        ],
    }

    def __init__(self, database_path):
        self.database_path = database_path
        self.closed = False
        self.calls = []
        self.__class__.instances.append(self)

    def close(self):
        self.closed = True

    def stats(self):
        return {
            "status": "OK",
            "managed_features": 23702,
            "metadata": [{"key": "built_at", "value": "2026-07-17T10:00:00Z"}],
        }

    def list_managed_features(self, **kwargs):
        self.calls.append(("list", kwargs))
        return self.list_result

    def get_managed_feature_detail(self, feature_key, max_depth=3):
        self.calls.append(("detail", feature_key, max_depth))
        if feature_key == "missing":
            return {"status": "NOT_FOUND", "feature_code": feature_key}
        return self.detail_result

    def list_managed_feature_taxonomy(self):
        self.calls.append(("taxonomy",))
        return self.taxonomy_result

    def business_subcategory_exists(self, code):
        self.calls.append(("subcategory_exists", code))
        return code == "customer_profile_qualification"

    def feature_group_exists(self, code):
        self.calls.append(("group_exists", code))
        return code in {"user_base", "other_group"}

    def feature_group_belongs_to_category(self, code, category):
        self.calls.append(("group_in_category", code, category))
        return code == "user_base" and category == "用户特征"


@pytest.fixture(autouse=True)
def reset_fake_service():
    FakeService.instances = []


@pytest.fixture
def runtime(tmp_path):
    return WebRuntime(
        project_root=tmp_path,
        knowledge_dir=tmp_path / "knowledge",
        database_path=tmp_path / "index.sqlite",
        service_factory=FakeService,
        available=True,
    )


@pytest.fixture
def client(runtime):
    app = create_app(runtime)
    app.config.update(TESTING=True)
    return app.test_client()


def test_list_api_maps_page_to_limit_offset_and_combines_filters(client):
    response = client.get(
        "/api/v1/features",
        query_string={
            "feature_key": " customer ",
            "feature_name": " 年龄 ",
            "feature_category": " 用户特征 ",
            "feature_subcategory": " user_base ",
            "page": 2,
            "page_size": 20,
        },
    )

    assert response.status_code == 200
    assert response.get_json() == {
        "status": "OK",
        "total": 1,
        "page": 2,
        "page_size": 20,
        "items": [{"feature_code": "CUSTOMER_AGE", "feature_name": "客户年龄"}],
    }
    assert FakeService.instances[0].calls[-1:] == [
        (
            "list",
            {
                "feature_key": "customer",
                "feature_name": "年龄",
                "feature_category": "用户特征",
                "business_subcategory": "",
                "feature_group": "user_base",
                "limit": 20,
                "offset": 20,
            },
        )
    ]
    assert FakeService.instances[0].calls[:-1] == [
        ("group_exists", "user_base"),
        ("group_in_category", "user_base", "用户特征"),
    ]
    assert FakeService.instances[0].closed is True


@pytest.mark.parametrize(
    "query,message",
    [
        ({"page": "zero"}, "page must be an integer"),
        ({"page": "0"}, "page must be positive"),
        ({"page_size": "10"}, "page_size must be one of 20, 50, 100"),
        ({"page_size": ""}, "page_size must be an integer"),
        ({"page": str(1 << 63)}, "page is too large"),
    ],
)
def test_list_api_rejects_invalid_pagination(client, query, message):
    response = client.get("/api/v1/features", query_string=query)

    assert response.status_code == 400
    assert response.get_json() == {
        "status": "ERROR",
        "error": "INVALID_ARGUMENT",
        "message": message,
    }
    assert FakeService.instances == []


def test_list_api_rejects_unbounded_query_text(client):
    response = client.get(
        "/api/v1/features", query_string={"feature_key": "x" * 513}
    )

    assert response.status_code == 400
    assert response.get_json()["error"] == "INVALID_ARGUMENT"
    assert FakeService.instances == []


def test_list_api_accepts_legacy_group_without_category(client):
    response = client.get(
        "/api/v1/features", query_string={"feature_subcategory": "user_base"}
    )

    assert response.status_code == 200
    assert FakeService.instances[0].calls[-1][1]["feature_group"] == "user_base"


def test_list_api_validates_category_query_length(client):
    response = client.get(
        "/api/v1/features", query_string={"feature_category": "x" * 513}
    )

    assert response.status_code == 400
    assert response.get_json()["error"] == "INVALID_ARGUMENT"
    assert FakeService.instances == []


def test_list_api_accepts_new_taxonomy_filters_and_combines_with_and(client):
    response = client.get(
        "/api/v1/features",
        query_string={
            "feature_category": "用户特征",
            "business_subcategory": "customer_profile_qualification",
            "feature_group": "user_base",
        },
    )

    assert response.status_code == 200
    assert FakeService.instances[0].calls == [
        ("subcategory_exists", "customer_profile_qualification"),
        ("group_exists", "user_base"),
        ("group_in_category", "user_base", "用户特征"),
        (
            "list",
            {
                "feature_key": "",
                "feature_name": "",
                "feature_category": "用户特征",
                "business_subcategory": "customer_profile_qualification",
                "feature_group": "user_base",
                "limit": 50,
                "offset": 0,
            },
        ),
    ]


@pytest.mark.parametrize(
    "query,message",
    [
        ([('feature_group', 'user_base'), ('feature_group', 'user_base')], "feature_group must not be repeated"),
        ({"feature_group": "user_base", "feature_subcategory": "other_group"}, "feature_group conflicts with feature_subcategory"),
        ({"business_subcategory": "unknown"}, "business_subcategory does not exist: unknown"),
        ({"feature_group": "unknown"}, "feature_group does not exist: unknown"),
        ({"feature_category": "其他类", "feature_group": "user_base"}, "feature_group does not belong to feature_category"),
    ],
)
def test_list_api_rejects_invalid_taxonomy_arguments(client, query, message):
    response = client.get("/api/v1/features", query_string=query)

    assert response.status_code == 400
    assert response.get_json()["message"] == message


def test_list_api_accepts_same_new_and_legacy_group_value(client):
    response = client.get(
        "/api/v1/features",
        query_string={
            "feature_category": "用户特征",
            "feature_group": " user_base ",
            "feature_subcategory": "user_base",
        },
    )

    assert response.status_code == 200
    assert FakeService.instances[0].calls[-1][1]["feature_group"] == "user_base"


def test_feature_taxonomy_api_returns_service_payload(client):
    response = client.get("/api/v1/feature-taxonomy")

    assert response.status_code == 200
    assert response.get_json() == FakeService.taxonomy_result
    assert FakeService.instances[0].calls == [("taxonomy",)]
    assert FakeService.instances[0].closed is True


def test_feature_taxonomy_api_reports_inconsistent_mapping_as_503(client, monkeypatch):
    def inconsistent_taxonomy(self):
        raise ValueError("inconsistent taxonomy")

    monkeypatch.setattr(FakeService, "list_managed_feature_taxonomy", inconsistent_taxonomy)
    response = client.get("/api/v1/feature-taxonomy")

    assert response.status_code == 503
    assert response.get_json() == {
        "status": "ERROR",
        "error": "INDEX_UNAVAILABLE",
        "message": "inconsistent taxonomy",
    }
    assert FakeService.instances[0].closed is True


def test_partial_detail_is_success_and_not_found_is_404(client):
    response = client.get("/api/v1/features/CUSTOMER_AGE")

    assert response.status_code == 200
    assert response.get_json()["logic"]["status"] == "PARTIAL"
    assert FakeService.instances[0].closed is True

    missing = client.get("/api/v1/features/missing")
    assert missing.status_code == 404
    assert missing.get_json()["error"] == "FEATURE_NOT_FOUND"
    assert len(FakeService.instances) == 2
    assert all(instance.closed for instance in FakeService.instances)


def test_each_request_uses_a_new_service_and_security_headers(client):
    first = client.get("/api/v1/features")
    second = client.get("/api/v1/health")

    assert len(FakeService.instances) == 2
    assert FakeService.instances[0] is not FakeService.instances[1]
    assert all(instance.closed for instance in FakeService.instances)
    assert first.headers["X-Content-Type-Options"] == "nosniff"
    assert first.headers["X-Frame-Options"] == "DENY"
    assert "default-src 'self'" in first.headers["Content-Security-Policy"]
    assert first.headers["Cache-Control"] == "no-store"
    assert "Access-Control-Allow-Origin" not in first.headers
    assert second.get_json()["index"]["managed_feature_count"] == 23702


def test_untrusted_host_is_rejected(client):
    response = client.get(
        "/api/v1/features",
        base_url="http://feature-copilot.attacker.example",
    )

    assert response.status_code == 400
    assert FakeService.instances == []


def test_page_routes_render_and_root_redirects_to_feature_list(client):
    root = client.get("/")
    listing = client.get("/features")
    detail = client.get("/features/CUSTOMER_AGE")

    assert root.status_code == 302
    assert root.headers["Location"].endswith("/features")
    assert listing.status_code == 200
    assert "特征目录" in listing.get_data(as_text=True)
    assert "受控特征目录" not in listing.get_data(as_text=True)
    assert 'name="business_subcategory"' in listing.get_data(as_text=True)
    assert 'name="feature_group"' in listing.get_data(as_text=True)
    assert "加工特征组" in listing.get_data(as_text=True)
    assert detail.status_code == 200
    assert "特征详情" in detail.get_data(as_text=True)


def test_web_javascript_generates_new_taxonomy_parameters_and_reads_legacy_group(client):
    response = client.get("/static/app.js")
    javascript = response.get_data(as_text=True)

    assert 'params.set("business_subcategory"' in javascript
    assert 'params.set("feature_group"' in javascript
    assert 'params.set("feature_subcategory"' not in javascript
    assert 'params.get("feature_subcategory")' in javascript
    assert "BUSINESS SUBCATEGORY" in javascript


def test_unavailable_index_returns_503_without_opening_service(tmp_path):
    runtime = WebRuntime(
        project_root=tmp_path,
        knowledge_dir=tmp_path / "knowledge",
        database_path=tmp_path / "missing.sqlite",
        service_factory=FakeService,
        available=False,
        build_error="build failed",
    )
    client = create_app(runtime).test_client()

    for path in (
        "/api/v1/features",
        "/api/v1/feature-taxonomy",
        "/api/v1/features/ANY",
        "/api/v1/health",
    ):
        response = client.get(path)
        assert response.status_code == 503
        assert response.get_json()["status"] in {"ERROR", "UNAVAILABLE"}
    assert FakeService.instances == []


def test_runtime_sqlite_failure_is_reported_as_503(tmp_path):
    def broken_service(database_path):
        raise sqlite3.OperationalError("database is locked")

    runtime = WebRuntime(
        project_root=tmp_path,
        knowledge_dir=tmp_path / "knowledge",
        database_path=tmp_path / "index.sqlite",
        service_factory=broken_service,
        available=True,
    )
    client = create_app(runtime).test_client()

    listing = client.get("/api/v1/features")
    detail = client.get("/api/v1/features/ANY")

    assert listing.status_code == 503
    assert listing.get_json()["error"] == "INDEX_UNAVAILABLE"
    assert detail.status_code == 503
    assert detail.get_json()["error"] == "INDEX_UNAVAILABLE"


def test_bootstrap_serves_readable_old_index_when_rebuild_fails(tmp_path):
    database = tmp_path / "old.sqlite"
    database.touch()

    def fail_build(knowledge, database_path, project_root):
        raise RuntimeError("source validation failed")

    runtime = bootstrap_runtime(
        project_root=tmp_path,
        knowledge_dir=tmp_path / "knowledge",
        database_path=database,
        service_factory=FakeService,
        build_function=fail_build,
        staleness_check=lambda database_path, knowledge, root: True,
    )

    assert runtime.available is True
    assert runtime.stale is True
    assert runtime.build_error == "source validation failed"
    assert FakeService.instances[0].closed is True


def test_bootstrap_leaves_runtime_unavailable_when_no_index_can_be_built(tmp_path):
    def fail_build(knowledge, database_path, project_root):
        raise RuntimeError("source validation failed")

    runtime = bootstrap_runtime(
        project_root=tmp_path,
        knowledge_dir=tmp_path / "knowledge",
        database_path=tmp_path / "missing.sqlite",
        service_factory=FakeService,
        build_function=fail_build,
        staleness_check=lambda database_path, knowledge, root: True,
    )

    assert runtime.available is False
    assert runtime.stale is False
    assert runtime.build_error == "source validation failed"
    assert FakeService.instances == []


def test_bootstrap_reports_unwritable_packaged_index(
    tmp_path, monkeypatch
):
    primary = tmp_path / "blocked" / "index.sqlite"
    calls = []

    def build(knowledge, database_path, project_root):
        calls.append(database_path)
        raise PermissionError("read-only packaged index")

    monkeypatch.setattr(
        "feature_copilot_web.runtime.default_database", lambda root: primary
    )
    runtime = bootstrap_runtime(
        project_root=tmp_path,
        knowledge_dir=tmp_path / "knowledge",
        service_factory=FakeService,
        build_function=build,
        staleness_check=lambda database_path, knowledge, root: True,
    )

    assert calls == [primary]
    assert runtime.database_path == primary
    assert runtime.available is False
    assert runtime.stale is False
    assert runtime.build_error == "read-only packaged index"
