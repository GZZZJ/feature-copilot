# 特征包背景知识

本文件维护四个受控特征包的包级业务背景，包括项目维护者确认的包级口径，以及从当前特征快照和代表性 SQL 提炼的代码证据说明。前者可作为包级定义，后者仅描述当前代码所见；两者都不能替代单个特征的正式定义、统计口径或加工证据。

## `package_3_br`：贷中百融变量特征包

该包中的特征是百融多头特征。

多头借贷是指单个借款人向 2 家或 2 家以上的金融机构提出借贷需求的行为。多头借贷数据一般至少会粗分为银行类多头借贷和非银类多头借贷。

这是包级业务背景，可用于解释该包大致描述的风险主题；不能仅凭这段背景推断某个具体特征统计了哪些机构、时间窗口、申请次数或借贷结果。具体口径仍需结合 `featureName`、字段级逻辑和 SQL 证据。

## `package_4_nuggets`：贷中掘金特征包

该包来源于共三期的“掘金计划”。掘金计划是在“贷中内部变量特征包”的基础上进行的贷中特征挖掘计划：

- 一期新增变化率特征，核心思路是计算指标的一阶导，用于描述指标随时间或相邻订单的变化。
- 二期拉长内部变量的时间窗口，并加入结清户特征。
- 三期新增轻重资产特征。原有逻辑直接将轻资产与重资产数据 `UNION` 在一起，解释性较弱；本期将轻资产和重资产拆开后分别衍生，并增加两类资产之间的交叉特征。

当前留存代码可支持以下补充说明：

- 代表性时间序列 SQL 先按相邻订单的金额和时间差计算一阶导，部分逻辑再由一阶导计算二阶导，并汇总导数的正负次数、均值差和比值等特征。证据见 `goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_his_apply_trend_time_series_df.sql`。
- 特征快照中存在名称明确包含“拉长窗口期”和“结清户”的独立特征组；结清户代表性逻辑使用 12 个月窗口。证据见 `goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_will_pressure_jqh_df.sql`、`goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_account_lmt_feature_sample_all_final_jqh_df.sql` 和 `goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_16draw_repay_crossed_jqh_df.sql`。
- 三期代表性 SQL 分别构造轻资产授信、交易与还款聚合，并进一步计算轻资产与重资产在授信额度、未还本金、交易和还款等维度的交叉关系。证据见 `goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_31light_credit_trade_cross_df.sql` 和 `goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_30light_cross_heavy_inner_behaviour_df.sql`。

“三期”描述的是特征挖掘计划的建设演进，不能仅凭期数判断单个特征的公式或上线时间；具体口径仍需查询所属特征组及 SQL。

## `package_5_04tnd`：贷中同盾特征包

该包中的特征是贷中同盾多头特征。它与百融多头特征描述相近的多头借贷主题，主要区别是数据源不同；因此不能因为中文含义相似就将同盾特征与百融特征视为同一变量或直接替换。

当前 SQL 显示，同盾多头特征来源于同盾平台明细数据，围绕申请人在多个平台申请借款的情况加工，覆盖 7 天、1 个月、3 个月、6 个月和 12 个月等窗口。特征既统计平台数量和行业类型数量，也按银行个人业务、银行小微贷款、小额贷款公司、消费金融、P2P、融资租赁等平台类型拆分，并衍生不同时间窗口之间的比值和差值。证据见 `goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_tnd_feature_di.sql`。

百融多头使用独立的百融变量与加工链路，例如 `als_*` 字段及银行/非银机构口径。证据见 `goal/dp_table_logic/pdm_risk_dz_daily_br_trend_feature.sql`。两类多头变量的机构分类、查询主体、时间窗口和返回口径必须分别以各自字段及 SQL 为准，不能只依据“多头”主题对齐。

## `package_7_02inner`：贷中内部变量特征包

该包是在贷中场景下使用各类内部变量加工形成的特征集合，也是掘金计划继续挖掘和衍生的基础之一。

从当前特征组和 SQL 看，该包不是单一风险主题，而是覆盖信贷业务链路中的多类内部数据，主要包括：

- 申请、借款订单及交易行为；
- 授信额度、可用额度和额度使用率；
- 应还、实还、提前还款、逾期、还款压力和偿债趋势；
- 扣款、余额不足及还款执行行为；
- 催收记录、呼叫和通话行为；
- App 列表、页面点击、活跃度、设备及 LBS 等用户行为信息。

代表性证据包括 `goal/dp_table_logic/pdm_risk_dz_model_daily_dcp_trade_feature_info1_df.sql`、`goal/dp_table_logic/pdm_risk_dz_model_account_lmt_feature_sample_final_df.sql`、`goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_repayment_deduct_info_df.sql`、`goal/dp_table_logic/pdm_risk_dh_model_final_13collection_call_info_trend_features_di.sql` 和 `goal/dp_table_logic/pdm_risk_applist_feature_newfeature_di_v3.sql`。

“内部变量”描述的是数据来源与建设范围，不代表所有特征都适用于同一客群、观察时点或策略场景。回答具体特征时仍需根据其特征组、时间窗口、数据可得性和 SQL 证据逐项判断。

## 维护约定

- 使用自然语言维护包的定位、核心术语、适用边界和容易误解之处，不要求把业务背景拆成复杂 JSON。
- 新增事实时注明其适用范围是“整个包”“某个特征组”还是“单个特征”；本文件当前只维护包级背景。
- 如果信息会改变特征值、包范围、特征分类或逻辑证据，应修改对应事实源并重建索引，不能只修改本文件。
- 区分项目维护者确认的包级口径与代码证据支持的补充说明；SQL 归纳只描述已检查到的代表性逻辑，不外推为每个特征都具备的性质。
- 无法确认的知识明确写为“尚未维护”，不要按包名、字段名或行业常识补全。

当前口径确认日期：2026-07-22。
