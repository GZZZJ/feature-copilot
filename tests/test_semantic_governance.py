import argparse
import base64
import copy
import datetime as dt
import gzip
import importlib.util
import json
import math
import re
from pathlib import Path

import pytest


ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "semantic_governance_tool", ROOT / "scripts" / "manage_semantic_tags.py"
)
assert SPEC and SPEC.loader
TOOL = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(TOOL)


@pytest.fixture(scope="module")
def governed_inputs():
    scope = ROOT / "knowledge" / "config" / "maintenance_scope.json"
    config_path = ROOT / "knowledge" / "config" / "managed_feature_semantics.json"
    records = TOOL.load_feature_records(ROOT, scope)
    config = json.loads(config_path.read_text(encoding="utf-8"))
    args = argparse.Namespace(
        root=str(ROOT),
        scope="knowledge/config/maintenance_scope.json",
        config="knowledge/config/managed_feature_semantics.json",
        target_count=250,
        batch_size=40,
    )
    candidate_export = TOOL.command_export(args)
    return records, config, candidate_export


def _batch_results(config, candidate_export):
    semantics = {item["feature_code"]: item for item in config["feature_semantics"]}
    results = []
    for batch in candidate_export["batches"]:
        results.append(
            (
                f"batch-{batch['batch']:02d}.json",
                {
                    "schema_version": 2,
                    "pilot_code": candidate_export["pilot_code"],
                    "input_hash": candidate_export["input_hash"],
                    "base_snapshot_sha256": candidate_export[
                        "base_snapshot_sha256"
                    ],
                    "batch": batch["batch"],
                    "items": [
                        copy.deepcopy(semantics[item["feature_code"]])
                        for item in reversed(batch["items"])
                    ],
                },
            )
        )
    return results


def test_candidate_export_balances_every_model_batch_between_40_and_50(governed_inputs):
    _, config, candidate_export = governed_inputs

    assert candidate_export["schema_version"] == 2
    assert candidate_export["base_snapshot_sha256"] == TOOL._content_hash(config)
    sizes = [len(batch["items"]) for batch in candidate_export["batches"]]
    assert sizes == candidate_export["actual_batch_sizes"]
    assert all(40 <= size <= 50 for size in sizes)
    assert sum(sizes) == 250


def test_governed_vocabulary_requires_chinese_names_and_chinese_aliases(
    governed_inputs,
):
    records, config, _ = governed_inputs
    invalid_name = copy.deepcopy(config)
    invalid_name["tags"][0]["name_zh"] = "overdue"
    with pytest.raises(TOOL.SemanticConfigError, match="must contain Chinese text"):
        TOOL.validate_snapshot(invalid_name, records)

    invalid_alias = copy.deepcopy(config)
    invalid_alias["tags"][0]["aliases_zh"] = ["delinquency"]
    with pytest.raises(TOOL.SemanticConfigError, match="must contain Chinese text"):
        TOOL.validate_snapshot(invalid_alias, records)


def test_merge_batches_is_deterministic_and_exact(governed_inputs):
    records, config, candidate_export = governed_inputs
    results = _batch_results(config, candidate_export)

    snapshot_a, report_a = TOOL.merge_batch_results(
        candidate_export, results, config, records
    )
    snapshot_b, report_b = TOOL.merge_batch_results(
        candidate_export, list(reversed(results)), config, records
    )

    assert snapshot_a == snapshot_b == config
    assert report_a["snapshot_sha256"] == report_b["snapshot_sha256"]
    assert report_a["merged_feature_count"] == 250
    assert report_a["merged_batch_count"] == len(candidate_export["batches"])
    assert report_a["conflict_report"]["conflicts"] == []


def test_merge_batches_rejects_stale_base_snapshot_and_stale_generation(
    governed_inputs,
):
    records, config, candidate_export = governed_inputs
    results = _batch_results(config, candidate_export)

    stale_results = copy.deepcopy(results)
    stale_results[0][1]["base_snapshot_sha256"] = "0" * 64
    with pytest.raises(TOOL.SemanticConfigError, match="base snapshot mismatch"):
        TOOL.merge_batch_results(candidate_export, stale_results, config, records)

    changed_results = copy.deepcopy(results)
    changed_results[0][1]["items"][0]["semantic_summary_zh"] += "复核修订。"
    with pytest.raises(TOOL.SemanticConfigError, match="generation override"):
        TOOL.merge_batch_results(candidate_export, changed_results, config, records)

    base_generated_at = dt.datetime.fromisoformat(
        config["generation"]["generated_at"].replace("Z", "+00:00")
    )
    changed_snapshot, _ = TOOL.merge_batch_results(
        candidate_export,
        changed_results,
        config,
        records,
        {
            "model": "offline-review-model-v2",
            "prompt_version": "overdue-semantics-v3",
            "generated_at": (base_generated_at + dt.timedelta(seconds=1)).isoformat(),
        },
    )
    assert changed_snapshot["generation"]["model"] == "offline-review-model-v2"
    assert changed_snapshot != config


def test_candidate_export_rejects_a_different_base_snapshot(governed_inputs):
    records, config, candidate_export = governed_inputs
    changed_base = copy.deepcopy(config)
    changed_base["generation"]["prompt_version"] += "-changed"

    with pytest.raises(TOOL.SemanticConfigError, match="base_snapshot_sha256"):
        TOOL._validate_candidate_export(candidate_export, records, changed_base)


def test_merge_batches_rejects_duplicate_batch_independent_of_input_order(governed_inputs):
    records, config, candidate_export = governed_inputs
    results = _batch_results(config, candidate_export)
    duplicate = copy.deepcopy(results[0][1])
    duplicate["items"] = []

    reports = []
    for ordered_results in (
        [*results, ("batch-01-duplicate.json", duplicate)],
        [("batch-01-duplicate.json", duplicate), *results],
    ):
        with pytest.raises(TOOL.MergeConflictError) as caught:
            TOOL.merge_batch_results(
                candidate_export, ordered_results, config, records
            )
        reports.append(caught.value.report)

    assert reports[0] == reports[1]
    conflicts = reports[0]["conflicts"]
    assert len(conflicts) == len(candidate_export["batches"][0]["items"])
    assert {item["reason"] for item in conflicts} == {"duplicate_batch_result"}


def test_merge_command_rejects_snapshot_and_conflict_path_alias(
    governed_inputs, tmp_path
):
    _, config, candidate_export = governed_inputs
    candidate_path = tmp_path / "candidate-export.json"
    TOOL._write_json(candidate_path, candidate_export)
    result_paths = []
    for source, payload in _batch_results(config, candidate_export):
        path = tmp_path / source
        TOOL._write_json(path, payload)
        result_paths.append(str(path))
    shared_output = tmp_path / "shared.json"
    args = argparse.Namespace(
        root=str(ROOT),
        scope="knowledge/config/maintenance_scope.json",
        config="knowledge/config/managed_feature_semantics.json",
        candidate_export=str(candidate_path),
        batch_result=result_paths,
        output=str(shared_output),
        conflict_report=str(shared_output),
        model=None,
        prompt_version=None,
        generated_at=None,
    )

    with pytest.raises(TOOL.SemanticConfigError, match="different paths"):
        TOOL.command_merge(args)
    assert not shared_output.exists()


def test_merge_command_never_overwrites_an_existing_snapshot(
    governed_inputs, tmp_path
):
    _, config, candidate_export = governed_inputs
    candidate_path = tmp_path / "candidate-export.json"
    TOOL._write_json(candidate_path, candidate_export)
    result_paths = []
    for source, payload in _batch_results(config, candidate_export):
        path = tmp_path / source
        TOOL._write_json(path, payload)
        result_paths.append(str(path))
    output = tmp_path / "snapshot.json"
    TOOL._write_json(output, {"protected": True})
    args = argparse.Namespace(
        root=str(ROOT),
        scope="knowledge/config/maintenance_scope.json",
        config="knowledge/config/managed_feature_semantics.json",
        candidate_export=str(candidate_path),
        batch_result=result_paths,
        output=str(output),
        conflict_report=None,
        model=None,
        prompt_version=None,
        generated_at=None,
    )

    with pytest.raises(TOOL.SemanticConfigError, match="refusing to overwrite"):
        TOOL.command_merge(args)
    assert json.loads(output.read_text(encoding="utf-8")) == {"protected": True}


def test_merge_batches_rejects_declared_model_conflict(governed_inputs):
    records, config, candidate_export = governed_inputs
    results = _batch_results(config, candidate_export)
    conflict_code = results[0][1]["items"][0]["feature_code"]
    results[0][1]["conflicts"] = [
        {"feature_code": conflict_code, "reason": "primary_metric_ambiguous"}
    ]

    with pytest.raises(TOOL.MergeConflictError) as caught:
        TOOL.merge_batch_results(candidate_export, results, config, records)

    assert caught.value.report["conflicts"] == [
        {
            "feature_code": conflict_code,
            "reason": "declared_label_conflict:primary_metric_ambiguous",
            "sources": ["batch-01.json"],
            "batches": [1],
        }
    ]


def test_review_plan_full_checks_low_and_conflicts_and_samples_high(governed_inputs):
    records, config, _ = governed_inputs
    config = copy.deepcopy(config)
    low_code = config["feature_semantics"][0]["feature_code"]
    conflict_code = config["feature_semantics"][1]["feature_code"]
    config["feature_semantics"][0]["summary_confidence"] = "low"
    conflict_payload = {
        "schema_version": 2,
        "pilot_code": config["pilot"]["code"],
        "input_hash": config["generation"]["input_hash"],
        "base_snapshot_sha256": TOOL._content_hash(config),
        "conflicts": [
            {
                "feature_code": conflict_code,
                "reason": "conflicting_feature_result",
                "sources": ["batch-a.json", "batch-b.json"],
                "batches": [1],
            }
        ],
    }

    plan = TOOL.build_review_plan(config, records, conflict_payload)
    by_code = {item["feature_code"]: item for item in plan["items"]}
    sampled = [
        item
        for item in plan["items"]
        if "high_confidence_stratified_sample" in item["review_reasons"]
    ]

    assert "low_confidence_full_review" in by_code[low_code]["review_reasons"]
    assert "merge_conflict_full_review" in by_code[conflict_code]["review_reasons"]
    verified_codes = {
        item["feature_code"]
        for item in config["feature_semantics"]
        if item["summary_source_type"] in {"manual_confirmed", "logic_verified"}
        or any(
            relation["source_type"] in {"manual_confirmed", "logic_verified"}
            for relation in item["tags"]
        )
    }
    assert len(verified_codes) == 22
    assert all(
        "verified_evidence_full_review" in by_code[code]["review_reasons"]
        for code in verified_codes
    )
    assert plan["population"]["verified_evidence_feature_count"] == 22
    assert plan["policy"]["verified_evidence_review_rate"] == 1.0
    assert len(sampled) == math.ceil(250 * 0.2)
    population_strata = {
        TOOL._primary_metric_stratum(item)
        for item in config["feature_semantics"]
        if item["summary_confidence"] == "high"
        or any(relation["confidence"] == "high" for relation in item["tags"])
    }
    assert {item["stratum"] for item in sampled} == population_strata
    assert all(item["status"] == "pending" for item in plan["items"])
    assert all(
        not item[field]
        for item in plan["items"]
        for field in ("reviewer", "reviewed_at", "decision", "review_evidence_ref")
    )

    stale_conflicts = copy.deepcopy(conflict_payload)
    stale_conflicts["base_snapshot_sha256"] = "0" * 64
    with pytest.raises(TOOL.SemanticConfigError, match="base_snapshot_sha256"):
        TOOL.build_review_plan(config, records, stale_conflicts)


def test_review_log_exposes_pending_review_and_requires_real_trail(governed_inputs):
    records, config, _ = governed_inputs
    plan = TOOL.build_review_plan(config, records)
    audit = TOOL.validate_review_log(plan, config, records)

    required_count = len(plan["items"])
    assert required_count == 67
    assert audit["required_review_feature_count"] == required_count
    assert audit["pending_review_feature_count"] == required_count
    assert audit["reviewed_feature_count"] == 0
    assert audit["requirements_met"] is False

    fabricated = copy.deepcopy(plan)
    fabricated["items"][0]["reviewer"] = "someone"
    with pytest.raises(TOOL.SemanticConfigError, match="fabricated completion field"):
        TOOL.validate_review_log(fabricated, config, records)

    completed = copy.deepcopy(plan)
    for item in completed["items"]:
        item.update(
            {
                "status": "completed",
                "reviewer": "human-reviewer",
                "reviewed_at": "2026-07-20T12:00:00+08:00",
                "decision": "approved",
                "review_evidence_ref": "review-ticket:example",
            }
        )
    completed_audit = TOOL.validate_review_log(completed, config, records)
    assert completed_audit["reviewed_feature_count"] == required_count
    assert completed_audit["pending_review_feature_count"] == 0
    assert completed_audit["requirements_met"] is True

    future = copy.deepcopy(completed)
    future["items"][0]["reviewed_at"] = "2999-01-01T00:00:00+08:00"
    with pytest.raises(TOOL.SemanticConfigError, match="cannot be in the future"):
        TOOL.validate_review_log(future, config, records)


def test_create_review_plan_is_idempotent_but_never_overwrites_review_history(
    governed_inputs, tmp_path
):
    records, config, _ = governed_inputs
    plan = TOOL.build_review_plan(config, records)
    output = tmp_path / "review.json"
    TOOL._write_json(output, plan)
    args = argparse.Namespace(
        root=str(ROOT),
        scope="knowledge/config/maintenance_scope.json",
        config="knowledge/config/managed_feature_semantics.json",
        conflict_report=None,
        output=str(output),
    )

    result = TOOL.command_create_review_plan(args)
    assert result["existing_review_preserved"] is True

    completed = copy.deepcopy(plan)
    completed["items"][0].update(
        {
            "status": "completed",
            "reviewer": "independent-reviewer",
            "reviewed_at": "2026-07-20T18:00:00+08:00",
            "decision": "approved",
            "review_evidence_ref": "source-package:example",
        }
    )
    TOOL._write_json(output, completed)
    with pytest.raises(TOOL.SemanticConfigError, match="refusing to overwrite"):
        TOOL.command_create_review_plan(args)


def test_review_validation_and_audit_exit_nonzero_until_approved(
    governed_inputs, tmp_path, capsys
):
    records, config, _ = governed_inputs
    review_path = tmp_path / "pending-review.json"
    TOOL._write_json(review_path, TOOL.build_review_plan(config, records))
    common = [
        "--root",
        str(ROOT),
        "--scope",
        "knowledge/config/maintenance_scope.json",
        "--config",
        "knowledge/config/managed_feature_semantics.json",
    ]

    assert TOOL.main([*common, "validate-review", "--review-log", str(review_path)]) == 1
    assert '"requirements_met": false' in capsys.readouterr().out
    assert TOOL.main([*common, "audit", "--review-log", str(review_path)]) == 1
    assert '"governance_requirements_met": false' in capsys.readouterr().out


def test_checked_in_review_log_is_bound_to_snapshot_and_covers_the_plan(governed_inputs):
    records, config, _ = governed_inputs
    review_log = json.loads(
        (
            ROOT
            / "knowledge"
            / "config"
            / "managed_feature_semantics_review.json"
        ).read_text(encoding="utf-8")
    )

    audit = TOOL.validate_review_log(review_log, config, records)

    assert audit["review_log_status"] == "present"
    required_count = len(review_log["items"])
    assert required_count == 67
    assert audit["required_review_feature_count"] == required_count
    assert audit["pending_review_feature_count"] + audit["reviewed_feature_count"] == required_count
    assert audit["approved_feature_count"] + audit["changes_required_feature_count"] == audit[
        "reviewed_feature_count"
    ]
    assert audit["requirements_met"] is (
        audit["approved_feature_count"] == required_count
    )


def test_checked_in_snapshot_has_expected_systematic_remediation_counts(governed_inputs):
    records, config, _ = governed_inputs

    audit = TOOL.validate_snapshot(config, records)

    assert audit["vocabulary_count"] == 43
    assert audit["pilot_candidate_count"] == 250
    assert audit["tagged_feature_count"] == 250
    assert audit["relationship_count"] == 1814
    assert audit["dimension_coverage"] == {
        "business": 720,
        "derivation": 364,
        "metric": 501,
        "time": 229,
    }
    assert audit["confidence_distribution"] == {
        "high": 1795,
        "medium": 19,
    }
    assert audit["source_type_distribution"] == {
        "logic_verified": 90,
        "manual_confirmed": 1,
        "model_inferred": 1723,
    }
    assert audit["review_requirements"]["low_confidence_all_feature_count"] == 0


def test_actual_repayment_principal_is_not_due_amount_and_stg_pln_is_loan_order(
    governed_inputs,
):
    _, config, _ = governed_inputs
    item = next(
        item
        for item in config["feature_semantics"]
        if item["feature_code"].endswith(
            ".stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_rto"
        )
    )
    tag_codes = {relation["tag_code"] for relation in item["tags"]}

    assert "business.loan_order" in tag_codes
    assert "metric.overdue_amount" in tag_codes
    assert "metric.due_amount" not in tag_codes
    assert "time.recent_1_month" not in tag_codes  # 30d is a DPD bucket boundary.
    assert "time.recent_12_months" in tag_codes


def test_due_amount_requires_the_final_output_to_be_amount_due(governed_inputs):
    records, config, _ = governed_inputs
    by_code = {item["feature_code"]: item for item in config["feature_semantics"]}
    due_features = [
        (records[code], semantic)
        for code, semantic in by_code.items()
        if any(relation["tag_code"] == "metric.due_amount" for relation in semantic["tags"])
    ]

    assert len(due_features) == 47
    assert all("应还本金金额" in record["feature_name"] for record, _ in due_features)
    assert not any("sum_rep_prc" in record["feature_column_name"] for record, _ in due_features)


def test_repayment_application_counts_do_not_impersonate_overdue_events(
    governed_inputs,
):
    records, config, _ = governed_inputs
    by_code = {item["feature_code"]: item for item in config["feature_semantics"]}
    application_counts = []
    for code, semantic in by_code.items():
        column = records[code]["feature_column_name"]
        if "rep_apl" in column and "cnt" in column and "amt" not in column:
            application_counts.append(semantic)

    assert len(application_counts) == 23
    for semantic in application_counts:
        primary = [
            relation["tag_code"]
            for relation in semantic["tags"]
            if relation["metric_scope"] == "primary"
        ]
        related = [
            relation["tag_code"]
            for relation in semantic["tags"]
            if relation["metric_scope"] == "related"
        ]
        assert primary == []
        assert related == ["metric.overdue_days"]


def test_day_windows_and_explicit_operators_are_normalized(governed_inputs):
    _, config, _ = governed_inputs
    by_suffix = {
        item["feature_code"].rsplit(".", 1)[-1]: item
        for item in config["feature_semantics"]
    }

    cases = {
        "d90_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum": {
            "time.recent_3_months",
            "derivation.ratio",
            "derivation.sum",
        },
        "d180_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum": {
            "time.recent_6_months",
            "derivation.ratio",
            "derivation.sum",
        },
        "d360_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum": {
            "time.recent_12_months",
            "derivation.ratio",
            "derivation.sum",
        },
        "d1080_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum": {
            "time.recent_36_months",
            "derivation.ratio",
            "derivation.sum",
        },
    }
    for suffix, expected in cases.items():
        actual = {relation["tag_code"] for relation in by_suffix[suffix]["tags"]}
        assert expected <= actual

    stage_max = by_suffix["cnt_stg_ever_max_overdue_days_30d"]
    stage_max_tags = {relation["tag_code"] for relation in stage_max["tags"]}
    assert "time.recent_1_month" in stage_max_tags
    assert "derivation.max" in stage_max_tags
    assert "derivation.count" not in stage_max_tags

    window_ratio = by_suffix["mdt_lst_30d_60d_stg_ever_avg_overdue_days_rte"]
    ratio_tags = {relation["tag_code"] for relation in window_ratio["tags"]}
    assert {
        "time.recent_1_month",
        "time.recent_2_months",
        "derivation.mean",
        "derivation.ratio",
    } <= ratio_tags


def test_reviewed_window_summaries_are_readable_and_evidence_resolved(
    governed_inputs,
):
    _, config, _ = governed_inputs

    assert all("_" not in item["semantic_summary_zh"] for item in config["feature_semantics"])
    assert all(
        not re.search(r"\b(?:cnt|avg|max|min|sum|rto|rte)\b", item["semantic_summary_zh"], re.I)
        for item in config["feature_semantics"]
    )
    low_items = [
        item for item in config["feature_semantics"] if item["summary_confidence"] == "low"
    ]
    assert low_items == []
    reviewed_stage = [
        item
        for item in config["feature_semantics"]
        if "22order_calculate_stage_order_info" in item["feature_code"]
    ]
    assert len(reviewed_stage) == 17
    assert all(item["summary_source_type"] == "logic_verified" for item in reviewed_stage)
    assert all("分期计划" in item["semantic_summary_zh"] for item in reviewed_stage)


def test_review_remediation_corrects_stage_plan_metrics_and_twelve_plan_window(
    governed_inputs,
):
    _, config, _ = governed_inputs
    by_code = {item["feature_code"]: item for item in config["feature_semantics"]}
    stage_items = [
        item
        for code, item in by_code.items()
        if "22order_calculate_stage_order_info" in code
    ]
    for item in stage_items:
        codes = {relation["tag_code"] for relation in item["tags"]}
        assert "business.loan_order" in codes
        if ".cnt_ever_overdue_days_" in item["feature_code"]:
            assert "metric.overdue_installment_count" in codes
            assert "metric.overdue_event_count" not in codes

    for count in (6, 12, 18, 24):
        sequence = next(
            item
            for code, item in by_code.items()
            if code.endswith(f".{count}thord_con_late_repay_max")
        )
        sequence_codes = {relation["tag_code"] for relation in sequence["tags"]}
        assert f"time.recent_{count}_installments" in sequence_codes
        assert f"time.recent_{count}_orders" not in sequence_codes
        assert "metric.overdue_installment_count" in sequence_codes

    first_installment = by_code[
        "ftr.off.usr.dwa_risk_dz_model_final_12his_rep_will_pressure_jqh_df."
        "min_fst_ddf_mdl_rep_dte_ovd_pls_bjq"
    ]
    first_codes = {relation["tag_code"] for relation in first_installment["tags"]}
    assert "business.loan_order" in first_codes
    assert "metric.overdue_days" not in first_codes


def test_completed_v1_snapshot_and_review_are_reproducibly_archived():
    archived_snapshot = json.loads(
        gzip.decompress(
            base64.b64decode(
                (
                    ROOT
                    / "knowledge"
                    / "config"
                    / "managed_feature_semantics_v1_d2f8786b.json.gz.b64"
                ).read_text(encoding="ascii")
            )
        )
    )
    archive = json.loads(
        (
            ROOT
            / "knowledge"
            / "config"
            / "managed_feature_semantics_review_v1_d2f8786b.json"
        ).read_text(encoding="utf-8")
    )

    snapshot_hash = TOOL._content_hash(archived_snapshot)
    assert snapshot_hash == archive["snapshot_sha256"] == (
        "d2f8786b13eb4aad39c99d689af7fd43e1e0bdc48d904d5f48ca88860d0ed604"
    )
    records = TOOL.load_feature_records(
        ROOT, ROOT / "knowledge" / "config" / "maintenance_scope.json"
    )
    snapshot_audit = TOOL.validate_snapshot(
        archived_snapshot, records, verify_input_hash=False
    )
    review_audit = TOOL.validate_review_log(
        archive, archived_snapshot, records, verify_input_hash=False
    )
    assert snapshot_audit["pilot_candidate_count"] == 250
    assert review_audit["reviewed_feature_count"] == 50
    assert review_audit["requirements_met"] is False
    assert len(archive["items"]) == 50
    assert {item["status"] for item in archive["items"]} == {"completed"}
    decisions = [item["decision"] for item in archive["items"]]
    assert decisions.count("approved") == 17
    assert decisions.count("changes_required") == 33
    assert all(item["reviewer"] and item["reviewed_at"] for item in archive["items"])


def test_completed_v2_snapshot_and_review_are_reproducibly_archived():
    archived_snapshot = json.loads(
        gzip.decompress(
            base64.b64decode(
                (
                    ROOT
                    / "knowledge"
                    / "config"
                    / "managed_feature_semantics_v2_5cbd2bba.json.gz.b64"
                ).read_text(encoding="ascii")
            )
        )
    )
    archive = json.loads(
        (
            ROOT
            / "knowledge"
            / "config"
            / "managed_feature_semantics_review_v2_5cbd2bba.json"
        ).read_text(encoding="utf-8")
    )
    records = TOOL.load_feature_records(
        ROOT, ROOT / "knowledge" / "config" / "maintenance_scope.json"
    )

    assert TOOL._content_hash(archived_snapshot) == archive["snapshot_sha256"] == (
        "5cbd2bba0ebbedb9f0b4bbb43e3b3e195d5cf3b0f36bb9f6160c450d40fb6dd7"
    )
    TOOL.validate_snapshot(archived_snapshot, records, verify_input_hash=False)
    review_audit = TOOL.validate_review_log(
        archive, archived_snapshot, records, verify_input_hash=False
    )
    assert review_audit["reviewed_feature_count"] == 59
    assert review_audit["approved_feature_count"] == 44
    assert review_audit["changes_required_feature_count"] == 15
    assert review_audit["requirements_met"] is False


def test_active_snapshot_has_honest_offline_generation_provenance(governed_inputs):
    _, config, _ = governed_inputs
    provenance = json.loads(
        (
            ROOT
            / "knowledge"
            / "config"
            / "managed_feature_semantics_provenance.json"
        ).read_text(encoding="utf-8")
    )

    assert provenance["active_snapshot_sha256"] == TOOL._content_hash(config)
    assert provenance["generation_method"] == "model_authored_rule_assisted"
    assert provenance["runtime_model_calls"] is False
    assert provenance["offline_batch_contract"]["historical_batch_artifacts_retained"] is False
    assert all((ROOT / reference).exists() for reference in provenance["evidence_refs"])
