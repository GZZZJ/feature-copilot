# dwa_f_user_first_loan_df - 首借大宽表

## 表信息
| 属性 | 值 |
|------|-----|
| 数据域 | 经营域 |
| 层级 | DWA |
| 项目 | dwa |
| 创建者 | 何胜 |
| 表类型 | 视图 (create or replace view) |
| 分区 | ds |

## 数据粒度
一行 = uid + ds 的用户首借经营特征日快照 (122列)

## 核心字段分类
### 首借交易
- first_loan_order_principal_by_blbtchhl: 首借本金 (20260101后口径切换)
- first_loan_order_loan_date: 首借放款日
- first_apply_date_by_blbtchhl: 首次发起借款日
- current_day_success_loan_order_flag: 当日是否成功动支

### 授信额度
- first_credit_time_by_btch: BTCH首次授信时间
- risk_credit_limit_by_bl/bt/ch/hl: 各业务类型授信额度
- risk_available_limit_by_bl/bt/ch/hl: 各业务类型可用额度
- first_credit_law_type: 首次授信案件类型 (FIRST_AUDIT/RE_APPLY/RE_AUDIT/PRE_LOAN_RECALL/OTHER)

### 风控模型
- latest_risk_model_a_score/g_score/b_score/g_score_v2/v3: 各版本模型评分

### 用户画像
- first_loan_user_type: 新户/睡眠/已动支_新户/已动支_睡眠
- income_level_group: 受薪/自雇
- age_group: 40岁以下/40岁及以上/其他
- city_level_group: 12线/345线

### 营销触达
- latest_month_dial_count/answer_count: 近月拨打/接通
- first_loan_promote_sms_cost/ai_cost/coupon_cost/manual_cost: 促首借成本

### 首借后30天跟踪
- first_loan_after_t1_t30_total_order_principal: 首借后30天累计交易额

## 加工逻辑
主表: dwa_f_user_feature_daily_view_df + 注册申请信息 + 首借后30天交易
派生: 收入/学历/年龄/城市分组 (CASE WHEN)
口径切换: 20260101起首借本金改用公司级口径