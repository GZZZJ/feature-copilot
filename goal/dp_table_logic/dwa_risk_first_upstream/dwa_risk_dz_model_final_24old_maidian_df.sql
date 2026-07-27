-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_24old_maidian_df
-- node_id: n_5699118617640435712
-- task_name: dwa_risk_dz_model_final_24old_maidian_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_24old_maidian_df.json
-- source_json_sha256: e4cec0a4801c598ae4808ff04efc8bc479ede04c4cfd4dc132489de2da967e94
-- upstream_table: pdm_risk_ftr.blue_customer_group_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_old_maidian_mid_di
-- upstream_table: dbus.dbus_f_yu_cus_grp_day_list_new_df
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_3mth_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_1mth_tmp

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 牛莲泽
--创建日期: 2024-03-31 23:38:46
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_24old_maidian_df (
	uid STRING comment  'uid' ,
	mdl_dte STRING comment  '模型打分日' ,
	md_loan_3mth_offline_5m_avg_stay_time DOUBLE comment  '近3个月订单成功前5minsapp启动到借款成功平均停留时长' ,
	md_loan_3mth_offline_5m_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins平均点击次数' ,
	md_loan_3mth_offline_5m_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins平均曝光次数' ,
	md_loan_3mth_offline_5m_core_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins核心页面平均点击次数' ,
	md_loan_3mth_offline_5m_noncore_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins非核心页面平均点击次数' ,
	md_loan_3mth_offline_5m_core_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins核心页面平均曝光次数' ,
	md_loan_3mth_offline_5m_noncore_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins非核心页面平均曝光次数' ,
	md_loan_3mth_offline_5m_lack_ability_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins还款能力不足类（灵活还款、更新收款卡还款卡）页面平均点击次数' ,
	md_loan_3mth_offline_5m_lack_ability_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins还款能力不足类（灵活还款、更新收款卡还款卡）页面平均曝光次数' ,
	md_loan_3mth_offline_5m_complain_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins投诉倾向（在线客服）类页面平均点击次数' ,
	md_loan_3mth_offline_5m_complain_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins投诉倾向（在线客服）类页面平均曝光次数' ,
	md_loan_3mth_offline_5m_price_sensitive_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins定价敏感（优惠券、会员权益）类页面平均点击次数' ,
	md_loan_3mth_offline_5m_price_sensitive_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins定价敏感（优惠券、会员权益）类页面平均曝光次数' ,
	md_loan_3mth_offline_5m_focus_credit_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins重视信用类（我的账单、借还详情页、待还账单列表）页面平均点击次数' ,
	md_loan_3mth_offline_5m_focus_credit_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins重视信用类（我的账单、借还详情页、待还账单列表）页面平均曝光次数' ,
	md_loan_3mth_offline_5m_amtinput_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins输入金额平均点击次数' ,
	md_loan_3mth_offline_5m_s1_amtinput_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步输入金额平均点击次数' ,
	md_loan_3mth_offline_5m_s1_lendall_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步全部借出平均点击次数' ,
	md_loan_3mth_offline_5m_s2_amtinput_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步输入金额平均点击次数' ,
	md_loan_3mth_offline_5m_s2_lendall_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步全部借出平均点击次数' ,
	md_loan_3mth_offline_5m_s1amtinput_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步或输入金额平均点击次数' ,
	md_loan_3mth_offline_5m_s1lendall_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步或全部借出平均点击次数' ,
	md_loan_3mth_offline_5m_s2amtinput_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步或输入金额平均点击次数' ,
	md_loan_3mth_offline_5m_s2lendall_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步或全部借出平均点击次数' ,
	md_loan_3mth_offline_5m_amt_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择金额平均点击次数' ,
	md_loan_3mth_offline_5m_period_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数平均点击次数' ,
	md_loan_3mth_offline_5m_period_3_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数为3期平均点击次数' ,
	md_loan_3mth_offline_5m_period_6_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数为6期平均点击次数' ,
	md_loan_3mth_offline_5m_period_12_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数为12期平均点击次数' ,
	md_loan_3mth_offline_5m_add_paycard_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins添加收款卡平均点击次数' ,
	md_loan_3mth_offline_5m_change_lendcard_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins更改信用卡平均点击次数' ,
	md_loan_3mth_offline_5m_change_paycard_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins更改收款卡平均点击次数' ,
	md_loan_3mth_offline_5m_coupon_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins优惠券相关平均点击次数' ,
	md_loan_3mth_offline_5m_payanytime_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins随借随还平均点击次数' ,
	md_loan_3mth_offline_5m_paymth_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins每月等额平均点击次数' ,
	md_loan_3mth_offline_5m_payfree_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins灵活还款平均点击次数' ,
	md_loan_3mth_offline_5m_vip_details_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins会员权益详情平均点击次数' ,
	md_loan_3mth_offline_5m_vipchoose_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins会员选中提交平均点击次数' ,
	md_loan_3mth_offline_5m_loanuse_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择借款用途平均点击次数' ,
	md_loan_3mth_offline_5m_online_service_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins在线客服平均点击次数' ,
	md_loan_3mth_offline_5m_avg_income_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins平均月收入平均点击次数' ,
	md_loan_3mth_offline_5m_amtinput_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins输入金额平均曝光次数' ,
	md_loan_3mth_offline_5m_s1_amtinput_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步输入金额平均曝光次数' ,
	md_loan_3mth_offline_5m_s1_lendall_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步全部借出平均曝光次数' ,
	md_loan_3mth_offline_5m_s2_amtinput_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步输入金额平均曝光次数' ,
	md_loan_3mth_offline_5m_s2_lendall_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步全部借出平均曝光次数' ,
	md_loan_3mth_offline_5m_s1amtinput_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步或输入金额平均曝光次数' ,
	md_loan_3mth_offline_5m_s1lendall_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第一步或全部借出平均曝光次数' ,
	md_loan_3mth_offline_5m_s2amtinput_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步或输入金额平均曝光次数' ,
	md_loan_3mth_offline_5m_s2lendall_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins第二步或全部借出平均曝光次数' ,
	md_loan_3mth_offline_5m_amt_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择金额平均曝光次数' ,
	md_loan_3mth_offline_5m_period_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数平均曝光次数' ,
	md_loan_3mth_offline_5m_period_3_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数为3期平均曝光次数' ,
	md_loan_3mth_offline_5m_period_6_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数为6期平均曝光次数' ,
	md_loan_3mth_offline_5m_period_12_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择期数为12期平均曝光次数' ,
	md_loan_3mth_offline_5m_addpaycard_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins添加收款卡平均曝光次数' ,
	md_loan_3mth_offline_5m_changelendcard_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins更改信用卡平均曝光次数' ,
	md_loan_3mth_offline_5m_changepaycard_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins更改收款卡平均曝光次数' ,
	md_loan_3mth_offline_5m_coupon_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins优惠券相关平均曝光次数' ,
	md_loan_3mth_offline_5m_payanytime_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins随借随还平均曝光次数' ,
	md_loan_3mth_offline_5m_paymth_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins每月等额平均曝光次数' ,
	md_loan_3mth_offline_5m_payfree_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins灵活还款平均曝光次数' ,
	md_loan_3mth_offline_5m_vipcheck_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins会员权益详情平均曝光次数' ,
	md_loan_3mth_offline_5m_vipchoose_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins会员选中提交平均曝光次数' ,
	md_loan_3mth_offline_5m_loanuse_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins选择借款用途平均曝光次数' ,
	md_loan_3mth_offline_5m_onservice1_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins在线客服平均曝光次数' ,
	md_loan_3mth_offline_5m_income_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins平均月收入平均曝光次数' ,
	md_loan_3mth_offline_5m_repay_plan_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins还款计划平均点击次数' ,
	md_loan_3mth_offline_5m_mybill_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins我的账单平均点击次数' ,
	md_loan_3mth_offline_5m_bill_detail_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins我的账单账单详情平均点击次数' ,
	md_loan_3mth_offline_5m_repay_rule_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins还款规则平均点击次数' ,
	md_loan_3mth_offline_5m_prepay_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins提前还款平均点击次数' ,
	md_loan_3mth_offline_5m_thismth_bill_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins本月待还平均点击次数' ,
	md_loan_3mth_offline_5m_nextmth_bill_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins下月待还平均点击次数' ,
	md_loan_3mth_offline_5m_fail_reason_click_avg_cnt DOUBLE comment  '近3个月订单成功前5mins失败原因平均点击次数' ,
	md_loan_3mth_offline_5m_repay_plan_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins还款计划平均曝光次数' ,
	md_loan_3mth_offline_5m_mybill_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins我的账单平均曝光次数' ,
	md_loan_3mth_offline_5m_bill_detail_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins我的账单账单详情平均曝光次数' ,
	md_loan_3mth_offline_5m_repay_rule_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins还款规则平均曝光次数' ,
	md_loan_3mth_offline_5m_prepay_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins提前还款平均曝光次数' ,
	md_loan_3mth_offline_5m_thismth_bill_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins本月待还平均曝光次数' ,
	md_loan_3mth_offline_5m_nextmth_bill_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins下月待还平均曝光次数' ,
	md_loan_3mth_offline_5m_fail_reason_show_avg_cnt DOUBLE comment  '近3个月订单成功前5mins失败原因平均曝光次数' ,
	md_loan_3mth_offline_5m_avg_click_stay_time DOUBLE comment  '近3个月订单成功前5mins平均点击停留时长' ,
	md_loan_3mth_offline_5m_avg_show_stay_time DOUBLE comment  '近3个月订单成功前5mins平均曝光停留时长' ,
	md_loan_3mth_offline_5m_core_avg_click_stay_time DOUBLE comment  '近3个月订单成功前5mins核心页面平均点击停留时长' ,
	md_loan_3mth_offline_5m_noncore_avg_click_stay_time DOUBLE comment  '近3个月订单成功前5mins非核心页面平均点击停留时长' ,
	md_loan_3mth_offline_5m_price_sensitive_avg_show_stay_time DOUBLE comment  '近3个月订单成功前5mins定价敏感（优惠券、会员权益）类页面平均曝光停留时长' ,
	md_loan_3mth_offline_5m_period_avg_click_stay_time DOUBLE comment  '近3个月订单成功前5mins选择期数平均点击停留时长' ,
	md_loan_3mth_offline_5m_period_3_avg_click_stay_time DOUBLE comment  '近3个月订单成功前5mins选择期数为3期平均点击停留时长' ,
	md_loan_3mth_offline_5m_period_6_avg_click_stay_time DOUBLE comment  '近3个月订单成功前5mins选择期数为6期平均点击停留时长' ,

	md_loan_1mth_offline_5m_avg_stay_time DOUBLE comment  '近1个月订单成功前5minsapp启动到借款成功平均停留时长' ,
	md_loan_1mth_offline_5m_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins平均点击次数' ,
	md_loan_1mth_offline_5m_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins平均曝光次数' ,
	md_loan_1mth_offline_5m_core_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins核心页面平均点击次数' ,
	md_loan_1mth_offline_5m_noncore_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins非核心页面平均点击次数' ,
	md_loan_1mth_offline_5m_core_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins核心页面平均曝光次数' ,
	md_loan_1mth_offline_5m_noncore_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins非核心页面平均曝光次数' ,
	md_loan_1mth_offline_5m_lack_ability_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins还款能力不足类（灵活还款、更新收款卡还款卡）页面平均点击次数' ,
	md_loan_1mth_offline_5m_lack_ability_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins还款能力不足类（灵活还款、更新收款卡还款卡）页面平均曝光次数' ,
	md_loan_1mth_offline_5m_complain_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins投诉倾向（在线客服）类页面平均点击次数' ,
	md_loan_1mth_offline_5m_complain_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins投诉倾向（在线客服）类页面平均曝光次数' ,
	md_loan_1mth_offline_5m_price_sensitive_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins定价敏感（优惠券、会员权益）类页面平均点击次数' ,
	md_loan_1mth_offline_5m_price_sensitive_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins定价敏感（优惠券、会员权益）类页面平均曝光次数' ,
	md_loan_1mth_offline_5m_focus_credit_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins重视信用类（我的账单、借还详情页、待还账单列表）页面平均点击次数' ,
	md_loan_1mth_offline_5m_focus_credit_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins重视信用类（我的账单、借还详情页、待还账单列表）页面平均曝光次数' ,
	md_loan_1mth_offline_5m_amtinput_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins输入金额平均点击次数' ,
	md_loan_1mth_offline_5m_s1_amtinput_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步输入金额平均点击次数' ,
	md_loan_1mth_offline_5m_s1_lendall_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步全部借出平均点击次数' ,
	md_loan_1mth_offline_5m_s2_amtinput_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步输入金额平均点击次数' ,
	md_loan_1mth_offline_5m_s2_lendall_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步全部借出平均点击次数' ,
	md_loan_1mth_offline_5m_s1amtinput_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步或输入金额平均点击次数' ,
	md_loan_1mth_offline_5m_s1lendall_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步或全部借出平均点击次数' ,
	md_loan_1mth_offline_5m_s2amtinput_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步或输入金额平均点击次数' ,
	md_loan_1mth_offline_5m_s2lendall_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步或全部借出平均点击次数' ,
	md_loan_1mth_offline_5m_amt_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择金额平均点击次数' ,
	md_loan_1mth_offline_5m_period_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数平均点击次数' ,
	md_loan_1mth_offline_5m_period_3_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数为3期平均点击次数' ,
	md_loan_1mth_offline_5m_period_6_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数为6期平均点击次数' ,
	md_loan_1mth_offline_5m_period_12_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数为12期平均点击次数' ,
	md_loan_1mth_offline_5m_add_paycard_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins添加收款卡平均点击次数' ,
	md_loan_1mth_offline_5m_change_lendcard_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins更改信用卡平均点击次数' ,
	md_loan_1mth_offline_5m_change_paycard_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins更改收款卡平均点击次数' ,
	md_loan_1mth_offline_5m_coupon_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins优惠券相关平均点击次数' ,
	md_loan_1mth_offline_5m_payanytime_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins随借随还平均点击次数' ,
	md_loan_1mth_offline_5m_paymth_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins每月等额平均点击次数' ,
	md_loan_1mth_offline_5m_payfree_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins灵活还款平均点击次数' ,
	md_loan_1mth_offline_5m_vip_details_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins会员权益详情平均点击次数' ,
	md_loan_1mth_offline_5m_vipchoose_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins会员选中提交平均点击次数' ,
	md_loan_1mth_offline_5m_loanuse_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择借款用途平均点击次数' ,
	md_loan_1mth_offline_5m_online_service_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins在线客服平均点击次数' ,
	md_loan_1mth_offline_5m_avg_income_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins平均月收入平均点击次数' ,
	md_loan_1mth_offline_5m_amtinput_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins输入金额平均曝光次数' ,
	md_loan_1mth_offline_5m_s1_amtinput_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步输入金额平均曝光次数' ,
	md_loan_1mth_offline_5m_s1_lendall_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步全部借出平均曝光次数' ,
	md_loan_1mth_offline_5m_s2_amtinput_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步输入金额平均曝光次数' ,
	md_loan_1mth_offline_5m_s2_lendall_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步全部借出平均曝光次数' ,
	md_loan_1mth_offline_5m_s1amtinput_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步或输入金额平均曝光次数' ,
	md_loan_1mth_offline_5m_s1lendall_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第一步或全部借出平均曝光次数' ,
	md_loan_1mth_offline_5m_s2amtinput_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步或输入金额平均曝光次数' ,
	md_loan_1mth_offline_5m_s2lendall_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins第二步或全部借出平均曝光次数' ,
	md_loan_1mth_offline_5m_amt_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择金额平均曝光次数' ,
	md_loan_1mth_offline_5m_period_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数平均曝光次数' ,
	md_loan_1mth_offline_5m_period_3_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数为3期平均曝光次数' ,
	md_loan_1mth_offline_5m_period_6_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数为6期平均曝光次数' ,
	md_loan_1mth_offline_5m_period_12_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择期数为12期平均曝光次数' ,
	md_loan_1mth_offline_5m_addpaycard_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins添加收款卡平均曝光次数' ,
	md_loan_1mth_offline_5m_changelendcard_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins更改信用卡平均曝光次数' ,
	md_loan_1mth_offline_5m_changepaycard_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins更改收款卡平均曝光次数' ,
	md_loan_1mth_offline_5m_coupon_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins优惠券相关平均曝光次数' ,
	md_loan_1mth_offline_5m_payanytime_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins随借随还平均曝光次数' ,
	md_loan_1mth_offline_5m_paymth_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins每月等额平均曝光次数' ,
	md_loan_1mth_offline_5m_payfree_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins灵活还款平均曝光次数' ,
	md_loan_1mth_offline_5m_vipcheck_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins会员权益详情平均曝光次数' ,
	md_loan_1mth_offline_5m_vipchoose_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins会员选中提交平均曝光次数' ,
	md_loan_1mth_offline_5m_loanuse_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins选择借款用途平均曝光次数' ,
	md_loan_1mth_offline_5m_onservice1_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins在线客服平均曝光次数' ,
	md_loan_1mth_offline_5m_income_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins平均月收入平均曝光次数' ,
	md_loan_1mth_offline_5m_repay_plan_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins还款计划平均点击次数' ,
	md_loan_1mth_offline_5m_mybill_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins我的账单平均点击次数' ,
	md_loan_1mth_offline_5m_bill_detail_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins我的账单账单详情平均点击次数' ,
	md_loan_1mth_offline_5m_repay_rule_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins还款规则平均点击次数' ,
	md_loan_1mth_offline_5m_prepay_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins提前还款平均点击次数' ,
	md_loan_1mth_offline_5m_thismth_bill_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins本月待还平均点击次数' ,
	md_loan_1mth_offline_5m_nextmth_bill_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins下月待还平均点击次数' ,
	md_loan_1mth_offline_5m_fail_reason_click_avg_cnt DOUBLE comment  '近1个月订单成功前5mins失败原因平均点击次数' ,
	md_loan_1mth_offline_5m_repay_plan_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins还款计划平均曝光次数' ,
	md_loan_1mth_offline_5m_mybill_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins我的账单平均曝光次数' ,
	md_loan_1mth_offline_5m_bill_detail_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins我的账单账单详情平均曝光次数' ,
	md_loan_1mth_offline_5m_repay_rule_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins还款规则平均曝光次数' ,
	md_loan_1mth_offline_5m_prepay_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins提前还款平均曝光次数' ,
	md_loan_1mth_offline_5m_thismth_bill_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins本月待还平均曝光次数' ,
	md_loan_1mth_offline_5m_nextmth_bill_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins下月待还平均曝光次数' ,
	md_loan_1mth_offline_5m_fail_reason_show_avg_cnt DOUBLE comment  '近1个月订单成功前5mins失败原因平均曝光次数' ,
	md_loan_1mth_offline_5m_avg_click_stay_time DOUBLE comment  '近1个月订单成功前5mins平均点击停留时长' ,
	md_loan_1mth_offline_5m_avg_show_stay_time DOUBLE comment  '近1个月订单成功前5mins平均曝光停留时长' ,
	md_loan_1mth_offline_5m_core_avg_click_stay_time DOUBLE comment  '近1个月订单成功前5mins核心页面平均点击停留时长' ,
	md_loan_1mth_offline_5m_noncore_avg_click_stay_time DOUBLE comment  '近1个月订单成功前5mins非核心页面平均点击停留时长' ,
	md_loan_1mth_offline_5m_price_sensitive_avg_show_stay_time DOUBLE comment  '近1个月订单成功前5mins定价敏感（优惠券、会员权益）类页面平均曝光停留时长' ,
	md_loan_1mth_offline_5m_period_avg_click_stay_time DOUBLE comment  '近1个月订单成功前5mins选择期数平均点击停留时长' ,
	md_loan_1mth_offline_5m_period_3_avg_click_stay_time DOUBLE comment  '近1个月订单成功前5mins选择期数为3期平均点击停留时长' ,
	md_loan_1mth_offline_5m_period_6_avg_click_stay_time DOUBLE comment  '近1个月订单成功前5mins选择期数为6期平均点击停留时长'
)comment '贷中宽表24_老埋点离线版特征,对全量复借户打分'
partitioned by (ds string)
;


drop table if exists dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_1mth_tmp;
create table dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_1mth_tmp as 

with base_1mth as (select d.uid,d.mdl_dte,d.ds,
       e.ord_no as ord_no_bf,e.ord_crt_tim,f.request_time,event_type_mapping,event_name
         from (            select uid
                   ,mdl_dte
                   ,ds 
            from(
                        select  uid
                                ,date_add(to_date(ds,'yyyymmdd'),1) as mdl_dte
                                ,ds
                        from    dbus.dbus_f_yu_cus_grp_day_list_new_df
                        where   ds = '${bizdate}'
                        and     grp not in ( 'A1-睡眠户' ) 
            
                        union all
            
                        select uid
                               ,date_format(date_add(to_date(ds,'yyyymmdd'),1),'yyyy-MM-dd') as mdl_dte
                               ,ds 
                        from pdm_risk_ftr.blue_customer_group_df 
                        where  ds='${bizdate}' 
                               and blue_customer_flag='B2'
                               
               ) group by uid
                          ,mdl_dte
                          ,ds) d
         left join( --近1月订单
                    select order_no as ord_no, apply_record_crt_time as ord_crt_tim,uid, date(apply_record_crt_time) as mdl_dte
                    from ${dwt}.dwt_heavy_order_df where ds = '${bizdate}'    
                --     select *
                --     from pdm_risk.pdm_risk_dz_trade_model_all_sample_di
                --     where ds>=date_format(last_day(add_months(date_format(to_date('${bizdate}','yyyymmdd'),'yyyy-MM-dd'),-1)),'yyyyMMdd') -- 月末分区
                --           and ds <=date_format(last_day(date_format(to_date('${bizdate}','yyyymmdd'),'yyyy-MM-dd')),'yyyyMMdd') 
                        
                ) e
         on d.uid=e.uid and add_months(d.mdl_dte,-1) <= e.mdl_dte and d.mdl_dte > e.mdl_dte
         left join -- 近一个月订单的埋点
                 (
                   select * 
                   from dwa_risk.dwa_risk_dz_model_final_old_maidian_mid_di 
                   where ds>=date_format(add_months(date_format(to_date('${bizdate}','yyyymmdd'),'yyyy-MM-dd'),-1),'yyyyMMdd')  
                         and ds <='${bizdate}'
                ) f
            on e.ord_no=f.ord_no 
)


select  uid,mdl_dte

-- 统计类
        ,sum(md_loan_stay_time) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_avg_stay_time
        ,sum(md_loan_1mth_offline_5m_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_core_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_core_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_noncore_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_noncore_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_core_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_core_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_noncore_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_noncore_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_lack_ability_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_lack_ability_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_lack_ability_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_lack_ability_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_complain_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_complain_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_complain_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_complain_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_price_sensitive_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_price_sensitive_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_price_sensitive_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_price_sensitive_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_focus_credit_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_focus_credit_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_focus_credit_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_focus_credit_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_amtinput_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1_amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1_amtinput_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1_lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1_lendall_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2_amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2_amtinput_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2_lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2_lendall_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1amtinput_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1lendall_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2amtinput_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2lendall_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_amt_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_amt_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_3_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_3_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_6_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_6_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_12_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_12_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_add_paycard_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_add_paycard_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_change_lendcard_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_change_lendcard_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_change_paycard_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_change_paycard_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_coupon_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_coupon_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_payanytime_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_payanytime_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_paymth_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_paymth_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_payfree_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_payfree_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_vip_details_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_vip_details_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_vipchoose_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_vipchoose_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_loanuse_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_loanuse_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_online_service_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_online_service_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_avg_income_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_avg_income_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_amtinput_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1_amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1_amtinput_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1_lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1_lendall_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2_amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2_amtinput_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2_lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2_lendall_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1amtinput_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s1lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s1lendall_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2amtinput_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_s2lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_s2lendall_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_amt_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_amt_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_3_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_3_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_6_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_6_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_period_12_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_12_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_addpaycard_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_addpaycard_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_changelendcard_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_changelendcard_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_changepaycard_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_changepaycard_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_coupon_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_coupon_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_payanytime_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_payanytime_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_paymth_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_paymth_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_payfree_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_payfree_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_vipcheck_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_vipcheck_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_vipchoose_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_vipchoose_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_loanuse_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_loanuse_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_onservice1_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_onservice1_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_income_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_income_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_repay_plan_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_repay_plan_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_mybill_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_mybill_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_bill_detail_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_bill_detail_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_repay_rule_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_repay_rule_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_prepay_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_prepay_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_thismth_bill_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_thismth_bill_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_nextmth_bill_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_nextmth_bill_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_fail_reason_click_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_fail_reason_click_avg_cnt
        ,sum(md_loan_1mth_offline_5m_repay_plan_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_repay_plan_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_mybill_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_mybill_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_bill_detail_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_bill_detail_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_repay_rule_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_repay_rule_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_prepay_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_prepay_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_thismth_bill_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_thismth_bill_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_nextmth_bill_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_nextmth_bill_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_fail_reason_show_cnt) /count(distinct ord_no_bf) as md_loan_1mth_offline_5m_fail_reason_show_avg_cnt
        ,sum(md_loan_1mth_offline_5m_click_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_avg_click_stay_time
        ,sum(md_loan_1mth_offline_5m_show_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_avg_show_stay_time
        ,sum(md_loan_1mth_offline_5m_core_click_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_core_avg_click_stay_time
        ,sum(md_loan_1mth_offline_5m_noncore_click_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_noncore_avg_click_stay_time
        ,sum(md_loan_1mth_offline_5m_price_sensitive_show_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_price_sensitive_avg_show_stay_time
        ,sum(md_loan_1mth_offline_5m_period_click_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_avg_click_stay_time
        ,sum(md_loan_1mth_offline_5m_period_3_click_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_3_avg_click_stay_time
        ,sum(md_loan_1mth_offline_5m_period_6_click_stay_time) / count(distinct ord_no_bf) as md_loan_1mth_offline_5m_period_6_avg_click_stay_time

from (

    select aa.*,bb.md_loan_stay_time
           ,md_loan_1mth_offline_5m_click_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_click_stay_time
           ,md_loan_1mth_offline_5m_show_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_show_stay_time
           ,md_loan_1mth_offline_5m_core_click_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_core_click_stay_time
           ,md_loan_1mth_offline_5m_noncore_click_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_noncore_click_stay_time
           ,md_loan_1mth_offline_5m_price_sensitive_show_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_price_sensitive_show_stay_time
           ,md_loan_1mth_offline_5m_period_click_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_period_click_stay_time
           ,md_loan_1mth_offline_5m_period_3_click_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_period_3_click_stay_time
           ,md_loan_1mth_offline_5m_period_6_click_cnt / bb.md_loan_stay_time as md_loan_1mth_offline_5m_period_6_click_stay_time

    from(
        select 
                -- 统计类
                a.uid,a.mdl_dte
                ,a.ord_no_bf
                -- 总计
                ,count(case when event_type_mapping in ('elementClick','buttonClick') then request_time else null end) as md_loan_1mth_offline_5m_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') then request_time else null end) as md_loan_1mth_offline_5m_show_cnt 
                
                -- 核心非核心类
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(输入金额_完成|选择期数|优惠券|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡|我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_1mth_offline_5m_core_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(随借随还|每月等额|灵活还款|会员权益|选择借款用途|在线客服|平均月收入).' then request_time else null end) as md_loan_1mth_offline_5m_noncore_click_cnt 
                -- count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(随借随还|每月等额|灵活还款|会员权益|选择借款用途|在线客服|平均月收入|我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_1mth_offline_5m_noncore_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(输入金额_完成|选择期数|优惠券|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡|我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_1mth_offline_5m_core_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(随借随还|每月等额|灵活还款|会员权益|选择借款用途|在线客服|平均月收入).' then request_time else null end) as md_loan_1mth_offline_5m_noncore_show_cnt 
                
                
                -- 还款能力不足类（灵活还款、更新收款卡还款卡）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(灵活还款|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_1mth_offline_5m_lack_ability_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(灵活还款|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_1mth_offline_5m_lack_ability_show_cnt 
                
                -- 投诉倾向类（在线客服）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_1mth_offline_5m_complain_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_1mth_offline_5m_complain_show_cnt 
                
                -- 定价敏感类（优惠券、会员权益）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(优惠券|会员权益).' then request_time else null end) as md_loan_1mth_offline_5m_price_sensitive_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(优惠券|会员权益).' then request_time else null end) as md_loan_1mth_offline_5m_price_sensitive_show_cnt 
                
                -- 期限敏感类（频繁选择期数）
                -- md_loan_1mth_offline_5m_period_click_cnt
                -- md_loan_1mth_offline_5m_period_show_cnt
                
                -- 借款谨慎类（频繁输入借款金额）
                -- md_loan_1mth_offline_5m_amtinput_click_cnt
                -- md_loan_1mth_offline_5m_amtinput_show_cnt
                
                -- 重视信用类（我的账单、借还详情页、待还账单列表）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_1mth_offline_5m_focus_credit_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_1mth_offline_5m_focus_credit_show_cnt 
                

                --**********************************************--
                -- 点击次数
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步.输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s1_amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步.全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s1_lendall_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步.输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s2_amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步.全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s2_lendall_click_cnt
                
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步|输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s1amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步|全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s1lendall_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步|输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s2amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步|全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s2lendall_click_cnt
                
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择金额_推荐金额.' then request_time else null end) as md_loan_1mth_offline_5m_amt_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数.' then request_time else null end) as md_loan_1mth_offline_5m_period_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数_3.' then request_time else null end) as md_loan_1mth_offline_5m_period_3_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数_6.' then request_time else null end) as md_loan_1mth_offline_5m_period_6_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数_12.' then request_time else null end) as md_loan_1mth_offline_5m_period_12_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(更改收款储蓄卡_添加储蓄卡|更改收款信用卡_添加信用卡).' then request_time else null end) as md_loan_1mth_offline_5m_add_paycard_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_1mth_offline_5m_change_lendcard_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(更改还款储蓄卡_点击储蓄卡).' then request_time else null end) as md_loan_1mth_offline_5m_change_paycard_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(优惠券_点击|优惠券提示_点击|优惠券_有钱任性).' then request_time else null end) as md_loan_1mth_offline_5m_coupon_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(随借随还_选中|随借随还_点击).' then request_time else null end) as md_loan_1mth_offline_5m_payanytime_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(每月等额_点击|每月等额tab_点击).' then request_time else null end) as md_loan_1mth_offline_5m_paymth_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(灵活还款_点击|灵活还款tab_点击).' then request_time else null end) as md_loan_1mth_offline_5m_payfree_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(会员权益详情_点击|查看详情_点击_).' then request_time else null end) as md_loan_1mth_offline_5m_vip_details_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '._选中提交.' then request_time else null end) as md_loan_1mth_offline_5m_vipchoose_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择借款用途_点击.' then request_time else null end) as md_loan_1mth_offline_5m_loanuse_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_1mth_offline_5m_online_service_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(平均月收入点击|平均月收入_点击).' then request_time else null end) as md_loan_1mth_offline_5m_avg_income_click_cnt
                
                -- 曝光次数
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步.输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s1_amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步.全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s1_lendall_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步.输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s2_amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步.全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s2_lendall_show_cnt
                
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步|输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s1amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步|全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s1lendall_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步|输入金额_完成).' then request_time else null end) as md_loan_1mth_offline_5m_s2amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步|全部借出).' then request_time else null end) as md_loan_1mth_offline_5m_s2lendall_show_cnt
                
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择金额_推荐金额.' then request_time else null end) as md_loan_1mth_offline_5m_amt_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数.' then request_time else null end) as md_loan_1mth_offline_5m_period_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数_3.' then request_time else null end) as md_loan_1mth_offline_5m_period_3_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数_6.' then request_time else null end) as md_loan_1mth_offline_5m_period_6_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数_12.' then request_time else null end) as md_loan_1mth_offline_5m_period_12_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.更改收款储蓄卡_添加储蓄卡|更改收款信用卡_添加信用卡.' then request_time else null end) as md_loan_1mth_offline_5m_addpaycard_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_1mth_offline_5m_changelendcard_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(更改还款储蓄卡).' then request_time else null end) as md_loan_1mth_offline_5m_changepaycard_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(优惠券|优惠券提示|优惠券_有钱任性).' then request_time else null end) as md_loan_1mth_offline_5m_coupon_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(随借随还_选中|随借随还).' then request_time else null end) as md_loan_1mth_offline_5m_payanytime_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(每月等额|每月等额tab).' then request_time else null end) as md_loan_1mth_offline_5m_paymth_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(灵活还款|灵活还款tab).' then request_time else null end) as md_loan_1mth_offline_5m_payfree_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(会员权益详情|查看详情_).' then request_time else null end) as md_loan_1mth_offline_5m_vipcheck_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '._选中提交.' then request_time else null end) as md_loan_1mth_offline_5m_vipchoose_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择借款用途.' then request_time else null end) as md_loan_1mth_offline_5m_loanuse_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_1mth_offline_5m_onservice1_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(平均月收入|平均月收入).' then request_time else null end) as md_loan_1mth_offline_5m_income_show_cnt
                
                -- 还款点击
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(还款计划点击|还款计划_点击).' then request_time else null end) as md_loan_1mth_offline_5m_repay_plan_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单).' then request_time else null end) as md_loan_1mth_offline_5m_mybill_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单_近期待还页|待还账单列表_分期详细).' then request_time else null end) as md_loan_1mth_offline_5m_bill_detail_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.借还详情页.还款规则.' then request_time else null end) as md_loan_1mth_offline_5m_repay_rule_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.借还详情页.提前还款.' then request_time else null end) as md_loan_1mth_offline_5m_prepay_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单.近期待还页.本月|我的账单_近期待还页_近31).' then request_time else null end) as md_loan_1mth_offline_5m_thismth_bill_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单_近期待还页_下月).' then request_time else null end) as md_loan_1mth_offline_5m_nextmth_bill_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.查看失败原因.' then request_time else null end) as md_loan_1mth_offline_5m_fail_reason_click_cnt 
                
                --还款曝光
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(还款计划|还款计划).' then request_time else null end) as md_loan_1mth_offline_5m_repay_plan_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单).' then request_time else null end) as md_loan_1mth_offline_5m_mybill_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单_近期待还页|待还账单列表_分期详细).' then request_time else null end) as md_loan_1mth_offline_5m_bill_detail_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.借还详情页.还款规则.' then request_time else null end) as md_loan_1mth_offline_5m_repay_rule_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.借还详情页.提前还款.' then request_time else null end) as md_loan_1mth_offline_5m_prepay_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单.近期待还页.本月|我的账单_近期待还页_近31).' then request_time else null end) as md_loan_1mth_offline_5m_thismth_bill_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单_近期待还页_下月).' then request_time else null end) as md_loan_1mth_offline_5m_nextmth_bill_show_cnt 
                
                -- 失败次数
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.查看失败原因.' then request_time else null end) as md_loan_1mth_offline_5m_fail_reason_show_cnt


        from 
       
         base_1mth a

        group by a.uid,a.mdl_dte,a.ord_no_bf
    ) aa
    left join(
    select --ord_no
            uid,mdl_dte
            ,ord_no_bf,md_loan_stay_time
    from(
            select --ord_no
                    uid,mdl_dte
                    ,ord_no_bf
                    ,row_number() over(partition by ord_no_bf order by request_time asc) as rn
                    ,datediff(ord_crt_tim,request_time,'ss') as md_loan_stay_time

            from base_1mth
            where event_type_mapping == 'appStart'
            
            ) where rn=1 
    and md_loan_stay_time<=300

    ) bb
    on aa.ord_no_bf=bb.ord_no_bf

)
group by uid,mdl_dte
;


--- 近3月订单
drop table if exists dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_3mth_tmp;
create table dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_3mth_tmp as 

with base_3mth as (select d.uid,d.mdl_dte,d.ds,
       e.ord_no as ord_no_bf,e.ord_crt_tim,f.request_time,event_type_mapping,event_name
         from (            select uid
                   ,mdl_dte
                   ,ds 
            from(
                        select  uid
                                ,date_add(to_date(ds,'yyyymmdd'),1) as mdl_dte
                                ,ds
                        from    dbus.dbus_f_yu_cus_grp_day_list_new_df
                        where   ds = '${bizdate}'
                        and     grp not in ( 'A1-睡眠户' ) 
            
                        union all
            
                        select uid
                               ,date_format(date_add(to_date(ds,'yyyymmdd'),1),'yyyy-MM-dd') as mdl_dte
                               ,ds 
                        from pdm_risk_ftr.blue_customer_group_df 
                        where  ds='${bizdate}' 
                               and blue_customer_flag='B2'
                               
               ) group by uid
                          ,mdl_dte
                          ,ds) d
         left join( --近3月订单
                    select order_no as ord_no, apply_record_crt_time as ord_crt_tim,uid, date(apply_record_crt_time) as mdl_dte
                    from ${dwt}.dwt_heavy_order_df where ds = '${bizdate}'  
                -- 20241206 chenxiao 替换pdm_risk_dz_trade_model_all_sample_di为更底层的fct_txn_heavy_loancore_order_df，提前宽表的产出时间
                --     select *
                --     from pdm_risk.pdm_risk_dz_trade_model_all_sample_di
                --     where ds>=date_format(last_day(add_months(date_format(to_date('${bizdate}','yyyymmdd'),'yyyy-MM-dd'),-3)),'yyyyMMdd') -- 月末分区
                --           and ds <=date_format(last_day(date_format(to_date('${bizdate}','yyyymmdd'),'yyyy-MM-dd')),'yyyyMMdd')   
                ) e
         on d.uid=e.uid and add_months(d.mdl_dte,-3) <= e.mdl_dte and d.mdl_dte > e.mdl_dte
         left join (
                 select * 
                 from dwa_risk.dwa_risk_dz_model_final_old_maidian_mid_di 
                 where ds>=date_format(add_months(date_format(to_date('${bizdate}','yyyymmdd'),'yyyy-MM-dd'),-3),'yyyyMMdd')  and ds <='${bizdate}'
                 ) f
            on e.ord_no=f.ord_no 
)


select  uid,mdl_dte

-- 统计类
        ,sum(md_loan_stay_time) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_avg_stay_time
        ,sum(md_loan_3mth_offline_5m_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_core_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_core_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_noncore_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_noncore_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_core_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_core_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_noncore_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_noncore_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_lack_ability_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_lack_ability_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_lack_ability_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_lack_ability_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_complain_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_complain_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_complain_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_complain_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_price_sensitive_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_price_sensitive_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_price_sensitive_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_price_sensitive_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_focus_credit_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_focus_credit_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_focus_credit_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_focus_credit_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_amtinput_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1_amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1_amtinput_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1_lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1_lendall_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2_amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2_amtinput_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2_lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2_lendall_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1amtinput_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1lendall_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2amtinput_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2amtinput_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2lendall_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2lendall_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_amt_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_amt_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_3_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_3_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_6_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_6_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_12_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_12_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_add_paycard_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_add_paycard_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_change_lendcard_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_change_lendcard_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_change_paycard_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_change_paycard_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_coupon_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_coupon_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_payanytime_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_payanytime_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_paymth_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_paymth_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_payfree_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_payfree_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_vip_details_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_vip_details_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_vipchoose_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_vipchoose_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_loanuse_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_loanuse_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_online_service_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_online_service_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_avg_income_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_avg_income_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_amtinput_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1_amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1_amtinput_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1_lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1_lendall_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2_amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2_amtinput_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2_lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2_lendall_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1amtinput_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s1lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s1lendall_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2amtinput_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2amtinput_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_s2lendall_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_s2lendall_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_amt_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_amt_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_3_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_3_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_6_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_6_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_period_12_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_12_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_addpaycard_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_addpaycard_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_changelendcard_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_changelendcard_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_changepaycard_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_changepaycard_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_coupon_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_coupon_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_payanytime_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_payanytime_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_paymth_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_paymth_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_payfree_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_payfree_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_vipcheck_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_vipcheck_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_vipchoose_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_vipchoose_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_loanuse_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_loanuse_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_onservice1_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_onservice1_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_income_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_income_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_repay_plan_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_repay_plan_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_mybill_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_mybill_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_bill_detail_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_bill_detail_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_repay_rule_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_repay_rule_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_prepay_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_prepay_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_thismth_bill_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_thismth_bill_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_nextmth_bill_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_nextmth_bill_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_fail_reason_click_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_fail_reason_click_avg_cnt
        ,sum(md_loan_3mth_offline_5m_repay_plan_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_repay_plan_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_mybill_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_mybill_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_bill_detail_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_bill_detail_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_repay_rule_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_repay_rule_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_prepay_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_prepay_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_thismth_bill_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_thismth_bill_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_nextmth_bill_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_nextmth_bill_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_fail_reason_show_cnt) /count(distinct ord_no_bf) as md_loan_3mth_offline_5m_fail_reason_show_avg_cnt
        ,sum(md_loan_3mth_offline_5m_click_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_avg_click_stay_time
        ,sum(md_loan_3mth_offline_5m_show_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_avg_show_stay_time
        ,sum(md_loan_3mth_offline_5m_core_click_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_core_avg_click_stay_time
        ,sum(md_loan_3mth_offline_5m_noncore_click_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_noncore_avg_click_stay_time
        ,sum(md_loan_3mth_offline_5m_price_sensitive_show_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_price_sensitive_avg_show_stay_time
        ,sum(md_loan_3mth_offline_5m_period_click_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_avg_click_stay_time
        ,sum(md_loan_3mth_offline_5m_period_3_click_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_3_avg_click_stay_time
        ,sum(md_loan_3mth_offline_5m_period_6_click_stay_time) / count(distinct ord_no_bf) as md_loan_3mth_offline_5m_period_6_avg_click_stay_time

from (

    select aa.*,bb.md_loan_stay_time
           ,md_loan_3mth_offline_5m_click_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_click_stay_time
           ,md_loan_3mth_offline_5m_show_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_show_stay_time
           ,md_loan_3mth_offline_5m_core_click_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_core_click_stay_time
           ,md_loan_3mth_offline_5m_noncore_click_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_noncore_click_stay_time
           ,md_loan_3mth_offline_5m_price_sensitive_show_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_price_sensitive_show_stay_time
           ,md_loan_3mth_offline_5m_period_click_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_period_click_stay_time
           ,md_loan_3mth_offline_5m_period_3_click_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_period_3_click_stay_time
           ,md_loan_3mth_offline_5m_period_6_click_cnt / bb.md_loan_stay_time as md_loan_3mth_offline_5m_period_6_click_stay_time

    from(
        select 
                -- 统计类
                a.uid,a.mdl_dte
                ,a.ord_no_bf
                -- 总计
                ,count(case when event_type_mapping in ('elementClick','buttonClick') then request_time else null end) as md_loan_3mth_offline_5m_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') then request_time else null end) as md_loan_3mth_offline_5m_show_cnt 
                
                -- 核心非核心类
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(输入金额_完成|选择期数|优惠券|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡|我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_3mth_offline_5m_core_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(随借随还|每月等额|灵活还款|会员权益|选择借款用途|在线客服|平均月收入).' then request_time else null end) as md_loan_3mth_offline_5m_noncore_click_cnt 
                -- count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(随借随还|每月等额|灵活还款|会员权益|选择借款用途|在线客服|平均月收入|我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_3mth_offline_5m_noncore_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(输入金额_完成|选择期数|优惠券|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡|我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_3mth_offline_5m_core_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(随借随还|每月等额|灵活还款|会员权益|选择借款用途|在线客服|平均月收入).' then request_time else null end) as md_loan_3mth_offline_5m_noncore_show_cnt 
                
                
                -- 还款能力不足类（灵活还款、更新收款卡还款卡）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(灵活还款|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_3mth_offline_5m_lack_ability_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(灵活还款|添加储蓄卡|添加信用卡|更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_3mth_offline_5m_lack_ability_show_cnt 
                
                -- 投诉倾向类（在线客服）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_3mth_offline_5m_complain_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_3mth_offline_5m_complain_show_cnt 
                
                -- 定价敏感类（优惠券、会员权益）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(优惠券|会员权益).' then request_time else null end) as md_loan_3mth_offline_5m_price_sensitive_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(优惠券|会员权益).' then request_time else null end) as md_loan_3mth_offline_5m_price_sensitive_show_cnt 
                
                -- 期限敏感类（频繁选择期数）
                -- md_loan_3mth_offline_5m_period_click_cnt
                -- md_loan_3mth_offline_5m_period_show_cnt
                
                -- 借款谨慎类（频繁输入借款金额）
                -- md_loan_3mth_offline_5m_amtinput_click_cnt
                -- md_loan_3mth_offline_5m_amtinput_show_cnt
                
                -- 重视信用类（我的账单、借还详情页、待还账单列表）
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_3mth_offline_5m_focus_credit_click_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单|借还详情页|待还账单).' then request_time else null end) as md_loan_3mth_offline_5m_focus_credit_show_cnt 
                

                --**********************************************--
                -- 点击次数
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步.输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s1_amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步.全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s1_lendall_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步.输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s2_amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步.全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s2_lendall_click_cnt
                
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步|输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s1amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第一步|全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s1lendall_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步|输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s2amtinput_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(第二步|全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s2lendall_click_cnt
                
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择金额_推荐金额.' then request_time else null end) as md_loan_3mth_offline_5m_amt_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数.' then request_time else null end) as md_loan_3mth_offline_5m_period_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数_3.' then request_time else null end) as md_loan_3mth_offline_5m_period_3_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数_6.' then request_time else null end) as md_loan_3mth_offline_5m_period_6_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择期数_12.' then request_time else null end) as md_loan_3mth_offline_5m_period_12_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(更改收款储蓄卡_添加储蓄卡|更改收款信用卡_添加信用卡).' then request_time else null end) as md_loan_3mth_offline_5m_add_paycard_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_3mth_offline_5m_change_lendcard_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(更改还款储蓄卡_点击储蓄卡).' then request_time else null end) as md_loan_3mth_offline_5m_change_paycard_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(优惠券_点击|优惠券提示_点击|优惠券_有钱任性).' then request_time else null end) as md_loan_3mth_offline_5m_coupon_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(随借随还_选中|随借随还_点击).' then request_time else null end) as md_loan_3mth_offline_5m_payanytime_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(每月等额_点击|每月等额tab_点击).' then request_time else null end) as md_loan_3mth_offline_5m_paymth_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(灵活还款_点击|灵活还款tab_点击).' then request_time else null end) as md_loan_3mth_offline_5m_payfree_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(会员权益详情_点击|查看详情_点击_).' then request_time else null end) as md_loan_3mth_offline_5m_vip_details_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '._选中提交.' then request_time else null end) as md_loan_3mth_offline_5m_vipchoose_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.选择借款用途_点击.' then request_time else null end) as md_loan_3mth_offline_5m_loanuse_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_3mth_offline_5m_online_service_click_cnt
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(平均月收入点击|平均月收入_点击).' then request_time else null end) as md_loan_3mth_offline_5m_avg_income_click_cnt
                
                -- 曝光次数
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步.输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s1_amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步.全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s1_lendall_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步.输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s2_amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步.全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s2_lendall_show_cnt
                
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步|输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s1amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第一步|全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s1lendall_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步|输入金额_完成).' then request_time else null end) as md_loan_3mth_offline_5m_s2amtinput_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(第二步|全部借出).' then request_time else null end) as md_loan_3mth_offline_5m_s2lendall_show_cnt
                
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择金额_推荐金额.' then request_time else null end) as md_loan_3mth_offline_5m_amt_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数.' then request_time else null end) as md_loan_3mth_offline_5m_period_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数_3.' then request_time else null end) as md_loan_3mth_offline_5m_period_3_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数_6.' then request_time else null end) as md_loan_3mth_offline_5m_period_6_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择期数_12.' then request_time else null end) as md_loan_3mth_offline_5m_period_12_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.更改收款储蓄卡_添加储蓄卡|更改收款信用卡_添加信用卡.' then request_time else null end) as md_loan_3mth_offline_5m_addpaycard_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(更改收款储蓄卡|更改收款信用卡).' then request_time else null end) as md_loan_3mth_offline_5m_changelendcard_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(更改还款储蓄卡).' then request_time else null end) as md_loan_3mth_offline_5m_changepaycard_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(优惠券|优惠券提示|优惠券_有钱任性).' then request_time else null end) as md_loan_3mth_offline_5m_coupon_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(随借随还_选中|随借随还).' then request_time else null end) as md_loan_3mth_offline_5m_payanytime_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(每月等额|每月等额tab).' then request_time else null end) as md_loan_3mth_offline_5m_paymth_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(灵活还款|灵活还款tab).' then request_time else null end) as md_loan_3mth_offline_5m_payfree_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(会员权益详情|查看详情_).' then request_time else null end) as md_loan_3mth_offline_5m_vipcheck_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '._选中提交.' then request_time else null end) as md_loan_3mth_offline_5m_vipchoose_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.选择借款用途.' then request_time else null end) as md_loan_3mth_offline_5m_loanuse_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.在线客服.' then request_time else null end) as md_loan_3mth_offline_5m_onservice1_show_cnt
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(平均月收入|平均月收入).' then request_time else null end) as md_loan_3mth_offline_5m_income_show_cnt
                
                -- 还款点击
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(还款计划点击|还款计划_点击).' then request_time else null end) as md_loan_3mth_offline_5m_repay_plan_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单).' then request_time else null end) as md_loan_3mth_offline_5m_mybill_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单_近期待还页|待还账单列表_分期详细).' then request_time else null end) as md_loan_3mth_offline_5m_bill_detail_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.借还详情页.还款规则.' then request_time else null end) as md_loan_3mth_offline_5m_repay_rule_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.借还详情页.提前还款.' then request_time else null end) as md_loan_3mth_offline_5m_prepay_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单.近期待还页.本月|我的账单_近期待还页_近31).' then request_time else null end) as md_loan_3mth_offline_5m_thismth_bill_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.(我的账单_近期待还页_下月).' then request_time else null end) as md_loan_3mth_offline_5m_nextmth_bill_click_cnt 
                ,count(case when event_type_mapping in ('elementClick','buttonClick') and event_name rlike '.查看失败原因.' then request_time else null end) as md_loan_3mth_offline_5m_fail_reason_click_cnt 
                
                --还款曝光
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(还款计划|还款计划).' then request_time else null end) as md_loan_3mth_offline_5m_repay_plan_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单).' then request_time else null end) as md_loan_3mth_offline_5m_mybill_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单_近期待还页|待还账单列表_分期详细).' then request_time else null end) as md_loan_3mth_offline_5m_bill_detail_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.借还详情页.还款规则.' then request_time else null end) as md_loan_3mth_offline_5m_repay_rule_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.借还详情页.提前还款.' then request_time else null end) as md_loan_3mth_offline_5m_prepay_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单.近期待还页.本月|我的账单_近期待还页_近31).' then request_time else null end) as md_loan_3mth_offline_5m_thismth_bill_show_cnt 
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.(我的账单_近期待还页_下月).' then request_time else null end) as md_loan_3mth_offline_5m_nextmth_bill_show_cnt 
                
                -- 失败次数
                ,count(case when event_type_mapping in ('elementShow','pageView') and event_name rlike '.查看失败原因.' then request_time else null end) as md_loan_3mth_offline_5m_fail_reason_show_cnt


        from 
       
         base_3mth a

        group by a.uid,a.mdl_dte,a.ord_no_bf
    ) aa
    left join(
    select --ord_no
            uid,mdl_dte
            ,ord_no_bf,md_loan_stay_time
    from(
            select --ord_no
                    uid,mdl_dte
                    ,ord_no_bf
                    ,row_number() over(partition by ord_no_bf order by request_time asc) as rn
                    ,datediff(ord_crt_tim,request_time,'ss') as md_loan_stay_time

            from base_3mth
            where event_type_mapping == 'appStart'
            
            ) where rn=1 
    and md_loan_stay_time<=300

    ) bb
    on aa.ord_no_bf=bb.ord_no_bf

)
group by uid,mdl_dte
;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_24old_maidian_df partition(ds='${bizdate}')
select a.uid,a.mdl_dte,`(uid|mdl_dte)?+.+`
from dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_3mth_tmp a
left join dwa_risk.dwa_risk_dz_model_final_24old_maidian_offline_1mth_tmp b
on a.uid=b.uid and a.mdl_dte=b.mdl_dte
;

-- select * from dwa_risk.dwa_risk_dz_model_final_24old_maidian_df where ds='20230121' limit 100
-- feature-copilot:node-end ordinal=0
