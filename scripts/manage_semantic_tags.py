#!/usr/bin/env python3
"""Offline tooling for the managed-feature Chinese semantic tag snapshot.

The commands in this module are deliberately deterministic and never call a
model or a remote service.  ``export-candidates`` prepares bounded batches for
offline labelling; each returned batch result uses the identity fields
``schema_version/pilot_code/input_hash/base_snapshot_sha256/batch`` and supplies
semantic ``items``.
``merge-batches`` canonicalizes those result files, ``create-review-plan``
creates pending-only stratified checks, and ``validate``/``validate-review``/
``audit`` govern the checked-in snapshot and independent review trail.
"""

from __future__ import annotations

import argparse
import copy
import datetime as dt
import hashlib
import json
import math
import os
import re
import sys
import tempfile
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any, Dict, Iterable, List, Mapping, Sequence, Tuple


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_SCOPE = PROJECT_ROOT / "knowledge" / "config" / "maintenance_scope.json"
DEFAULT_CONFIG = PROJECT_ROOT / "knowledge" / "config" / "managed_feature_semantics.json"
DEFAULT_REVIEW_LOG = (
    PROJECT_ROOT / "knowledge" / "config" / "managed_feature_semantics_review.json"
)

DIMENSIONS = {
    "business": "业务维度",
    "metric": "指标主题",
    "time": "时间范围",
    "derivation": "衍生方式",
}
SOURCE_TYPES = {"model_inferred", "manual_confirmed", "logic_verified"}
CONFIDENCE_LEVELS = {"high", "medium", "low"}
METRIC_SCOPES = {"primary", "related"}
REVIEW_STATUSES = {"pending", "completed"}
REVIEW_DECISIONS = {"approved", "changes_required"}
REVIEW_POLICY = {
    "low_confidence_review_rate": 1.0,
    "conflict_review_rate": 1.0,
    "high_confidence_sample_rate": 0.2,
    "high_confidence_stratum": "primary_metric_tag",
    "sampling_method": "proportional_sha256_v1",
}

DIRECT_NAME_RE = re.compile(r"逾期(?:天数|日数|时长)|连续逾期")
THRESHOLD_NAME_RE = re.compile(
    r"逾期(?:还款)?\s*(?:"
    r"(?:[><≥≤]|大于|超过|不少于|不低于|至少|小于|低于|不超过|至多)\s*"
    r"[0-9一二三四五六七八九十百]+\s*(?:天|日)|"
    r"[0-9一二三四五六七八九十百]+\s*(?:天|日)(?:以上|以内|以下)|"
    r"[0-9一二三四五六七八九十百]+\s*(?:到|至|[-~～])\s*"
    r"[0-9一二三四五六七八九十百]+\s*(?:天|日)|M[234]\+)",
    re.IGNORECASE,
)
THRESHOLD_COLUMN_RE = re.compile(
    r"(?:^|_)ovd_(?:[0-9]+d(?:_?[0-9]+d)?|m[234])(?:_|$)", re.IGNORECASE
)
OVERDUE_TOKEN_RE = re.compile(r"(?:^|_)(?:ovd|overdue|dpd|delinq)(?:_|$)", re.IGNORECASE)
DAY_TOKEN_RE = re.compile(r"(?:^|_)(?:day|days|dte|dur)(?:_|$)", re.IGNORECASE)
CHINESE_CHAR_RE = re.compile(r"[\u3400-\u9fff]")


TAG_SEED: Sequence[Mapping[str, Any]] = (
    {"code": "business.delinquency", "dimension": "business", "name_zh": "逾期", "aliases_zh": ["延迟还款", "延滞", "违约"], "aliases_technical": ["ovd", "overdue", "delinq"]},
    {"code": "business.repayment", "dimension": "business", "name_zh": "还款", "aliases_zh": ["偿还", "应还", "实还", "扣款"], "aliases_technical": ["repay", "repayment", "rep"]},
    {"code": "business.loan_order", "dimension": "business", "name_zh": "订单与分期", "aliases_zh": ["借款订单", "分期计划", "账单"], "aliases_technical": ["order", "ord", "stg_pln"]},
    {"code": "business.borrowing", "dimension": "business", "name_zh": "借款与动支", "aliases_zh": ["借款", "动支", "支用", "放款"], "aliases_technical": ["loan", "draw", "lending"]},
    {"code": "business.credit_limit", "dimension": "business", "name_zh": "授信额度", "aliases_zh": ["额度", "可用额度", "授信"], "aliases_technical": ["limit", "lmt", "credit_limit"]},
    {"code": "business.external_credit", "dimension": "business", "name_zh": "外部征信与多头", "aliases_zh": ["外部征信", "多头", "征信查询"], "aliases_technical": ["credit_report", "bureau", "br"]},
    {"code": "metric.overdue_days", "dimension": "metric", "name_zh": "逾期天数", "aliases_zh": ["逾期日数", "逾期时长", "逾期持续天数"], "aliases_technical": ["dpd", "ovd_day", "overdue_days"]},
    {"code": "metric.continuous_overdue_days", "dimension": "metric", "name_zh": "连续逾期天数", "aliases_zh": ["连续逾期日数", "持续逾期天数"], "aliases_technical": ["ctn_ovd_day", "consecutive_overdue_days"]},
    {"code": "metric.overdue_interval_days", "dimension": "metric", "name_zh": "逾期事件间隔天数", "aliases_zh": ["距逾期天数", "逾期间隔", "逾期时间间隔"], "aliases_technical": ["dte_ovd", "overdue_interval"]},
    {"code": "metric.overdue_event_count", "dimension": "metric", "name_zh": "逾期次数", "aliases_zh": ["逾期笔数", "逾期事件数"], "aliases_technical": ["ovd_cnt", "overdue_count"]},
    {"code": "metric.overdue_installment_count", "dimension": "metric", "name_zh": "逾期分期计划数", "aliases_zh": ["逾期期数", "逾期计划数"], "aliases_technical": ["stg_pln_cnt_ovd", "overdue_installment_count"]},
    {"code": "metric.overdue_amount", "dimension": "metric", "name_zh": "逾期金额", "aliases_zh": ["逾期本金", "逾期应还金额", "逾期还款金额"], "aliases_technical": ["ovd_amt", "overdue_amount", "prc_amt_ovd"]},
    {"code": "metric.overdue_month_count", "dimension": "metric", "name_zh": "逾期月份数", "aliases_zh": ["发生逾期的月份数", "逾期月数"], "aliases_technical": ["overdue_month_cnt"]},
    {"code": "metric.overdue_month_ratio", "dimension": "metric", "name_zh": "逾期月份占比", "aliases_zh": ["逾期月数占比", "发生逾期月份比例"], "aliases_technical": ["overdue_month_rto"]},
    {"code": "metric.overdue_month_index", "dimension": "metric", "name_zh": "逾期月份序号", "aliases_zh": ["逾期月份编号", "发生逾期的月份序号"], "aliases_technical": ["overdue_month_no"]},
    {"code": "metric.due_amount", "dimension": "metric", "name_zh": "应还金额", "aliases_zh": ["应还本金", "计划还款金额"], "aliases_technical": ["due_amt", "prc_amt", "scheduled_amount"]},
    {"code": "time.history", "dimension": "time", "name_zh": "历史至今", "aliases_zh": ["历史", "全部历史", "历次"], "aliases_technical": ["his", "history", "all_time"]},
    {"code": "time.recent_1_month", "dimension": "time", "name_zh": "近1个月", "aliases_zh": ["最近1个月", "过去1个月", "近一个月"], "aliases_technical": ["recent_1m", "d30"]},
    {"code": "time.recent_2_months", "dimension": "time", "name_zh": "近2个月", "aliases_zh": ["最近2个月", "过去2个月", "近60天"], "aliases_technical": ["recent_2m", "d60"]},
    {"code": "time.recent_3_months", "dimension": "time", "name_zh": "近3个月", "aliases_zh": ["最近3个月", "过去3个月", "近三个月"], "aliases_technical": ["recent_3m", "d90"]},
    {"code": "time.recent_6_months", "dimension": "time", "name_zh": "近6个月", "aliases_zh": ["最近6个月", "过去半年", "半年内"], "aliases_technical": ["recent_6m", "d180"]},
    {"code": "time.recent_12_months", "dimension": "time", "name_zh": "近12个月", "aliases_zh": ["最近12个月", "过去一年", "近一年"], "aliases_technical": ["recent_12m", "d360"]},
    {"code": "time.recent_24_months", "dimension": "time", "name_zh": "近24个月", "aliases_zh": ["最近24个月", "过去两年", "近两年"], "aliases_technical": ["recent_24m", "d720"]},
    {"code": "time.recent_36_months", "dimension": "time", "name_zh": "近36个月", "aliases_zh": ["最近36个月", "过去三年", "近三年"], "aliases_technical": ["recent_36m", "d1080"]},
    {"code": "time.before_settlement_12_months", "dimension": "time", "name_zh": "结清前12个月", "aliases_zh": ["订单结清前12个月", "结清前一年"], "aliases_technical": ["bjq_12m", "before_settlement_12m"]},
    {"code": "time.days_30_to_60", "dimension": "time", "name_zh": "30至60天区间", "aliases_zh": ["30到60天", "30-60天", "第31至60天"], "aliases_technical": ["30d_60d", "days_30_to_60"]},
    {"code": "time.days_30_to_90", "dimension": "time", "name_zh": "30至90天区间", "aliases_zh": ["30到90天", "30-90天", "第31至90天"], "aliases_technical": ["30d_90d", "days_30_to_90"]},
    {"code": "time.recent_6_orders", "dimension": "time", "name_zh": "近6笔订单", "aliases_zh": ["最近6笔订单", "近六笔订单"], "aliases_technical": ["6thord"]},
    {"code": "time.recent_6_installments", "dimension": "time", "name_zh": "近6期分期", "aliases_zh": ["最近6期", "近六期", "近6条分期计划"], "aliases_technical": ["recent_6_installments", "recent_6_stage_plans"]},
    {"code": "time.recent_12_orders", "dimension": "time", "name_zh": "近12笔订单", "aliases_zh": ["最近12笔订单", "近十二笔订单"], "aliases_technical": ["12thord"]},
    {"code": "time.recent_12_installments", "dimension": "time", "name_zh": "近12期分期", "aliases_zh": ["最近12期", "近十二期", "近12条分期计划"], "aliases_technical": ["recent_12_installments", "recent_12_stage_plans"]},
    {"code": "time.recent_18_orders", "dimension": "time", "name_zh": "近18笔订单", "aliases_zh": ["最近18笔订单", "近十八笔订单"], "aliases_technical": ["18thord"]},
    {"code": "time.recent_18_installments", "dimension": "time", "name_zh": "近18期分期", "aliases_zh": ["最近18期", "近十八期", "近18条分期计划"], "aliases_technical": ["recent_18_installments", "recent_18_stage_plans"]},
    {"code": "time.recent_24_orders", "dimension": "time", "name_zh": "近24笔订单", "aliases_zh": ["最近24笔订单", "近二十四笔订单"], "aliases_technical": ["24thord"]},
    {"code": "time.recent_24_installments", "dimension": "time", "name_zh": "近24期分期", "aliases_zh": ["最近24期", "近二十四期", "近24条分期计划"], "aliases_technical": ["recent_24_installments", "recent_24_stage_plans"]},
    {"code": "derivation.count", "dimension": "derivation", "name_zh": "计数", "aliases_zh": ["次数", "数量", "笔数"], "aliases_technical": ["count", "cnt"]},
    {"code": "derivation.sum", "dimension": "derivation", "name_zh": "求和", "aliases_zh": ["总和", "合计", "累计"], "aliases_technical": ["sum", "total"]},
    {"code": "derivation.mean", "dimension": "derivation", "name_zh": "均值", "aliases_zh": ["平均", "平均值", "单次平均"], "aliases_technical": ["avg", "mean"]},
    {"code": "derivation.max", "dimension": "derivation", "name_zh": "最大值", "aliases_zh": ["最大", "最高", "最多", "最长"], "aliases_technical": ["max", "maximum"]},
    {"code": "derivation.min", "dimension": "derivation", "name_zh": "最小值", "aliases_zh": ["最小", "最低", "最少", "最短"], "aliases_technical": ["min", "minimum"]},
    {"code": "derivation.ratio", "dimension": "derivation", "name_zh": "比值", "aliases_zh": ["比例", "占比", "比率"], "aliases_technical": ["ratio", "rto", "divide"]},
    {"code": "derivation.latest", "dimension": "derivation", "name_zh": "最近一次", "aliases_zh": ["最近", "最新", "末次", "最后一次"], "aliases_technical": ["latest", "recent_event"]},
    {"code": "derivation.continuous", "dimension": "derivation", "name_zh": "连续统计", "aliases_zh": ["连续", "持续", "连续次数"], "aliases_technical": ["continuous", "consecutive", "ctn", "con"]},
)


class SemanticConfigError(ValueError):
    """Raised when the governed semantic snapshot is inconsistent."""


class MergeConflictError(SemanticConfigError):
    """Raised with a persistable report when batch outputs disagree."""

    def __init__(self, message: str, report: Mapping[str, Any]):
        super().__init__(message)
        self.report = dict(report)


def _read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise SemanticConfigError(f"cannot read JSON {path}: {exc}") from exc


def _write_json(path: Path, payload: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    serialized = json.dumps(payload, ensure_ascii=False, indent=2) + "\n"
    temporary: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "w",
            encoding="utf-8",
            dir=path.parent,
            prefix=f".{path.name}.",
            suffix=".tmp",
            delete=False,
        ) as handle:
            handle.write(serialized)
            handle.flush()
            os.fsync(handle.fileno())
            temporary = Path(handle.name)
        os.replace(temporary, path)
        temporary = None
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


def _assert_safe_json_target(path: Path, payload: Any, artifact: str) -> bool:
    """Return whether a write is needed; never replace different governed history."""
    if not path.exists():
        return True
    existing = _read_json(path)
    if existing == payload:
        return False
    raise SemanticConfigError(
        f"refusing to overwrite existing {artifact}: {path}; "
        "use an explicit new output path and archive the old artifact"
    )


def _content_hash(payload: Any) -> str:
    canonical = json.dumps(payload, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
    return hashlib.sha256(canonical.encode("utf-8")).hexdigest()


def _resolve(root: Path, configured: str) -> Path:
    path = Path(configured)
    return path if path.is_absolute() else root / path


def load_feature_records(root: Path, scope_path: Path) -> Dict[str, Dict[str, Any]]:
    scope = _read_json(scope_path)
    if scope.get("schema_version") != 1:
        raise SemanticConfigError("unsupported maintenance scope schema")
    records: Dict[str, Dict[str, Any]] = {}
    for package in scope.get("packages", []):
        source = _resolve(root, str(package.get("feature_file", "")))
        rows = _read_json(source)
        if not isinstance(rows, list):
            raise SemanticConfigError(f"feature package must be an array: {source}")
        expected = package.get("expected_feature_count")
        if expected is not None and len(rows) != expected:
            raise SemanticConfigError(f"unexpected feature count for {package.get('name', source.name)}")
        for raw in rows:
            code = str(raw.get("featureCode", "")).strip()
            if not code:
                raise SemanticConfigError(f"empty featureCode in {source}")
            item = {
                "feature_code": code,
                "feature_name": str(raw.get("featureName", "")).strip(),
                "feature_column_name": str(raw.get("featureColumnName", "")).strip(),
                "group_code": str(raw.get("groupCode", "")).strip(),
                "group_name": str(raw.get("groupName", "")).strip(),
                "source_path": source.relative_to(root).as_posix(),
            }
            previous = records.get(code)
            if previous and any(previous[key] != item[key] for key in ("feature_name", "feature_column_name", "group_code")):
                raise SemanticConfigError(f"conflicting feature metadata for {code}")
            records.setdefault(code, item)
    return records


def feature_input_hash(records: Mapping[str, Mapping[str, Any]]) -> str:
    selected = [
        {key: records[code][key] for key in ("feature_code", "feature_name", "feature_column_name", "group_code")}
        for code in sorted(records)
    ]
    value = json.dumps(selected, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def candidate_reasons(record: Mapping[str, Any]) -> List[str]:
    name = str(record.get("feature_name", ""))
    column = str(record.get("feature_column_name", ""))
    reasons: List[str] = []
    if DIRECT_NAME_RE.search(name):
        reasons.append("direct_chinese_phrase")
    if THRESHOLD_NAME_RE.search(name) or THRESHOLD_COLUMN_RE.search(column):
        reasons.append("overdue_day_threshold")
    if OVERDUE_TOKEN_RE.search(column) and DAY_TOKEN_RE.search(column):
        reasons.append("technical_overdue_day_pair")
    return reasons


def broad_candidates(records: Mapping[str, Mapping[str, Any]]) -> List[Dict[str, Any]]:
    candidates = []
    for code in sorted(records):
        reasons = candidate_reasons(records[code])
        if reasons:
            candidates.append({**records[code], "candidate_reasons": reasons})
    return candidates


def select_pilot(candidates: Sequence[Mapping[str, Any]], target_count: int = 250) -> List[Dict[str, Any]]:
    """Keep all direct/technical hits, then deterministically stratify thresholds."""
    if target_count < 200 or target_count > 300:
        raise SemanticConfigError("pilot target_count must be between 200 and 300")
    forced = [
        dict(item)
        for item in candidates
        if {"direct_chinese_phrase", "technical_overdue_day_pair"}.intersection(item["candidate_reasons"])
    ]
    forced_codes = {item["feature_code"] for item in forced}
    remaining_by_group: Dict[str, List[Dict[str, Any]]] = defaultdict(list)
    for item in candidates:
        if item["feature_code"] in forced_codes:
            continue
        remaining_by_group[str(item["group_code"])].append(dict(item))
    for items in remaining_by_group.values():
        items.sort(key=lambda item: hashlib.sha256(str(item["feature_code"]).encode("utf-8")).hexdigest())
    chosen = sorted(forced, key=lambda item: str(item["feature_code"]))
    groups = sorted(remaining_by_group)
    while len(chosen) < target_count and groups:
        next_groups = []
        for group in groups:
            items = remaining_by_group[group]
            if items and len(chosen) < target_count:
                chosen.append(items.pop(0))
            if items:
                next_groups.append(group)
        groups = next_groups
    if len(chosen) < target_count:
        raise SemanticConfigError(f"only {len(chosen)} eligible candidates for target {target_count}")
    return sorted(chosen, key=lambda item: str(item["feature_code"]))


def _column_has(column: str, expression: str) -> bool:
    """Match a complete underscore-delimited field-name token."""
    return re.search(rf"(?:^|_)(?:{expression})(?:_|$)", column, re.IGNORECASE) is not None


def _metric_tags_for(record: Mapping[str, Any]) -> List[Tuple[str, str, str, str]]:
    """Classify the feature's final output before its overdue-day condition.

    The pilot contains several families whose *filter* is an overdue-day bucket
    but whose output is a repayment application count or deduction count.  Such
    outputs deliberately receive no fabricated primary metric tag; overdue days
    remains a related navigation signal.
    """
    name = str(record["feature_name"])
    column = str(record["feature_column_name"]).lower()
    group = str(record["group_code"]).lower()
    evidence = "feature_name+feature_column_name"
    stage_plan_threshold_count = (
        "order_calculate_stage_order_info" in group
        and column.startswith("cnt_ever_overdue_days_")
    )
    recent_installment_continuous_count = (
        "his_rep_trend_time_series" in group
        and re.fullmatch(r"(?:6|12|18|24)thord_con_late_repay_max", column)
        is not None
    )
    repayment_application_count = (
        "rep_apl" in column
        and ("次数" in name or _column_has(column, r"cnt|count"))
        and not _column_has(column, r"amt")
    )

    primary = ""
    if re.search(r"连续逾期(?:天数|日数)|ctn_ovd_day", f"{name} {column}", re.IGNORECASE):
        primary = "metric.continuous_overdue_days"
    elif re.search(r"月份(?:数|月数).*占比|month_rto", f"{name} {column}", re.IGNORECASE):
        primary = "metric.overdue_month_ratio"
    elif re.search(r"月份(?:编号|序号)|month_no", f"{name} {column}", re.IGNORECASE):
        primary = "metric.overdue_month_index"
    elif re.search(r"逾期.*月份数|month_cnt", f"{name} {column}", re.IGNORECASE):
        primary = "metric.overdue_month_count"
    elif repayment_application_count:
        primary = ""
    elif stage_plan_threshold_count or recent_installment_continuous_count:
        primary = "metric.overdue_installment_count"
    elif re.search(r"分期计划数|逾期期数", name) or re.search(
        r"(?:^|_)stg_pln_(?:fst_)?cnt_ovd(?:_|$)", column
    ):
        primary = "metric.overdue_installment_count"
    elif re.search(r"距.*(?:逾期|结清).*天|逾期.*间隔|mdl_rep_dte_ovd", f"{name} {column}", re.IGNORECASE):
        primary = "metric.overdue_interval_days"
    elif re.search(r"逾期(?:天数|日数|时长)|(?:avg|max|min)_overdue_days|rep_tim_dte_ovd", f"{name} {column}", re.IGNORECASE):
        primary = "metric.overdue_days"
    elif re.search(r"金额|本金", name) or re.search(
        r"(?:^|_)(?:amt|prc_amt|rep_prc)(?:_|$)", column
    ):
        primary = "metric.overdue_amount"
    elif re.search(r"曾逾期.*次数|连续逾期还款.*次数", name):
        primary = "metric.overdue_event_count"

    tags: List[Tuple[str, str, str, str]] = []
    if primary:
        tags.append((primary, "primary", "high", evidence))
    suppress_generic_overdue_days = (
        column == "min_fst_ddf_mdl_rep_dte_ovd_pls_bjq"
    )
    if primary != "metric.overdue_days" and not suppress_generic_overdue_days:
        tags.append(("metric.overdue_days", "related", "high", evidence))
    # Generic ``prc_amt`` and the phrase ``应还日`` are insufficient: due_amount
    # is present only when the final output itself is explicitly an amount due.
    if primary == "metric.overdue_amount" and "应还本金金额" in name:
        tags.append(("metric.due_amount", "related", "high", "feature_name"))
    return tags


def _time_tags_for(record: Mapping[str, Any]) -> List[Tuple[str, str, str, str]]:
    name = str(record["feature_name"])
    column = str(record["feature_column_name"]).lower()
    group = str(record["group_code"]).lower()
    combined = f"{name} {column}"
    tags: List[Tuple[str, str, str, str]] = []

    if re.search(r"结清前\s*12\s*个月|bjq_12m", combined, re.IGNORECASE):
        return [("time.before_settlement_12_months", "", "high", "feature_name+feature_column_name")]

    # The calculate-stage suffixes describe explicit event-age ranges.  They
    # are not interchangeable with ``d30``/``d90`` lookback prefixes.
    if column.startswith("cnt_"):
        if column.endswith("_30d_60d"):
            tags.append(("time.days_30_to_60", "", "low", "feature_column_name"))
        elif column.endswith("_30d_90d"):
            tags.append(("time.days_30_to_90", "", "low", "feature_column_name"))
        elif column.endswith("_30d"):
            tags.append(("time.recent_1_month", "", "high", "feature_column_name"))
    elif column.startswith("mdt_lst_30d_60d_"):
        tags.extend(
            [
                ("time.recent_1_month", "", "low", "feature_column_name"),
                ("time.recent_2_months", "", "low", "feature_column_name"),
            ]
        )

    installment_sequence_match = (
        re.fullmatch(r"(6|12|18|24)thord_con_late_repay_max", column)
        if "his_rep_trend_time_series" in group
        else None
    )
    recent_installment_sequence = (
        "his_rep_trend_time_series" in group
        and installment_sequence_match is not None
    )
    if recent_installment_sequence:
        installment_count = installment_sequence_match.group(1)
        tags.append(
            (
                f"time.recent_{installment_count}_installments",
                "",
                "high",
                "feature_name+feature_column_name",
            )
        )

    order_windows = (
        (6, "time.recent_6_orders"),
        (12, "time.recent_12_orders"),
        (18, "time.recent_18_orders"),
        (24, "time.recent_24_orders"),
    )
    for count, tag_code in order_windows:
        if not recent_installment_sequence and re.search(
            rf"近\s*{count}\s*笔订单|(?:^|_){count}thord(?:_|$)",
            combined,
            re.IGNORECASE,
        ):
            tags.append((tag_code, "", "high", "feature_name+feature_column_name"))

    month_windows = (
        (1, "time.recent_1_month", "d30"),
        (2, "time.recent_2_months", "d60"),
        (3, "time.recent_3_months", "d90"),
        (6, "time.recent_6_months", "d180"),
        (12, "time.recent_12_months", "d360"),
        (24, "time.recent_24_months", "d720"),
        (36, "time.recent_36_months", "d1080"),
    )
    prefix_windows = set(re.findall(r"(?:^|_)(d(?:30|60|90|180|360|720|1080))(?:_|$)", column))
    ambiguous_multi_window = len(prefix_windows) > 1
    for months, tag_code, day_token in month_windows:
        technical_patterns = [
            rf"^m{months}_",
            rf"(?:^|_)(?:recent_{months}m|rep_{months}m)(?:_|$)",
            rf"(?:^|_){re.escape(day_token)}(?:_|$)",
        ]
        chinese_patterns = (
            rf"近\s*{months}\s*个月",
            rf"近\s*{months * 30}\s*天",
        )
        if any(re.search(pattern, column, re.IGNORECASE) for pattern in technical_patterns) or any(
            re.search(pattern, name) for pattern in chinese_patterns
        ):
            tags.append(
                (
                    tag_code,
                    "",
                    "low" if ambiguous_multi_window else "high",
                    "feature_name+feature_column_name",
                )
            )

    if not tags and re.search(r"历史|(?:^|_)his(?:_|$)", combined, re.IGNORECASE):
        tags.append(("time.history", "", "high", "feature_name+feature_column_name"))
    return tags


def _derivation_tags_for(record: Mapping[str, Any]) -> List[Tuple[str, str, str, str]]:
    name = str(record["feature_name"])
    column = str(record["feature_column_name"]).lower()
    combined = f"{name} {column}"
    tags: List[Tuple[str, str, str, str]] = []
    patterns = (
        (r"占比|比例|比值|(?:^|_)(?:rto|ratio|rat|rte|divide)(?:_|$)", "derivation.ratio"),
        (r"均值|平均|(?:^|_)(?:avg|mean)(?:_|$)", "derivation.mean"),
        (r"总和|合计|(?:^|_)(?:sum|total)(?:_|$)", "derivation.sum"),
        (r"最大|最长|(?:^|_)max(?:_|$)", "derivation.max"),
        (r"最小|最短|(?:^|_)min(?:_|$)", "derivation.min"),
    )
    for pattern, tag_code in patterns:
        if re.search(pattern, name, re.IGNORECASE) or re.search(pattern, column, re.IGNORECASE):
            tags.append((tag_code, "", "high", "feature_name+feature_column_name"))

    explicit_value_aggregate = any(tag[0] in {"derivation.mean", "derivation.max", "derivation.min"} for tag in tags)
    count_pattern = r"次数|笔数|分期计划数|月份数|(?:^|_)(?:cnt|count)(?:_|$)"
    count_signal = re.search(count_pattern, name, re.IGNORECASE) or re.search(
        count_pattern, column, re.IGNORECASE
    )
    # In the calculate-stage family ``cnt_`` is a table-family prefix, not an
    # output operator.  Explicit avg/max/min output therefore wins.
    if count_signal and not (column.startswith("cnt_") and explicit_value_aggregate):
        tags.append(("derivation.count", "", "high", "feature_name+feature_column_name"))
    if re.search(r"最近一次|最后一次|末次", name):
        tags.append(("derivation.latest", "", "high", "feature_name"))
    continuous_pattern = r"连续|(?:^|_)(?:ctn|con|continuous|consecutive)(?:_|$)"
    if re.search(continuous_pattern, name, re.IGNORECASE) or re.search(
        continuous_pattern, column, re.IGNORECASE
    ):
        tags.append(("derivation.continuous", "", "high", "feature_name+feature_column_name"))
    return tags


def _tag_codes_for(record: Mapping[str, Any]) -> List[Tuple[str, str, str, str]]:
    """Return normalized tag relationships after final-output-first analysis."""
    name = str(record["feature_name"])
    column = str(record["feature_column_name"]).lower()
    group = str(record["group_code"]).lower()
    explicit_repayment = re.search(r"还款|应还|实还|扣款|还款本金", name) or _column_has(
        column, r"rep|repay|repayment|rep_prc|rep_apl"
    )
    tags: List[Tuple[str, str, str, str]] = [
        ("business.delinquency", "", "high", "feature_name+feature_column_name"),
        (
            "business.repayment",
            "",
            "high" if explicit_repayment else "medium",
            "feature_name+feature_column_name",
        ),
    ]
    if (
        re.search(r"订单|分期|账单", name)
        or _column_has(column, r"ord|stg_pln")
        or "order_calculate_stage_order_info" in group
        or (
            "rep_will_pressure_jqh" in group
            and column == "min_fst_ddf_mdl_rep_dte_ovd_pls_bjq"
        )
    ):
        tags.append(("business.loan_order", "", "high", "feature_name+feature_column_name"))
    if re.search(r"借款|动支|放款", name) or _column_has(column, r"draw|loan|lending"):
        tags.append(("business.borrowing", "", "high", "feature_name+feature_column_name"))
    if re.search(r"额度|授信", name) or _column_has(column, r"limit|lmt"):
        tags.append(("business.credit_limit", "", "high", "feature_name+feature_column_name"))
    if re.search(r"征信|多头|百融", name) or _column_has(column, r"bureau|credit_report|br"):
        tags.append(("business.external_credit", "", "high", "feature_name+feature_column_name"))

    tags.extend(_metric_tags_for(record))
    tags.extend(_time_tags_for(record))
    tags.extend(_derivation_tags_for(record))
    deduplicated: List[Tuple[str, str, str, str]] = []
    seen = set()
    for item in tags:
        if item[0] not in seen:
            deduplicated.append(item)
            seen.add(item[0])
    return deduplicated


def _semantic_summary_for(record: Mapping[str, Any]) -> Tuple[str, str]:
    """Return a readable Chinese navigation summary and its confidence."""
    name = str(record["feature_name"]).strip()
    column = str(record["feature_column_name"]).lower()
    group = str(record["group_code"]).lower()
    stage_plan_group = "order_calculate_stage_order_info" in group
    window_tokens = sorted(
        set(re.findall(r"(?:d(?:30|60|90|180|360|720|1080)|(?:30|60|90|180|360|720|1080)d)", column))
    )
    threshold_match = re.search(r"曾逾期大于(\d+)天的次数", name)
    aggregate_match = re.search(r"曾逾期(平均|最大)逾期天数", name)
    if stage_plan_group:
        window = (
            "距评分日30–60天"
            if column.endswith("_30d_60d")
            else "距评分日30–90天"
            if column.endswith("_30d_90d")
            else "距评分日1–30天"
        )
        if column == "mdt_lst_30d_60d_stg_ever_avg_overdue_days_rte":
            return "近30天逾期分期计划平均逾期天数与近60天对应均值的比率。", "high"
        if column == "mdt_lst_30d_60d_stg_ever_max_overdue_days_rte":
            return "近30天逾期分期计划最大逾期天数与近60天对应最大值的比率。", "high"
        if threshold_match:
            return (
                f"{window}的应还分期计划中，逾期超过{threshold_match.group(1)}天的分期计划数。",
                "high",
            )
        if aggregate_match:
            operator = "平均" if aggregate_match.group(1) == "平均" else "最大"
            return f"{window}的逾期分期计划{operator}逾期天数。", "high"
    installment_sequence_match = re.fullmatch(
        r"(6|12|18|24)thord_con_late_repay_max", column
    )
    if "his_rep_trend_time_series" in group and installment_sequence_match:
        count = installment_sequence_match.group(1)
        return f"近{count}条分期计划明细中，连续逾期还款段的最大分期计划数。", "high"
    if threshold_match:
        metric = f"曾逾期超过{threshold_match.group(1)}天的次数"
        if len(window_tokens) == 1 and window_tokens[0] in {"30d", "d30"}:
            return f"近30天{metric}。", "high"
        return f"{metric}，字段包含{'/'.join(window_tokens)}窗口标记；具体窗口组合关系待逻辑核验。", "low"
    if aggregate_match:
        operator = "平均" if aggregate_match.group(1) == "平均" else "最大"
        if len(window_tokens) == 1 and window_tokens[0] in {"30d", "d30"}:
            return f"近30天曾逾期记录的{operator}逾期天数。", "high"
        return f"曾逾期记录的{operator}逾期天数，字段包含{'/'.join(window_tokens)}窗口标记；具体窗口组合关系待逻辑核验。", "low"
    if column == "mdt_lst_30d_60d_stg_ever_avg_overdue_days_rte":
        return "最近30天与60天窗口的平均逾期天数比率；具体分子、分母及窗口关系待逻辑核验。", "low"
    if column == "mdt_lst_30d_60d_stg_ever_max_overdue_days_rte":
        return "最近30天与60天窗口的最大逾期天数比率；具体分子、分母及窗口关系待逻辑核验。", "low"

    summary = name
    summary = re.sub(r"_v2$", "（v2口径）", summary, flags=re.IGNORECASE)
    summary = re.sub(r"_(avg|mean)$", "，均值", summary, flags=re.IGNORECASE)
    summary = re.sub(r"_max$", "，最大值", summary, flags=re.IGNORECASE)
    summary = re.sub(r"_min$", "，最小值", summary, flags=re.IGNORECASE)
    summary = re.sub(r"_sum$", "，求和", summary, flags=re.IGNORECASE)
    summary = re.sub(r"_+", "，", summary).strip("，。 ")
    return f"{summary}。", "high"


def build_snapshot(root: Path = PROJECT_ROOT, scope_path: Path = DEFAULT_SCOPE, target_count: int = 250) -> Dict[str, Any]:
    """Build the deterministic first-pass snapshot for offline review.

    This helper intentionally is not exposed as a CLI command.  Checked-in
    snapshot changes must be reviewed and versioned rather than regenerated at
    runtime.
    """
    records = load_feature_records(root, scope_path)
    candidates = select_pilot(broad_candidates(records), target_count)
    feature_semantics = []
    for item in candidates:
        summary, summary_confidence = _semantic_summary_for(item)
        relations = [
            {
                "tag_code": tag_code,
                "metric_scope": metric_scope,
                "source_type": "model_inferred",
                "confidence": confidence,
                "evidence_ref": evidence_ref,
            }
            for tag_code, metric_scope, confidence, evidence_ref in _tag_codes_for(item)
        ]
        feature_semantics.append(
            {
                "feature_code": item["feature_code"],
                "semantic_summary_zh": summary,
                "summary_source_type": "model_inferred",
                "summary_confidence": summary_confidence,
                "summary_evidence_ref": "feature_name+feature_column_name",
                "tags": relations,
            }
        )
    return {
        "schema_version": 1,
        "generation": {
            "model": "codex-gpt-5.6-systematic-review",
            "prompt_version": "overdue-semantics-v2-systematic-remediation",
            "generated_at": "2026-07-20T16:00:00+08:00",
            "input_hash": feature_input_hash(records),
        },
        "dimensions": [{"code": code, "name_zh": DIMENSIONS[code]} for code in DIMENSIONS],
        "tags": [dict(item) for item in TAG_SEED],
        "pilot": {
            "code": "overdue-days-v1",
            "candidate_feature_codes": [item["feature_code"] for item in candidates],
        },
        "feature_semantics": feature_semantics,
    }


def _require_string(value: Any, field: str) -> str:
    if not isinstance(value, str) or not value.strip():
        raise SemanticConfigError(f"{field} must be a non-empty string")
    return value.strip()


def _require_iso_datetime(value: Any, field: str, *, reject_future: bool = True) -> str:
    text = _require_string(value, field)
    try:
        parsed = dt.datetime.fromisoformat(text.replace("Z", "+00:00"))
    except ValueError as exc:
        raise SemanticConfigError(f"{field} must be an ISO-8601 datetime") from exc
    if parsed.utcoffset() is None:
        raise SemanticConfigError(f"{field} must include a timezone offset")
    if reject_future:
        now = dt.datetime.now(dt.timezone.utc)
        if parsed.astimezone(dt.timezone.utc) > now + dt.timedelta(minutes=5):
            raise SemanticConfigError(f"{field} cannot be in the future")
    return text


def _require_chinese(value: Any, field: str) -> str:
    text = _require_string(value, field)
    if not CHINESE_CHAR_RE.search(text):
        raise SemanticConfigError(f"{field} must contain Chinese text")
    return text


def validate_snapshot(
    config: Mapping[str, Any],
    records: Mapping[str, Mapping[str, Any]],
    *,
    verify_input_hash: bool = True,
) -> Dict[str, Any]:
    if config.get("schema_version") != 1:
        raise SemanticConfigError("unsupported semantic config schema")
    generation = config.get("generation")
    if not isinstance(generation, Mapping):
        raise SemanticConfigError("generation must be an object")
    for field in ("model", "prompt_version", "generated_at", "input_hash"):
        _require_string(generation.get(field), f"generation.{field}")
    _require_iso_datetime(generation.get("generated_at"), "generation.generated_at")
    actual_hash = feature_input_hash(records)
    if verify_input_hash and generation.get("input_hash") != actual_hash:
        raise SemanticConfigError("generation.input_hash does not match current managed features")

    dimensions = config.get("dimensions")
    if not isinstance(dimensions, list):
        raise SemanticConfigError("dimensions must be an array")
    dimension_codes = []
    for index, item in enumerate(dimensions):
        if not isinstance(item, Mapping):
            raise SemanticConfigError(f"dimensions[{index}] must be an object")
        dimension_codes.append(_require_string(item.get("code"), f"dimensions[{index}].code"))
        _require_chinese(item.get("name_zh"), f"dimensions[{index}].name_zh")
    if set(dimension_codes) != set(DIMENSIONS) or len(dimension_codes) != len(DIMENSIONS):
        raise SemanticConfigError("dimensions must contain business/metric/time/derivation exactly once")

    tags = config.get("tags")
    if not isinstance(tags, list):
        raise SemanticConfigError("tags must be an array")
    tag_by_code: Dict[str, Mapping[str, Any]] = {}
    aliases_by_dimension: Dict[Tuple[str, str], str] = {}
    for index, item in enumerate(tags):
        if not isinstance(item, Mapping):
            raise SemanticConfigError(f"tags[{index}] must be an object")
        code = _require_string(item.get("code"), f"tags[{index}].code")
        dimension = _require_string(item.get("dimension"), f"tags[{index}].dimension")
        name = _require_chinese(item.get("name_zh"), f"tags[{index}].name_zh")
        if code in tag_by_code:
            raise SemanticConfigError(f"duplicate tag code: {code}")
        if dimension not in DIMENSIONS:
            raise SemanticConfigError(f"invalid dimension for tag {code}: {dimension}")
        if not re.fullmatch(r"[a-z][a-z0-9_]*(?:\.[a-z][a-z0-9_]*)*", code):
            raise SemanticConfigError(f"invalid semantic tag code: {code}")
        if not code.startswith(dimension + "."):
            raise SemanticConfigError(f"tag code must be namespaced by dimension: {code}")
        for field in ("aliases_zh", "aliases_technical"):
            values = item.get(field)
            if not isinstance(values, list) or any(not isinstance(value, str) or not value.strip() for value in values):
                raise SemanticConfigError(f"{code}.{field} must be an array of non-empty strings")
            if len({value.strip().casefold() for value in values}) != len(values):
                raise SemanticConfigError(f"duplicate alias in {code}.{field}")
        for alias_index, alias in enumerate(item["aliases_zh"]):
            _require_chinese(alias, f"{code}.aliases_zh[{alias_index}]")
        for alias in [name, *item["aliases_zh"], *item["aliases_technical"]]:
            key = (dimension, alias.strip().casefold())
            owner = aliases_by_dimension.get(key)
            if owner and owner != code:
                raise SemanticConfigError(f"alias conflict in {dimension}: {alias!r} maps to {owner} and {code}")
            aliases_by_dimension[key] = code
        tag_by_code[code] = item

    pilot = config.get("pilot")
    if not isinstance(pilot, Mapping):
        raise SemanticConfigError("pilot must be an object")
    _require_string(pilot.get("code"), "pilot.code")
    candidate_codes = pilot.get("candidate_feature_codes")
    if not isinstance(candidate_codes, list) or any(not isinstance(code, str) or not code for code in candidate_codes):
        raise SemanticConfigError("pilot.candidate_feature_codes must be an array of strings")
    if not 200 <= len(candidate_codes) <= 300:
        raise SemanticConfigError("pilot must contain between 200 and 300 candidates")
    if len(set(candidate_codes)) != len(candidate_codes):
        raise SemanticConfigError("pilot contains duplicate feature codes")
    unknown_candidates = sorted(set(candidate_codes) - set(records))
    if unknown_candidates:
        raise SemanticConfigError(f"pilot contains unknown feature: {unknown_candidates[0]}")
    # A checked-in snapshot is immutable once it has been independently
    # reviewed.  It must remain eligible for the pilot topic, but a later
    # deterministic re-sampling of the wider candidate pool must not make the
    # historical snapshot invalid.  Exact selection is enforced when a new
    # snapshot is created; this validation only checks snapshot integrity.
    broad_codes = {item["feature_code"] for item in broad_candidates(records)}
    ineligible_candidates = sorted(set(candidate_codes) - broad_codes)
    if ineligible_candidates:
        raise SemanticConfigError(
            f"pilot contains feature outside the overdue-day candidate scope: {ineligible_candidates[0]}"
        )

    semantics = config.get("feature_semantics")
    if not isinstance(semantics, list):
        raise SemanticConfigError("feature_semantics must be an array")
    seen_features = set()
    relationship_count = 0
    dimension_coverage: Counter[str] = Counter()
    confidence_counts: Counter[str] = Counter()
    source_counts: Counter[str] = Counter()
    feature_confidence_presence: Counter[str] = Counter()
    for index, item in enumerate(semantics):
        if not isinstance(item, Mapping):
            raise SemanticConfigError(f"feature_semantics[{index}] must be an object")
        code = _require_string(item.get("feature_code"), f"feature_semantics[{index}].feature_code")
        if code not in records:
            raise SemanticConfigError(f"unknown semantic feature: {code}")
        if code in seen_features:
            raise SemanticConfigError(f"duplicate feature semantic: {code}")
        seen_features.add(code)
        _require_string(item.get("semantic_summary_zh"), f"{code}.semantic_summary_zh")
        summary_source = _require_string(item.get("summary_source_type"), f"{code}.summary_source_type")
        summary_confidence = _require_string(item.get("summary_confidence"), f"{code}.summary_confidence")
        _require_string(item.get("summary_evidence_ref"), f"{code}.summary_evidence_ref")
        if summary_source not in SOURCE_TYPES:
            raise SemanticConfigError(f"invalid summary_source_type for {code}")
        if summary_confidence not in CONFIDENCE_LEVELS:
            raise SemanticConfigError(f"invalid summary_confidence for {code}")
        relations = item.get("tags")
        if not isinstance(relations, list) or not relations:
            raise SemanticConfigError(f"{code}.tags must be a non-empty array")
        seen_relations = set()
        feature_confidences = {summary_confidence}
        for relation in relations:
            if not isinstance(relation, Mapping):
                raise SemanticConfigError(f"tag relation for {code} must be an object")
            tag_code = _require_string(relation.get("tag_code"), f"{code}.tag_code")
            if tag_code not in tag_by_code:
                raise SemanticConfigError(f"unknown tag {tag_code} on {code}")
            metric_scope = relation.get("metric_scope")
            if not isinstance(metric_scope, str):
                raise SemanticConfigError(f"metric_scope must be a string on {code}/{tag_code}")
            dimension = str(tag_by_code[tag_code]["dimension"])
            if dimension == "metric" and metric_scope not in METRIC_SCOPES:
                raise SemanticConfigError(f"metric tag requires primary/related scope on {code}/{tag_code}")
            if dimension != "metric" and metric_scope != "":
                raise SemanticConfigError(f"non-metric tag must use empty metric_scope on {code}/{tag_code}")
            if tag_code in seen_relations:
                raise SemanticConfigError(f"duplicate tag relation on {code}: {tag_code}")
            seen_relations.add(tag_code)
            source = _require_string(relation.get("source_type"), f"{code}/{tag_code}.source_type")
            confidence = _require_string(relation.get("confidence"), f"{code}/{tag_code}.confidence")
            _require_string(relation.get("evidence_ref"), f"{code}/{tag_code}.evidence_ref")
            if source not in SOURCE_TYPES:
                raise SemanticConfigError(f"invalid source_type on {code}/{tag_code}")
            if confidence not in CONFIDENCE_LEVELS:
                raise SemanticConfigError(f"invalid confidence on {code}/{tag_code}")
            relationship_count += 1
            dimension_coverage[dimension] += 1
            confidence_counts[confidence] += 1
            source_counts[source] += 1
            feature_confidences.add(confidence)
        for confidence in feature_confidences:
            feature_confidence_presence[confidence] += 1
    if seen_features != set(candidate_codes):
        missing = sorted(set(candidate_codes) - seen_features)
        extra = sorted(seen_features - set(candidate_codes))
        detail = missing[0] if missing else extra[0]
        raise SemanticConfigError(f"feature_semantics must exactly cover pilot candidates; first mismatch: {detail}")
    for dimension in DIMENSIONS:
        if not dimension_coverage[dimension]:
            raise SemanticConfigError(f"pilot has no {dimension} tag relationships")

    return {
        "status": "OK",
        "schema_version": 1,
        "vocabulary_count": len(tags),
        "pilot_candidate_count": len(candidate_codes),
        "tagged_feature_count": len(seen_features),
        "relationship_count": relationship_count,
        "dimension_coverage": dict(sorted(dimension_coverage.items())),
        "confidence_distribution": dict(sorted(confidence_counts.items())),
        "source_type_distribution": dict(sorted(source_counts.items())),
        "review_requirements": {
            "low_confidence_all_feature_count": feature_confidence_presence["low"],
            "high_confidence_sample_rate": 0.2,
            "high_confidence_sample_feature_count": math.ceil(feature_confidence_presence["high"] * 0.2),
            "conflicts_all_count": 0,
        },
        "conflict_count": 0,
    }


def _balanced_batches(
    items: Sequence[Mapping[str, Any]], preferred_size: int
) -> List[List[Dict[str, Any]]]:
    """Split a 200--300 item pilot into deterministic 40--50 item batches."""
    count = len(items)
    valid_batch_counts = [
        batch_count
        for batch_count in range(math.ceil(count / 50), math.floor(count / 40) + 1)
        if batch_count > 0
    ]
    if not valid_batch_counts:
        raise SemanticConfigError(
            f"cannot split {count} candidates into batches containing 40 to 50 items"
        )
    batch_count = min(
        valid_batch_counts,
        key=lambda value: (abs(count / value - preferred_size), value),
    )
    base_size, remainder = divmod(count, batch_count)
    sizes = [base_size + (1 if index < remainder else 0) for index in range(batch_count)]
    batches: List[List[Dict[str, Any]]] = []
    start = 0
    for size in sizes:
        batches.append([dict(item) for item in items[start : start + size]])
        start += size
    return batches


def _validate_candidate_export(
    payload: Mapping[str, Any],
    records: Mapping[str, Mapping[str, Any]],
    base_config: Mapping[str, Any],
) -> List[Tuple[int, List[str]]]:
    if payload.get("schema_version") != 2:
        raise SemanticConfigError("unsupported candidate export schema")
    pilot = base_config.get("pilot")
    generation = base_config.get("generation")
    if not isinstance(pilot, Mapping) or not isinstance(generation, Mapping):
        raise SemanticConfigError("base config must contain pilot and generation objects")
    if payload.get("pilot_code") != pilot.get("code"):
        raise SemanticConfigError("candidate export pilot_code does not match base config")
    if payload.get("input_hash") != generation.get("input_hash"):
        raise SemanticConfigError("candidate export input_hash does not match base config")
    if payload.get("input_hash") != feature_input_hash(records):
        raise SemanticConfigError("candidate export input_hash does not match managed features")
    if payload.get("base_snapshot_sha256") != _content_hash(base_config):
        raise SemanticConfigError(
            "candidate export base_snapshot_sha256 does not match base config"
        )
    batches = payload.get("batches")
    if not isinstance(batches, list) or not batches:
        raise SemanticConfigError("candidate export batches must be a non-empty array")

    expected_batch_number = 1
    batch_members: List[Tuple[int, List[str]]] = []
    flattened: List[str] = []
    for batch in batches:
        if not isinstance(batch, Mapping):
            raise SemanticConfigError("candidate export batch must be an object")
        batch_number = batch.get("batch")
        if batch_number != expected_batch_number:
            raise SemanticConfigError("candidate export batches must be numbered consecutively from 1")
        raw_items = batch.get("items")
        if not isinstance(raw_items, list) or not 40 <= len(raw_items) <= 50:
            raise SemanticConfigError(
                f"candidate export batch {batch_number} must contain 40 to 50 items"
            )
        codes: List[str] = []
        for item in raw_items:
            if not isinstance(item, Mapping):
                raise SemanticConfigError(
                    f"candidate export batch {batch_number} item must be an object"
                )
            code = _require_string(item.get("feature_code"), "candidate feature_code")
            if code not in records:
                raise SemanticConfigError(f"candidate export contains unknown feature: {code}")
            record = records[code]
            for field in ("feature_name", "feature_column_name", "group_code"):
                if item.get(field) != record[field]:
                    raise SemanticConfigError(
                        f"candidate export metadata mismatch for {code}: {field}"
                    )
            reasons = item.get("candidate_reasons")
            if reasons != candidate_reasons(record):
                raise SemanticConfigError(f"candidate reasons mismatch for {code}")
            codes.append(code)
        batch_members.append((batch_number, codes))
        flattened.extend(codes)
        expected_batch_number += 1

    if len(flattened) != len(set(flattened)):
        raise SemanticConfigError("candidate export contains duplicate feature codes")
    configured_codes = pilot.get("candidate_feature_codes")
    if flattened != configured_codes:
        raise SemanticConfigError(
            "candidate export order or coverage does not match base config pilot"
        )
    if payload.get("selected_candidate_count") != len(flattened):
        raise SemanticConfigError("candidate export selected_candidate_count is inconsistent")
    if payload.get("broad_candidate_count") != len(broad_candidates(records)):
        raise SemanticConfigError("candidate export broad_candidate_count is inconsistent")
    actual_sizes = [len(codes) for _, codes in batch_members]
    if payload.get("actual_batch_sizes") != actual_sizes:
        raise SemanticConfigError("candidate export actual_batch_sizes is inconsistent")
    requested_size = payload.get("batch_size")
    if not isinstance(requested_size, int) or not 40 <= requested_size <= 50:
        raise SemanticConfigError("candidate export batch_size must be between 40 and 50")
    expected_partition = _balanced_batches(
        [{"feature_code": code} for code in configured_codes], requested_size
    )
    expected_batch_codes = [
        [str(item["feature_code"]) for item in batch] for batch in expected_partition
    ]
    if [codes for _, codes in batch_members] != expected_batch_codes:
        raise SemanticConfigError("candidate export batches do not match deterministic partition")
    return batch_members


def _conflict_report(
    pilot_code: str,
    input_hash: str,
    base_snapshot_sha256: str,
    conflicts: Sequence[Mapping[str, Any]],
) -> Dict[str, Any]:
    return {
        "schema_version": 2,
        "pilot_code": pilot_code,
        "input_hash": input_hash,
        "base_snapshot_sha256": base_snapshot_sha256,
        "conflicts": sorted(
            [dict(item) for item in conflicts],
            key=lambda item: (str(item.get("feature_code", "")), str(item.get("reason", ""))),
        ),
    }


def merge_batch_results(
    candidate_export: Mapping[str, Any],
    batch_results: Sequence[Tuple[str, Mapping[str, Any]]],
    base_config: Mapping[str, Any],
    records: Mapping[str, Mapping[str, Any]],
    generation_override: Mapping[str, str] | None = None,
) -> Tuple[Dict[str, Any], Dict[str, Any]]:
    """Merge offline model outputs without calling a model or remote service.

    Results are canonicalized by candidate batch and feature code, so input-file
    order and item order cannot change the produced snapshot.
    """
    validate_snapshot(base_config, records)
    batch_members = _validate_candidate_export(candidate_export, records, base_config)
    expected_by_batch = {number: codes for number, codes in batch_members}
    pilot_code = str(candidate_export["pilot_code"])
    input_hash = str(candidate_export["input_hash"])
    base_snapshot_sha256 = str(candidate_export["base_snapshot_sha256"])

    result_by_batch: Dict[int, List[Mapping[str, Any]]] = {}
    result_source_by_batch: Dict[int, str] = {}
    occurrences: Dict[str, List[Tuple[str, int, Mapping[str, Any]]]] = defaultdict(list)
    declared_conflicts: Dict[str, Dict[str, Any]] = {}
    source_hashes: List[Dict[str, str]] = []
    for source_name, payload in batch_results:
        if not isinstance(payload, Mapping) or payload.get("schema_version") != 2:
            raise SemanticConfigError(f"unsupported batch result schema: {source_name}")
        if payload.get("pilot_code") != pilot_code or payload.get("input_hash") != input_hash:
            raise SemanticConfigError(f"batch result identity mismatch: {source_name}")
        if payload.get("base_snapshot_sha256") != base_snapshot_sha256:
            raise SemanticConfigError(
                f"batch result base snapshot mismatch: {source_name}"
            )
        batch_number = payload.get("batch")
        if not isinstance(batch_number, int) or batch_number not in expected_by_batch:
            raise SemanticConfigError(f"unknown batch number in result: {source_name}")
        if batch_number in result_by_batch:
            duplicate_report = _conflict_report(
                pilot_code,
                input_hash,
                base_snapshot_sha256,
                [
                    {
                        "feature_code": code,
                        "reason": "duplicate_batch_result",
                        "sources": sorted(
                            [result_source_by_batch[batch_number], source_name]
                        ),
                        "batches": [batch_number],
                    }
                    for code in expected_by_batch[batch_number]
                ],
            )
            raise MergeConflictError(
                f"duplicate result for exported batch {batch_number}", duplicate_report
            )
        items = payload.get("items")
        if not isinstance(items, list):
            raise SemanticConfigError(f"batch result items must be an array: {source_name}")
        result_by_batch[batch_number] = items
        result_source_by_batch[batch_number] = source_name
        for item in items:
            if not isinstance(item, Mapping):
                raise SemanticConfigError(f"batch result item must be an object: {source_name}")
            code = _require_string(item.get("feature_code"), "batch result feature_code")
            if code not in expected_by_batch[batch_number]:
                raise SemanticConfigError(
                    f"feature {code} is not assigned to exported batch {batch_number}"
                )
            occurrences[code].append((source_name, batch_number, item))
        raw_conflicts = payload.get("conflicts", [])
        if not isinstance(raw_conflicts, list):
            raise SemanticConfigError(f"batch result conflicts must be an array: {source_name}")
        for conflict in raw_conflicts:
            if not isinstance(conflict, Mapping):
                raise SemanticConfigError(
                    f"batch result conflict must be an object: {source_name}"
                )
            code = _require_string(
                conflict.get("feature_code"), "batch conflict feature_code"
            )
            reason = _require_string(conflict.get("reason"), "batch conflict reason")
            if code not in expected_by_batch[batch_number]:
                raise SemanticConfigError(
                    f"conflict feature {code} is not assigned to exported batch {batch_number}"
                )
            if code in declared_conflicts:
                raise SemanticConfigError(f"duplicate declared conflict for feature: {code}")
            declared_conflicts[code] = {
                "feature_code": code,
                "reason": f"declared_label_conflict:{reason}",
                "sources": [source_name],
                "batches": [batch_number],
            }
        source_hashes.append({"source": source_name, "sha256": _content_hash(payload)})

    conflict_by_code: Dict[str, Dict[str, Any]] = dict(declared_conflicts)
    for code, values in occurrences.items():
        if len(values) <= 1:
            continue
        item_hashes = {_content_hash(value[2]) for value in values}
        duplicate_reason = (
            "duplicate_feature_result"
            if len(item_hashes) == 1
            else "conflicting_feature_result"
        )
        existing = conflict_by_code.get(code)
        conflict_by_code[code] = {
            "feature_code": code,
            "reason": (
                f"{existing['reason']};{duplicate_reason}" if existing else duplicate_reason
            ),
            "sources": sorted(
                set(existing["sources"] if existing else [])
                | {value[0] for value in values}
            ),
            "batches": sorted(
                set(existing["batches"] if existing else [])
                | {value[1] for value in values}
            ),
        }
    conflicts = list(conflict_by_code.values())
    conflict_payload = _conflict_report(
        pilot_code, input_hash, base_snapshot_sha256, conflicts
    )
    if conflicts:
        raise MergeConflictError(
            f"batch results contain {len(conflicts)} duplicate or conflicting features",
            conflict_payload,
        )
    if set(result_by_batch) != set(expected_by_batch):
        missing = sorted(set(expected_by_batch) - set(result_by_batch))
        raise SemanticConfigError(f"batch results do not exactly cover exported batches; missing {missing}")

    merged_items: Dict[str, Mapping[str, Any]] = {}
    for batch_number in sorted(expected_by_batch):
        expected_codes = expected_by_batch[batch_number]
        items = result_by_batch[batch_number]
        actual_codes = [str(item.get("feature_code", "")) for item in items]
        if set(actual_codes) != set(expected_codes) or len(actual_codes) != len(expected_codes):
            raise SemanticConfigError(
                f"batch result {batch_number} does not exactly cover its exported feature codes"
            )
        for item in items:
            merged_items[str(item["feature_code"])] = copy.deepcopy(dict(item))

    snapshot = copy.deepcopy(dict(base_config))
    changed_items = any(
        merged_items[code] != original
        for code, original in {
            str(item["feature_code"]): item
            for item in base_config["feature_semantics"]
        }.items()
    )
    if changed_items and not generation_override:
        raise SemanticConfigError(
            "changed batch results require model/prompt_version/generated_at generation override"
        )
    if generation_override:
        override_keys = set(generation_override)
        if override_keys != {"model", "prompt_version", "generated_at"}:
            raise SemanticConfigError("generation override must provide model/prompt_version/generated_at")
        override_generated_at = _require_iso_datetime(
            generation_override["generated_at"], "generation override generated_at"
        )
        base_generated_at = _require_iso_datetime(
            base_config["generation"]["generated_at"],
            "base generation.generated_at",
        )
        override_dt = dt.datetime.fromisoformat(
            override_generated_at.replace("Z", "+00:00")
        )
        base_dt = dt.datetime.fromisoformat(base_generated_at.replace("Z", "+00:00"))
        if override_dt < base_dt:
            raise SemanticConfigError(
                "generation override generated_at cannot precede the base snapshot"
            )
        snapshot["generation"].update(generation_override)
    snapshot["generation"]["input_hash"] = input_hash
    pilot_codes = list(snapshot["pilot"]["candidate_feature_codes"])
    snapshot["feature_semantics"] = [merged_items[code] for code in pilot_codes]
    audit = validate_snapshot(snapshot, records)
    report = {
        "status": "OK",
        "pilot_code": pilot_code,
        "merged_batch_count": len(expected_by_batch),
        "merged_feature_count": len(merged_items),
        "snapshot_sha256": _content_hash(snapshot),
        "batch_result_sources": sorted(source_hashes, key=lambda item: item["source"]),
        "conflict_report": conflict_payload,
        "snapshot_audit": audit,
    }
    return snapshot, report


def _validated_conflicts(
    payload: Mapping[str, Any] | None,
    config: Mapping[str, Any],
) -> List[Dict[str, Any]]:
    if payload is None:
        return []
    if payload.get("schema_version") != 2:
        raise SemanticConfigError("unsupported merge conflict report schema")
    pilot = config["pilot"]
    generation = config["generation"]
    if payload.get("pilot_code") != pilot.get("code"):
        raise SemanticConfigError("conflict report pilot_code does not match semantic snapshot")
    if payload.get("input_hash") != generation.get("input_hash"):
        raise SemanticConfigError("conflict report input_hash does not match semantic snapshot")
    if payload.get("base_snapshot_sha256") != _content_hash(config):
        raise SemanticConfigError(
            "conflict report base_snapshot_sha256 does not match semantic snapshot"
        )
    raw_conflicts = payload.get("conflicts")
    if not isinstance(raw_conflicts, list):
        raise SemanticConfigError("conflict report conflicts must be an array")
    pilot_codes = set(pilot["candidate_feature_codes"])
    seen = set()
    conflicts: List[Dict[str, Any]] = []
    for index, item in enumerate(raw_conflicts):
        if not isinstance(item, Mapping):
            raise SemanticConfigError(f"conflicts[{index}] must be an object")
        code = _require_string(item.get("feature_code"), f"conflicts[{index}].feature_code")
        reason = _require_string(item.get("reason"), f"conflicts[{index}].reason")
        if code not in pilot_codes:
            raise SemanticConfigError(f"conflict feature is outside pilot: {code}")
        if code in seen:
            raise SemanticConfigError(f"duplicate conflict feature: {code}")
        seen.add(code)
        conflicts.append({"feature_code": code, "reason": reason})
    return sorted(conflicts, key=lambda item: item["feature_code"])


def _primary_metric_stratum(semantic: Mapping[str, Any]) -> str:
    primary = sorted(
        str(relation["tag_code"])
        for relation in semantic["tags"]
        if str(relation["tag_code"]).startswith("metric.")
        and relation.get("metric_scope") == "primary"
    )
    return "+".join(primary) if primary else "metric.none"


def _proportional_high_sample(
    semantics: Sequence[Mapping[str, Any]],
    pilot_code: str,
) -> Tuple[List[str], Dict[str, str], int]:
    high_items = [
        item
        for item in semantics
        if item.get("summary_confidence") == "high"
        or any(relation.get("confidence") == "high" for relation in item["tags"])
    ]
    quota = math.ceil(len(high_items) * float(REVIEW_POLICY["high_confidence_sample_rate"]))
    if not high_items or not quota:
        return [], {}, 0
    by_stratum: Dict[str, List[str]] = defaultdict(list)
    strata: Dict[str, str] = {}
    for item in high_items:
        code = str(item["feature_code"])
        stratum = _primary_metric_stratum(item)
        strata[code] = stratum
        by_stratum[stratum].append(code)
    salt = f"{pilot_code}:high-confidence:proportional-sha256-v1"
    for codes in by_stratum.values():
        codes.sort(key=lambda code: (hashlib.sha256(f"{salt}:{code}".encode()).hexdigest(), code))

    total = len(high_items)
    stratum_codes = sorted(by_stratum)
    guarantee_each_stratum = quota >= len(stratum_codes)
    allocations: Dict[str, int] = {
        stratum: (1 if guarantee_each_stratum else 0) for stratum in stratum_codes
    }
    allocated = sum(allocations.values())
    remaining = quota - allocated
    capacities = {
        stratum: len(by_stratum[stratum]) - allocations[stratum]
        for stratum in stratum_codes
    }
    total_capacity = sum(capacities.values())
    remainders: List[Tuple[float, str]] = []
    if remaining and not total_capacity:
        raise SemanticConfigError("cannot allocate deterministic high-confidence review sample")
    for stratum in stratum_codes:
        exact = remaining * capacities[stratum] / total_capacity if total_capacity else 0.0
        base = math.floor(exact)
        allocations[stratum] += base
        allocated += base
        remainders.append((exact - base, stratum))
    for _, stratum in sorted(remainders, key=lambda item: (-item[0], item[1])):
        if allocated >= quota:
            break
        if allocations[stratum] < len(by_stratum[stratum]):
            allocations[stratum] += 1
            allocated += 1
    if allocated != quota:
        raise SemanticConfigError("cannot allocate deterministic high-confidence review sample")
    if guarantee_each_stratum and any(not allocations[stratum] for stratum in stratum_codes):
        raise SemanticConfigError("stratified sample omitted a non-empty primary metric stratum")
    selected = [
        code
        for stratum in sorted(by_stratum)
        for code in by_stratum[stratum][: allocations[stratum]]
    ]
    return sorted(selected), strata, len(high_items)


def build_review_plan(
    config: Mapping[str, Any],
    records: Mapping[str, Mapping[str, Any]],
    conflict_payload: Mapping[str, Any] | None = None,
    *,
    verify_input_hash: bool = True,
) -> Dict[str, Any]:
    """Create a deterministic pending-only review plan for a static snapshot."""
    validate_snapshot(config, records, verify_input_hash=verify_input_hash)
    conflicts = _validated_conflicts(conflict_payload, config)
    semantics = list(config["feature_semantics"])
    low_codes = {
        str(item["feature_code"])
        for item in semantics
        if item.get("summary_confidence") == "low"
        or any(relation.get("confidence") == "low" for relation in item["tags"])
    }
    verified_codes = {
        str(item["feature_code"])
        for item in semantics
        if item.get("summary_source_type") in {"manual_confirmed", "logic_verified"}
        or any(
            relation.get("source_type") in {"manual_confirmed", "logic_verified"}
            for relation in item["tags"]
        )
    }
    high_sample, strata, high_population = _proportional_high_sample(
        semantics, str(config["pilot"]["code"])
    )
    conflict_by_code = {item["feature_code"]: item["reason"] for item in conflicts}
    required_codes = sorted(
        low_codes | verified_codes | set(high_sample) | set(conflict_by_code)
    )
    items = []
    for code in required_codes:
        reasons = []
        if code in low_codes:
            reasons.append("low_confidence_full_review")
        if code in conflict_by_code:
            reasons.append("merge_conflict_full_review")
        if code in high_sample:
            reasons.append("high_confidence_stratified_sample")
        if code in verified_codes:
            reasons.append("verified_evidence_full_review")
        items.append(
            {
                "feature_code": code,
                "review_reasons": reasons,
                "stratum": strata.get(code, "not_applicable"),
                "conflict_reason": conflict_by_code.get(code, ""),
                "status": "pending",
                "reviewer": "",
                "reviewed_at": "",
                "decision": "",
                "review_evidence_ref": "",
                "notes": "",
            }
        )
    policy = dict(REVIEW_POLICY)
    population = {
        "low_confidence_feature_count": len(low_codes),
        "conflict_feature_count": len(conflict_by_code),
        "high_confidence_feature_count": high_population,
        "high_confidence_sample_feature_count": len(high_sample),
    }
    # Old all-model snapshots retain their original deterministic policy shape,
    # so their archived review logs remain independently reproducible.
    if verified_codes:
        policy["verified_evidence_review_rate"] = 1.0
        population["verified_evidence_feature_count"] = len(verified_codes)
    return {
        "schema_version": 1,
        "pilot_code": config["pilot"]["code"],
        "snapshot_sha256": _content_hash(config),
        "policy": policy,
        "population": population,
        "items": items,
    }


def validate_review_log(
    review_log: Mapping[str, Any],
    config: Mapping[str, Any],
    records: Mapping[str, Mapping[str, Any]],
    conflict_payload: Mapping[str, Any] | None = None,
    *,
    verify_input_hash: bool = True,
) -> Dict[str, Any]:
    """Validate plan selection and independently entered review trail separately."""
    expected = build_review_plan(
        config,
        records,
        conflict_payload,
        verify_input_hash=verify_input_hash,
    )
    if review_log.get("schema_version") != 1:
        raise SemanticConfigError("unsupported semantic review log schema")
    for field in ("pilot_code", "snapshot_sha256", "policy", "population"):
        if review_log.get(field) != expected[field]:
            raise SemanticConfigError(f"review log {field} does not match deterministic plan")
    raw_items = review_log.get("items")
    if not isinstance(raw_items, list):
        raise SemanticConfigError("review log items must be an array")
    expected_by_code = {item["feature_code"]: item for item in expected["items"]}
    actual_codes = []
    status_counts: Counter[str] = Counter()
    decision_counts: Counter[str] = Counter()
    for index, item in enumerate(raw_items):
        if not isinstance(item, Mapping):
            raise SemanticConfigError(f"review items[{index}] must be an object")
        code = _require_string(item.get("feature_code"), f"review items[{index}].feature_code")
        if code not in expected_by_code:
            raise SemanticConfigError(f"unexpected review feature: {code}")
        actual_codes.append(code)
        expected_item = expected_by_code[code]
        for field in ("review_reasons", "stratum", "conflict_reason"):
            if item.get(field) != expected_item[field]:
                raise SemanticConfigError(f"review plan metadata mismatch for {code}: {field}")
        status = item.get("status")
        if status not in REVIEW_STATUSES:
            raise SemanticConfigError(f"invalid review status for {code}")
        for field in ("reviewer", "reviewed_at", "decision", "review_evidence_ref", "notes"):
            if not isinstance(item.get(field), str):
                raise SemanticConfigError(f"review {field} must be a string for {code}")
        if status == "pending":
            for field in ("reviewer", "reviewed_at", "decision", "review_evidence_ref"):
                if item[field]:
                    raise SemanticConfigError(
                        f"pending review cannot contain fabricated completion field {field}: {code}"
                    )
        else:
            for field in ("reviewer", "reviewed_at", "decision", "review_evidence_ref"):
                _require_string(item[field], f"{code}.{field}")
            _require_iso_datetime(item["reviewed_at"], f"{code}.reviewed_at")
            if item["decision"] not in REVIEW_DECISIONS:
                raise SemanticConfigError(f"invalid review decision for {code}")
            decision_counts[item["decision"]] += 1
        status_counts[status] += 1
    if len(actual_codes) != len(set(actual_codes)):
        raise SemanticConfigError("review log contains duplicate feature codes")
    if set(actual_codes) != set(expected_by_code):
        raise SemanticConfigError("review log does not exactly cover deterministic review plan")

    required_count = len(expected_by_code)
    approved = decision_counts["approved"]
    requirements_met = approved == required_count
    return {
        "status": "OK",
        "review_log_status": "present",
        "required_review_feature_count": required_count,
        "pending_review_feature_count": status_counts["pending"],
        "reviewed_feature_count": status_counts["completed"],
        "approved_feature_count": approved,
        "changes_required_feature_count": decision_counts["changes_required"],
        "requirements_met": requirements_met,
        "population": expected["population"],
    }


def missing_review_audit(
    config: Mapping[str, Any],
    records: Mapping[str, Mapping[str, Any]],
    conflict_payload: Mapping[str, Any] | None = None,
) -> Dict[str, Any]:
    expected = build_review_plan(config, records, conflict_payload)
    required = len(expected["items"])
    return {
        "status": "OK",
        "review_log_status": "missing",
        "required_review_feature_count": required,
        "pending_review_feature_count": required,
        "reviewed_feature_count": 0,
        "approved_feature_count": 0,
        "changes_required_feature_count": 0,
        "requirements_met": required == 0,
        "population": expected["population"],
    }


def _paths(args: argparse.Namespace) -> Tuple[Path, Path, Path]:
    root = Path(args.root).resolve()
    scope = _resolve(root, args.scope)
    config = _resolve(root, args.config)
    return root, scope, config


def command_export(args: argparse.Namespace) -> Dict[str, Any]:
    root, scope, config_path = _paths(args)
    records = load_feature_records(root, scope)
    base_config = _read_json(config_path)
    validate_snapshot(base_config, records)
    broad = broad_candidates(records)
    pilot_codes = list(base_config["pilot"]["candidate_feature_codes"])
    if args.target_count != len(pilot_codes):
        raise SemanticConfigError(
            "target-count must match the frozen active pilot candidate count"
        )
    candidate_by_code = {item["feature_code"]: item for item in broad}
    pilot = [candidate_by_code[code] for code in pilot_codes]
    batch_size = args.batch_size
    batches = []
    for items in _balanced_batches(pilot, batch_size):
        batches.append(
            {
                "batch": len(batches) + 1,
                "items": [
                    {key: item[key] for key in ("feature_code", "feature_name", "feature_column_name", "group_code", "candidate_reasons")}
                    for item in items
                ],
            }
        )
    return {
        "schema_version": 2,
        "pilot_code": base_config["pilot"]["code"],
        "input_hash": feature_input_hash(records),
        "base_snapshot_sha256": _content_hash(base_config),
        "broad_candidate_count": len(broad),
        "selected_candidate_count": len(pilot),
        "batch_size": batch_size,
        "actual_batch_sizes": [len(batch["items"]) for batch in batches],
        "batch_result_contract": {
            "required_top_level_fields": [
                "schema_version",
                "pilot_code",
                "input_hash",
                "base_snapshot_sha256",
                "batch",
                "items",
            ],
            "optional_top_level_fields": ["conflicts"],
            "item_fields": [
                "feature_code",
                "semantic_summary_zh",
                "summary_source_type",
                "summary_confidence",
                "summary_evidence_ref",
                "tags",
            ],
            "conflict_fields": ["feature_code", "reason"],
        },
        "batches": batches,
    }


def command_validate(args: argparse.Namespace) -> Dict[str, Any]:
    root, scope, config_path = _paths(args)
    records = load_feature_records(root, scope)
    return validate_snapshot(_read_json(config_path), records)


def _optional_json(root: Path, configured: str | None) -> Mapping[str, Any] | None:
    if not configured:
        return None
    return _read_json(_resolve(root, configured))


def command_merge(args: argparse.Namespace) -> Dict[str, Any]:
    root, scope, config_path = _paths(args)
    records = load_feature_records(root, scope)
    base_config = _read_json(config_path)
    candidate_export = _read_json(_resolve(root, args.candidate_export))
    result_paths = [_resolve(root, value) for value in args.batch_result]
    batch_results = [(path.as_posix(), _read_json(path)) for path in result_paths]
    override_values = (args.model, args.prompt_version, args.generated_at)
    if any(override_values) and not all(override_values):
        raise SemanticConfigError(
            "--model, --prompt-version and --generated-at must be provided together"
        )
    generation_override = None
    if all(override_values):
        generation_override = {
            "model": args.model,
            "prompt_version": args.prompt_version,
            "generated_at": args.generated_at,
        }
    output = _resolve(root, args.output)
    conflict_path = _resolve(root, args.conflict_report) if args.conflict_report else None
    if conflict_path and output.resolve() == conflict_path.resolve():
        raise SemanticConfigError(
            "semantic snapshot output and conflict report must use different paths"
        )
    try:
        snapshot, report = merge_batch_results(
            candidate_export,
            batch_results,
            base_config,
            records,
            generation_override,
        )
    except MergeConflictError as exc:
        if conflict_path:
            if _assert_safe_json_target(
                conflict_path, exc.report, "semantic conflict report"
            ):
                _write_json(conflict_path, exc.report)
        raise
    write_snapshot = _assert_safe_json_target(
        output, snapshot, "semantic snapshot"
    )
    write_conflict = bool(
        conflict_path
        and _assert_safe_json_target(
            conflict_path, report["conflict_report"], "semantic conflict report"
        )
    )
    if write_snapshot:
        _write_json(output, snapshot)
    if conflict_path:
        if write_conflict:
            _write_json(conflict_path, report["conflict_report"])
    report = dict(report)
    report["output"] = output.as_posix()
    report["existing_snapshot_preserved"] = not write_snapshot
    if conflict_path:
        report["conflict_report_output"] = conflict_path.as_posix()
    return report


def command_create_review_plan(args: argparse.Namespace) -> Dict[str, Any]:
    root, scope, config_path = _paths(args)
    records = load_feature_records(root, scope)
    config = _read_json(config_path)
    conflicts = _optional_json(root, args.conflict_report)
    plan = build_review_plan(config, records, conflicts)
    output = _resolve(root, args.output)
    if output.exists():
        existing = _read_json(output)
        if existing == plan:
            return {
                "status": "OK",
                "output": output.as_posix(),
                "snapshot_sha256": plan["snapshot_sha256"],
                "required_review_feature_count": len(plan["items"]),
                "population": plan["population"],
                "all_reviews_initialized_as_pending": True,
                "existing_review_preserved": True,
            }
        existing_items = existing.get("items", []) if isinstance(existing, Mapping) else []
        completed_count = sum(
            1
            for item in existing_items
            if isinstance(item, Mapping) and item.get("status") == "completed"
        )
        detail = (
            f"existing log contains {completed_count} completed reviews"
            if completed_count
            else "existing log differs from the deterministic pending plan"
        )
        raise SemanticConfigError(
            "refusing to overwrite semantic review history: "
            f"{output} ({detail}); use an explicit new --output path and archive the old log"
        )
    _write_json(output, plan)
    return {
        "status": "OK",
        "output": output.as_posix(),
        "snapshot_sha256": plan["snapshot_sha256"],
        "required_review_feature_count": len(plan["items"]),
        "population": plan["population"],
        "all_reviews_initialized_as_pending": True,
    }


def command_validate_review(args: argparse.Namespace) -> Dict[str, Any]:
    root, scope, config_path = _paths(args)
    records = load_feature_records(root, scope)
    config = _read_json(config_path)
    conflicts = _optional_json(root, args.conflict_report)
    review_log = _read_json(_resolve(root, args.review_log))
    return validate_review_log(review_log, config, records, conflicts)


def command_audit(args: argparse.Namespace) -> Dict[str, Any]:
    root, scope, config_path = _paths(args)
    records = load_feature_records(root, scope)
    broad = broad_candidates(records)
    config = _read_json(config_path)
    result = validate_snapshot(config, records)
    conflicts = _optional_json(root, args.conflict_report)
    validated_conflicts = _validated_conflicts(conflicts, config)
    review_path = _resolve(root, args.review_log)
    if review_path.exists():
        try:
            review_audit = validate_review_log(
                _read_json(review_path), config, records, conflicts
            )
        except SemanticConfigError as exc:
            review_audit = missing_review_audit(config, records, conflicts)
            review_audit["review_log_status"] = "invalid"
            review_audit["validation_error"] = str(exc)
    else:
        review_audit = missing_review_audit(config, records, conflicts)
    result.update(
        {
            "managed_unique_feature_count": len(records),
            "broad_candidate_count": len(broad),
            "unselected_broad_candidate_count": len(broad) - result["pilot_candidate_count"],
            "review_audit": review_audit,
            "conflict_count": len(validated_conflicts),
            "governance_requirements_met": review_audit["requirements_met"],
        }
    )
    result["review_requirements"]["conflicts_all_count"] = len(validated_conflicts)
    return result


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", default=str(PROJECT_ROOT), help="project root")
    parser.add_argument("--scope", default="knowledge/config/maintenance_scope.json")
    parser.add_argument("--config", default="knowledge/config/managed_feature_semantics.json")
    subparsers = parser.add_subparsers(dest="command", required=True)

    export = subparsers.add_parser("export-candidates", help="export deterministic offline-labelling batches")
    export.add_argument("--target-count", type=int, default=250)
    export.add_argument("--batch-size", type=int, default=50, choices=range(40, 51), metavar="40..50")
    export.add_argument("--output", help="optional output JSON path; stdout when omitted")
    export.add_argument("--root", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    export.add_argument("--scope", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    export.add_argument("--config", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    export.set_defaults(handler=command_export)

    merge = subparsers.add_parser(
        "merge-batches", help="deterministically merge offline model batch results"
    )
    merge.add_argument("--candidate-export", required=True, help="export-candidates JSON")
    merge.add_argument(
        "--batch-result",
        action="append",
        required=True,
        help="one model-result JSON per batch; repeat for every batch",
    )
    merge.add_argument("--output", required=True, help="validated snapshot output JSON")
    merge.add_argument(
        "--conflict-report",
        help="optional static conflict report written on both success and conflict failure",
    )
    merge.add_argument("--model", help="explicit generation model override")
    merge.add_argument("--prompt-version", help="explicit prompt version override")
    merge.add_argument("--generated-at", help="explicit generation timestamp override")
    merge.add_argument("--root", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    merge.add_argument("--scope", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    merge.add_argument("--config", default=argparse.SUPPRESS, help="vocabulary/base snapshot path")
    merge.set_defaults(handler=command_merge)

    review = subparsers.add_parser(
        "create-review-plan", help="create a deterministic pending review plan"
    )
    review.add_argument(
        "--output",
        default="knowledge/config/managed_feature_semantics_review.json",
        help="static review log output JSON",
    )
    review.add_argument("--conflict-report", help="optional merge conflict report JSON")
    review.add_argument("--root", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    review.add_argument("--scope", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    review.add_argument("--config", default=argparse.SUPPRESS, help="semantic snapshot path")
    review.set_defaults(handler=command_create_review_plan)

    validate_review = subparsers.add_parser(
        "validate-review", help="validate review sampling and independent review trail"
    )
    validate_review.add_argument(
        "--review-log",
        default="knowledge/config/managed_feature_semantics_review.json",
    )
    validate_review.add_argument("--conflict-report", help="optional merge conflict report JSON")
    validate_review.add_argument("--root", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    validate_review.add_argument("--scope", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    validate_review.add_argument("--config", default=argparse.SUPPRESS, help="semantic snapshot path")
    validate_review.set_defaults(handler=command_validate_review)

    validate = subparsers.add_parser("validate", help="validate the governed static snapshot")
    validate.add_argument("--root", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    validate.add_argument("--scope", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    validate.add_argument("--config", default=argparse.SUPPRESS, help="semantic snapshot path")
    validate.set_defaults(handler=command_validate)

    audit = subparsers.add_parser("audit", help="report vocabulary and pilot coverage")
    audit.add_argument("--root", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    audit.add_argument("--scope", default=argparse.SUPPRESS, help=argparse.SUPPRESS)
    audit.add_argument("--config", default=argparse.SUPPRESS, help="semantic snapshot path")
    audit.add_argument(
        "--review-log",
        default="knowledge/config/managed_feature_semantics_review.json",
        help="review plan/log path; missing is reported as pending rather than fabricated",
    )
    audit.add_argument("--conflict-report", help="optional merge conflict report JSON")
    audit.set_defaults(handler=command_audit)
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        payload = args.handler(args)
        if args.command == "export-candidates" and args.output:
            _write_json(Path(args.output), payload)
        else:
            print(json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True))
        if args.command == "validate-review" and not payload["requirements_met"]:
            return 1
        if args.command == "audit" and not payload["governance_requirements_met"]:
            return 1
        return 0
    except SemanticConfigError as exc:
        print(json.dumps({"status": "ERROR", "error": str(exc)}, ensure_ascii=False), file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
