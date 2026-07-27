#!/usr/bin/env python3
"""Generate the deterministic full-catalog semantic snapshot (schema v2).

This utility is deliberately local and rule based.  It never calls a model;
the output labels are navigation metadata with ``rule_inferred`` provenance.
"""
from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

from feature_copilot.logic_catalog import load_managed_catalog

ROOT = Path(__file__).resolve().parents[1]
SCOPE = ROOT / "knowledge/config/maintenance_scope.json"
OUTPUT = ROOT / "knowledge/config/managed_feature_semantics_full.json"
CHINESE_CHAR = re.compile(r"[\u4e00-\u9fff]")

DIMENSIONS = [
    ("feature_role", "特征角色"), ("business_stage", "业务阶段"), ("business", "业务主题"),
    ("metric", "指标形态"), ("time", "时间语义"), ("derivation", "衍生方式"),
]

def tag(code, dimension, name_zh, aliases_zh=(), aliases_technical=()):
    return {"code": code, "dimension": dimension, "name_zh": name_zh,
            "aliases_zh": list(aliases_zh), "aliases_technical": list(aliases_technical)}

TAGS = [
    tag("feature_role.business_indicator", "feature_role", "业务指标", ("业务特征",), ("business_metric",)),
    tag("feature_role.product_model_output", "feature_role", "模型或产品输出", ("模型输出", "产品输出", "决策输出"), ("model_output", "product_output")),
    tag("feature_role.technical_governance", "feature_role", "技术或治理字段", ("技术字段", "元数据", "治理字段"), ("metadata", "technical_field")),
    tag("feature_role.needs_review", "feature_role", "待人工确认", ("待确认",), ("needs_review",)),
    tag("business_stage.pre_loan", "business_stage", "贷前", ("贷前阶段", "准入前"), ("pre_loan",)),
    tag("business_stage.in_loan", "business_stage", "贷中", ("贷中阶段",), ("in_loan",)),
    tag("business.external_credit", "business", "外部征信与多头", ("征信查询", "外部数据", "多头风险"), ("bureau", "als", "nbank")),
    tag("business.application", "business", "申请与准入", ("申请", "准入"), ("apply", "apl")),
    tag("business.borrowing", "business", "借款与动支", ("借款", "动支", "放款"), ("loan", "draw")),
    tag("business.loan_order", "business", "订单与分期", ("订单", "分期", "账单"), ("order", "ord", "stg", "pln")),
    tag("business.account_limit", "business", "账户与额度", ("额度", "授信", "可用额度"), ("limit", "lmt")),
    tag("business.transaction_payment", "business", "交易与支付", ("交易", "支付", "消费"), ("trade", "trans", "pay")),
    tag("business.due_payment", "business", "应还", ("应还款", "应付"), ("due",)),
    tag("business.repayment", "business", "还款", ("实还", "提前还款", "已还"), ("repay", "rep")),
    tag("business.delinquency", "business", "逾期", ("延滞", "拖欠"), ("ovd", "overdue", "dpd", "delinq")),
    tag("business.debt_refinance", "business", "负债与借新还旧", ("负债", "借新还旧"), ("debt", "refinance")),
    tag("business.fee_rate", "business", "利率与费用", ("利率", "费用", "手续费"), ("interest", "apr", "fee")),
    tag("business.app_interaction", "business", "App交互与埋点", ("应用交互", "曝光", "点击", "埋点"), ("maidian", "click", "show")),
    tag("business.device_identity", "business", "设备与身份识别", ("设备", "设备指纹", "身份识别"), ("imei", "idfa", "oaid", "device")),
    tag("business.location", "business", "地理位置", ("位置", "地理", "经纬度"), ("gps", "lbs", "geo")),
    tag("business.contact_call", "business", "联系与外呼", ("通话", "联系人", "外呼"), ("call", "contact", "phone")),
    tag("business.collection", "business", "催收反馈", ("催收", "承诺还款", "失联"), ("collection", "ptp")),
    tag("business.marketing", "business", "营销触达与响应", ("营销", "触达", "推广"), ("marketing", "campaign", "sms")),
    tag("metric.amount", "metric", "金额/本金/余额", ("金额", "本金", "余额"), ("amt", "amount", "bal", "principal")),
    tag("metric.count", "metric", "次数/数量/笔数", ("次数", "笔数", "机构数"), ("cnt", "count", "num", "orgnum")),
    tag("metric.duration_days", "metric", "天数/时长/间隔", ("天数", "日数", "时长", "间隔"), ("day", "dte", "dur")),
    tag("metric.ratio", "metric", "比例/占比/比率", ("比例", "占比", "比率"), ("rto", "ratio", "rate", "divide")),
    tag("metric.limit", "metric", "额度与利用率", ("额度", "额度利用率"), ("lmt", "limit")),
    tag("metric.interest_rate", "metric", "利率与费率", ("利率", "费率"), ("apr", "interest")),
    tag("metric.status", "metric", "状态与标识", ("状态", "标识", "是否"), ("flag", "status", "ind")),
    tag("metric.category", "metric", "类别与分布", ("类别", "分布", "渠道"), ("category", "channel")),
    tag("metric.datetime", "metric", "日期与时间点", ("日期", "时间点"), ("date", "datetime")),
    tag("metric.score_rank", "metric", "评分/等级/排序", ("评分", "等级", "排名"), ("score", "rank", "grade")),
    tag("metric.distance", "metric", "地理距离", ("距离",), ("distance", "dist")),
    tag("metric.overdue_days", "metric", "逾期天数", ("逾期日数", "逾期时长", "逾期持续天数"), ("dpd", "ovd_day", "overdue_days")),
    tag("metric.continuous_overdue_days", "metric", "连续逾期天数", ("连续逾期日数", "持续逾期天数"), ("ctn_ovd_day",)),
    tag("time.rolling_window", "time", "滚动观察窗口", ("近一段时间", "最近一段时间"), ("recent", "window")),
    tag("time.history", "time", "历史累计", ("历史", "累计", "全量历史"), ("his", "history")),
    tag("time.current", "time", "当前或截止时点", ("当前", "截至", "最新"), ("current", "latest", "asof")),
    tag("time.relative", "time", "事件相对时间", ("距今", "前后间隔"), ("dte", "ago", "since")),
    tag("time.order_installment_sequence", "time", "订单或分期序列", ("首期", "末期", "第几期"), ("fst", "lst", "stg")),
    tag("time.future", "time", "未来或预测窗口", ("未来", "预测"), ("future", "forecast", "pred")),
    tag("time.natural_period", "time", "自然周期", ("自然月", "自然周", "本月"), ("monthly", "weekly", "yearly")),
    tag("derivation.count", "derivation", "计数", ("次数统计", "数量统计"), ("cnt", "count", "num")),
    tag("derivation.sum", "derivation", "求和", ("总和", "合计"), ("sum", "total")),
    tag("derivation.mean", "derivation", "均值", ("平均", "单次平均"), ("avg", "mean")),
    tag("derivation.max", "derivation", "最大值", ("最大", "最高"), ("max",)),
    tag("derivation.min", "derivation", "最小值", ("最小", "最低"), ("min",)),
    tag("derivation.ratio", "derivation", "比值", ("比例计算", "占比计算"), ("rto", "ratio", "rate", "divide")),
    tag("derivation.difference", "derivation", "差值", ("相差",), ("diff", "delta")),
    tag("derivation.change_rate", "derivation", "变化率", ("同比", "环比", "增幅"), ("roc", "growth")),
    tag("derivation.dispersion", "derivation", "波动与离散", ("标准差", "方差", "波动"), ("std", "variance", "var")),
    tag("derivation.trend", "derivation", "趋势", ("趋势变化", "斜率"), ("trend", "slope")),
    tag("derivation.threshold", "derivation", "阈值与分段", ("超过阈值", "区间分段"), ("threshold", "above", "below")),
    tag("derivation.rank", "derivation", "排名与分位", ("分位", "排序"), ("rank", "quantile")),
    tag("derivation.continuous", "derivation", "连续与序列", ("连续", "序列"), ("consecutive", "sequence", "ctn")),
]

DEFAULT_TOPIC = {
    "外部多头与征信风险": "business.external_credit", "交易与支付行为": "business.transaction_payment",
    "App、设备与位置行为": "business.app_interaction", "还款行为与还款能力": "business.repayment",
    "借款申请与订单": "business.application", "逾期与偿债压力": "business.delinquency",
    "负债、费用与借新还旧": "business.debt_refinance", "账户与授信额度": "business.account_limit",
    "联系、催收与营销响应": "business.contact_call",
}

def matched(text, *patterns): return any(re.search(pattern, text, re.I) for pattern in patterns)
def tokenized(column): return set(token for token in re.split(r"[^a-z0-9]+", column.lower()) if token)
def relation(code, confidence): return {"tag_code": code, "metric_scope": "", "source_type": "rule_inferred", "confidence": confidence, "evidence_ref": "rule:full-v2:name-column-group"}


# These names are intentionally generated from the governed local inputs.  A
# feature alias is a navigation aid, not a replacement for feature_name or a
# claim about a calculation that is not present in the local SQL.
WINDOWS = {
    "d7": "近7天", "7d": "近7天", "1d": "近1天", "3d": "近3天",
    "7d": "近7天", "14d": "近14天", "30d": "近30天", "90d": "近90天",
    "180d": "近180天", "360d": "近360天", "m1": "近1个月", "m3": "近3个月",
    "m6": "近6个月", "m12": "近12个月", "1m": "近1个月", "3m": "近3个月",
    "6m": "近6个月", "12m": "近12个月",
}


def _tongdun_industry_names():
    """Read the source SQL's industry labels rather than guessing abbreviations."""
    path = ROOT / "goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_tnd_feature_di.sql"
    if not path.is_file():
        return {}
    text = path.read_text(encoding="utf-8")
    return {
        column.lower(): industry
        for industry, column in re.findall(
            r"industry_display_name\s*=\s*'([^']+)'[^\n]+?\bas\s+([a-z0-9_]+)", text, re.I
        )
    }


TONGDUN_INDUSTRIES = _tongdun_industry_names()
TONGDUN_COMPOSITE_INDUSTRIES = {
    "les": "租赁类平台", "bnk": "银行类平台", "csm": "消费金融类平台", "car": "汽车金融类平台",
    "ecm_ptf": "电商类平台", "ptt_lon": "小额贷款类平台", "oth": "其他类平台",
}
TONGDUN_WINDOW = r"(?:d7|7d|m1|m3|m6|m12|1m|3m|6m|12m)"


def _window(token):
    value = token.lower()
    if value in WINDOWS:
        return WINDOWS[value]
    match = re.fullmatch(r"(\d+)d", value)
    return f"近{match.group(1)}天" if match else token


def _tongdun_alias(column):
    """Return a Chinese alias for a field materialized by the Tongdun SQL."""
    value = column.lower()
    if not value.startswith("tnd_rsk_itm_"):
        return ""
    if value == "tnd_rsk_itm_max_ptf_cnt":
        return "同盾多头：历史最大借款申请平台数"
    match = re.fullmatch(rf"tnd_rsk_itm_({TONGDUN_WINDOW})_typ", value)
    if match:
        return f"同盾多头：{_window(match.group(1))}借款申请平台所属行业数"
    match = re.fullmatch(r"tnd_rsk_itm_(one_wek|one_mth|thr_mth|six_mth|one_yer)_ptf_apl", value)
    if match:
        window = {"one_wek": "近7天", "one_mth": "近1个月", "thr_mth": "近3个月", "six_mth": "近6个月", "one_yer": "近12个月"}[match.group(1)]
        return f"同盾多头：{window}借款申请平台数"
    match = re.fullmatch(rf"tnd_rsk_itm_({TONGDUN_WINDOW})_(.+?)(_rat)?", value)
    if match and value in TONGDUN_INDUSTRIES:
        window, _, ratio = match.groups()
        suffix = "申请平台数占比" if ratio else "借款申请平台数"
        return f"同盾多头：{_window(window)}{TONGDUN_INDUSTRIES[value]}{suffix}"
    match = re.fullmatch(rf"tnd_rsk_itm_({TONGDUN_WINDOW})_(les|bnk|csm|car|ecm_ptf|ptt_lon|oth)(_rat)?", value)
    if match:
        window, industry, ratio = match.groups()
        suffix = "申请平台数占比" if ratio else "借款申请平台数"
        return f"同盾多头：{_window(window)}{TONGDUN_COMPOSITE_INDUSTRIES[industry]}{suffix}"
    match = re.fullmatch(rf"tnd_rsk_itm_({TONGDUN_WINDOW})_(div|dif)_({TONGDUN_WINDOW})", value)
    if match:
        left, operator, right = match.groups()
        label = "之比" if operator == "div" else "之差"
        return f"同盾多头：{_window(left)}与{_window(right)}借款申请平台数{label}"
    match = re.fullmatch(rf"tnd_rsk_itm_typ_({TONGDUN_WINDOW})_(div|dif)_({TONGDUN_WINDOW})", value)
    if match:
        left, operator, right = match.groups()
        label = "之比" if operator == "div" else "之差"
        return f"同盾多头：{_window(left)}与{_window(right)}申请平台所属行业数{label}"
    return "同盾多头：借款申请风险指标（字段口径待人工确认）"


TOKEN_NAMES = {
    "avg": "平均值", "mean": "平均值", "max": "最大值", "min": "最小值", "sum": "总和",
    "stddev": "标准差", "cnt": "次数", "count": "次数", "amt": "金额", "day": "天数",
    "diff": "差值", "rate": "比率", "ratio": "比率", "repay": "还款", "loan": "借款",
    "event": "事件", "type": "类型", "channel": "渠道", "all": "全量", "recent": "近期",
    "call": "外呼", "answer": "接通", "busy": "占线", "close": "挂断", "click": "点击",
    "clk": "点击", "dau": "活跃天数", "active": "活跃", "page": "页面", "view": "浏览",
    "first": "首次", "last": "末次", "cur": "当前", "ord": "订单", "ordr": "订单",
    "crt": "创建", "dte": "日期", "mdl": "模型评分", "con": "连续", "hb": "还呗",
}


def _generic_code_alias(column):
    """Conservative fallback for the few legacy fields without a Chinese name."""
    windows, words = [], []
    for token in column.lower().split("_"):
        if token in WINDOWS:
            windows.append(_window(token))
        elif token in TOKEN_NAMES:
            words.append(TOKEN_NAMES[token])
        elif token.isdigit():
            words.append(token)
    return "".join([*windows, *words]) or "待人工确认的技术字段"


def _window_from_column(column):
    match = re.search(r"(?:^|_)(\d+d)(?:$|_)", column.lower())
    return _window(match.group(1)) if match else ""


def _ai_call_alias(column):
    """Decode only labels that are visible in the local AI-call task SQL."""
    match = re.fullmatch(r"ai_(.+?)_cnt(?:_(\d+d))?", column.lower())
    if not match:
        return ""
    event, days = match.groups()
    labels = {
        "call": "外呼", "answer": "接通", "answer_close": "接通后挂断", "busy": "占线",
        "tousu2": "投诉标签2", "alpa": "结果码ALPA",
    }
    return f"AI外呼：{_window(days) if days else '历史'}{labels.get(event, event.upper())}次数"


def _page_click_alias(column):
    match = re.fullmatch(r"clk_cnt(?:_(00)_(06))?(?:_(rep|drw))?_(\d+d)", column.lower())
    if not match:
        return ""
    start, end, scope, days = match.groups()
    period = f"凌晨{int(start)}-{int(end)}时" if start else ""
    suffix = f"（{scope.upper()}口径）" if scope else ""
    return f"{_window(days)}{period}点击次数{suffix}"


def _page_activity_alias(column):
    value = column.lower()
    match = re.fullmatch(r"dau_00_06_(\d+d)", value)
    if match:
        return f"{_window(match.group(1))}凌晨0-6时活跃天数"
    match = re.fullmatch(r"pge_id_cnt(?:_00_06)?_(\d+d)", value)
    if match:
        period = "凌晨0-6时" if "_00_06_" in value else ""
        return f"{_window(match.group(1))}{period}访问页面数"
    return ""


def _active_days_alias(column):
    value = column.lower()
    match = re.fullmatch(r"dau_(\d+d)", value)
    if match:
        return f"{_window(match.group(1))}活跃天数"
    match = re.fullmatch(r"max_con_dau_(\d+d)", value)
    if match:
        return f"{_window(match.group(1))}最长连续活跃天数"
    match = re.fullmatch(r"ddf_mdl_max_dau_dt_(\d+d)", value)
    if match:
        return f"{_window(match.group(1))}最近活跃日距评分日天数"
    match = re.fullmatch(r"ddf_mdl_max_con_dau_dt_(\d+d)", value)
    if match:
        return f"{_window(match.group(1))}最长连续活跃期结束日距评分日天数"
    return ""


def _pip_heavy_alias(column):
    """Render the 22pip event fields as stable dimension/value clauses."""
    value = column.lower()
    aggregation = next((label for token, label in {
        "avg": "均值", "mean": "均值", "max": "最大值", "min": "最小值", "sum": "总和",
        "cnt": "次数", "n_unique": "去重值个数", "std": "标准差", "stddev": "标准差",
        "median": "中位数", "first": "首个值", "last": "末个值", "per": "占比", "div": "比值", "redu": "差值",
    }.items() if value.startswith(token + "_")), "")
    if not aggregation:
        direct = {
            "amt_n_unique_all": "重资产事件：全量｜金额去重值个数",
            "day_diff_first_event_result_10": "重资产事件：事件结果=10的首个事件间隔天数",
            "day_diff_first_limit_repay": "重资产事件：额度事件与还款事件的首个间隔天数",
            "day_diff_last_repay_loan": "重资产事件：还款事件与借款事件的末个间隔天数",
            "day_diff_shift1_n_unique_all": "重资产事件：全量｜相邻事件间隔天数去重值个数",
            "succloan_day_diff_reud_stage_num_first_all": "重资产事件：全量｜成功借款后剩余期数首个事件间隔天数",
            "succloan_day_diff_reud_stage_num_min_all": "重资产事件：全量｜成功借款后剩余期数最小事件间隔天数",
            "succloan_day_diff_reud_stage_num_sum_all": "重资产事件：全量｜成功借款后剩余期数事件间隔天数总和",
            "succloan_stage_num_mean_all": "重资产事件：全量｜成功借款分期期数均值",
        }
        return direct.get(value, "")
    period = "全量"
    match = re.search(r"(?:recent(?:_days)?|uid_recent_days)_(\d+)", value)
    if match:
        period = f"近{match.group(1)}天"
    clauses = []
    for marker, label in (
        ("event_type_credit", "事件类型=授信"), ("event_type_limit", "事件类型=额度"),
        ("event_type_loan", "事件类型=借款"), ("event_type_repay", "事件类型=还款"),
        ("event_result_0", "事件结果=0"), ("event_result_1", "事件结果=1"),
        ("channel_hb", "渠道=HB"), ("type_heavy", "类型=重资产"),
        ("microcredit_lv1", "微贷层级=1"), ("manual_repay", "附加信息=人工还款"),
        ("day_diff_shift1", "相邻事件间隔天数"), ("day_diff", "事件间隔天数"),
        ("amt", "金额"),
    ):
        if marker in value and label not in clauses:
            clauses.append(label)
    if not clauses:
        clauses.append("事件记录")
    return f"重资产事件：{period}｜{'｜'.join(clauses)}｜{aggregation}"


def _small_group_alias(feature):
    column, table = feature["feature_column_name"].lower(), feature["table_name"]
    if table == "dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_df":
        return {
            "cur_ord_rn": "当前订单序号", "ddf_fst_cur_ord_crt_dte": "当前订单创建日距首笔订单创建日天数",
            "ddf_mdl_cur_ord_crt_dte": "评分日距当前订单创建日天数",
        }.get(column, "")
    if table == "dwa_risk_dz_model_final_12his_rep_will_pressure_df":
        return {
            "stg_pln_pay_off_cnt_cur_ord": "当前订单已结清分期计划数",
            "stg_pln_pay_off_sum_prc_amt_cur_ord": "当前订单已结清分期计划本金总额",
        }.get(column, "")
    if table == "dwa_risk_dz_model_final_14ftr_rep_pressure_df":
        return {
            "mdl_dte": "模型评分日", "stg_pln_max_prc_amt_6m_ftr_rep": "未来6个月应还分期计划最大本金金额",
        }.get(column, "")
    return ""


def _normalise_existing_name(name):
    value = re.sub(r"\s+", "", name.strip())
    value = value.replace("(", "（").replace(")", "）")
    value = value.replace("取max", "取最大值").replace("取min", "取最小值")
    value = re.sub(r"近(\d+)(?=m(?:[）_，。]|$))", r"近\1个月", value, flags=re.I)
    value = re.sub(r"近(\d+)(?=d(?:[）_，。]|$))", r"近\1天", value, flags=re.I)
    return value


def alias_for(feature):
    """Generate a readable alias while keeping the source feature name intact."""
    name, column = feature["feature_name"].strip(), feature["feature_column_name"].strip()
    tongdun = _tongdun_alias(column)
    if tongdun:
        confidence = "high" if column.lower() in TONGDUN_INDUSTRIES or "_div_" in column or "_dif_" in column or column.lower().endswith(("_typ", "_ptf_apl", "_max_ptf_cnt")) else "medium"
        return tongdun, confidence, "rule:alias-v1:tongdun-local-sql"
    table = feature["table_name"]
    specialised = (
        _ai_call_alias(column) if table == "pdm_risk_dh_model_15ai_call_record" else
        (_page_click_alias(column) or _page_activity_alias(column)) if table == "dwa_risk_dz_model_final_8active_page_view_n_click_cnt" else
        _active_days_alias(column) if table == "dwa_risk_dz_model_final_8active_dau" else
        _pip_heavy_alias(column) if table == "dwa_risk_dz_model_final_22pip_heavy_cross_info_df" else
        _small_group_alias(feature)
    )
    if specialised:
        return specialised, "high", "rule:alias-v2:local-sql-field-pattern"
    if CHINESE_CHAR.search(name) and name != "-":
        return _normalise_existing_name(name), "high", "rule:alias-v1:feature-name"
    return _generic_code_alias(column), "medium", "rule:alias-v1:column-token"

def infer(feature):
    name, column = feature["feature_name"], feature["feature_column_name"]
    text, tokens = (name + " " + column).lower(), tokenized(column)
    topics, metrics, times, derivations = set(), set(), set(), set()
    rules = {
        "business.application": (r"申请|准入", "apply", "apl"), "business.external_credit": (r"征信|资信|查询|多头", "als", "nbank"),
        "business.borrowing": (r"借款|动支|放款", "loan", "draw", "lend"), "business.loan_order": (r"订单|分期|账单", "ord", "order", "stg", "pln"),
        "business.account_limit": (r"额度|授信", "lmt", "limit"), "business.transaction_payment": (r"交易|支付|消费|商户", "trade", "trans", "pay"),
        "business.due_payment": (r"应还|应付", "due"), "business.repayment": (r"还款|实还|已还|提前还", "repay", "rep"),
        "business.delinquency": (r"逾期|拖欠", "ovd", "overdue", "dpd", "delinq"), "business.debt_refinance": (r"负债|借新还旧", "debt", "refinance"),
        "business.fee_rate": (r"利率|费用|手续费", "fee", "apr", "interest"), "business.app_interaction": (r"曝光|点击|停留|埋点|页面|登录|活跃", "click", "show", "maidian"),
        "business.device_identity": (r"设备|机型|指纹", "device", "imei", "idfa", "oaid"), "business.location": (r"地理|位置|经纬度|距离", "gps", "lbs", "geo"),
        "business.contact_call": (r"通话|联系人|外呼|接通|拒接", "call", "contact", "phone"), "business.collection": (r"催收|承诺还款|失联|投诉", "collection", "ptp"),
        "business.marketing": (r"营销|触达|推广|短信", "marketing", "campaign", "sms"),
    }
    for code, patterns in rules.items():
        if matched(text, patterns[0]) or tokens.intersection(patterns[1:]): topics.add(code)
    explicit_topic = bool(topics)
    if not topics: topics.add(DEFAULT_TOPIC[feature["business_subcategory_name"]])
    metric_rules = {
        "metric.overdue_days": (r"逾期(?:天数|日数|时长)|连续逾期", {"dpd", "ovd", "overdue"}),
        "metric.continuous_overdue_days": (r"连续逾期", {"ctn"}), "metric.amount": (r"金额|本金|余额|欠款", {"amt", "bal", "principal"}),
        "metric.count": (r"次数|笔数|数量|机构数|月份数", {"cnt", "count", "num", "orgnum", "mons"}),
        "metric.duration_days": (r"天数|日数|时长|间隔", {"day", "days", "dte", "dur"}), "metric.ratio": (r"比例|占比|比率", {"rto", "ratio", "rate", "divide"}),
        "metric.limit": (r"额度|授信", {"lmt", "limit"}), "metric.interest_rate": (r"利率|费率", {"apr", "interest"}),
        "metric.status": (r"是否|标识|状态|响应码", {"flag", "status", "ind"}), "metric.category": (r"类别|分布|渠道|地区", {"category", "channel"}),
        "metric.datetime": (r"日期|时间", {"date", "datetime", "tim"}), "metric.score_rank": (r"评分|分数|等级|排名", {"score", "rank", "grade"}),
        "metric.distance": (r"距离", {"distance", "dist"}),
    }
    for code, (chinese, technical) in metric_rules.items():
        if matched(text, chinese) or tokens.intersection(technical): metrics.add(code)
    if matched(text, r"近\d+|最近\d+|过去\d+") or any(re.fullmatch(r"[dmwy]\d+", x) for x in tokens): times.add("time.rolling_window")
    if matched(text, r"历史|累计|全量") or tokens.intersection({"his", "history", "all"}): times.add("time.history")
    if matched(text, r"当前|截至|最新|期末") or tokens.intersection({"current", "latest", "asof"}): times.add("time.current")
    if matched(text, r"距今|距.*日|前.*日|后.*日") or tokens.intersection({"dte", "ago", "since", "until"}): times.add("time.relative")
    if matched(text, r"首期|末期|第[一二三四五六七八九十\d]+期") or tokens.intersection({"fst", "lst", "stg"}): times.add("time.order_installment_sequence")
    if matched(text, r"未来|预测") or tokens.intersection({"future", "forecast", "pred"}): times.add("time.future")
    if matched(text, r"本月|本周|本年|自然月|自然周") or tokens.intersection({"monthly", "weekly", "yearly"}): times.add("time.natural_period")
    derivation_rules = {"derivation.count": (r"次数|笔数|数量|机构数", {"cnt", "count", "num", "orgnum"}), "derivation.sum": (r"总和|合计|总额", {"sum", "total"}), "derivation.mean": (r"平均|均值", {"avg", "mean"}), "derivation.max": (r"最大|最高", {"max"}), "derivation.min": (r"最小|最低", {"min"}), "derivation.ratio": (r"比例|占比|比率", {"rto", "ratio", "rate", "divide"}), "derivation.difference": (r"差值|相差", {"diff", "delta"}), "derivation.change_rate": (r"变化率|同比|环比|增幅|降幅", {"roc", "growth"}), "derivation.dispersion": (r"方差|标准差|波动|离散", {"std", "variance", "var"}), "derivation.trend": (r"趋势|斜率", {"trend", "slope"}), "derivation.threshold": (r"超过|大于|小于|阈值|连续逾期", {"above", "below", "threshold", "m2p", "m3p", "m4p"}), "derivation.rank": (r"排名|分位", {"rank", "quantile"}), "derivation.continuous": (r"连续|序列", {"consecutive", "sequence", "ctn"})}
    for code, (chinese, technical) in derivation_rules.items():
        if matched(text, chinese) or tokens.intersection(technical): derivations.add(code)
    generic = {"created", "updated", "at", "rcd", "tim", "data", "id", "code"}
    if (tokens <= generic or column.lower() in {"created_at", "updated_at", "rcd_tim", "data_id", "code"}): role = "feature_role.technical_governance"
    elif matched(text, r"产品输出|模型输出|借贷意向验证") or column.lower().startswith("flag_"): role = "feature_role.product_model_output"
    elif not name.strip(): role = "feature_role.needs_review"
    else: role = "feature_role.business_indicator"
    confidence = "high" if explicit_topic and (metrics or times or derivations) else ("low" if role != "feature_role.business_indicator" else "medium")
    ordered_metrics = [code for code in ("metric.continuous_overdue_days", "metric.overdue_days", "metric.ratio", "metric.interest_rate", "metric.amount", "metric.limit", "metric.duration_days", "metric.count", "metric.status", "metric.category", "metric.datetime", "metric.score_rank", "metric.distance") if code in metrics]
    stage = feature.get("business_stage", "")
    stage_tag = f"business_stage.{stage}" if stage else ""
    if stage_tag and stage_tag not in {item["code"] for item in TAGS}:
        raise ValueError(f"unsupported business stage for {feature['feature_code']}: {stage}")
    relations = [relation(role, confidence)]
    if stage_tag:
        relations.append(relation(stage_tag, "high"))
    relations += [relation(code, confidence) for code in sorted(topics)]
    for index, code in enumerate(ordered_metrics):
        item = relation(code, confidence); item["metric_scope"] = "primary" if index == 0 else "related"; relations.append(item)
    relations += [relation(code, confidence) for code in sorted(times)] + [relation(code, confidence) for code in sorted(derivations)]
    alias, alias_confidence, alias_evidence = alias_for(feature)
    summary = f"{feature['business_subcategory_name']}｜{alias}"
    return {"feature_code": feature["feature_code"], "alias_zh": alias, "alias_source_type": "rule_inferred", "alias_confidence": alias_confidence, "alias_evidence_ref": alias_evidence, "semantic_summary_zh": summary, "summary_source_type": "rule_inferred", "summary_confidence": confidence, "summary_evidence_ref": "rule:full-v2:name-column-group", "tags": relations}

def main():
    # A new semantic schema must be generatable from the raw feature catalog;
    # do not require the previous generated snapshot to validate first.
    catalog = load_managed_catalog(ROOT, SCOPE, validate_semantics=False)
    features = sorted(catalog["features"], key=lambda item: item["feature_code"])
    inputs = [{key: str(feature.get(key, "")).strip() for key in ("feature_code", "feature_name", "feature_column_name", "group_code")} for feature in features]
    input_hash = hashlib.sha256(json.dumps(inputs, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode()).hexdigest()
    payload = {"schema_version": 2, "generation": {"model": "deterministic-rule-engine", "prompt_version": "full-semantic-rules-v2-alias-v1", "generated_at": "2026-07-22T00:00:00+08:00", "input_hash": input_hash}, "coverage": {"mode": "full_catalog", "feature_count": len(features)}, "dimensions": [{"code": code, "name_zh": name} for code, name in DIMENSIONS], "tags": TAGS, "feature_semantics": [infer(feature) for feature in features]}
    OUTPUT.write_text(json.dumps(payload, ensure_ascii=False, separators=(",", ":")) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(OUTPUT.relative_to(ROOT)), "feature_count": len(features), "tag_count": len(TAGS)}, ensure_ascii=False))

if __name__ == "__main__": main()
