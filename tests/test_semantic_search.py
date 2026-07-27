import copy
import hashlib
import importlib.util
import json
import os
import shutil
import sqlite3
from pathlib import Path

import pytest

from feature_copilot import cache, index_builder
from feature_copilot.cli import EXIT_OK, EXIT_RUNTIME, main
from feature_copilot.errors import ValidationError
from feature_copilot.index_builder import build_index
from feature_copilot.logic_catalog import _managed_feature_semantics
from feature_copilot.service import FeatureService


ROOT = Path(__file__).resolve().parents[1]
SEMANTIC_TOOL_SPEC = importlib.util.spec_from_file_location(
    "manage_semantic_tags", ROOT / "scripts" / "manage_semantic_tags.py"
)
assert SEMANTIC_TOOL_SPEC and SEMANTIC_TOOL_SPEC.loader
SEMANTIC_TOOL = importlib.util.module_from_spec(SEMANTIC_TOOL_SPEC)
SEMANTIC_TOOL_SPEC.loader.exec_module(SEMANTIC_TOOL)
FEATURE_CODE = "ftr.off.usr.example_table.example_feature"
FEATURE_CODES = [FEATURE_CODE] + [
    f"ftr.off.usr.example_table.example_feature_{index:03d}" for index in range(1, 200)
]


def _semantic_payload():
    relation = {
        "tag_code": "business.delinquency",
        "metric_scope": "",
        "source_type": "model_inferred",
        "confidence": "high",
        "evidence_ref": "test:tag",
    }
    return {
        "schema_version": 1,
        "generation": {
            "model": "test-model",
            "prompt_version": "semantic-test-v1",
            "generated_at": "2026-07-20T00:00:00+08:00",
            "input_hash": "fixture-input-hash",
        },
        "dimensions": [
            {"code": "business", "name_zh": "业务维度"},
            {"code": "metric", "name_zh": "指标主题"},
            {"code": "time", "name_zh": "时间范围"},
            {"code": "derivation", "name_zh": "衍生方式"},
        ],
        "tags": [
            {
                "code": "business.delinquency",
                "dimension": "business",
                "name_zh": "逾期",
                "aliases_zh": ["延滞"],
                "aliases_technical": ["overdue"],
            }
        ],
        "pilot": {"code": "test-pilot", "candidate_feature_codes": FEATURE_CODES},
        "feature_semantics": [
            {
                "feature_code": feature_code,
                "semantic_summary_zh": "示例逾期特征",
                "summary_source_type": "model_inferred",
                "summary_confidence": "high",
                "summary_evidence_ref": "test:summary",
                "tags": [copy.deepcopy(relation)],
            }
            for feature_code in FEATURE_CODES
        ],
    }


def _load_semantic_fixture(tmp_path, payload, sync_input_hash=True):
    features = [
        {
            "feature_code": feature_code,
            "feature_name": "",
            "feature_column_name": "",
            "group_code": "",
        }
        for feature_code in FEATURE_CODES
    ]
    semantic_inputs = [
        {
            key: feature[key]
            for key in ("feature_code", "feature_name", "feature_column_name", "group_code")
        }
        for feature in features
    ]
    if sync_input_hash:
        payload["generation"]["input_hash"] = hashlib.sha256(
            json.dumps(
                semantic_inputs,
                ensure_ascii=False,
                sort_keys=True,
                separators=(",", ":"),
            ).encode("utf-8")
        ).hexdigest()
    path = tmp_path / "semantics.json"
    path.write_text(json.dumps(payload, ensure_ascii=False), encoding="utf-8")
    return _managed_feature_semantics(
        tmp_path,
        {"managed_feature_semantics_config": "semantics.json"},
        features,
    )


@pytest.fixture(scope="module")
def managed_index(tmp_path_factory):
    database = tmp_path_factory.mktemp("semantic-index") / "managed.sqlite"
    report = build_index(ROOT / "knowledge", database, ROOT)
    return database, report


@pytest.fixture
def managed_service(managed_index):
    service = FeatureService(managed_index[0])
    yield service
    service.close()


@pytest.mark.parametrize(
    ("case", "message"),
    [
        ("unknown_tag", "unknown semantic tag for feature"),
        ("duplicate_relation", "duplicate semantic tag relation"),
        ("feature_outside_scope", "semantic feature is outside maintenance scope"),
    ],
)
def test_semantic_config_rejects_invalid_feature_relations(tmp_path, case, message):
    payload = _semantic_payload()
    semantic = payload["feature_semantics"][0]
    if case == "unknown_tag":
        semantic["tags"][0]["tag_code"] = "business.unknown"
    elif case == "duplicate_relation":
        semantic["tags"].append(copy.deepcopy(semantic["tags"][0]))
    else:
        semantic["feature_code"] = "ftr.off.usr.missing_table.missing_feature"

    with pytest.raises(ValidationError, match=message):
        _load_semantic_fixture(tmp_path, payload)


def test_semantic_config_rejects_alias_conflict_within_dimension(tmp_path):
    payload = _semantic_payload()
    payload["tags"].append(
        {
            "code": "business.other",
            "dimension": "business",
            "name_zh": "其他业务",
            "aliases_zh": ["延滞"],
            "aliases_technical": [],
        }
    )

    with pytest.raises(ValidationError, match="conflicting semantic tag alias in dimension business"):
        _load_semantic_fixture(tmp_path, payload)


def test_semantic_config_rejects_stale_generation_input_hash(tmp_path):
    with pytest.raises(ValidationError, match="input_hash does not match"):
        _load_semantic_fixture(tmp_path, _semantic_payload(), sync_input_hash=False)


def test_semantic_config_requires_timezone_aware_generation_timestamp(tmp_path):
    payload = _semantic_payload()
    payload["generation"]["generated_at"] = "not-a-timestamp"
    with pytest.raises(ValidationError, match="ISO-8601"):
        _load_semantic_fixture(tmp_path, payload)

    payload = _semantic_payload()
    payload["generation"]["generated_at"] = "2026-07-20T00:00:00"
    with pytest.raises(ValidationError, match="timezone offset"):
        _load_semantic_fixture(tmp_path, payload)


def test_semantic_config_requires_chinese_standard_names_and_chinese_aliases(
    tmp_path,
):
    payload = _semantic_payload()
    payload["tags"][0]["name_zh"] = "overdue"
    with pytest.raises(ValidationError, match="Chinese semantic tag name"):
        _load_semantic_fixture(tmp_path, payload)

    payload = _semantic_payload()
    payload["tags"][0]["aliases_zh"] = ["delinquency"]
    with pytest.raises(ValidationError, match="must contain Chinese text"):
        _load_semantic_fixture(tmp_path, payload)


def test_semantic_config_requires_exact_pilot_coverage(tmp_path):
    payload = _semantic_payload()
    payload["feature_semantics"] = []

    with pytest.raises(ValidationError, match="coverage must exactly match pilot"):
        _load_semantic_fixture(tmp_path, payload)


def test_semantic_tag_code_must_match_dimension_namespace(tmp_path):
    payload = _semantic_payload()
    payload["tags"][0]["dimension"] = "time"

    with pytest.raises(ValidationError, match="dimension namespace"):
        _load_semantic_fixture(tmp_path, payload)


@pytest.mark.parametrize("case", ["empty_code", "too_few_candidates"])
def test_semantic_pilot_identity_and_size_are_governed(tmp_path, case):
    payload = _semantic_payload()
    if case == "empty_code":
        payload["pilot"]["code"] = ""
        message = "pilot code must be non-empty"
    else:
        payload["pilot"]["candidate_feature_codes"] = FEATURE_CODES[:-1]
        payload["feature_semantics"] = payload["feature_semantics"][:-1]
        message = "between 200 and 300 candidates"

    with pytest.raises(ValidationError, match=message):
        _load_semantic_fixture(tmp_path, payload)


def test_offline_validator_rejects_same_tag_with_conflicting_metric_scopes():
    records = SEMANTIC_TOOL.load_feature_records(
        ROOT, ROOT / "knowledge" / "config" / "maintenance_scope.json"
    )
    payload = json.loads(
        (ROOT / "knowledge" / "config" / "managed_feature_semantics.json").read_text(
            encoding="utf-8"
        )
    )
    semantic = payload["feature_semantics"][0]
    metric_relation = next(
        relation for relation in semantic["tags"] if relation["tag_code"].startswith("metric.")
    )
    duplicate = copy.deepcopy(metric_relation)
    duplicate["metric_scope"] = (
        "related" if metric_relation["metric_scope"] == "primary" else "primary"
    )
    semantic["tags"].append(duplicate)

    with pytest.raises(SEMANTIC_TOOL.SemanticConfigError, match="duplicate tag relation"):
        SEMANTIC_TOOL.validate_snapshot(payload, records)


def test_managed_semantic_index_preserves_feature_code_identity_contract(managed_index):
    database, report = managed_index
    assert report["managed_source_feature_rows"] == 23702
    assert report["managed_feature_count"] == 23702
    assert report["managed_semantic_audit"]["tagged_feature_count"] == 23702

    service = FeatureService(database)
    try:
        assert service.repository.row("SELECT COUNT(*) AS count FROM managed_features")["count"] == 23702
    finally:
        service.close()


def test_full_catalog_aliases_are_indexed_and_tongdun_uses_local_sql_evidence(managed_service):
    result = managed_service.get(
        "ftr.off.usr.dwa_risk_tnd_feature_di.tnd_rsk_itm_1m_div_6m"
    )

    metadata = result["semantic_metadata"]
    assert metadata["alias_zh"] == "同盾多头：近1个月与近6个月借款申请平台数之比"
    assert metadata["alias_source_type"] == "rule_inferred"
    assert metadata["alias_confidence"] == "high"
    assert metadata["alias_evidence_ref"] == "rule:alias-v1:tongdun-local-sql"

    aliases = managed_service.repository.row(
        "SELECT COUNT(*) AS count FROM managed_feature_semantics WHERE alias_zh<>''"
    )
    assert aliases["count"] == 23702


def test_full_catalog_aliases_do_not_retain_generic_code_token_fallbacks():
    payload = json.loads(
        (ROOT / "knowledge" / "config" / "managed_feature_semantics_full.json").read_text(
            encoding="utf-8"
        )
    )
    aliases = payload["feature_semantics"]
    assert len(aliases) == 23702
    assert not [
        item for item in aliases
        if item["alias_evidence_ref"] == "rule:alias-v1:column-token"
    ]

    click = next(
        item for item in aliases
        if item["feature_code"].endswith(".clk_cnt_00_06_14d")
    )
    assert click["alias_zh"] == "近14天凌晨0-6时点击次数"
    assert click["alias_evidence_ref"] == "rule:alias-v2:local-sql-field-pattern"


def test_managed_semantic_tables_and_repeated_build_are_deterministic(managed_index, tmp_path):
    first_database, first_report = managed_index
    second_database = tmp_path / "managed-second.sqlite"
    second_report = build_index(ROOT / "knowledge", second_database, ROOT)

    assert second_report["managed_semantic_audit"] == first_report["managed_semantic_audit"]
    first_manifest = json.loads(first_database.with_suffix(".manifest.json").read_text(encoding="utf-8"))
    second_manifest = json.loads(second_database.with_suffix(".manifest.json").read_text(encoding="utf-8"))
    assert second_manifest["schema_version"] == first_manifest["schema_version"] == 3
    assert second_manifest["source_hashes"] == first_manifest["source_hashes"]

    service = FeatureService(second_database)
    try:
        expected_counts = {
            "managed_tag_dimensions": 6,
            "managed_tags": 56,
            "managed_tag_aliases": 332,
            "managed_feature_semantics": 23702,
            "managed_feature_tags": 213501,
        }
        for table, expected in expected_counts.items():
            actual = service.repository.row(f"SELECT COUNT(*) AS count FROM {table}")["count"]
            assert actual == expected
    finally:
        service.close()


def test_chinese_standard_term_and_alias_recall_semantic_features(managed_service):
    direct = managed_service.search(["连续逾期天数"], limit=10)
    assert direct["counts"]["managed"] >= 2
    assert all("semantic_text_zh" in item["match_sources"] for item in direct["items"])
    assert all(
        any(tag["code"] == "metric.continuous_overdue_days" for tag in item["matched_tags"])
        for item in direct["items"]
    )

    alias = managed_service.search(["延滞"], limit=5)
    assert alias["counts"]["managed"] > 0
    assert all("semantic_text_zh" in item["match_sources"] for item in alias["items"])
    assert all(
        any(tag["code"] == "business.delinquency" for tag in item["matched_tags"])
        for item in alias["items"]
    )

    mixed = managed_service.search(
        ["dwa_risk_dz_model_final_12his_continue_ovd_days_df", "持续逾期天数"],
        limit=5,
    )
    assert mixed["counts"]["managed"] >= 2
    assert all(
        {"keyword_metadata", "semantic_text_zh"}.issubset(item["match_sources"])
        for item in mixed["items"]
    )


@pytest.mark.parametrize(
    "terms",
    [
        ["逾期"],
        ["延滞"],
        ["dwa_risk_dz_model_final_12his_continue_ovd_days_df", "持续逾期天数"],
        ["逾期 延迟还款"],
    ],
)
def test_managed_literal_keyword_fast_path_matches_legacy_concatenated_search(
    managed_service, terms
):
    use_semantic = managed_service._semantic_lexical_match_exists(terms)
    source = " FROM managed_features"
    fields = (
        "coalesce(managed_features.feature_code,'') || ' ' || "
        "coalesce(managed_features.feature_column_name,'') || ' ' || "
        "coalesce(managed_features.feature_name,'') || ' ' || "
        "coalesce(managed_features.feature_category,'') || ' ' || "
        "coalesce(managed_features.business_subcategory_name,'') || ' ' || "
        "coalesce(managed_features.group_name,'') || ' ' || "
        "coalesce(managed_features.table_name,'')"
    )
    if use_semantic:
        source += (
            " LEFT JOIN managed_feature_semantics semantic "
            "ON semantic.feature_id=managed_features.rowid"
        )
        fields += " || ' ' || coalesce(semantic.search_text_zh,'')"
    where = " AND ".join(f"lower({fields}) LIKE lower(?)" for _ in terms)
    parameters = tuple(f"%{term}%" for term in terms)
    expected_count = managed_service.repository.row(
        "SELECT COUNT(*) AS count" + source + " WHERE " + where, parameters
    )["count"]
    expected_codes = [
        row["feature_code"]
        for row in managed_service.repository.rows(
            "SELECT managed_features.feature_code"
            + source
            + " WHERE "
            + where
            + " ORDER BY managed_features.feature_name, managed_features.feature_code LIMIT 40",
            parameters,
        )
    ]

    result = managed_service.search(terms, limit=40)

    assert result["counts"]["fixture"] == 0
    assert result["counts"]["managed"] == expected_count
    assert [item["feature_code"] for item in result["items"]] == expected_codes


def test_managed_field_fast_path_excludes_phrase_and_like_wildcard_queries():
    assert FeatureService._can_search_managed_fields_separately(["逾期", "DPD"])
    assert not FeatureService._can_search_managed_fields_separately(["逾期 天数"])
    assert not FeatureService._can_search_managed_fields_separately(["ovd%day"])
    assert not FeatureService._can_search_managed_fields_separately(["ovd_day"])


def test_related_metric_scope_filters_relations(managed_service):
    result = managed_service.search(
        [], {"tag": ["metric.overdue_days"], "metric_scope": "related"}, limit=10
    )

    assert result["total"] > 0
    assert result["matched_tags"] == [
        {"code": "metric.overdue_days", "dimension": "metric", "name_zh": "逾期天数"}
    ]
    assert all(item["verified"] is False for item in result["items"])
    assert all(
        any(
            tag["code"] == "metric.overdue_days" and tag["metric_scope"] == "related"
            for tag in item["matched_tags"]
        )
        for item in result["items"]
    )


def test_get_exposes_navigation_metadata_without_upgrading_verification(managed_service):
    code = (
        "ftr.off.usr.dwa_risk_dz_model_final_12his_continue_ovd_days_df."
        "max_ctn_ovd_day"
    )
    result = managed_service.get(code)

    assert result["status"] == "OK"
    assert result["verified"] is False
    assert result["semantic_metadata"]["coverage"] == "tagged"
    assert result["semantic_metadata"]["source_type"] == "rule_inferred"
    assert result["matched_tags"] == []
    assert result["match_sources"] == ["exact_feature"]


def test_tag_only_search_and_multiple_tags_use_and_semantics(managed_service):
    tag_only = managed_service.search([], {"tag": ["逾期"]}, limit=10)
    combined = managed_service.search(
        [], {"tag": ["business.delinquency", "time.recent_12_months"]}, limit=10
    )

    assert 0 < combined["total"] < tag_only["total"]
    assert tag_only["counts"]["fixture"] == combined["counts"]["fixture"] == 0
    assert {tag["code"] for tag in combined["matched_tags"]} == {
        "business.delinquency",
        "time.recent_12_months",
    }
    assert all(
        {tag["code"] for tag in item["matched_tags"]}
        >= {"business.delinquency", "time.recent_12_months"}
        for item in combined["items"]
    )


def test_business_stage_tag_covers_all_current_managed_features(managed_service):
    result = managed_service.search([], {"tag": ["贷中"]}, limit=10)

    assert result["total"] == 23702
    assert result["matched_tags"] == [
        {"code": "business_stage.in_loan", "dimension": "business_stage", "name_zh": "贷中"}
    ]
    assert all(
        any(tag["code"] == "business_stage.in_loan" for tag in item["matched_tags"])
        for item in result["items"]
    )


def test_unknown_tag_is_rejected(managed_service):
    with pytest.raises(ValidationError, match="unknown semantic tag"):
        managed_service.search([], {"tag": ["metric.not_configured"]})


def test_keyword_search_falls_back_to_untagged_managed_metadata(managed_service):
    result = managed_service.search(["非银机构夜间申请"], limit=5)

    assert result["counts"]["managed"] > 0
    assert all(item["semantic_metadata"]["coverage"] == "untagged" for item in result["items"])
    assert all(item["matched_tags"] == [] for item in result["items"])
    assert all(item["match_sources"] == ["keyword_metadata"] for item in result["items"])


def test_semantic_search_works_when_fts_is_disabled(managed_index, tmp_path):
    database = tmp_path / "without-fts.sqlite"
    shutil.copy2(managed_index[0], database)
    service = FeatureService(database)
    try:
        service.repository.connection.execute("UPDATE metadata SET value='false' WHERE key='fts5'")
        result = service.search(["连续逾期天数"], limit=5)
        assert result["search_mode"] == "like"
        assert result["counts"]["managed"] == 2
        assert all("semantic_text_zh" in item["match_sources"] for item in result["items"])
    finally:
        service.close()


def test_direct_python_access_to_old_index_falls_back_to_keyword_search(managed_index, tmp_path):
    database = tmp_path / "old-schema.sqlite"
    shutil.copy2(managed_index[0], database)
    service = FeatureService(database)
    try:
        for table in (
            "managed_feature_tags",
            "managed_feature_semantics",
            "managed_tag_aliases",
            "managed_tags",
            "managed_tag_dimensions",
        ):
            service.repository.connection.execute(f"DROP TABLE {table}")
        service.repository.connection.commit()
    finally:
        service.close()

    service = FeatureService(database)
    try:
        result = service.search(["max_ctn_ovd_day"], limit=5)
        assert any(item.get("feature_column_name") == "max_ctn_ovd_day" for item in result["items"])
        assert all(item["semantic_metadata"]["coverage"] == "untagged" for item in result["items"])
        assert service.list_tags()["semantic_index"] == "unavailable"
    finally:
        service.close()


def test_legacy_search_call_without_semantic_parameters_is_unchanged(service):
    result = service.search(["fixture_income_avg_30d"])

    assert result["search_mode"] == "fts5"
    assert result["total"] == 2
    assert result["counts"] == {"fixture": 2, "managed": 0}
    assert result["matched_tags"] == []


@pytest.mark.parametrize("reserved_word", ["AND", "OR", "NOT"])
def test_fts_reserved_words_are_safe_search_terms(service, reserved_word):
    result = service.search([reserved_word])

    assert result["status"] == "OK"
    assert result["search_mode"] == "fts5"


def test_search_offset_is_applied_across_fixture_and_managed_results(managed_service):
    full = managed_service.search(["avg"], limit=4, offset=0)
    boundary = managed_service.search(["avg"], limit=2, offset=1)
    managed_only = managed_service.search(["avg"], limit=1, offset=2)

    def identity(item):
        return item.get("feature_id") or item.get("feature_code")

    full_ids = [identity(item) for item in full["items"]]
    assert full["counts"]["fixture"] == 2
    assert [identity(item) for item in boundary["items"]] == full_ids[1:3]
    assert [identity(item) for item in managed_only["items"]] == full_ids[2:3]


def test_schema_v1_manifest_is_stale(tmp_path):
    database = tmp_path / "feature_copilot.sqlite"
    database.write_bytes(b"old-index")
    database.with_suffix(".manifest.json").write_text(
        json.dumps({"schema_version": 1}), encoding="utf-8"
    )

    assert cache.index_needs_rebuild(database, tmp_path / "knowledge", tmp_path) is True


def test_semantic_config_content_hash_marks_index_stale_even_with_old_mtime(tmp_path):
    project = tmp_path / "project"
    knowledge = project / "knowledge"
    config = knowledge / "config"
    config.mkdir(parents=True)
    for filename in cache.KNOWLEDGE_FILES:
        (knowledge / filename).write_text("fixture", encoding="utf-8")
    scope = config / "maintenance_scope.json"
    scope.write_text(
        json.dumps(
            {
                "packages": [],
                "group_logic_directory": "missing-group-logic",
                "dp_logic_directory": "missing-dp-logic",
                "managed_feature_semantics_config": "knowledge/config/semantics.json",
            }
        ),
        encoding="utf-8",
    )
    semantics = config / "semantics.json"
    original = b'{"schema_version": 1, "value": "before"}'
    semantics.write_bytes(original)

    database = tmp_path / "feature_copilot.sqlite"
    connection = sqlite3.connect(database)
    connection.execute("CREATE TABLE metadata(key TEXT PRIMARY KEY, value TEXT NOT NULL)")
    connection.execute("INSERT INTO metadata VALUES ('build_id', 'test-build')")
    connection.commit()
    connection.close()
    database.with_suffix(".manifest.json").write_text(
        json.dumps(
            {
                "schema_version": 3,
                "build_id": "test-build",
                "knowledge_source_hashes": {
                    filename: hashlib.sha256(b"fixture").hexdigest()
                    for filename in cache.KNOWLEDGE_FILES
                },
                "source_hashes": {
                    "knowledge/config/semantics.json": hashlib.sha256(original).hexdigest()
                },
            }
        ),
        encoding="utf-8",
    )
    old_ns = database.stat().st_mtime_ns - 1_000_000_000
    for path in [scope, semantics, *(knowledge / name for name in cache.KNOWLEDGE_FILES)]:
        os.utime(path, ns=(old_ns, old_ns))
    assert cache.index_needs_rebuild(database, knowledge, project) is False

    semantics.write_bytes(b'{"schema_version": 1, "value": "after"}')
    os.utime(semantics, ns=(old_ns, old_ns))
    assert cache.index_needs_rebuild(database, knowledge, project) is True

    semantics.unlink()
    assert cache.index_needs_rebuild(database, knowledge, project) is True


def test_invalid_semantic_config_does_not_replace_existing_index(kb, tmp_path, monkeypatch):
    knowledge, database = kb
    manifest = database.with_suffix(".manifest.json")
    before_database = database.read_bytes()
    before_manifest = manifest.read_bytes()
    payload = _semantic_payload()
    payload["feature_semantics"][0]["tags"][0]["tag_code"] = "business.unknown"

    def load_invalid_semantics(*_args, **_kwargs):
        return _load_semantic_fixture(tmp_path, payload)

    monkeypatch.setattr(index_builder, "load_managed_catalog", load_invalid_semantics)
    with pytest.raises(ValidationError, match="unknown semantic tag"):
        build_index(knowledge, database, ROOT, include_managed_assets=True)

    assert database.read_bytes() == before_database
    assert manifest.read_bytes() == before_manifest


def test_manifest_write_failure_does_not_replace_existing_index(kb, monkeypatch):
    knowledge, database = kb
    manifest = database.with_suffix(".manifest.json")
    before_database = database.read_bytes()
    before_manifest = manifest.read_bytes()

    def fail_manifest(*_args, **_kwargs):
        raise OSError("simulated manifest write failure")

    monkeypatch.setattr(index_builder, "_write_manifest", fail_manifest)
    with pytest.raises(OSError, match="simulated manifest write failure"):
        build_index(knowledge, database, ROOT)

    assert database.read_bytes() == before_database
    assert manifest.read_bytes() == before_manifest


def test_manifest_install_failure_rolls_back_database_and_manifest_pair(tmp_path, monkeypatch):
    database = tmp_path / "feature_copilot.sqlite"
    manifest = database.with_suffix(".manifest.json")
    temp_database = tmp_path / "new.sqlite"
    temp_manifest = temp_database.with_suffix(".manifest.json")
    database.write_bytes(b"old-database")
    manifest.write_bytes(b"old-manifest")
    temp_database.write_bytes(b"new-database")
    temp_manifest.write_bytes(b"new-manifest")
    real_replace = index_builder.os.replace

    def fail_new_manifest(source, target):
        if Path(source) == temp_manifest and Path(target) == manifest:
            raise OSError("simulated manifest install failure")
        return real_replace(source, target)

    monkeypatch.setattr(index_builder.os, "replace", fail_new_manifest)
    with pytest.raises(OSError, match="simulated manifest install failure"):
        index_builder._replace_index_pair(temp_database, temp_manifest, database)

    assert database.read_bytes() == b"old-database"
    assert manifest.read_bytes() == b"old-manifest"


def test_backup_creation_failure_leaves_existing_pair_untouched(tmp_path, monkeypatch):
    database = tmp_path / "feature_copilot.sqlite"
    manifest = database.with_suffix(".manifest.json")
    temp_database = tmp_path / "new.sqlite"
    temp_manifest = temp_database.with_suffix(".manifest.json")
    database.write_bytes(b"old-database")
    manifest.write_bytes(b"old-manifest")
    temp_database.write_bytes(b"new-database")
    temp_manifest.write_bytes(b"new-manifest")

    def fail_backup(*_args, **_kwargs):
        raise OSError("simulated hard-link failure")

    monkeypatch.setattr(index_builder.os, "link", fail_backup)
    with pytest.raises(OSError, match="simulated hard-link failure"):
        index_builder._replace_index_pair(temp_database, temp_manifest, database)

    assert database.read_bytes() == b"old-database"
    assert manifest.read_bytes() == b"old-manifest"


def test_failed_rollback_preserves_recoverable_database_backup(tmp_path, monkeypatch):
    database = tmp_path / "feature_copilot.sqlite"
    manifest = database.with_suffix(".manifest.json")
    temp_database = tmp_path / "new.sqlite"
    temp_manifest = temp_database.with_suffix(".manifest.json")
    database.write_bytes(b"old-database")
    manifest.write_bytes(b"old-manifest")
    temp_database.write_bytes(b"new-database")
    temp_manifest.write_bytes(b"new-manifest")
    real_replace = index_builder.os.replace

    def fail_install_and_database_restore(source, target):
        source_path = Path(source)
        target_path = Path(target)
        if source_path == temp_manifest and target_path == manifest:
            raise OSError("simulated manifest install failure")
        if source_path.name.endswith(".sqlite.bak") and target_path == database:
            raise OSError("simulated database rollback failure")
        return real_replace(source, target)

    monkeypatch.setattr(index_builder.os, "replace", fail_install_and_database_restore)
    with pytest.raises(RuntimeError, match="rollback was incomplete"):
        index_builder._replace_index_pair(temp_database, temp_manifest, database)

    backups = list(tmp_path.glob("feature_copilot_previous_*.sqlite.bak"))
    assert len(backups) == 1
    assert backups[0].read_bytes() == b"old-database"
    assert manifest.read_bytes() == b"old-manifest"


def test_cli_lists_tags_searches_with_semantic_options_and_rejects_empty_query(
    managed_index, capsys
):
    database = managed_index[0]
    common = ["--data-dir", str(ROOT / "knowledge"), "--db", str(database)]

    assert main([*common, "tags", "延滞", "--dimension", "business", "--format", "json"]) == EXIT_OK
    tags = json.loads(capsys.readouterr().out)
    assert tags["total"] == 1
    assert tags["items"][0]["code"] == "business.delinquency"
    assert "延滞" in tags["items"][0]["aliases_zh"]

    assert main([*common, "tags", "--format", "json"]) == EXIT_OK
    assert json.loads(capsys.readouterr().out)["total"] == 56

    assert main([*common, "tags", "--dimension", "business_stage", "--format", "json"]) == EXIT_OK
    stages = json.loads(capsys.readouterr().out)
    assert {item["code"] for item in stages["items"]} == {
        "business_stage.in_loan", "business_stage.pre_loan"
    }

    assert main(
        [
            *common,
            "search",
            "--tag",
            "business.delinquency",
            "--tag",
            "time.recent_12_months",
            "--metric-scope",
            "any",
            "--limit",
            "3",
            "--format",
            "json",
        ]
    ) == EXIT_OK
    search = json.loads(capsys.readouterr().out)
    assert search["total"] > len(search["items"]) == 3
    assert {tag["code"] for tag in search["matched_tags"]} == {
        "business.delinquency",
        "time.recent_12_months",
    }

    assert main([*common, "search", "--format", "json"]) == EXIT_RUNTIME
    empty = json.loads(capsys.readouterr().out)
    assert empty["status"] == "ERROR"
    assert "at least one keyword or --tag" in empty["error"]
