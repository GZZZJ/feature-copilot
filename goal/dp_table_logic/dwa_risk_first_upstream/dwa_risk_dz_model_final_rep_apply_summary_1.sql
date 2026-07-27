-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_rep_apply_summary_1
-- node_id: n_4039771952878190592
-- task_name: dwa_risk_dz_model_final_rep_apply_summary_1
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_rep_apply_summary_1.json
-- source_json_sha256: ac001307db85e70fe5a2ad81c3848c57809788990d6a5c79a74daf98b05f092b
-- upstream_table: dwa_risk.dwa_risk_f_repay_apply_stage_plan_detail
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_1_tmp1
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_1_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 任俊峰
--创建日期: 2022-09-22 15:12:12
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
m1_rep_apl_cnt double comment '近1个月扣款次数',
m3_rep_apl_cnt double comment '近3个月扣款次数',
m6_rep_apl_cnt double comment '近6个月扣款次数',
m1_manual_rep_apl_cnt double comment '近1个月用户主动还款_扣款次数',
m3_manual_rep_apl_cnt double comment '近3个月用户主动还款_扣款次数',
m6_manual_rep_apl_cnt double comment '近6个月用户主动还款_扣款次数',
m1_ao_offline_rep_apl_cnt double comment '近1个月(数禾对公)线下还款_扣款次数',
m3_ao_offline_rep_apl_cnt double comment '近3个月(数禾对公)线下还款_扣款次数',
m6_ao_offline_rep_apl_cnt double comment '近6个月(数禾对公)线下还款_扣款次数',
m1_manual_deduct_rep_apl_cnt double comment '近1个月人工扣款_扣款次数',
m3_manual_deduct_rep_apl_cnt double comment '近3个月人工扣款_扣款次数',
m6_manual_deduct_rep_apl_cnt double comment '近6个月人工扣款_扣款次数',
m1_normal_batch_rep_apl_cnt double comment '近1个月常规批扣_扣款次数',
m3_normal_batch_rep_apl_cnt double comment '近3个月常规批扣_扣款次数',
m6_normal_batch_rep_apl_cnt double comment '近6个月常规批扣_扣款次数',
m1_add_bathch_rep_apl_cnt double comment '近1个月逾期批扣_扣款次数',
m3_add_bathch_rep_apl_cnt double comment '近3个月逾期批扣_扣款次数',
m6_add_bathch_rep_apl_cnt double comment '近6个月逾期批扣_扣款次数',
m1_rep_apl_suc_cnt double comment '近1个月扣款成功次数',
m3_rep_apl_suc_cnt double comment '近3个月扣款成功次数',
m6_rep_apl_suc_cnt double comment '近6个月扣款成功次数',
m1_manual_rep_apl_suc_cnt double comment '近1个月用户主动还款_扣款成功次数',
m3_manual_rep_apl_suc_cnt double comment '近3个月用户主动还款_扣款成功次数',
m6_manual_rep_apl_suc_cnt double comment '近6个月用户主动还款_扣款成功次数',
m1_ao_offline_rep_apl_suc_cnt double comment '近1个月(数禾对公)线下还款_扣款成功次数',
m3_ao_offline_rep_apl_suc_cnt double comment '近3个月(数禾对公)线下还款_扣款成功次数',
m6_ao_offline_rep_apl_suc_cnt double comment '近6个月(数禾对公)线下还款_扣款成功次数',
m1_manual_deduct_rep_apl_suc_cnt double comment '近1个月人工扣款_扣款成功次数',
m3_manual_deduct_rep_apl_suc_cnt double comment '近3个月人工扣款_扣款成功次数',
m6_manual_deduct_rep_apl_suc_cnt double comment '近6个月人工扣款_扣款成功次数',
m1_normal_batch_rep_apl_suc_cnt double comment '近1个月常规批扣_扣款成功次数',
m3_normal_batch_rep_apl_suc_cnt double comment '近3个月常规批扣_扣款成功次数',
m6_normal_batch_rep_apl_suc_cnt double comment '近6个月常规批扣_扣款成功次数',
m1_add_bathch_rep_apl_suc_cnt double comment '近1个月逾期批扣_扣款成功次数',
m3_add_bathch_rep_apl_suc_cnt double comment '近3个月逾期批扣_扣款成功次数',
m6_add_bathch_rep_apl_suc_cnt double comment '近6个月逾期批扣_扣款成功次数',
m1_rep_apl_fal_cnt double comment '近1个月扣款失败次数',
m3_rep_apl_fal_cnt double comment '近3个月扣款失败次数',
m6_rep_apl_fal_cnt double comment '近6个月扣款失败次数',
m1_manual_rep_apl_fal_cnt double comment '近1个月用户主动还款_扣款失败次数',
m3_manual_rep_apl_fal_cnt double comment '近3个月用户主动还款_扣款失败次数',
m6_manual_rep_apl_fal_cnt double comment '近6个月用户主动还款_扣款失败次数',
m1_ao_offline_rep_apl_fal_cnt double comment '近1个月(数禾对公)线下还款_扣款失败次数',
m3_ao_offline_rep_apl_fal_cnt double comment '近3个月(数禾对公)线下还款_扣款失败次数',
m6_ao_offline_rep_apl_fal_cnt double comment '近6个月(数禾对公)线下还款_扣款失败次数',
m1_manual_deduct_rep_apl_fal_cnt double comment '近1个月人工扣款_扣款失败次数',
m3_manual_deduct_rep_apl_fal_cnt double comment '近3个月人工扣款_扣款失败次数',
m6_manual_deduct_rep_apl_fal_cnt double comment '近6个月人工扣款_扣款失败次数',
m1_normal_batch_rep_apl_fal_cnt double comment '近1个月常规批扣_扣款失败次数',
m3_normal_batch_rep_apl_fal_cnt double comment '近3个月常规批扣_扣款失败次数',
m6_normal_batch_rep_apl_fal_cnt double comment '近6个月常规批扣_扣款失败次数',
m1_add_bathch_rep_apl_fal_cnt double comment '近1个月逾期批扣_扣款失败次数',
m3_add_bathch_rep_apl_fal_cnt double comment '近3个月逾期批扣_扣款失败次数',
m6_add_bathch_rep_apl_fal_cnt double comment '近6个月逾期批扣_扣款失败次数',
m1_submit_fal_rep_apl_cnt double comment '近1个月提交失败_扣款次数',
m3_submit_fal_rep_apl_cnt double comment '近3个月提交失败_扣款次数',
m6_submit_fal_rep_apl_cnt double comment '近6个月提交失败_扣款次数',
m1_part_suc_rep_apl_cnt double comment '近1个月部分成功_扣款次数',
m3_part_suc_rep_apl_cnt double comment '近3个月部分成功_扣款次数',
m6_part_suc_rep_apl_cnt double comment '近6个月部分成功_扣款次数',
m1_mrn_rep_apl_cnt double comment '近1个月上午扣款次数',
m3_mrn_rep_apl_cnt double comment '近3个月上午扣款次数',
m6_mrn_rep_apl_cnt double comment '近6个月上午扣款次数',
m1_mrn_rep_apl_suc_cnt double comment '近1个月上午_扣款成功次数',
m3_mrn_rep_apl_suc_cnt double comment '近3个月上午_扣款成功次数',
m6_mrn_rep_apl_suc_cnt double comment '近6个月上午_扣款成功次数',
m1_manual_mrn_rep_apl_suc_cnt double comment '近1个月用户主动还款上午扣款成功次数',
m3_manual_mrn_rep_apl_suc_cnt double comment '近3个月用户主动还款上午扣款成功次数',
m6_manual_mrn_rep_apl_suc_cnt double comment '近6个月用户主动还款_上午扣款成功次数',
m1_ao_offline_mrn_rep_apl_suc_cnt double comment '近1个月(数禾对公)线下还款_上午扣款成功次数',
m3_ao_offline_mrn_rep_apl_suc_cnt double comment '近3个月(数禾对公)线下还款_上午扣款成功次数',
m6_ao_offline_mrn_rep_apl_suc_cnt double comment '近6个月(数禾对公)线下还款_上午扣款成功次数',
m1_manual_deduct_mrn_rep_apl_suc_cnt double comment '近1个月人工扣款上午扣款成功次数',
m3_manual_deduct_mrn_rep_apl_suc_cnt double comment '近3个月人工扣款上午扣款成功次数',
m6_manual_deduct_mrn_rep_apl_suc_cnt double comment '近6个月人工扣款上午扣款成功次数',
m1_normal_batch_mrn_rep_apl_suc_cnt double comment '近1个月常规批扣上午扣款成功次数',
m3_normal_batch_mrn_rep_apl_suc_cnt double comment '近3个月常规批扣上午扣款成功次数',
m6_normal_batch_mrn_rep_apl_suc_cnt double comment '近6个月常规批扣_上午扣款成功次数',
m1_add_bathch_mrn_rep_apl_suc_cnt double comment '近1个月逾期批扣上午扣款成功次数',
m3_add_bathch_mrn_rep_apl_suc_cnt double comment '近3个月逾期批扣上午扣款成功次数',
m6_add_bathch_mrn_rep_apl_suc_cnt double comment '近6个月逾期批扣上午扣款成功次数',
m1_mrn_rep_apl_fal_cnt double comment '近1个月上午_扣款失败次数',
m3_mrn_rep_apl_fal_cnt double comment '近3个月上午_扣款失败次数',
m6_mrn_rep_apl_fal_cnt double comment '近6个月上午_扣款失败次数',
m1_manual_mrn_rep_apl_fal_cnt double comment '近1个月用户主动还款_上午扣款失败次数',
m3_manual_mrn_rep_apl_fal_cnt double comment '近3个月用户主动还款_上午扣款失败次数',
m6_manual_mrn_rep_apl_fal_cnt double comment '近6个月用户主动还款_上午扣款失败次数',
m1_ao_offline_mrn_rep_apl_fal_cnt double comment '近1个月(数禾对公)线下还款_上午扣款失败次数',
m3_ao_offline_mrn_rep_apl_fal_cnt double comment '近3个月(数禾对公)线下还款_上午扣款失败次数',
m6_ao_offline_mrn_rep_apl_fal_cnt double comment '近6个月(数禾对公)线下还款_上午扣款失败次数',
m1_manual_deduct_mrn_rep_apl_fal_cnt double comment '近1个月人工扣款上午扣款失败次数',
m3_manual_deduct_mrn_rep_apl_fal_cnt double comment '近3个月人工扣款上午扣款失败次数',
m6_manual_deduct_mrn_rep_apl_fal_cnt double comment '近6个月人工扣款上午扣款失败次数',
m1_normal_batch_mrn_rep_apl_fal_cnt double comment '近1个月常规批扣上午扣款失败次数',
m3_normal_batch_mrn_rep_apl_fal_cnt double comment '近3个月常规批扣上午扣款失败次数',
m6_normal_batch_mrn_rep_apl_fal_cnt double comment '近6个月常规批扣上午扣款失败次数',
m1_add_bathch_mrn_rep_apl_fal_cnt double comment '近1个月逾期批扣_上午扣款失败次数',
m3_add_bathch_mrn_rep_apl_fal_cnt double comment '近3个月逾期批扣_上午扣款失败次数',
m6_add_bathch_mrn_rep_apl_fal_cnt double comment '近6个月逾期批扣_上午扣款失败次数',
m1_manual_tim_0_5_rep_apl_cnt double comment '近1个月用户主动还款_0点-5点_扣款次数',
m3_manual_tim_0_5_rep_apl_cnt double comment '近3个月用户主动还款_0点-5点_扣款次数',
m6_manual_tim_0_5_rep_apl_cnt double comment '近6个月用户主动还款_0点-5点_扣款次数',
m1_manual_tim_6_12_rep_apl_cnt double comment '近1个月用户主动还款_6点-12点_扣款次数',
m3_manual_tim_6_12_rep_apl_cnt double comment '近3个月用户主动还款_6点-12点_扣款次数',
m6_manual_tim_6_12_rep_apl_cnt double comment '近6个月用户主动还款_6点-12点_扣款次数',
m1_manual_tim_13_18_rep_apl_cnt double comment '近1个月用户主动还款_13点-18点_扣款次数',
m3_manual_tim_13_18_rep_apl_cnt double comment '近3个月用户主动还款_13点-18点_扣款次数',
m6_manual_tim_13_18_rep_apl_cnt double comment '近6个月用户主动还款_13点-18点_扣款次数',
m1_manual_tim_19_24_rep_apl_cnt double comment '近1个月用户主动还款_19点-24点_扣款次数',
m3_manual_tim_19_24_rep_apl_cnt double comment '近3个月用户主动还款_19点-24点_扣款次数',
m6_manual_tim_19_24_rep_apl_cnt double comment '近6个月用户主动还款_19点-24点_扣款次数',
m1_manual_weekend_day_rep_apl_cnt double comment '近1个月用户主动还款_周末_扣款次数',
m3_manual_weekend_day_rep_apl_cnt double comment '近3个月用户主动还款_周末_扣款次数',
m6_manual_weekend_day_rep_apl_cnt double comment '近6个月用户主动还款_周末_扣款次数',
m1_manual_work_day_rep_apl_cnt double comment '近1个月用户主动还款_工作日_扣款次数',
m3_manual_work_day_rep_apl_cnt double comment '近3个月用户主动还款_工作日_扣款次数',
m6_manual_work_day_rep_apl_cnt double comment '近6个月用户主动还款_工作日_扣款次数',
m1_manual_tim_0_5_rep_apl_suc_cnt double comment '近1个月用户主动还款_0点-5点_扣款成功次数',
m3_manual_tim_0_5_rep_apl_suc_cnt double comment '近3个月用户主动还款_0点-5点_扣款成功次数',
m6_manual_tim_0_5_rep_apl_suc_cnt double comment '近6个月用户主动还款_0点-5点_扣款成功次数',
m1_manual_tim_0_5_rep_apl_fal_cnt double comment '近1个月用户主动还款_0点-5点_扣款失败次数',
m3_manual_tim_0_5_rep_apl_fal_cnt double comment '近3个月用户主动还款_0点-5点_扣款失败次数',
m6_manual_tim_0_5_rep_apl_fal_cnt double comment '近6个月用户主动还款_0点-5点_扣款失败次数',
m1_manual_tim_6_12_rep_apl_suc_cnt double comment '近1个月用户主动还款_6点-12点_扣款成功次数',
m3_manual_tim_6_12_rep_apl_suc_cnt double comment '近3个月用户主动还款_6点-12点_扣款成功次数',
m6_manual_tim_6_12_rep_apl_suc_cnt double comment '近6个月用户主动还款_6点-12点_扣款成功次数',
m1_manual_tim_6_12_rep_apl_fal_cnt double comment '近1个月用户主动还款_6点-12点_扣款失败次数',
m3_manual_tim_6_12_rep_apl_fal_cnt double comment '近3个月用户主动还款_6点-12点_扣款失败次数',
m6_manual_tim_6_12_rep_apl_fal_cnt double comment '近6个月用户主动还款_6点-12点_扣款失败次数',
m1_manual_tim_13_18_rep_apl_suc_cnt double comment '近1个月用户主动还款_13点-18点_扣款成功次数',
m3_manual_tim_13_18_rep_apl_suc_cnt double comment '近3个月用户主动还款_13点-18点_扣款成功次数',
m6_manual_tim_13_18_rep_apl_suc_cnt double comment '近6个月用户主动还款_13点-18点_扣款成功次数',
m1_manual_tim_13_18_rep_apl_fal_cnt double comment '近1个月用户主动还款_13点-18点_扣款失败次数',
m3_manual_tim_13_18_rep_apl_fal_cnt double comment '近3个月用户主动还款_13点-18点_扣款失败次数',
m6_manual_tim_13_18_rep_apl_fal_cnt double comment '近6个月用户主动还款_13点-18点_扣款失败次数',
m1_manual_tim_19_24_rep_apl_suc_cnt double comment '近1个月用户主动还款_19点-24点_扣款成功次数',
m3_manual_tim_19_24_rep_apl_suc_cnt double comment '近3个月用户主动还款_19点-24点_扣款成功次数',
m6_manual_tim_19_24_rep_apl_suc_cnt double comment '近6个月用户主动还款_19点-24点_扣款成功次数',
m1_manual_tim_19_24_rep_apl_fal_cnt double comment '近1个月用户主动还款_19点-24点_扣款失败次数',
m3_manual_tim_19_24_rep_apl_fal_cnt double comment '近3个月用户主动还款_19点-24点_扣款失败次数',
m6_manual_tim_19_24_rep_apl_fal_cnt double comment '近6个月用户主动还款_19点-24点_扣款失败次数',
m1_manual_weekend_day_rep_apl_suc_cnt double comment '近1个月用户主动还款_周末_扣款成功次数',
m3_manual_weekend_day_rep_apl_suc_cnt double comment '近3个月用户主动还款_周末_扣款成功次数',
m6_manual_weekend_day_rep_apl_suc_cnt double comment '近6个月用户主动还款_周末_扣款成功次数',
m1_manual_weekend_day_rep_apl_fal_cnt double comment '近1个月用户主动还款_周末_扣款失败次数',
m3_manual_weekend_day_rep_apl_fal_cnt double comment '近3个月用户主动还款_周末_扣款失败次数',
m6_manual_weekend_day_rep_apl_fal_cnt double comment '近6个月用户主动还款_周末_扣款失败次数',
m1_manual_work_day_rep_apl_suc_cnt double comment '近1个月用户主动还款_工作日_扣款成功次数',
m3_manual_work_day_rep_apl_suc_cnt double comment '近3个月用户主动还款_工作日_扣款成功次数',
m6_manual_work_day_rep_apl_suc_cnt double comment '近6个月用户主动还款_工作日_扣款成功次数',
m1_manual_work_day_rep_apl_fal_cnt double comment '近1个月用户主动还款_工作日_扣款失败次数',
m3_manual_work_day_rep_apl_fal_cnt double comment '近3个月用户主动还款_工作日_扣款失败次数',
m6_manual_work_day_rep_apl_fal_cnt double comment '近6个月用户主动还款_工作日_扣款失败次数',
m1_rep_apl_suc_amt_sum double comment '近1个月扣款金额_sum',
m3_rep_apl_suc_amt_sum double comment '近3个月扣款金额_sum',
m6_rep_apl_suc_amt_sum double comment '近6个月扣款金额_sum',
m1_manual_rep_apl_suc_amt_sum double comment '近1个月用户主动还款_扣款金额_sum',
m3_manual_rep_apl_suc_amt_sum double comment '近3个月用户主动还款_扣款金额_sum',
m6_manual_rep_apl_suc_amt_sum double comment '近6个月用户主动还款_扣款金额_sum',
m1_ao_offline_rep_apl_suc_amt_sum double comment '近1个月(数禾对公)线下还款_扣款金额_sum',
m3_ao_offline_rep_apl_suc_amt_sum double comment '近3个月(数禾对公)线下还款_扣款金额_sum',
m6_ao_offline_rep_apl_suc_amt_sum double comment '近6个月(数禾对公)线下还款_扣款金额_sum',
m1_manual_deduct_rep_apl_suc_amt_sum double comment '近1个月人工扣款_扣款成功金额_sum',
m3_manual_deduct_rep_apl_suc_amt_sum double comment '近3个月人工扣款_扣款成功金额_sum',
m6_manual_deduct_rep_apl_suc_amt_sum double comment '近6个月人工扣款_扣款成功金额_sum',
m1_normal_batch_rep_apl_suc_amt_sum double comment '近1个月常规批扣_扣款成功金额_sum',
m3_normal_batch_rep_apl_suc_amt_sum double comment '近3个月常规批扣_扣款成功金额_sum',
m6_normal_batch_rep_apl_suc_amt_sum double comment '近6个月常规批扣_扣款金额_sum',
m1_add_bathch_rep_apl_suc_amt_sum double comment '近1个月逾期批扣_扣款成功金额_sum',
m3_add_bathch_rep_apl_suc_amt_sum double comment '近3个月逾期批扣_扣款成功金额_sum',
m6_add_bathch_rep_apl_suc_amt_sum double comment '近6个月逾期批扣_扣款成功金额_sum',
m1_rep_apl_suc_amt_max double comment '近1个月扣款金额_max',
m3_rep_apl_suc_amt_max double comment '近3个月扣款成功金额_max',
m6_rep_apl_suc_amt_max double comment '近6个月扣款成功金额_max',
m1_manual_rep_apl_suc_amt_max double comment '近1个月用户主动还款_扣款金额_max',
m3_manual_rep_apl_suc_amt_max double comment '近3个月用户主动还款_扣款成功金额_max',
m6_manual_rep_apl_suc_amt_max double comment '近6个月用户主动还款_扣款成功金额_max',
m1_ao_offline_rep_apl_suc_amt_max double comment '近1个月(数禾对公)线下还款_扣款金额_max',
m3_ao_offline_rep_apl_suc_amt_max double comment '近3个月(数禾对公)线下还款_扣款金额_max',
m6_ao_offline_rep_apl_suc_amt_max double comment '近6个月(数禾对公)线下还款_扣款金额_max',
m1_manual_deduct_rep_apl_suc_amt_max double comment '近1个月人工扣款_扣款成功金额_max',
m3_manual_deduct_rep_apl_suc_amt_max double comment '近3个月人工扣款_扣款成功金额_max',
m6_manual_deduct_rep_apl_suc_amt_max double comment '近6个月人工扣款_扣款金额_max',
m1_normal_batch_rep_apl_suc_amt_max double comment '近1个月常规批扣_扣款成功金额_max',
m3_normal_batch_rep_apl_suc_amt_max double comment '近3个月常规批扣_扣款金额_max',
m6_normal_batch_rep_apl_suc_amt_max double comment '近6个月常规批扣_扣款金额_max',
m1_add_bathch_rep_apl_suc_amt_max double comment '近1个月逾期批扣_扣款成功金额_max',
m3_add_bathch_rep_apl_suc_amt_max double comment '近3个月逾期批扣_扣款成功金额_max',
m6_add_bathch_rep_apl_suc_amt_max double comment '近6个月逾期批扣_扣款成功金额_max',
m1_rep_apl_suc_amt_min double comment '近1个月扣款金额_min',
m3_rep_apl_suc_amt_min double comment '近3个月扣款金额_min',
m6_rep_apl_suc_amt_min double comment '近6个月扣款成功金额_min',
m1_manual_rep_apl_suc_amt_min double comment '近1个月用户主动还款_扣款金额_min',
m3_manual_rep_apl_suc_amt_min double comment '近3个月用户主动还款_扣款金额_min',
m6_manual_rep_apl_suc_amt_min double comment '近6个月用户主动还款_扣款成功金额_min',
m1_ao_offline_rep_apl_suc_amt_min double comment '近1个月(数禾对公)线下还款_扣款金额_min',
m3_ao_offline_rep_apl_suc_amt_min double comment '近3个月(数禾对公)线下还款_扣款金额_min',
m6_ao_offline_rep_apl_suc_amt_min double comment '近6个月(数禾对公)线下还款_扣款金额_min',
m1_manual_deduct_rep_apl_suc_amt_min double comment '近1个月人工扣款_扣款金额_min',
m3_manual_deduct_rep_apl_suc_amt_min double comment '近3个月人工扣款_扣款金额_min',
m6_manual_deduct_rep_apl_suc_amt_min double comment '近6个月人工扣款_扣款金额_min',
m1_normal_batch_rep_apl_suc_amt_min double comment '近1个月常规批扣_扣款金额_min',
m3_normal_batch_rep_apl_suc_amt_min double comment '近3个月常规批扣_扣款金额_min',
m6_normal_batch_rep_apl_suc_amt_min double comment '近6个月常规批扣_扣款成功金额_min',
m1_add_bathch_rep_apl_suc_amt_min double comment '近1个月逾期批扣_扣款金额_min',
m3_add_bathch_rep_apl_suc_amt_min double comment '近3个月逾期批扣_扣款金额_min',
m6_add_bathch_rep_apl_suc_amt_min double comment '近6个月逾期批扣_扣款金额_min',
m1_rep_apl_suc_amt_avg double comment '近1个月扣款成功金额_avg',
m3_rep_apl_suc_amt_avg double comment '近3个月扣款成功金额_avg',
m6_rep_apl_suc_amt_avg double comment '近6个月扣款成功金额_avg',
m1_manual_rep_apl_suc_amt_avg double comment '近1个月用户主动还款_扣款金额_avg',
m3_manual_rep_apl_suc_amt_avg double comment '近3个月用户主动还款_扣款成功金额_avg',
m6_manual_rep_apl_suc_amt_avg double comment '近6个月用户主动还款_扣款成功金额_avg',
m1_ao_offline_rep_apl_suc_amt_avg double comment '近1个月(数禾对公)线下还款_扣款金额_avg',
m3_ao_offline_rep_apl_suc_amt_avg double comment '近3个月(数禾对公)线下还款_扣款金额_avg',
m6_ao_offline_rep_apl_suc_amt_avg double comment '近6个月(数禾对公)线下还款_扣款金额_avg',
m1_manual_deduct_rep_apl_suc_amt_avg double comment '近1个月人工扣款_扣款成功金额_avg',
m3_manual_deduct_rep_apl_suc_amt_avg double comment '近3个月人工扣款_扣款金额_avg',
m6_manual_deduct_rep_apl_suc_amt_avg double comment '近6个月人工扣款_扣款金额_avg',
m1_normal_batch_rep_apl_suc_amt_avg double comment '近1个月常规批扣_扣款成功金额_avg',
m3_normal_batch_rep_apl_suc_amt_avg double comment '近3个月常规批扣_扣款成功金额_avg',
m6_normal_batch_rep_apl_suc_amt_avg double comment '近6个月常规批扣_扣款成功金额_avg',
m1_add_bathch_rep_apl_suc_amt_avg double comment '近1个月逾期批扣_扣款成功金额_avg',
m3_add_bathch_rep_apl_suc_amt_avg double comment '近3个月逾期批扣_扣款金额_avg',
m6_add_bathch_rep_apl_suc_amt_avg double comment '近6个月逾期批扣_扣款金额_avg',
m1_manual_rep_apl_cnt_rat double comment '近1个月用户主动还款_扣款次数占比',
m1_ao_offline_rep_apl_cnt_rat double comment '近1个月(数禾对公)线下还款_扣款次数占比',
m1_manual_deduct_rep_apl_cnt_rat double comment '近1个月人工扣款_扣款次数占比',
m1_normal_batch_rep_apl_cnt_rat double comment '近1个月常规批扣_扣款次数占比',
m1_add_bathch_rep_apl_cnt_rat double comment '近1个月逾期批扣_扣款次数占比',
m1_rep_apl_suc_cnt_rat double comment '近1个月扣款成功次数占比',
m1_submit_fal_rep_apl_cnt_rat double comment '近1个月提交失败_扣款次数占比',
m1_part_suc_rep_apl_cnt_rat double comment '近1个月部分成功_扣款次数占比',
m1_manual_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_扣款成功次数占比',
m1_ao_offline_rep_apl_suc_cnt_rat double comment '近1个月(数禾对公)线下还款_扣款成功次数占比',
m1_manual_deduct_rep_apl_suc_cnt_rat double comment '近1个月人工扣款_扣款成功次数占比',
m1_normal_batch_rep_apl_suc_cnt_rat double comment '近1个月常规批扣_扣款成功次数占比',
m1_add_bathch_rep_apl_suc_cnt_rat double comment '近1个月逾期批扣_扣款成功次数占比',
m1_manual_rep_apl_fal_cnt_rat double comment '近1个月用户主动还款_扣款失败次数占比',
m1_ao_offline_rep_apl_fal_cnt_rat double comment '近1个月(数禾对公)线下还款_扣款失败次数占比',
m1_manual_deduct_rep_apl_fal_cnt_rat double comment '近1个月人工扣款_扣款失败次数占比',
m1_normal_batch_rep_apl_fal_cnt_rat double comment '近1个月常规批扣_扣款失败次数占比',
m1_add_bathch_rep_apl_fal_cnt_rat double comment '近1个月逾期批扣_扣款失败次数占比',
m1_manual_rep_apl_suc_cnt_in_manual_rep_rat double comment '近1个月用户主动还款_扣款成功次数_in_用户主动还款_rep占比',
m1_manual_tim_0_5_rep_apl_cnt_rat double comment '近1个月用户主动还款_0点-5点_扣款次数占比',
m1_manual_tim_6_12_rep_apl_cnt_rat double comment '近1个月用户主动还款_6点-12点_扣款次数占比',
m1_manual_tim_13_18_rep_apl_cnt_rat double comment '近1个月用户主动还款_13点-18点_扣款次数占比',
m1_manual_tim_19_24_rep_apl_cnt_rat double comment '近1个月用户主动还款_19点-24点_扣款次数占比',
m1_manual_weekend_day_rep_apl_cnt_rat double comment '近1个月用户主动还款_周末_扣款次数占比',
m1_manual_work_day_rep_apl_cnt_rat double comment '近1个月用户主动还款_工作日_扣款次数占比',
m1_manual_tim_0_5_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_0点-5点_扣款成功次数占比',
m1_manual_tim_6_12_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_6点-12点_扣款成功次数占比',
m1_manual_tim_13_18_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_13点-18点_扣款成功次数占比',
m1_manual_tim_19_24_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_19点-24点_扣款成功次数占比',
m1_manual_weekend_day_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_周末_扣款成功次数占比',
m1_manual_work_day_rep_apl_suc_cnt_rat double comment '近1个月用户主动还款_工作日_扣款成功次数占比',
m3_manual_rep_apl_cnt_rat double comment '近3个月用户主动还款_扣款次数占比',
m3_ao_offline_rep_apl_cnt_rat double comment '近3个月(数禾对公)线下还款_扣款次数占比',
m3_manual_deduct_rep_apl_cnt_rat double comment '近3个月人工扣款_扣款次数占比',
m3_normal_batch_rep_apl_cnt_rat double comment '近3个月常规批扣_扣款次数占比',
m3_add_bathch_rep_apl_cnt_rat double comment '近3个月逾期批扣_扣款次数占比',
m3_rep_apl_suc_cnt_rat double comment '近3个月扣款成功次数占比',
m3_submit_fal_rep_apl_cnt_rat double comment '近3个月提交失败_扣款次数占比',
m3_part_suc_rep_apl_cnt_rat double comment '近3个月部分成功_扣款次数占比',
m3_manual_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_扣款成功次数占比',
m3_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月(数禾对公)线下还款_扣款成功次数占比',
m3_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月人工扣款_扣款成功次数占比',
m3_normal_batch_rep_apl_suc_cnt_rat double comment '近3个月常规批扣_扣款成功次数占比',
m3_add_bathch_rep_apl_suc_cnt_rat double comment '近3个月逾期批扣_扣款成功次数占比',
m3_manual_rep_apl_fal_cnt_rat double comment '近3个月用户主动还款_扣款失败次数占比',
m3_ao_offline_rep_apl_fal_cnt_rat double comment '近3个月(数禾对公)线下还款_扣款失败次数占比',
m3_manual_deduct_rep_apl_fal_cnt_rat double comment '近3个月人工扣款_扣款失败次数占比',
m3_normal_batch_rep_apl_fal_cnt_rat double comment '近3个月常规批扣_扣款失败次数占比',
m3_add_bathch_rep_apl_fal_cnt_rat double comment '近3个月逾期批扣_扣款失败次数占比',
m3_manual_rep_apl_suc_cnt_in_manual_rep_rat double comment '近3个月用户主动还款_扣款成功次数_in_用户主动还款_rep占比',
m3_manual_tim_0_5_rep_apl_cnt_rat double comment '近3个月用户主动还款_0点-5点_扣款次数占比',
m3_manual_tim_6_12_rep_apl_cnt_rat double comment '近3个月用户主动还款_6点-12点_扣款次数占比',
m3_manual_tim_13_18_rep_apl_cnt_rat double comment '近3个月用户主动还款_13点-18点_扣款次数占比',
m3_manual_tim_19_24_rep_apl_cnt_rat double comment '近3个月用户主动还款_19点-24点_扣款次数占比',
m3_manual_weekend_day_rep_apl_cnt_rat double comment '近3个月用户主动还款_周末_扣款次数占比',
m3_manual_work_day_rep_apl_cnt_rat double comment '近3个月用户主动还款_工作日_扣款次数占比',
m3_manual_tim_0_5_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_0点-5点_扣款成功次数占比',
m3_manual_tim_6_12_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_6点-12点_扣款成功次数占比',
m3_manual_tim_13_18_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_13点-18点_扣款成功次数占比',
m3_manual_tim_19_24_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_19点-24点_扣款成功次数占比',
m3_manual_weekend_day_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_周末_扣款成功次数占比',
m3_manual_work_day_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_工作日_扣款成功次数占比',
m6_manual_rep_apl_cnt_rat double comment '近6个月用户主动还款_扣款次数占比',
m6_ao_offline_rep_apl_cnt_rat double comment '近6个月(数禾对公)线下还款_扣款次数占比',
m6_manual_deduct_rep_apl_cnt_rat double comment '近6个月人工扣款_扣款次数占比',
m6_normal_batch_rep_apl_cnt_rat double comment '近6个月常规批扣_扣款次数占比',
m6_add_bathch_rep_apl_cnt_rat double comment '近6个月逾期批扣_扣款次数占比',
m6_rep_apl_suc_cnt_rat double comment '近6个月扣款成功次数占比',
m6_submit_fal_rep_apl_cnt_rat double comment '近6个月提交失败_扣款次数占比',
m6_part_suc_rep_apl_cnt_rat double comment '近6个月部分成功_扣款次数占比',
m6_manual_rep_apl_suc_cnt_rat double comment '近6个月用户主动还款_扣款成功次数占比',
m6_ao_offline_rep_apl_suc_cnt_rat double comment '近6个月(数禾对公)线下还款_扣款成功次数占比',
m6_manual_deduct_rep_apl_suc_cnt_rat double comment '近6个月人工扣款_扣款成功次数占比',
m6_normal_batch_rep_apl_suc_cnt_rat double comment '近6个月常规批扣_扣款成功次数占比',
m6_add_bathch_rep_apl_suc_cnt_rat double comment '近6个月逾期批扣_扣款成功次数占比',
m6_manual_rep_apl_fal_cnt_rat double comment '近6个月用户主动还款_扣款失败次数占比',
m6_ao_offline_rep_apl_fal_cnt_rat double comment '近6个月(数禾对公)线下还款_扣款失败次数占比',
m6_manual_deduct_rep_apl_fal_cnt_rat double comment '近6个月人工扣款_扣款失败次数占比',
m6_normal_batch_rep_apl_fal_cnt_rat double comment '近6个月常规批扣_扣款失败次数占比',
m6_add_bathch_rep_apl_fal_cnt_rat double comment '近6个月逾期批扣_扣款失败次数占比',
m6_manual_rep_apl_suc_cnt_in_manual_rep_rat double comment '近3个月用户主动还款_扣款成功次数_in_用户主动还款_rep占比',
m6_manual_tim_0_5_rep_apl_cnt_rat double comment '近3个月用户主动还款_0点-5点_扣款次数占比',
m6_manual_tim_6_12_rep_apl_cnt_rat double comment '近6个月用户主动还款_6点-12点_扣款次数占比',
m6_manual_tim_13_18_rep_apl_cnt_rat double comment '近6个月用户主动还款_13点-18点_扣款次数占比',
m6_manual_tim_19_24_rep_apl_cnt_rat double comment '近3个月用户主动还款_19点-24点_扣款次数占比',
m6_manual_weekend_day_rep_apl_cnt_rat double comment '近3个月用户主动还款_周末_扣款次数占比',
m6_manual_work_day_rep_apl_cnt_rat double comment '近3个月用户主动还款_工作日_扣款次数占比',
m6_manual_tim_0_5_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_0点-5点_扣款成功次数占比',
m6_manual_tim_6_12_rep_apl_suc_cnt_rat double comment '近6个月用户主动还款_6点-12点_扣款成功次数占比',
m6_manual_tim_13_18_rep_apl_suc_cnt_rat double comment '近6个月用户主动还款_13点-18点_扣款成功次数占比',
m6_manual_tim_19_24_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_19点-24点_扣款成功次数占比',
m6_manual_weekend_day_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_周末_扣款成功次数占比',
m6_manual_work_day_rep_apl_suc_cnt_rat double comment '近3个月用户主动还款_工作日_扣款成功次数占比'
)comment 'dwa_risk_dz_model_final_rep_apply_summary_1'
partitioned by (ds string)
;
set odps.stage.mapper.split.size=20;
----------------------------** 变量衍生 **------------------------------
-- by 扣款记录\扣款成功金额衍生
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp1 as
select uid
       ,mdl_dte
       -- 扣款记录 --
       ,count(case when m1_flg = 1 then repay_apply_no else NULL end) as m1_rep_apl_cnt
       ,count(case when m3_flg = 1 then repay_apply_no else NULL end) as m3_rep_apl_cnt
       ,count(case when m6_flg = 1 then repay_apply_no else NULL end) as m6_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_manual_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_manual_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_manual_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_ao_offline_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_ao_offline_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_ao_offline_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_manual_deduct_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_manual_deduct_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_manual_deduct_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_normal_batch_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_normal_batch_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_normal_batch_rep_apl_cnt     
       ,count(case when m1_flg = 1 and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m1_add_bathch_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m3_add_bathch_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m6_add_bathch_rep_apl_cnt      
       -- 成功还款方式
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m1_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m3_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m6_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_manual_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_manual_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_manual_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_ao_offline_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_ao_offline_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_ao_offline_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_manual_deduct_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_manual_deduct_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_manual_deduct_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_normal_batch_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_normal_batch_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_normal_batch_rep_apl_suc_cnt     
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m1_add_bathch_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m3_add_bathch_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m6_add_bathch_rep_apl_suc_cnt
       -- 失败还款方式
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m1_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m3_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m6_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_manual_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_manual_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_manual_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_ao_offline_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_ao_offline_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_ao_offline_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_manual_deduct_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_manual_deduct_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_manual_deduct_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_normal_batch_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_normal_batch_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_normal_batch_rep_apl_fal_cnt     
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m1_add_bathch_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m3_add_bathch_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '逾期批扣' then repay_apply_no else NULL end) as m6_add_bathch_rep_apl_fal_cnt
       
       -- 处理状态repay_status
       ,count(case when m1_flg = 1 and repay_status = 'INIT_ABORT' then repay_apply_no else NULL end) as m1_submit_fal_rep_apl_cnt
       ,count(case when m3_flg = 1 and repay_status = 'INIT_ABORT' then repay_apply_no else NULL end) as m3_submit_fal_rep_apl_cnt
       ,count(case when m6_flg = 1 and repay_status = 'INIT_ABORT' then repay_apply_no else NULL end) as m6_submit_fal_rep_apl_cnt       
       ,count(case when m1_flg = 1 and repay_status = 'PART_SUCCESS' then repay_apply_no else NULL end) as m1_part_suc_rep_apl_cnt
       ,count(case when m3_flg = 1 and repay_status = 'PART_SUCCESS' then repay_apply_no else NULL end) as m3_part_suc_rep_apl_cnt
       ,count(case when m6_flg = 1 and repay_status = 'PART_SUCCESS' then repay_apply_no else NULL end) as m6_part_suc_rep_apl_cnt       

       -- 扣款时间
       ,count(case when m1_flg = 1 and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_mrn_rep_apl_cnt
       ,count(case when m3_flg = 1 and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_mrn_rep_apl_cnt
       ,count(case when m6_flg = 1 and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_mrn_rep_apl_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_mrn_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_mrn_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_mrn_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_manual_mrn_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_manual_mrn_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_manual_mrn_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_ao_offline_mrn_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_ao_offline_mrn_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_ao_offline_mrn_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_manual_deduct_mrn_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_manual_deduct_mrn_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_manual_deduct_mrn_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_normal_batch_mrn_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_normal_batch_mrn_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_normal_batch_mrn_rep_apl_suc_cnt     
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_add_bathch_mrn_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_add_bathch_mrn_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_add_bathch_mrn_rep_apl_suc_cnt

       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_mrn_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_mrn_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_mrn_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_manual_mrn_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_manual_mrn_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_manual_mrn_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(数禾对公)线下还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_ao_offline_mrn_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(数禾对公)线下还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_ao_offline_mrn_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(数禾对公)线下还款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_ao_offline_mrn_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '人工扣款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_manual_deduct_mrn_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '人工扣款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_manual_deduct_mrn_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '人工扣款' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_manual_deduct_mrn_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '常规批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_normal_batch_mrn_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '常规批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_normal_batch_mrn_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '常规批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_normal_batch_mrn_rep_apl_fal_cnt     
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '逾期批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m1_add_bathch_mrn_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '逾期批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m3_add_bathch_mrn_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '逾期批扣' and crt_tim_typ2 = '上午' then repay_apply_no else NULL end) as m6_add_bathch_mrn_rep_apl_fal_cnt       

       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m1_manual_tim_0_5_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m3_manual_tim_0_5_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m6_manual_tim_0_5_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m1_manual_tim_6_12_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m3_manual_tim_6_12_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m6_manual_tim_6_12_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m1_manual_tim_13_18_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m3_manual_tim_13_18_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m6_manual_tim_13_18_rep_apl_cnt       
       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m1_manual_tim_19_24_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m3_manual_tim_19_24_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m6_manual_tim_19_24_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m1_manual_weekend_day_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m3_manual_weekend_day_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m6_manual_weekend_day_rep_apl_cnt
       ,count(case when m1_flg = 1 and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m1_manual_work_day_rep_apl_cnt
       ,count(case when m3_flg = 1 and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m3_manual_work_day_rep_apl_cnt
       ,count(case when m6_flg = 1 and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m6_manual_work_day_rep_apl_cnt 

       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m1_manual_tim_0_5_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m3_manual_tim_0_5_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m6_manual_tim_0_5_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m1_manual_tim_0_5_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m3_manual_tim_0_5_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '凌晨0-5' then repay_apply_no else NULL end) as m6_manual_tim_0_5_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m1_manual_tim_6_12_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m3_manual_tim_6_12_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m6_manual_tim_6_12_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m1_manual_tim_6_12_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m3_manual_tim_6_12_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '上午6-12' then repay_apply_no else NULL end) as m6_manual_tim_6_12_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m1_manual_tim_13_18_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m3_manual_tim_13_18_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m6_manual_tim_13_18_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m1_manual_tim_13_18_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m3_manual_tim_13_18_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '下午13-18' then repay_apply_no else NULL end) as m6_manual_tim_13_18_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m1_manual_tim_19_24_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m3_manual_tim_19_24_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m6_manual_tim_19_24_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m1_manual_tim_19_24_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m3_manual_tim_19_24_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_tim_typ1 = '晚上19-24' then repay_apply_no else NULL end) as m6_manual_tim_19_24_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m1_manual_weekend_day_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m3_manual_weekend_day_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m6_manual_weekend_day_rep_apl_suc_cnt       
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m1_manual_weekend_day_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m3_manual_weekend_day_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 1 then repay_apply_no else NULL end) as m6_manual_weekend_day_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m1_manual_work_day_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m3_manual_work_day_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m6_manual_work_day_rep_apl_suc_cnt       
       ,count(case when m1_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m1_manual_work_day_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m3_manual_work_day_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' and crt_weekend_day = 0 then repay_apply_no else NULL end) as m6_manual_work_day_rep_apl_fal_cnt


       -- 扣款金额 --
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m1_rep_apl_suc_amt_sum
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m3_rep_apl_suc_amt_sum
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m6_rep_apl_suc_amt_sum
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m1_manual_rep_apl_suc_amt_sum
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m3_manual_rep_apl_suc_amt_sum
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m6_manual_rep_apl_suc_amt_sum
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m1_ao_offline_rep_apl_suc_amt_sum
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m3_ao_offline_rep_apl_suc_amt_sum
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m6_ao_offline_rep_apl_suc_amt_sum
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m1_manual_deduct_rep_apl_suc_amt_sum
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m3_manual_deduct_rep_apl_suc_amt_sum
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m6_manual_deduct_rep_apl_suc_amt_sum
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m1_normal_batch_rep_apl_suc_amt_sum
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m3_normal_batch_rep_apl_suc_amt_sum
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m6_normal_batch_rep_apl_suc_amt_sum     
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m1_add_bathch_rep_apl_suc_amt_sum
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m3_add_bathch_rep_apl_suc_amt_sum
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m6_add_bathch_rep_apl_suc_amt_sum

       ,max(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m1_rep_apl_suc_amt_max
       ,max(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m3_rep_apl_suc_amt_max
       ,max(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m6_rep_apl_suc_amt_max
       ,max(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m1_manual_rep_apl_suc_amt_max
       ,max(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m3_manual_rep_apl_suc_amt_max
       ,max(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m6_manual_rep_apl_suc_amt_max
       ,max(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m1_ao_offline_rep_apl_suc_amt_max
       ,max(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m3_ao_offline_rep_apl_suc_amt_max
       ,max(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m6_ao_offline_rep_apl_suc_amt_max
       ,max(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m1_manual_deduct_rep_apl_suc_amt_max
       ,max(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m3_manual_deduct_rep_apl_suc_amt_max
       ,max(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m6_manual_deduct_rep_apl_suc_amt_max
       ,max(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m1_normal_batch_rep_apl_suc_amt_max
       ,max(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m3_normal_batch_rep_apl_suc_amt_max
       ,max(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m6_normal_batch_rep_apl_suc_amt_max     
       ,max(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m1_add_bathch_rep_apl_suc_amt_max
       ,max(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m3_add_bathch_rep_apl_suc_amt_max
       ,max(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m6_add_bathch_rep_apl_suc_amt_max

       ,min(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m1_rep_apl_suc_amt_min
       ,min(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m3_rep_apl_suc_amt_min
       ,min(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m6_rep_apl_suc_amt_min
       ,min(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m1_manual_rep_apl_suc_amt_min
       ,min(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m3_manual_rep_apl_suc_amt_min
       ,min(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m6_manual_rep_apl_suc_amt_min
       ,min(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m1_ao_offline_rep_apl_suc_amt_min
       ,min(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m3_ao_offline_rep_apl_suc_amt_min
       ,min(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m6_ao_offline_rep_apl_suc_amt_min
       ,min(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m1_manual_deduct_rep_apl_suc_amt_min
       ,min(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m3_manual_deduct_rep_apl_suc_amt_min
       ,min(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m6_manual_deduct_rep_apl_suc_amt_min
       ,min(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m1_normal_batch_rep_apl_suc_amt_min
       ,min(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m3_normal_batch_rep_apl_suc_amt_min
       ,min(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m6_normal_batch_rep_apl_suc_amt_min     
       ,min(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m1_add_bathch_rep_apl_suc_amt_min
       ,min(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m3_add_bathch_rep_apl_suc_amt_min
       ,min(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m6_add_bathch_rep_apl_suc_amt_min    

       ,avg(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m1_rep_apl_suc_amt_avg
       ,avg(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m3_rep_apl_suc_amt_avg
       ,avg(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_amt else 0 end) as m6_rep_apl_suc_amt_avg
       ,avg(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m1_manual_rep_apl_suc_amt_avg
       ,avg(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m3_manual_rep_apl_suc_amt_avg
       ,avg(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then rep_amt else 0 end) as m6_manual_rep_apl_suc_amt_avg
       ,avg(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m1_ao_offline_rep_apl_suc_amt_avg
       ,avg(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m3_ao_offline_rep_apl_suc_amt_avg
       ,avg(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then rep_amt else 0 end) as m6_ao_offline_rep_apl_suc_amt_avg
       ,avg(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m1_manual_deduct_rep_apl_suc_amt_avg
       ,avg(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m3_manual_deduct_rep_apl_suc_amt_avg
       ,avg(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then rep_amt else 0 end) as m6_manual_deduct_rep_apl_suc_amt_avg
       ,avg(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m1_normal_batch_rep_apl_suc_amt_avg
       ,avg(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m3_normal_batch_rep_apl_suc_amt_avg
       ,avg(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then rep_amt else 0 end) as m6_normal_batch_rep_apl_suc_amt_avg     
       ,avg(case when m1_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m1_add_bathch_rep_apl_suc_amt_avg
       ,avg(case when m3_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m3_add_bathch_rep_apl_suc_amt_avg
       ,avg(case when m6_flg = 1 and repay_status like '%SUCCESS%' and rpy_desc = '逾期批扣' then rep_amt else 0 end) as m6_add_bathch_rep_apl_suc_amt_avg

from 
(
	select  uid
	        ,mdl_dte
            ,repay_status
            ,rpy_desc
            ,repay_apply_no
            ,rep_amt
            ,crt_tim_typ1
            ,crt_tim_typ2
            ,crt_weekend_day
            ,m1_flg
            ,m3_flg
            ,m6_flg
	from ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail  --由于表里关联了分期计划号，此处按照uid+repay_apply_no去重
    group by uid
	        ,mdl_dte
            ,repay_status
            ,rpy_desc
            ,repay_apply_no
            ,rep_amt
            ,crt_tim_typ1
            ,crt_tim_typ2
            ,crt_weekend_day
            ,m1_flg
            ,m3_flg
            ,m6_flg
) as a
group by uid
         ,mdl_dte 
;



-- 占比类变量
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp2 as
select uid
       ,mdl_dte
       
       ,case when m1_rep_apl_cnt>0 then m1_manual_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_manual_rep_apl_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_ao_offline_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_ao_offline_rep_apl_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_manual_deduct_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_manual_deduct_rep_apl_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_normal_batch_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_normal_batch_rep_apl_cnt_rat       
       ,case when m1_rep_apl_cnt>0 then m1_add_bathch_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_add_bathch_rep_apl_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_rep_apl_suc_cnt/m1_rep_apl_cnt else null end as m1_rep_apl_suc_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_submit_fal_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_submit_fal_rep_apl_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_part_suc_rep_apl_cnt/m1_rep_apl_cnt else null end as m1_part_suc_rep_apl_cnt_rat

       -- 扣款成功 --
       ,case when m1_rep_apl_suc_cnt>0 then m1_manual_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else null end as m1_manual_rep_apl_suc_cnt_rat
       ,case when m1_rep_apl_suc_cnt>0 then m1_ao_offline_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else null end as m1_ao_offline_rep_apl_suc_cnt_rat
       ,case when m1_rep_apl_suc_cnt>0 then m1_manual_deduct_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else null end as m1_manual_deduct_rep_apl_suc_cnt_rat
       ,case when m1_rep_apl_suc_cnt>0 then m1_normal_batch_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else null end as m1_normal_batch_rep_apl_suc_cnt_rat       
       ,case when m1_rep_apl_suc_cnt>0 then m1_add_bathch_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else null end as m1_add_bathch_rep_apl_suc_cnt_rat
       -- 扣款失败 --
       ,case when m1_rep_apl_fal_cnt>0 then m1_manual_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else null end as m1_manual_rep_apl_fal_cnt_rat
       ,case when m1_rep_apl_fal_cnt>0 then m1_ao_offline_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else null end as m1_ao_offline_rep_apl_fal_cnt_rat
       ,case when m1_rep_apl_fal_cnt>0 then m1_manual_deduct_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else null end as m1_manual_deduct_rep_apl_fal_cnt_rat
       ,case when m1_rep_apl_fal_cnt>0 then m1_normal_batch_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else null end as m1_normal_batch_rep_apl_fal_cnt_rat       
       ,case when m1_rep_apl_fal_cnt>0 then m1_add_bathch_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else null end as m1_add_bathch_rep_apl_fal_cnt_rat

       -- 主动还款 --
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_rep_apl_suc_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_rep_apl_suc_cnt_in_manual_rep_rat
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_tim_0_5_rep_apl_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_tim_0_5_rep_apl_cnt_rat
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_tim_6_12_rep_apl_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_tim_6_12_rep_apl_cnt_rat
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_tim_13_18_rep_apl_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_tim_13_18_rep_apl_cnt_rat
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_tim_19_24_rep_apl_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_tim_19_24_rep_apl_cnt_rat
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_weekend_day_rep_apl_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_weekend_day_rep_apl_cnt_rat
       ,case when m1_manual_rep_apl_cnt>0 then m1_manual_work_day_rep_apl_cnt/m1_manual_rep_apl_cnt else null end as m1_manual_work_day_rep_apl_cnt_rat


       ,case when m1_manual_rep_apl_suc_cnt>0 then m1_manual_tim_0_5_rep_apl_suc_cnt/m1_manual_rep_apl_suc_cnt else null end as m1_manual_tim_0_5_rep_apl_suc_cnt_rat
       ,case when m1_manual_rep_apl_suc_cnt>0 then m1_manual_tim_6_12_rep_apl_suc_cnt/m1_manual_rep_apl_suc_cnt else null end as m1_manual_tim_6_12_rep_apl_suc_cnt_rat
       ,case when m1_manual_rep_apl_suc_cnt>0 then m1_manual_tim_13_18_rep_apl_suc_cnt/m1_manual_rep_apl_suc_cnt else null end as m1_manual_tim_13_18_rep_apl_suc_cnt_rat
       ,case when m1_manual_rep_apl_suc_cnt>0 then m1_manual_tim_19_24_rep_apl_suc_cnt/m1_manual_rep_apl_suc_cnt else null end as m1_manual_tim_19_24_rep_apl_suc_cnt_rat
       ,case when m1_manual_rep_apl_suc_cnt>0 then m1_manual_weekend_day_rep_apl_suc_cnt/m1_manual_rep_apl_suc_cnt else null end as m1_manual_weekend_day_rep_apl_suc_cnt_rat
       ,case when m1_manual_rep_apl_suc_cnt>0 then m1_manual_work_day_rep_apl_suc_cnt/m1_manual_rep_apl_suc_cnt else null end as m1_manual_work_day_rep_apl_suc_cnt_rat

       ,case when m3_rep_apl_cnt>0 then m3_manual_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_manual_rep_apl_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_ao_offline_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_ao_offline_rep_apl_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_manual_deduct_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_manual_deduct_rep_apl_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_normal_batch_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_normal_batch_rep_apl_cnt_rat       
       ,case when m3_rep_apl_cnt>0 then m3_add_bathch_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_add_bathch_rep_apl_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_rep_apl_suc_cnt/m3_rep_apl_cnt else null end as m3_rep_apl_suc_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_submit_fal_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_submit_fal_rep_apl_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_part_suc_rep_apl_cnt/m3_rep_apl_cnt else null end as m3_part_suc_rep_apl_cnt_rat

       -- 扣款成功 --
       ,case when m3_rep_apl_suc_cnt>0 then m3_manual_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else null end as m3_manual_rep_apl_suc_cnt_rat
       ,case when m3_rep_apl_suc_cnt>0 then m3_ao_offline_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else null end as m3_ao_offline_rep_apl_suc_cnt_rat
       ,case when m3_rep_apl_suc_cnt>0 then m3_manual_deduct_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else null end as m3_manual_deduct_rep_apl_suc_cnt_rat
       ,case when m3_rep_apl_suc_cnt>0 then m3_normal_batch_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else null end as m3_normal_batch_rep_apl_suc_cnt_rat       
       ,case when m3_rep_apl_suc_cnt>0 then m3_add_bathch_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else null end as m3_add_bathch_rep_apl_suc_cnt_rat
       -- 扣款失败 --
       ,case when m3_rep_apl_fal_cnt>0 then m3_manual_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else null end as m3_manual_rep_apl_fal_cnt_rat
       ,case when m3_rep_apl_fal_cnt>0 then m3_ao_offline_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else null end as m3_ao_offline_rep_apl_fal_cnt_rat
       ,case when m3_rep_apl_fal_cnt>0 then m3_manual_deduct_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else null end as m3_manual_deduct_rep_apl_fal_cnt_rat
       ,case when m3_rep_apl_fal_cnt>0 then m3_normal_batch_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else null end as m3_normal_batch_rep_apl_fal_cnt_rat       
       ,case when m3_rep_apl_fal_cnt>0 then m3_add_bathch_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else null end as m3_add_bathch_rep_apl_fal_cnt_rat

       -- 主动还款 --
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_rep_apl_suc_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_rep_apl_suc_cnt_in_manual_rep_rat
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_tim_0_5_rep_apl_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_tim_0_5_rep_apl_cnt_rat
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_tim_6_12_rep_apl_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_tim_6_12_rep_apl_cnt_rat
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_tim_13_18_rep_apl_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_tim_13_18_rep_apl_cnt_rat
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_tim_19_24_rep_apl_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_tim_19_24_rep_apl_cnt_rat
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_weekend_day_rep_apl_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_weekend_day_rep_apl_cnt_rat
       ,case when m3_manual_rep_apl_cnt>0 then m3_manual_work_day_rep_apl_cnt/m3_manual_rep_apl_cnt else null end as m3_manual_work_day_rep_apl_cnt_rat

       ,case when m3_manual_rep_apl_suc_cnt>0 then m3_manual_tim_0_5_rep_apl_suc_cnt/m3_manual_rep_apl_suc_cnt else null end as m3_manual_tim_0_5_rep_apl_suc_cnt_rat
       ,case when m3_manual_rep_apl_suc_cnt>0 then m3_manual_tim_6_12_rep_apl_suc_cnt/m3_manual_rep_apl_suc_cnt else null end as m3_manual_tim_6_12_rep_apl_suc_cnt_rat
       ,case when m3_manual_rep_apl_suc_cnt>0 then m3_manual_tim_13_18_rep_apl_suc_cnt/m3_manual_rep_apl_suc_cnt else null end as m3_manual_tim_13_18_rep_apl_suc_cnt_rat
       ,case when m3_manual_rep_apl_suc_cnt>0 then m3_manual_tim_19_24_rep_apl_suc_cnt/m3_manual_rep_apl_suc_cnt else null end as m3_manual_tim_19_24_rep_apl_suc_cnt_rat
       ,case when m3_manual_rep_apl_suc_cnt>0 then m3_manual_weekend_day_rep_apl_suc_cnt/m3_manual_rep_apl_suc_cnt else null end as m3_manual_weekend_day_rep_apl_suc_cnt_rat
       ,case when m3_manual_rep_apl_suc_cnt>0 then m3_manual_work_day_rep_apl_suc_cnt/m3_manual_rep_apl_suc_cnt else null end as m3_manual_work_day_rep_apl_suc_cnt_rat

       ,case when m6_rep_apl_cnt>0 then m6_manual_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_manual_rep_apl_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_ao_offline_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_ao_offline_rep_apl_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_manual_deduct_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_manual_deduct_rep_apl_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_normal_batch_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_normal_batch_rep_apl_cnt_rat       
       ,case when m6_rep_apl_cnt>0 then m6_add_bathch_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_add_bathch_rep_apl_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_rep_apl_suc_cnt/m6_rep_apl_cnt else null end as m6_rep_apl_suc_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_submit_fal_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_submit_fal_rep_apl_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_part_suc_rep_apl_cnt/m6_rep_apl_cnt else null end as m6_part_suc_rep_apl_cnt_rat

       -- 扣款成功 --
       ,case when m6_rep_apl_suc_cnt>0 then m6_manual_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else null end as m6_manual_rep_apl_suc_cnt_rat
       ,case when m6_rep_apl_suc_cnt>0 then m6_ao_offline_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else null end as m6_ao_offline_rep_apl_suc_cnt_rat
       ,case when m6_rep_apl_suc_cnt>0 then m6_manual_deduct_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else null end as m6_manual_deduct_rep_apl_suc_cnt_rat
       ,case when m6_rep_apl_suc_cnt>0 then m6_normal_batch_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else null end as m6_normal_batch_rep_apl_suc_cnt_rat       
       ,case when m6_rep_apl_suc_cnt>0 then m6_add_bathch_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else null end as m6_add_bathch_rep_apl_suc_cnt_rat
       -- 扣款失败 --
       ,case when m6_rep_apl_fal_cnt>0 then m6_manual_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else null end as m6_manual_rep_apl_fal_cnt_rat
       ,case when m6_rep_apl_fal_cnt>0 then m6_ao_offline_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else null end as m6_ao_offline_rep_apl_fal_cnt_rat
       ,case when m6_rep_apl_fal_cnt>0 then m6_manual_deduct_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else null end as m6_manual_deduct_rep_apl_fal_cnt_rat
       ,case when m6_rep_apl_fal_cnt>0 then m6_normal_batch_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else null end as m6_normal_batch_rep_apl_fal_cnt_rat       
       ,case when m6_rep_apl_fal_cnt>0 then m6_add_bathch_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else null end as m6_add_bathch_rep_apl_fal_cnt_rat

       -- 主动还款 --
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_rep_apl_suc_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_rep_apl_suc_cnt_in_manual_rep_rat
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_tim_0_5_rep_apl_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_tim_0_5_rep_apl_cnt_rat
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_tim_6_12_rep_apl_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_tim_6_12_rep_apl_cnt_rat
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_tim_13_18_rep_apl_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_tim_13_18_rep_apl_cnt_rat
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_tim_19_24_rep_apl_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_tim_19_24_rep_apl_cnt_rat
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_weekend_day_rep_apl_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_weekend_day_rep_apl_cnt_rat
       ,case when m6_manual_rep_apl_cnt>0 then m6_manual_work_day_rep_apl_cnt/m6_manual_rep_apl_cnt else null end as m6_manual_work_day_rep_apl_cnt_rat

       ,case when m6_manual_rep_apl_suc_cnt>0 then m6_manual_tim_0_5_rep_apl_suc_cnt/m6_manual_rep_apl_suc_cnt else null end as m6_manual_tim_0_5_rep_apl_suc_cnt_rat
       ,case when m6_manual_rep_apl_suc_cnt>0 then m6_manual_tim_6_12_rep_apl_suc_cnt/m6_manual_rep_apl_suc_cnt else null end as m6_manual_tim_6_12_rep_apl_suc_cnt_rat
       ,case when m6_manual_rep_apl_suc_cnt>0 then m6_manual_tim_13_18_rep_apl_suc_cnt/m6_manual_rep_apl_suc_cnt else null end as m6_manual_tim_13_18_rep_apl_suc_cnt_rat
       ,case when m6_manual_rep_apl_suc_cnt>0 then m6_manual_tim_19_24_rep_apl_suc_cnt/m6_manual_rep_apl_suc_cnt else null end as m6_manual_tim_19_24_rep_apl_suc_cnt_rat
       ,case when m6_manual_rep_apl_suc_cnt>0 then m6_manual_weekend_day_rep_apl_suc_cnt/m6_manual_rep_apl_suc_cnt else null end as m6_manual_weekend_day_rep_apl_suc_cnt_rat
       ,case when m6_manual_rep_apl_suc_cnt>0 then m6_manual_work_day_rep_apl_suc_cnt/m6_manual_rep_apl_suc_cnt else null end as m6_manual_work_day_rep_apl_suc_cnt_rat              
from ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp1
;


-- 合并
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1 partition(ds = '${bizdate}')
select  a.uid
        ,a.mdl_dte
        ,a.m1_rep_apl_cnt
        ,a.m3_rep_apl_cnt
        ,a.m6_rep_apl_cnt
        ,a.m1_manual_rep_apl_cnt
        ,a.m3_manual_rep_apl_cnt
        ,a.m6_manual_rep_apl_cnt
        ,a.m1_ao_offline_rep_apl_cnt
        ,a.m3_ao_offline_rep_apl_cnt
        ,a.m6_ao_offline_rep_apl_cnt
        ,a.m1_manual_deduct_rep_apl_cnt
        ,a.m3_manual_deduct_rep_apl_cnt
        ,a.m6_manual_deduct_rep_apl_cnt
        ,a.m1_normal_batch_rep_apl_cnt
        ,a.m3_normal_batch_rep_apl_cnt
        ,a.m6_normal_batch_rep_apl_cnt
        ,a.m1_add_bathch_rep_apl_cnt
        ,a.m3_add_bathch_rep_apl_cnt
        ,a.m6_add_bathch_rep_apl_cnt
        ,a.m1_rep_apl_suc_cnt
        ,a.m3_rep_apl_suc_cnt
        ,a.m6_rep_apl_suc_cnt
        ,a.m1_manual_rep_apl_suc_cnt
        ,a.m3_manual_rep_apl_suc_cnt
        ,a.m6_manual_rep_apl_suc_cnt
        ,a.m1_ao_offline_rep_apl_suc_cnt
        ,a.m3_ao_offline_rep_apl_suc_cnt
        ,a.m6_ao_offline_rep_apl_suc_cnt
        ,a.m1_manual_deduct_rep_apl_suc_cnt
        ,a.m3_manual_deduct_rep_apl_suc_cnt
        ,a.m6_manual_deduct_rep_apl_suc_cnt
        ,a.m1_normal_batch_rep_apl_suc_cnt
        ,a.m3_normal_batch_rep_apl_suc_cnt
        ,a.m6_normal_batch_rep_apl_suc_cnt
        ,a.m1_add_bathch_rep_apl_suc_cnt
        ,a.m3_add_bathch_rep_apl_suc_cnt
        ,a.m6_add_bathch_rep_apl_suc_cnt
        ,a.m1_rep_apl_fal_cnt
        ,a.m3_rep_apl_fal_cnt
        ,a.m6_rep_apl_fal_cnt
        ,a.m1_manual_rep_apl_fal_cnt
        ,a.m3_manual_rep_apl_fal_cnt
        ,a.m6_manual_rep_apl_fal_cnt
        ,a.m1_ao_offline_rep_apl_fal_cnt
        ,a.m3_ao_offline_rep_apl_fal_cnt
        ,a.m6_ao_offline_rep_apl_fal_cnt
        ,a.m1_manual_deduct_rep_apl_fal_cnt
        ,a.m3_manual_deduct_rep_apl_fal_cnt
        ,a.m6_manual_deduct_rep_apl_fal_cnt
        ,a.m1_normal_batch_rep_apl_fal_cnt
        ,a.m3_normal_batch_rep_apl_fal_cnt
        ,a.m6_normal_batch_rep_apl_fal_cnt
        ,a.m1_add_bathch_rep_apl_fal_cnt
        ,a.m3_add_bathch_rep_apl_fal_cnt
        ,a.m6_add_bathch_rep_apl_fal_cnt
        ,a.m1_submit_fal_rep_apl_cnt
        ,a.m3_submit_fal_rep_apl_cnt
        ,a.m6_submit_fal_rep_apl_cnt
        ,a.m1_part_suc_rep_apl_cnt
        ,a.m3_part_suc_rep_apl_cnt
        ,a.m6_part_suc_rep_apl_cnt
        ,a.m1_mrn_rep_apl_cnt
        ,a.m3_mrn_rep_apl_cnt
        ,a.m6_mrn_rep_apl_cnt
        ,a.m1_mrn_rep_apl_suc_cnt
        ,a.m3_mrn_rep_apl_suc_cnt
        ,a.m6_mrn_rep_apl_suc_cnt
        ,a.m1_manual_mrn_rep_apl_suc_cnt
        ,a.m3_manual_mrn_rep_apl_suc_cnt
        ,a.m6_manual_mrn_rep_apl_suc_cnt
        ,a.m1_ao_offline_mrn_rep_apl_suc_cnt
        ,a.m3_ao_offline_mrn_rep_apl_suc_cnt
        ,a.m6_ao_offline_mrn_rep_apl_suc_cnt
        ,a.m1_manual_deduct_mrn_rep_apl_suc_cnt
        ,a.m3_manual_deduct_mrn_rep_apl_suc_cnt
        ,a.m6_manual_deduct_mrn_rep_apl_suc_cnt
        ,a.m1_normal_batch_mrn_rep_apl_suc_cnt
        ,a.m3_normal_batch_mrn_rep_apl_suc_cnt
        ,a.m6_normal_batch_mrn_rep_apl_suc_cnt
        ,a.m1_add_bathch_mrn_rep_apl_suc_cnt
        ,a.m3_add_bathch_mrn_rep_apl_suc_cnt
        ,a.m6_add_bathch_mrn_rep_apl_suc_cnt
        ,a.m1_mrn_rep_apl_fal_cnt
        ,a.m3_mrn_rep_apl_fal_cnt
        ,a.m6_mrn_rep_apl_fal_cnt
        ,a.m1_manual_mrn_rep_apl_fal_cnt
        ,a.m3_manual_mrn_rep_apl_fal_cnt
        ,a.m6_manual_mrn_rep_apl_fal_cnt
        ,a.m1_ao_offline_mrn_rep_apl_fal_cnt
        ,a.m3_ao_offline_mrn_rep_apl_fal_cnt
        ,a.m6_ao_offline_mrn_rep_apl_fal_cnt
        ,a.m1_manual_deduct_mrn_rep_apl_fal_cnt
        ,a.m3_manual_deduct_mrn_rep_apl_fal_cnt
        ,a.m6_manual_deduct_mrn_rep_apl_fal_cnt
        ,a.m1_normal_batch_mrn_rep_apl_fal_cnt
        ,a.m3_normal_batch_mrn_rep_apl_fal_cnt
        ,a.m6_normal_batch_mrn_rep_apl_fal_cnt
        ,a.m1_add_bathch_mrn_rep_apl_fal_cnt
        ,a.m3_add_bathch_mrn_rep_apl_fal_cnt
        ,a.m6_add_bathch_mrn_rep_apl_fal_cnt
        ,a.m1_manual_tim_0_5_rep_apl_cnt
        ,a.m3_manual_tim_0_5_rep_apl_cnt
        ,a.m6_manual_tim_0_5_rep_apl_cnt
        ,a.m1_manual_tim_6_12_rep_apl_cnt
        ,a.m3_manual_tim_6_12_rep_apl_cnt
        ,a.m6_manual_tim_6_12_rep_apl_cnt
        ,a.m1_manual_tim_13_18_rep_apl_cnt
        ,a.m3_manual_tim_13_18_rep_apl_cnt
        ,a.m6_manual_tim_13_18_rep_apl_cnt
        ,a.m1_manual_tim_19_24_rep_apl_cnt
        ,a.m3_manual_tim_19_24_rep_apl_cnt
        ,a.m6_manual_tim_19_24_rep_apl_cnt
        ,a.m1_manual_weekend_day_rep_apl_cnt
        ,a.m3_manual_weekend_day_rep_apl_cnt
        ,a.m6_manual_weekend_day_rep_apl_cnt
        ,a.m1_manual_work_day_rep_apl_cnt
        ,a.m3_manual_work_day_rep_apl_cnt
        ,a.m6_manual_work_day_rep_apl_cnt
        ,a.m1_manual_tim_0_5_rep_apl_suc_cnt
        ,a.m3_manual_tim_0_5_rep_apl_suc_cnt
        ,a.m6_manual_tim_0_5_rep_apl_suc_cnt
        ,a.m1_manual_tim_0_5_rep_apl_fal_cnt
        ,a.m3_manual_tim_0_5_rep_apl_fal_cnt
        ,a.m6_manual_tim_0_5_rep_apl_fal_cnt
        ,a.m1_manual_tim_6_12_rep_apl_suc_cnt
        ,a.m3_manual_tim_6_12_rep_apl_suc_cnt
        ,a.m6_manual_tim_6_12_rep_apl_suc_cnt
        ,a.m1_manual_tim_6_12_rep_apl_fal_cnt
        ,a.m3_manual_tim_6_12_rep_apl_fal_cnt
        ,a.m6_manual_tim_6_12_rep_apl_fal_cnt
        ,a.m1_manual_tim_13_18_rep_apl_suc_cnt
        ,a.m3_manual_tim_13_18_rep_apl_suc_cnt
        ,a.m6_manual_tim_13_18_rep_apl_suc_cnt
        ,a.m1_manual_tim_13_18_rep_apl_fal_cnt
        ,a.m3_manual_tim_13_18_rep_apl_fal_cnt
        ,a.m6_manual_tim_13_18_rep_apl_fal_cnt
        ,a.m1_manual_tim_19_24_rep_apl_suc_cnt
        ,a.m3_manual_tim_19_24_rep_apl_suc_cnt
        ,a.m6_manual_tim_19_24_rep_apl_suc_cnt
        ,a.m1_manual_tim_19_24_rep_apl_fal_cnt
        ,a.m3_manual_tim_19_24_rep_apl_fal_cnt
        ,a.m6_manual_tim_19_24_rep_apl_fal_cnt
        ,a.m1_manual_weekend_day_rep_apl_suc_cnt
        ,a.m3_manual_weekend_day_rep_apl_suc_cnt
        ,a.m6_manual_weekend_day_rep_apl_suc_cnt
        ,a.m1_manual_weekend_day_rep_apl_fal_cnt
        ,a.m3_manual_weekend_day_rep_apl_fal_cnt
        ,a.m6_manual_weekend_day_rep_apl_fal_cnt
        ,a.m1_manual_work_day_rep_apl_suc_cnt
        ,a.m3_manual_work_day_rep_apl_suc_cnt
        ,a.m6_manual_work_day_rep_apl_suc_cnt
        ,a.m1_manual_work_day_rep_apl_fal_cnt
        ,a.m3_manual_work_day_rep_apl_fal_cnt
        ,a.m6_manual_work_day_rep_apl_fal_cnt
        ,a.m1_rep_apl_suc_amt_sum
        ,a.m3_rep_apl_suc_amt_sum
        ,a.m6_rep_apl_suc_amt_sum
        ,a.m1_manual_rep_apl_suc_amt_sum
        ,a.m3_manual_rep_apl_suc_amt_sum
        ,a.m6_manual_rep_apl_suc_amt_sum
        ,a.m1_ao_offline_rep_apl_suc_amt_sum
        ,a.m3_ao_offline_rep_apl_suc_amt_sum
        ,a.m6_ao_offline_rep_apl_suc_amt_sum
        ,a.m1_manual_deduct_rep_apl_suc_amt_sum
        ,a.m3_manual_deduct_rep_apl_suc_amt_sum
        ,a.m6_manual_deduct_rep_apl_suc_amt_sum
        ,a.m1_normal_batch_rep_apl_suc_amt_sum
        ,a.m3_normal_batch_rep_apl_suc_amt_sum
        ,a.m6_normal_batch_rep_apl_suc_amt_sum
        ,a.m1_add_bathch_rep_apl_suc_amt_sum
        ,a.m3_add_bathch_rep_apl_suc_amt_sum
        ,a.m6_add_bathch_rep_apl_suc_amt_sum
        ,a.m1_rep_apl_suc_amt_max
        ,a.m3_rep_apl_suc_amt_max
        ,a.m6_rep_apl_suc_amt_max
        ,a.m1_manual_rep_apl_suc_amt_max
        ,a.m3_manual_rep_apl_suc_amt_max
        ,a.m6_manual_rep_apl_suc_amt_max
        ,a.m1_ao_offline_rep_apl_suc_amt_max
        ,a.m3_ao_offline_rep_apl_suc_amt_max
        ,a.m6_ao_offline_rep_apl_suc_amt_max
        ,a.m1_manual_deduct_rep_apl_suc_amt_max
        ,a.m3_manual_deduct_rep_apl_suc_amt_max
        ,a.m6_manual_deduct_rep_apl_suc_amt_max
        ,a.m1_normal_batch_rep_apl_suc_amt_max
        ,a.m3_normal_batch_rep_apl_suc_amt_max
        ,a.m6_normal_batch_rep_apl_suc_amt_max
        ,a.m1_add_bathch_rep_apl_suc_amt_max
        ,a.m3_add_bathch_rep_apl_suc_amt_max
        ,a.m6_add_bathch_rep_apl_suc_amt_max
        ,a.m1_rep_apl_suc_amt_min
        ,a.m3_rep_apl_suc_amt_min
        ,a.m6_rep_apl_suc_amt_min
        ,a.m1_manual_rep_apl_suc_amt_min
        ,a.m3_manual_rep_apl_suc_amt_min
        ,a.m6_manual_rep_apl_suc_amt_min
        ,a.m1_ao_offline_rep_apl_suc_amt_min
        ,a.m3_ao_offline_rep_apl_suc_amt_min
        ,a.m6_ao_offline_rep_apl_suc_amt_min
        ,a.m1_manual_deduct_rep_apl_suc_amt_min
        ,a.m3_manual_deduct_rep_apl_suc_amt_min
        ,a.m6_manual_deduct_rep_apl_suc_amt_min
        ,a.m1_normal_batch_rep_apl_suc_amt_min
        ,a.m3_normal_batch_rep_apl_suc_amt_min
        ,a.m6_normal_batch_rep_apl_suc_amt_min
        ,a.m1_add_bathch_rep_apl_suc_amt_min
        ,a.m3_add_bathch_rep_apl_suc_amt_min
        ,a.m6_add_bathch_rep_apl_suc_amt_min
        ,a.m1_rep_apl_suc_amt_avg
        ,a.m3_rep_apl_suc_amt_avg
        ,a.m6_rep_apl_suc_amt_avg
        ,a.m1_manual_rep_apl_suc_amt_avg
        ,a.m3_manual_rep_apl_suc_amt_avg
        ,a.m6_manual_rep_apl_suc_amt_avg
        ,a.m1_ao_offline_rep_apl_suc_amt_avg
        ,a.m3_ao_offline_rep_apl_suc_amt_avg
        ,a.m6_ao_offline_rep_apl_suc_amt_avg
        ,a.m1_manual_deduct_rep_apl_suc_amt_avg
        ,a.m3_manual_deduct_rep_apl_suc_amt_avg
        ,a.m6_manual_deduct_rep_apl_suc_amt_avg
        ,a.m1_normal_batch_rep_apl_suc_amt_avg
        ,a.m3_normal_batch_rep_apl_suc_amt_avg
        ,a.m6_normal_batch_rep_apl_suc_amt_avg
        ,a.m1_add_bathch_rep_apl_suc_amt_avg
        ,a.m3_add_bathch_rep_apl_suc_amt_avg
        ,a.m6_add_bathch_rep_apl_suc_amt_avg
        ,m1_manual_rep_apl_cnt_rat
        ,m1_ao_offline_rep_apl_cnt_rat
        ,m1_manual_deduct_rep_apl_cnt_rat
        ,m1_normal_batch_rep_apl_cnt_rat
        ,m1_add_bathch_rep_apl_cnt_rat
        ,m1_rep_apl_suc_cnt_rat
        ,m1_submit_fal_rep_apl_cnt_rat
        ,m1_part_suc_rep_apl_cnt_rat
        ,m1_manual_rep_apl_suc_cnt_rat
        ,m1_ao_offline_rep_apl_suc_cnt_rat
        ,m1_manual_deduct_rep_apl_suc_cnt_rat
        ,m1_normal_batch_rep_apl_suc_cnt_rat
        ,m1_add_bathch_rep_apl_suc_cnt_rat
        ,m1_manual_rep_apl_fal_cnt_rat
        ,m1_ao_offline_rep_apl_fal_cnt_rat
        ,m1_manual_deduct_rep_apl_fal_cnt_rat
        ,m1_normal_batch_rep_apl_fal_cnt_rat
        ,m1_add_bathch_rep_apl_fal_cnt_rat
        ,m1_manual_rep_apl_suc_cnt_in_manual_rep_rat
        ,m1_manual_tim_0_5_rep_apl_cnt_rat
        ,m1_manual_tim_6_12_rep_apl_cnt_rat
        ,m1_manual_tim_13_18_rep_apl_cnt_rat
        ,m1_manual_tim_19_24_rep_apl_cnt_rat
        ,m1_manual_weekend_day_rep_apl_cnt_rat
        ,m1_manual_work_day_rep_apl_cnt_rat
        ,m1_manual_tim_0_5_rep_apl_suc_cnt_rat
        ,m1_manual_tim_6_12_rep_apl_suc_cnt_rat
        ,m1_manual_tim_13_18_rep_apl_suc_cnt_rat
        ,m1_manual_tim_19_24_rep_apl_suc_cnt_rat
        ,m1_manual_weekend_day_rep_apl_suc_cnt_rat
        ,m1_manual_work_day_rep_apl_suc_cnt_rat
        ,m3_manual_rep_apl_cnt_rat
        ,m3_ao_offline_rep_apl_cnt_rat
        ,m3_manual_deduct_rep_apl_cnt_rat
        ,m3_normal_batch_rep_apl_cnt_rat
        ,m3_add_bathch_rep_apl_cnt_rat
        ,m3_rep_apl_suc_cnt_rat
        ,m3_submit_fal_rep_apl_cnt_rat
        ,m3_part_suc_rep_apl_cnt_rat
        ,m3_manual_rep_apl_suc_cnt_rat
        ,m3_ao_offline_rep_apl_suc_cnt_rat
        ,m3_manual_deduct_rep_apl_suc_cnt_rat
        ,m3_normal_batch_rep_apl_suc_cnt_rat
        ,m3_add_bathch_rep_apl_suc_cnt_rat
        ,m3_manual_rep_apl_fal_cnt_rat
        ,m3_ao_offline_rep_apl_fal_cnt_rat
        ,m3_manual_deduct_rep_apl_fal_cnt_rat
        ,m3_normal_batch_rep_apl_fal_cnt_rat
        ,m3_add_bathch_rep_apl_fal_cnt_rat
        ,m3_manual_rep_apl_suc_cnt_in_manual_rep_rat
        ,m3_manual_tim_0_5_rep_apl_cnt_rat
        ,m3_manual_tim_6_12_rep_apl_cnt_rat
        ,m3_manual_tim_13_18_rep_apl_cnt_rat
        ,m3_manual_tim_19_24_rep_apl_cnt_rat
        ,m3_manual_weekend_day_rep_apl_cnt_rat
        ,m3_manual_work_day_rep_apl_cnt_rat
        ,m3_manual_tim_0_5_rep_apl_suc_cnt_rat
        ,m3_manual_tim_6_12_rep_apl_suc_cnt_rat
        ,m3_manual_tim_13_18_rep_apl_suc_cnt_rat
        ,m3_manual_tim_19_24_rep_apl_suc_cnt_rat
        ,m3_manual_weekend_day_rep_apl_suc_cnt_rat
        ,m3_manual_work_day_rep_apl_suc_cnt_rat
        ,m6_manual_rep_apl_cnt_rat
        ,m6_ao_offline_rep_apl_cnt_rat
        ,m6_manual_deduct_rep_apl_cnt_rat
        ,m6_normal_batch_rep_apl_cnt_rat
        ,m6_add_bathch_rep_apl_cnt_rat
        ,m6_rep_apl_suc_cnt_rat
        ,m6_submit_fal_rep_apl_cnt_rat
        ,m6_part_suc_rep_apl_cnt_rat
        ,m6_manual_rep_apl_suc_cnt_rat
        ,m6_ao_offline_rep_apl_suc_cnt_rat
        ,m6_manual_deduct_rep_apl_suc_cnt_rat
        ,m6_normal_batch_rep_apl_suc_cnt_rat
        ,m6_add_bathch_rep_apl_suc_cnt_rat
        ,m6_manual_rep_apl_fal_cnt_rat
        ,m6_ao_offline_rep_apl_fal_cnt_rat
        ,m6_manual_deduct_rep_apl_fal_cnt_rat
        ,m6_normal_batch_rep_apl_fal_cnt_rat
        ,m6_add_bathch_rep_apl_fal_cnt_rat
        ,m6_manual_rep_apl_suc_cnt_in_manual_rep_rat
        ,m6_manual_tim_0_5_rep_apl_cnt_rat
        ,m6_manual_tim_6_12_rep_apl_cnt_rat
        ,m6_manual_tim_13_18_rep_apl_cnt_rat
        ,m6_manual_tim_19_24_rep_apl_cnt_rat
        ,m6_manual_weekend_day_rep_apl_cnt_rat
        ,m6_manual_work_day_rep_apl_cnt_rat
        ,m6_manual_tim_0_5_rep_apl_suc_cnt_rat
        ,m6_manual_tim_6_12_rep_apl_suc_cnt_rat
        ,m6_manual_tim_13_18_rep_apl_suc_cnt_rat
        ,m6_manual_tim_19_24_rep_apl_suc_cnt_rat
        ,m6_manual_weekend_day_rep_apl_suc_cnt_rat
        ,m6_manual_work_day_rep_apl_suc_cnt_rat
from ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp1 as a
left join ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_1_tmp2 as b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;
-- feature-copilot:node-end ordinal=0
