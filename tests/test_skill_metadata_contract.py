from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILL = (ROOT / "SKILL.md").read_text(encoding="utf-8")
FIELDS = (ROOT / "references" / "feature-snapshot-fields.md").read_text(encoding="utf-8")
BACKGROUNDS = (ROOT / "references" / "feature-package-backgrounds.md").read_text(encoding="utf-8")


def test_metadata_questions_are_routed_to_separate_curated_references():
    assert "references/feature-snapshot-fields.md" in SKILL
    assert "references/feature-package-backgrounds.md" in SKILL
    assert "特征包背景时读取" in SKILL
    for trigger in ("includeTodayFlag", "timeRange"):
        assert trigger in SKILL
    assert "不虚构查询状态或同步时间" in SKILL


def test_confirmed_field_definitions_are_preserved():
    expected_definitions = (
        "特征 Code",
        "特征字段名",
        "特征名称",
        "特征组 Code",
        "特征组名称",
        "特征主题域",
        "`UID` 表示用户主题域",
        "`0` 表示不回溯当天，`1` 表示回溯当天",
        "特征缓存天数",
    )
    for definition in expected_definitions:
        assert definition in FIELDS


def test_time_range_is_not_misrepresented_as_a_calculation_window():
    assert "该字段不是特征统计或计算的回溯窗口" in FIELDS
    assert "`timeRange` 表示缓存天数，不得解释为特征计算或统计的回溯窗口" in SKILL


def test_package_background_has_scope_and_missing_knowledge_guardrails():
    assert "该包中的特征是百融多头特征" in BACKGROUNDS
    assert "单个借款人向 2 家或 2 家以上的金融机构提出借贷需求" in BACKGROUNDS
    assert "不得根据包名、行业常识或其他包的背景补全" in SKILL


def test_nuggets_background_preserves_three_phase_plan_and_sql_evidence():
    for expected in (
        "共三期的“掘金计划”",
        "一期新增变化率特征",
        "二期拉长内部变量的时间窗口，并加入结清户特征",
        "三期新增轻重资产特征",
        "由一阶导计算二阶导",
        "dwa_risk_dz_model_30light_cross_heavy_inner_behaviour_df.sql",
    ):
        assert expected in BACKGROUNDS


def test_tongdun_and_internal_backgrounds_keep_source_and_scope_boundaries():
    for expected in (
        "贷中同盾多头特征",
        "主要区别是数据源不同",
        "覆盖 7 天、1 个月、3 个月、6 个月和 12 个月",
        "使用各类内部变量加工形成的特征集合",
        "扣款、余额不足及还款执行行为",
        "App 列表、页面点击、活跃度、设备及 LBS",
    ):
        assert expected in BACKGROUNDS
    assert "不能按相似中文名直接等同或替换" in SKILL


def test_logic_questions_still_use_deterministic_query_evidence():
    assert "具体特征的名称、取值、加工逻辑和血缘只采信本地命令的 JSON 输出" in SKILL
    assert "包级背景只用于补充业务上下文" in SKILL
    assert "更新进入索引的特征快照、分类、语义标签或逻辑事实源后" in SKILL
    assert "只更新字段字典或特征包背景参考文件不需要重建索引" in SKILL
