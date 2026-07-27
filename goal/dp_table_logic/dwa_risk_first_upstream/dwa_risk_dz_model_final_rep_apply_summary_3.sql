-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_rep_apply_summary_3
-- node_id: n_4039786796285034496
-- task_name: dwa_risk_dz_model_final_rep_apply_summary_3
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_rep_apply_summary_3.json
-- source_json_sha256: 7cb2b1cd60844fdc2b1e221270478e3e867598c637377b9b2bba87174ca3db33
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp1
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_1
-- upstream_table: dwa_risk.dwa_risk_f_repay_apply_stage_plan_detail
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 任俊峰
--创建日期: 2022-09-22 15:35:54
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
m1_stg_pln_d0_rep_apl_cnt double comment '近1个月单期计划中D0还款还款_扣款次数',
m1_stg_pln_adv_rep_apl_cnt double comment '近1个月单期计划中提前还款_扣款次数',
m1_stg_pln_ovd_1d_3d_rep_apl_cnt double comment '近1个月历史逾期1-3天分期计划_扣款次数',
m1_stg_pln_his_ovd_rep_apl_cnt double comment '近1个月历史逾期分期计划_扣款次数',
m1_stg_pln_d0_rep_apl_suc_cnt double comment '近1个月单期计划中D0还款_扣款成功次数',
m1_stg_pln_d0_manual_rep_apl_suc_cnt double comment '近1个月单期计划中D0还款还款_用户主动还款_扣款成功次数',
m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt double comment '近1个月单期计划中D0还款还款_(数禾对公)线下还款_扣款成功次数',
m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt double comment '近1个月单期计划中D0还款_常规批扣_扣款成功次数',
m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt double comment '近1个月单期计划中D0还款还款_人工扣款_扣款成功次数',
m1_stg_pln_adv_rep_apl_suc_cnt double comment '近1个月单期计划中提前还款_扣款成功次数',
m1_stg_pln_adv_manual_rep_apl_suc_cnt double comment '近1个月单期计划中提前还款_用户主动还款_扣款成功次数',
m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt double comment '近1个月单期计划中提前还款_(数禾对公)线下还款_扣款成功次数',
m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt double comment '近1个月单期计划中提前还款_常规批扣_扣款成功次数',
m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt double comment '近1个月单期计划中提前还款_人工扣款_扣款成功次数',
m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt double comment '近1个月历史逾期1-3天分期计划_扣款成功次数',
m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt double comment '近1个月历史逾期1-3天分期计划_用户主动还款_扣款成功次数',
m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt double comment '近1个月历史逾期1-3天分期计划_(数禾对公)线下还款_扣款成功次数',
m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt double comment '近1个月历史逾期1-3天分期计划_常规批扣_扣款成功次数',
m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt double comment '近1个月历史逾期1-3天分期计划_人工扣款_扣款成功次数',
m1_stg_pln_his_ovd_rep_apl_suc_cnt double comment '近1个月历史逾期分期计划_扣款成功次数',
m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt double comment '近1个月历史逾期分期计划_用户主动还款_扣款成功次数',
m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt double comment '近1个月历史逾期分期计划_(数禾对公)线下还款_扣款成功次数',
m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt double comment '近1个月历史逾期分期计划_常规批扣_扣款成功次数',
m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt double comment '近1个月历史逾期分期计划_人工扣款_扣款成功次数',
m1_stg_pln_d0_rep_apl_fal_cnt double comment '近1个月单期计划中D0还款还款_扣款失败次数',
m1_stg_pln_adv_rep_apl_fal_cnt double comment '近1个月单期计划中提前还款_扣款失败次数',
m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt double comment '近1个月历史逾期1-3天分期计划_扣款失败次数',
m1_stg_pln_his_ovd_rep_apl_fal_cnt double comment '近1个月历史逾期分期计划_扣款失败次数',
m1_stg_pln_d0_manual_rep_apl_fal_cnt double comment '近1个月单期计划中D0还款还款_用户主动还款_扣款失败次数',
m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt double comment '近1个月单期计划中D0还款还款_常规批扣_扣款失败次数',
m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt double comment '近1个月单期计划中D0还款还款_人工扣款_扣款失败次数',
m1_stg_pln_adv_manual_rep_apl_fal_cnt double comment '近1个月单期计划中提前还款_用户主动还款_扣款失败次数',
m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt double comment '近1个月单期计划中提前还款_人工扣款_扣款失败次数',
m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt double comment '近1个月历史逾期1-3天分期计划_用户主动还款_扣款失败次数',
m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt double comment '近1个月历史逾期1-3天分期计划_常规批扣_扣款失败次数',
m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt double comment '近1个月历史逾期1-3天分期计划_人工扣款_扣款失败次数',
m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt double comment '近1个月历史逾期分期计划_用户主动还款_扣款失败次数',
m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt double comment '近1个月历史逾期分期计划_常规批扣_扣款失败次数',
m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt double comment '近1个月历史逾期分期计划_人工扣款_扣款失败次数',
m3_stg_pln_d0_rep_apl_cnt double comment '近3个月单期计划中D0还款还款_扣款次数',
m3_stg_pln_adv_rep_apl_cnt double comment '近3个月单期计划中提前还款_扣款次数',
m3_stg_pln_ovd_1d_3d_rep_apl_cnt double comment '近3个月历史逾期1-3天分期计划_扣款次数',
m3_stg_pln_his_ovd_rep_apl_cnt double comment '近3个月历史逾期分期计划_扣款次数',
m3_stg_pln_d0_rep_apl_suc_cnt double comment '近3个月单期计划中D0还款还款_扣款成功次数',
m3_stg_pln_d0_manual_rep_apl_suc_cnt double comment '近3个月单期计划中D0还款还款_用户主动还款_扣款成功次数',
m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt double comment '近3个月单期计划中D0还款还款_(数禾对公)线下还款_扣款成功次数',
m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt double comment '近3个月单期计划中D0还款_常规批扣_扣款成功次数',
m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt double comment '近3个月单期计划中D0还款还款_人工扣款_扣款成功次数',
m3_stg_pln_adv_rep_apl_suc_cnt double comment '近3个月单期计划中提前还款_扣款成功次数',
m3_stg_pln_adv_manual_rep_apl_suc_cnt double comment '近3个月单期计划中提前还款_用户主动还款_扣款成功次数',
m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt double comment '近3个月单期计划中提前还款_(数禾对公)线下还款_扣款成功次数',
m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt double comment '近3个月单期计划中提前还款_常规批扣_扣款成功次数',
m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt double comment '近3个月单期计划中提前还款_人工扣款_扣款成功次数',
m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt double comment '近3个月历史逾期1-3天分期计划_扣款成功次数',
m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt double comment '近3个月历史逾期1-3天分期计划_用户主动还款_扣款成功次数',
m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt double comment '近3个月历史逾期1-3天分期计划_(数禾对公)线下还款_扣款成功次数',
m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt double comment '近3个月历史逾期1-3天分期计划_常规批扣_扣款成功次数',
m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt double comment '近3个月历史逾期1-3天分期计划_人工扣款_扣款成功次数',
m3_stg_pln_his_ovd_rep_apl_suc_cnt double comment '近3个月历史逾期分期计划_扣款成功次数',
m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt double comment '近3个月历史逾期分期计划_用户主动还款_扣款成功次数',
m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt double comment '近3个月历史逾期分期计划_(数禾对公)线下还款_扣款成功次数',
m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt double comment '近3个月历史逾期分期计划_常规批扣_扣款成功次数',
m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt double comment '近3个月历史逾期分期计划_人工扣款_扣款成功次数',
m3_stg_pln_d0_rep_apl_fal_cnt double comment '近3个月单期计划中D0还款_扣款失败次数',
m3_stg_pln_adv_rep_apl_fal_cnt double comment '近3个月单期计划中提前还款_扣款失败次数',
m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt double comment '近3个月历史逾期1-3天分期计划_扣款失败次数',
m3_stg_pln_his_ovd_rep_apl_fal_cnt double comment '近3个月历史逾期分期计划_扣款失败次数',
m3_stg_pln_d0_manual_rep_apl_fal_cnt double comment '近3个月单期计划中D0还款还款_用户主动还款_扣款失败次数',
m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt double comment '近3个月单期计划中D0还款_常规批扣_扣款失败次数',
m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt double comment '近3个月单期计划中D0还款还款_人工扣款_扣款失败次数',
m3_stg_pln_adv_manual_rep_apl_fal_cnt double comment '近3个月单期计划中提前还款_用户主动还款_扣款失败次数',
m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt double comment '近3个月单期计划中提前还款_人工扣款_扣款失败次数',
m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt double comment '近3个月历史逾期1-3天分期计划_用户主动还款_扣款失败次数',
m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt double comment '近3个月历史逾期1-3天分期计划_常规批扣_扣款失败次数',
m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt double comment '近3个月历史逾期1-3天分期计划_人工扣款_扣款失败次数',
m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt double comment '近3个月历史逾期分期计划_用户主动还款_扣款失败次数',
m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt double comment '近3个月历史逾期分期计划_常规批扣_扣款失败次数',
m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt double comment '近3个月历史逾期分期计划_人工扣款_扣款失败次数',
m6_stg_pln_d0_rep_apl_cnt double comment '近6个月单期计划中D0还款还款_扣款次数',
m6_stg_pln_adv_rep_apl_cnt double comment '近6个月单期计划中提前还款_扣款次数',
m6_stg_pln_ovd_1d_3d_rep_apl_cnt double comment '近6个月历史逾期1-3天分期计划_扣款次数',
m6_stg_pln_his_ovd_rep_apl_cnt double comment '近6个月历史逾期分期计划_扣款次数',
m6_stg_pln_d0_rep_apl_suc_cnt double comment '近6个月单期计划中D0还款还款_扣款成功次数',
m6_stg_pln_d0_manual_rep_apl_suc_cnt double comment '近6个月单期计划中D0还款还款_用户主动还款_扣款成功次数',
m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt double comment '近6个月单期计划中D0还款还款_(数禾对公)线下还款_扣款成功次数',
m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt double comment '近6个月单期计划中D0还款还款_常规批扣_扣款成功次数',
m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt double comment '近6个月单期计划中D0还款还款_人工扣款_扣款成功次数',
m6_stg_pln_adv_rep_apl_suc_cnt double comment '近6个月单期计划中提前还款_扣款成功次数',
m6_stg_pln_adv_manual_rep_apl_suc_cnt double comment '近6个月单期计划中提前还款_用户主动还款_扣款成功次数',
m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt double comment '近6个月单期计划中提前还款_(数禾对公)线下还款_扣款成功次数',
m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt double comment '近6个月单期计划中提前还款_常规批扣_扣款成功次数',
m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt double comment '近6个月单期计划中提前还款_人工扣款_扣款成功次数',
m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt double comment '近6个月历史逾期1-3天分期计划_扣款成功次数',
m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt double comment '近6个月历史逾期1-3天分期计划_用户主动还款_扣款成功次数',
m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt double comment '近6个月历史逾期1-3天分期计划_(数禾对公)线下还款_扣款成功次数',
m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt double comment '近6个月历史逾期1-3天分期计划_常规批扣_扣款成功次数',
m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt double comment '近6个月历史逾期1-3天分期计划_人工扣款_扣款成功次数',
m6_stg_pln_his_ovd_rep_apl_suc_cnt double comment '近6个月历史逾期分期计划_扣款成功次数',
m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt double comment '近6个月历史逾期分期计划_用户主动还款_扣款成功次数',
m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt double comment '近6个月历史逾期分期计划_(数禾对公)线下还款_扣款成功次数',
m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt double comment '近6个月历史逾期分期计划_常规批扣_扣款成功次数',
m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt double comment '近6个月历史逾期分期计划_人工扣款_扣款成功次数',
m6_stg_pln_d0_rep_apl_fal_cnt double comment '近6个月单期计划中D0还款还款_扣款失败次数',
m6_stg_pln_adv_rep_apl_fal_cnt double comment '近6个月单期计划中提前还款_扣款失败次数',
m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt double comment '近6个月历史逾期1-3天分期计划_扣款失败次数',
m6_stg_pln_his_ovd_rep_apl_fal_cnt double comment '近6个月历史逾期分期计划_扣款失败次数',
m6_stg_pln_d0_manual_rep_apl_fal_cnt double comment '近6个月单期计划中D0还款还款_用户主动还款_扣款失败次数',
m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt double comment '近6个月单期计划中D0还款还款_常规批扣_扣款失败次数',
m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt double comment '近6个月单期计划中D0还款还款_人工扣款_扣款失败次数',
m6_stg_pln_adv_manual_rep_apl_fal_cnt double comment '近6个月单期计划中提前还款_用户主动还款_扣款失败次数',
m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt double comment '近6个月单期计划中提前还款_人工扣款_扣款失败次数',
m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt double comment '近6个月历史逾期1-3天分期计划_用户主动还款_扣款失败次数',
m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt double comment '近6个月历史逾期1-3天分期计划_常规批扣_扣款失败次数',
m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt double comment '近6个月历史逾期1-3天分期计划_人工扣款_扣款失败次数',
m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt double comment '近6个月历史逾期分期计划_用户主动还款_扣款失败次数',
m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt double comment '近6个月历史逾期分期计划_常规批扣_扣款失败次数',
m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt double comment '近6个月历史逾期分期计划_人工扣款_扣款失败次数',
m1_stg_pln_d0_rep_apl_cnt_rat double comment '近1个月D0还款分期计划_扣款次数占比',
m1_stg_pln_adv_rep_apl_cnt_rat double comment '近1个月提前还款分期计划_扣款次数占比',
m1_stg_pln_ovd_1d_3d_rep_apl_cnt_rat double comment '近1个月历史逾期1-3天分期计划_扣款次数占比',
m1_stg_pln_his_ovd_rep_apl_cnt_rat double comment '近1个月历史逾期分期计划_扣款次数占比',
m1_stg_pln_d0_rep_apl_suc_cnt_rat double comment '近1个月D0还款分期计划_扣款成功次数占比',
m1_stg_pln_adv_rep_apl_suc_cnt_rat double comment '近1个月提前还款分期计划_扣款成功次数占比',
m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat double comment '近1个月历史逾期1-3天分期计划_扣款成功次数占比',
m1_stg_pln_his_ovd_rep_apl_suc_cnt_rat double comment '近1个月历史逾期分期计划_扣款成功次数占比',
m1_stg_pln_d0_rep_apl_fal_cnt_rat double comment '近1个月D0还款分期计划_扣款失败次数占比',
m1_stg_pln_adv_rep_apl_fal_cnt_rat double comment '近1个月提前还款分期计划_扣款失败次数占比',
m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat double comment '近1个月历史逾期1-3天分期计划_扣款失败次数占比',
m1_stg_pln_his_ovd_rep_apl_fal_cnt_rat double comment '近1个月历史逾期分期计划_扣款失败次数占比',
m1_stg_pln_d0_manual_rep_apl_suc_cnt_rat double comment '近1个月D0还款分期计划_用户主动还款_扣款成功次数占比',
m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat double comment '近1个月D0还款分期计划_(数禾对公)线下还款_扣款成功次数占比',
m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat double comment '近1个月D0还款分期计划_常规批扣_扣款成功次数占比',
m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat double comment '近1个月D0还款分期计划_人工扣款_扣款成功次数占比',
m1_stg_pln_adv_manual_rep_apl_suc_cnt_rat double comment '近1个月提前还款分期计划_用户主动还款_扣款成功次数占比',
m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat double comment '近1个月提前还款分期计划_(数禾对公)线下还款_扣款成功次数占比',
m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat double comment '近1个月提前还款分期计划_常规批扣_扣款成功次数占比',
m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat double comment '近1个月提前还款分期计划_人工扣款_扣款成功次数占比',
m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat double comment '近1个月历史逾期1-3天分期计划_用户主动还款_扣款成功次数占比',
m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat double comment '近1个月历史逾期1-3天分期计划_(数禾对公)线下还款_扣款成功次数占比',
m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat double comment '近1个月历史逾期1-3天分期计划_常规批扣_扣款成功次数占比',
m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat double comment '近1个月历史逾期1-3天分期计划_人工扣款_扣款成功次数占比',
m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat double comment '近1个月历史逾期分期计划_用户主动还款_扣款成功次数占比',
m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat double comment '近1个月历史逾期分期计划_(数禾对公)线下还款_扣款成功次数占比',
m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat double comment '近1个月历史逾期分期计划_常规批扣_扣款成功次数占比',
m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat double comment '近1个月历史逾期分期计划_人工扣款_扣款成功次数占比',
m1_stg_pln_d0_manual_rep_apl_fal_cnt_rat double comment '近1个月D0还款分期计划_用户主动还款_扣款失败次数占比',
m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat double comment '近1个月D0还款分期计划_常规批扣_扣款失败次数占比',
m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat double comment '近1个月D0还款分期计划_人工扣款_扣款失败次数占比',
m1_stg_pln_adv_manual_rep_apl_fal_cnt_rat double comment '近1个月提前还款分期计划_用户主动还款_扣款失败次数占比',
m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat double comment '近1个月提前还款分期计划_人工扣款_扣款失败次数占比',
m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat double comment '近1个月历史逾期1-3天分期计划_用户主动还款_扣款失败次数占比',
m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat double comment '近1个月历史逾期1-3天分期计划_常规批扣_扣款失败次数占比',
m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat double comment '近1个月历史逾期1-3天分期计划_人工扣款_扣款失败次数占比',
m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat double comment '近1个月历史逾期分期计划_用户主动还款_扣款失败次数占比',
m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat double comment '近1个月历史逾期分期计划_常规批扣_扣款失败次数占比',
m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat double comment '近1个月历史逾期分期计划_人工扣款_扣款失败次数占比',
m3_stg_pln_d0_rep_apl_cnt_rat double comment '近3个月D0还款分期计划_扣款次数占比',
m3_stg_pln_adv_rep_apl_cnt_rat double comment '近3个月提前还款分期计划_扣款次数占比',
m3_stg_pln_ovd_1d_3d_rep_apl_cnt_rat double comment '近3个月历史逾期1-3天分期计划_扣款次数占比',
m3_stg_pln_his_ovd_rep_apl_cnt_rat double comment '近3个月历史逾期分期计划_扣款次数占比',
m3_stg_pln_d0_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_扣款成功次数占比',
m3_stg_pln_adv_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_扣款成功次数占比',
m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat double comment '近3个月历史逾期1-3天分期计划_扣款成功次数占比',
m3_stg_pln_his_ovd_rep_apl_suc_cnt_rat double comment '近3个月历史逾期分期计划_扣款成功次数占比',
m3_stg_pln_d0_rep_apl_fal_cnt_rat double comment '近3个月D0还款分期计划_扣款失败次数占比',
m3_stg_pln_adv_rep_apl_fal_cnt_rat double comment '近3个月提前还款分期计划_扣款失败次数占比',
m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat double comment '近3个月历史逾期1-3天分期计划_扣款失败次数占比',
m3_stg_pln_his_ovd_rep_apl_fal_cnt_rat double comment '近3个月历史逾期分期计划_扣款失败次数占比',
m3_stg_pln_d0_manual_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_用户主动还款_扣款成功次数占比',
m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_(数禾对公)线下还款_扣款成功次数占比',
m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_常规批扣_扣款成功次数占比',
m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_人工扣款_扣款成功次数占比',
m3_stg_pln_adv_manual_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_用户主动还款_扣款成功次数占比',
m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_(数禾对公)线下还款_扣款成功次数占比',
m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_常规批扣_扣款成功次数占比',
m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_人工扣款_扣款成功次数占比',
m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat double comment '近3个月历史逾期1-3天分期计划_用户主动还款_扣款成功次数占比',
m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月历史逾期1-3天分期计划_(数禾对公)线下还款_扣款成功次数占比',
m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat double comment '近3个月历史逾期1-3天分期计划_常规批扣_扣款成功次数占比',
m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月历史逾期1-3天分期计划_人工扣款_扣款成功次数占比',
m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat double comment '近3个月历史逾期分期计划_用户主动还款_扣款成功次数占比',
m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月历史逾期分期计划_(数禾对公)线下还款_扣款成功次数占比',
m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat double comment '近3个月历史逾期分期计划_常规批扣_扣款成功次数占比',
m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月历史逾期分期计划_人工扣款_扣款成功次数占比',
m3_stg_pln_d0_manual_rep_apl_fal_cnt_rat double comment '近3个月D0还款分期计划_用户主动还款_扣款失败次数占比',
m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat double comment '近3个月D0还款分期计划_常规批扣_扣款失败次数占比',
m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat double comment '近3个月D0还款分期计划_人工扣款_扣款失败次数占比',
m3_stg_pln_adv_manual_rep_apl_fal_cnt_rat double comment '近3个月提前还款分期计划_用户主动还款_扣款失败次数占比',
m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat double comment '近3个月提前还款分期计划_人工扣款_扣款失败次数占比',
m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat double comment '近3个月历史逾期1-3天分期计划_用户主动还款_扣款失败次数占比',
m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat double comment '近3个月历史逾期1-3天分期计划_常规批扣_扣款失败次数占比',
m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat double comment '近3个月历史逾期1-3天分期计划_人工扣款_扣款失败次数占比',
m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat double comment '近3个月历史逾期分期计划_用户主动还款_扣款失败次数占比',
m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat double comment '近3个月历史逾期分期计划_常规批扣_扣款失败次数占比',
m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat double comment '近3个月历史逾期分期计划_人工扣款_扣款失败次数占比',
m6_stg_pln_d0_rep_apl_cnt_rat double comment '近6个月D0还款分期计划_扣款次数占比',
m6_stg_pln_adv_rep_apl_cnt_rat double comment '近6个月提前还款分期计划_扣款次数占比',
m6_stg_pln_ovd_1d_3d_rep_apl_cnt_rat double comment '近6个月历史逾期1-3天分期计划_扣款次数占比',
m6_stg_pln_his_ovd_rep_apl_cnt_rat double comment '近6个月历史逾期分期计划_扣款次数占比',
m6_stg_pln_d0_rep_apl_suc_cnt_rat double comment '近6个月D0还款分期计划_扣款成功次数占比',
m6_stg_pln_adv_rep_apl_suc_cnt_rat double comment '近6个月提前还款分期计划_扣款成功次数占比',
m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat double comment '近6个月历史逾期1-3天分期计划_扣款成功次数占比',
m6_stg_pln_his_ovd_rep_apl_suc_cnt_rat double comment '近6个月历史逾期分期计划_扣款成功次数占比',
m6_stg_pln_d0_rep_apl_fal_cnt_rat double comment '近6个月D0还款分期计划_扣款失败次数占比',
m6_stg_pln_adv_rep_apl_fal_cnt_rat double comment '近6个月提前还款分期计划_扣款失败次数占比',
m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat double comment '近6个月历史逾期1-3天分期计划_扣款失败次数占比',
m6_stg_pln_his_ovd_rep_apl_fal_cnt_rat double comment '近6个月历史逾期分期计划_扣款失败次数占比',
m6_stg_pln_d0_manual_rep_apl_suc_cnt_rat double comment '近6个月D0还款分期计划_用户主动还款_扣款成功次数占比',
m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_(数禾对公)线下还款_扣款成功次数占比',
m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat double comment '近6个月D0还款分期计划_常规批扣_扣款成功次数占比',
m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月D0还款分期计划_人工扣款_扣款成功次数占比',
m6_stg_pln_adv_manual_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_用户主动还款_扣款成功次数占比',
m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_(数禾对公)线下还款_扣款成功次数占比',
m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_常规批扣_扣款成功次数占比',
m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat double comment '近3个月提前还款分期计划_人工扣款_扣款成功次数占比',
m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat double comment '近6个月历史逾期1-3天分期计划_用户主动还款_扣款成功次数占比',
m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat double comment '近6个月历史逾期1-3天分期计划_(数禾对公)线下还款_扣款成功次数占比',
m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat double comment '近6个月历史逾期1-3天分期计划_常规批扣_扣款成功次数占比',
m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat double comment '近6个月历史逾期1-3天分期计划_人工扣款_扣款成功次数占比',
m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat double comment '近6个月历史逾期分期计划_用户主动还款_扣款成功次数占比',
m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat double comment '近6个月历史逾期分期计划_(数禾对公)线下还款_扣款成功次数占比',
m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat double comment '近6个月历史逾期分期计划_常规批扣_扣款成功次数占比',
m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat double comment '近6个月历史逾期分期计划_人工扣款_扣款成功次数占比',
m6_stg_pln_d0_manual_rep_apl_fal_cnt_rat double comment '近6个月D0还款分期计划_用户主动还款_扣款失败次数占比',
m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat double comment '近6个月D0还款分期计划_常规批扣_扣款失败次数占比',
m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat double comment '近6个月D0还款分期计划_人工扣款_扣款失败次数占比',
m6_stg_pln_adv_manual_rep_apl_fal_cnt_rat double comment '近3个月提前还款分期计划_用户主动还款_扣款失败次数占比',
m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat double comment '近3个月提前还款分期计划_人工扣款_扣款失败次数占比',
m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat double comment '近6个月历史逾期1-3天分期计划_用户主动还款_扣款失败次数占比',
m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat double comment '近6个月历史逾期1-3天分期计划_常规批扣_扣款失败次数占比',
m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat double comment '近6个月历史逾期1-3天分期计划_人工扣款_扣款失败次数占比',
m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat double comment '近6个月历史逾期分期计划_用户主动还款_扣款失败次数占比',
m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat double comment '近6个月历史逾期分期计划_常规批扣_扣款失败次数占比',
m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat double comment '近6个月历史逾期分期计划_人工扣款_扣款失败次数占比'
)comment 'dwa_risk_dz_model_final_rep_apply_summary_3'
partitioned by (ds string)
;

set odps.stage.mapper.split.size=20;
-- 扣款明细+分期计划
drop table if exists dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp1;
create table dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp1 as
select uid
       ,mdl_dte

       -- 扣款记录 --
       -- 还款时间类型
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' then repay_apply_no else NULL end) as m1_stg_pln_d0_rep_apl_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' then repay_apply_no else NULL end) as m1_stg_pln_adv_rep_apl_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_rep_apl_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_rep_apl_cnt

       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m1_stg_pln_d0_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_d0_manual_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m1_stg_pln_adv_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_adv_manual_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt
       
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m1_stg_pln_d0_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m1_stg_pln_adv_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_d0_manual_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_adv_manual_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt
       ,count(case when m1_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt


       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' then repay_apply_no else NULL end) as m3_stg_pln_d0_rep_apl_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' then repay_apply_no else NULL end) as m3_stg_pln_adv_rep_apl_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_rep_apl_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_rep_apl_cnt

       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m3_stg_pln_d0_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_d0_manual_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m3_stg_pln_adv_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_adv_manual_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m3_stg_pln_d0_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m3_stg_pln_adv_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_d0_manual_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_adv_manual_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt
       ,count(case when m3_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt

       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' then repay_apply_no else NULL end) as m6_stg_pln_d0_rep_apl_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' then repay_apply_no else NULL end) as m6_stg_pln_adv_rep_apl_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_rep_apl_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_rep_apl_cnt

       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m6_stg_pln_d0_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_d0_manual_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m6_stg_pln_adv_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_adv_manual_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '(数禾对公)线下还款' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status like '%SUCCESS%' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt

       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m6_stg_pln_d0_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m6_stg_pln_adv_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_d0_manual_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = 'D0还款' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_adv_manual_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '提前还款' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type = '历史逾期1-3天' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '(用户)主动还款' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '常规批扣' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt
       ,count(case when m6_flg = 1 and rep_tim_type like '%历史逾期%' and repay_status = 'FAILURE' and rpy_desc = '人工扣款' then repay_apply_no else NULL end) as m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt

from 
(
    select uid
       ,mdl_dte
       ,rep_tim_type
       ,repay_status
       ,rpy_desc
       ,repay_apply_no
       ,m1_flg
       ,m3_flg
       ,m6_flg
    from dwa_risk.dwa_risk_f_repay_apply_stage_plan_detail
    where repay_type = 'STAGE'
    group by uid
       ,mdl_dte
       ,rep_tim_type
       ,repay_status
       ,rpy_desc
       ,repay_apply_no
       ,m1_flg
       ,m3_flg
       ,m6_flg
) as a 
group by uid
         ,mdl_dte
;



-- 扣款明细+分期计划
drop table if exists dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp2;
create table dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp2 as
select a.uid
       ,a.mdl_dte

       ,case when m1_rep_apl_cnt>0 then m1_stg_pln_d0_rep_apl_cnt/m1_rep_apl_cnt else NULL end as m1_stg_pln_d0_rep_apl_cnt_rat
       ,case when m1_rep_apl_cnt>0 then m1_stg_pln_adv_rep_apl_cnt/m1_rep_apl_cnt else NULL end as m1_stg_pln_adv_rep_apl_cnt_rat      
       ,case when m1_rep_apl_cnt>0 then m1_stg_pln_ovd_1d_3d_rep_apl_cnt/m1_rep_apl_cnt else NULL end as m1_stg_pln_ovd_1d_3d_rep_apl_cnt_rat  
       ,case when m1_rep_apl_cnt>0 then m1_stg_pln_his_ovd_rep_apl_cnt/m1_rep_apl_cnt else NULL end as m1_stg_pln_his_ovd_rep_apl_cnt_rat  
       ,case when m1_rep_apl_suc_cnt>0 then m1_stg_pln_d0_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else NULL end as m1_stg_pln_d0_rep_apl_suc_cnt_rat
       ,case when m1_rep_apl_suc_cnt>0 then m1_stg_pln_adv_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else NULL end as m1_stg_pln_adv_rep_apl_suc_cnt_rat      
       ,case when m1_rep_apl_suc_cnt>0 then m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else NULL end as m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat  
       ,case when m1_rep_apl_suc_cnt>0 then m1_stg_pln_his_ovd_rep_apl_suc_cnt/m1_rep_apl_suc_cnt else NULL end as m1_stg_pln_his_ovd_rep_apl_suc_cnt_rat         
       ,case when m1_rep_apl_fal_cnt>0 then m1_stg_pln_d0_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else NULL end as m1_stg_pln_d0_rep_apl_fal_cnt_rat
       ,case when m1_rep_apl_fal_cnt>0 then m1_stg_pln_adv_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else NULL end as m1_stg_pln_adv_rep_apl_fal_cnt_rat      
       ,case when m1_rep_apl_fal_cnt>0 then m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else NULL end as m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat  
       ,case when m1_rep_apl_fal_cnt>0 then m1_stg_pln_his_ovd_rep_apl_fal_cnt/m1_rep_apl_fal_cnt else NULL end as m1_stg_pln_his_ovd_rep_apl_fal_cnt_rat   

       ,case when m1_stg_pln_d0_rep_apl_suc_cnt>0 then m1_stg_pln_d0_manual_rep_apl_suc_cnt/m1_stg_pln_d0_rep_apl_suc_cnt else NULL end as m1_stg_pln_d0_manual_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_d0_rep_apl_suc_cnt>0 then m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt/m1_stg_pln_d0_rep_apl_suc_cnt else NULL end as m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_d0_rep_apl_suc_cnt>0 then m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt/m1_stg_pln_d0_rep_apl_suc_cnt else NULL end as m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_d0_rep_apl_suc_cnt>0 then m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt/m1_stg_pln_d0_rep_apl_suc_cnt else NULL end as m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat 
       
       ,case when m1_stg_pln_adv_rep_apl_suc_cnt>0 then m1_stg_pln_adv_manual_rep_apl_suc_cnt/m1_stg_pln_adv_rep_apl_suc_cnt else NULL end as m1_stg_pln_adv_manual_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_adv_rep_apl_suc_cnt>0 then m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt/m1_stg_pln_adv_rep_apl_suc_cnt else NULL end as m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_adv_rep_apl_suc_cnt>0 then m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt/m1_stg_pln_adv_rep_apl_suc_cnt else NULL end as m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_adv_rep_apl_suc_cnt>0 then m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt/m1_stg_pln_adv_rep_apl_suc_cnt else NULL end as m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat   

       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat   
       ,case when m1_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt/m1_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt/m1_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt/m1_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m1_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt/m1_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat 

       ,case when m1_stg_pln_d0_rep_apl_fal_cnt>0 then m1_stg_pln_d0_manual_rep_apl_fal_cnt/m1_stg_pln_d0_rep_apl_fal_cnt else NULL end as m1_stg_pln_d0_manual_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_d0_rep_apl_fal_cnt>0 then m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt/m1_stg_pln_d0_rep_apl_fal_cnt else NULL end as m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_d0_rep_apl_fal_cnt>0 then m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt/m1_stg_pln_d0_rep_apl_fal_cnt else NULL end as m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat  

       ,case when m1_stg_pln_adv_rep_apl_fal_cnt>0 then m1_stg_pln_adv_manual_rep_apl_fal_cnt/m1_stg_pln_adv_rep_apl_fal_cnt else NULL end as m1_stg_pln_adv_manual_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_adv_rep_apl_fal_cnt>0 then m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt/m1_stg_pln_adv_rep_apl_fal_cnt else NULL end as m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt/m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt/m1_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt/m1_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m1_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt/m1_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat  

      ,case when m3_rep_apl_cnt>0 then m3_stg_pln_d0_rep_apl_cnt/m3_rep_apl_cnt else NULL end as m3_stg_pln_d0_rep_apl_cnt_rat
       ,case when m3_rep_apl_cnt>0 then m3_stg_pln_adv_rep_apl_cnt/m3_rep_apl_cnt else NULL end as m3_stg_pln_adv_rep_apl_cnt_rat      
       ,case when m3_rep_apl_cnt>0 then m3_stg_pln_ovd_1d_3d_rep_apl_cnt/m3_rep_apl_cnt else NULL end as m3_stg_pln_ovd_1d_3d_rep_apl_cnt_rat  
       ,case when m3_rep_apl_cnt>0 then m3_stg_pln_his_ovd_rep_apl_cnt/m3_rep_apl_cnt else NULL end as m3_stg_pln_his_ovd_rep_apl_cnt_rat  
       ,case when m3_rep_apl_suc_cnt>0 then m3_stg_pln_d0_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else NULL end as m3_stg_pln_d0_rep_apl_suc_cnt_rat
       ,case when m3_rep_apl_suc_cnt>0 then m3_stg_pln_adv_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else NULL end as m3_stg_pln_adv_rep_apl_suc_cnt_rat      
       ,case when m3_rep_apl_suc_cnt>0 then m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else NULL end as m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat  
       ,case when m3_rep_apl_suc_cnt>0 then m3_stg_pln_his_ovd_rep_apl_suc_cnt/m3_rep_apl_suc_cnt else NULL end as m3_stg_pln_his_ovd_rep_apl_suc_cnt_rat         
       ,case when m3_rep_apl_fal_cnt>0 then m3_stg_pln_d0_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else NULL end as m3_stg_pln_d0_rep_apl_fal_cnt_rat
       ,case when m3_rep_apl_fal_cnt>0 then m3_stg_pln_adv_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else NULL end as m3_stg_pln_adv_rep_apl_fal_cnt_rat      
       ,case when m3_rep_apl_fal_cnt>0 then m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else NULL end as m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat  
       ,case when m3_rep_apl_fal_cnt>0 then m3_stg_pln_his_ovd_rep_apl_fal_cnt/m3_rep_apl_fal_cnt else NULL end as m3_stg_pln_his_ovd_rep_apl_fal_cnt_rat   

       ,case when m3_stg_pln_d0_rep_apl_suc_cnt>0 then m3_stg_pln_d0_manual_rep_apl_suc_cnt/m3_stg_pln_d0_rep_apl_suc_cnt else NULL end as m3_stg_pln_d0_manual_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_d0_rep_apl_suc_cnt>0 then m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt/m3_stg_pln_d0_rep_apl_suc_cnt else NULL end as m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_d0_rep_apl_suc_cnt>0 then m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt/m3_stg_pln_d0_rep_apl_suc_cnt else NULL end as m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_d0_rep_apl_suc_cnt>0 then m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt/m3_stg_pln_d0_rep_apl_suc_cnt else NULL end as m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat 
       
       ,case when m3_stg_pln_adv_rep_apl_suc_cnt>0 then m3_stg_pln_adv_manual_rep_apl_suc_cnt/m3_stg_pln_adv_rep_apl_suc_cnt else NULL end as m3_stg_pln_adv_manual_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_adv_rep_apl_suc_cnt>0 then m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt/m3_stg_pln_adv_rep_apl_suc_cnt else NULL end as m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_adv_rep_apl_suc_cnt>0 then m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt/m3_stg_pln_adv_rep_apl_suc_cnt else NULL end as m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_adv_rep_apl_suc_cnt>0 then m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt/m3_stg_pln_adv_rep_apl_suc_cnt else NULL end as m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat   

       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat   
       ,case when m3_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt/m3_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt/m3_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt/m3_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m3_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt/m3_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat 

       ,case when m3_stg_pln_d0_rep_apl_fal_cnt>0 then m3_stg_pln_d0_manual_rep_apl_fal_cnt/m3_stg_pln_d0_rep_apl_fal_cnt else NULL end as m3_stg_pln_d0_manual_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_d0_rep_apl_fal_cnt>0 then m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt/m3_stg_pln_d0_rep_apl_fal_cnt else NULL end as m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_d0_rep_apl_fal_cnt>0 then m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt/m3_stg_pln_d0_rep_apl_fal_cnt else NULL end as m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat  

       ,case when m3_stg_pln_adv_rep_apl_fal_cnt>0 then m3_stg_pln_adv_manual_rep_apl_fal_cnt/m3_stg_pln_adv_rep_apl_fal_cnt else NULL end as m3_stg_pln_adv_manual_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_adv_rep_apl_fal_cnt>0 then m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt/m3_stg_pln_adv_rep_apl_fal_cnt else NULL end as m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt/m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt/m3_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt/m3_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m3_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt/m3_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat  

      ,case when m6_rep_apl_cnt>0 then m6_stg_pln_d0_rep_apl_cnt/m6_rep_apl_cnt else NULL end as m6_stg_pln_d0_rep_apl_cnt_rat
       ,case when m6_rep_apl_cnt>0 then m6_stg_pln_adv_rep_apl_cnt/m6_rep_apl_cnt else NULL end as m6_stg_pln_adv_rep_apl_cnt_rat      
       ,case when m6_rep_apl_cnt>0 then m6_stg_pln_ovd_1d_3d_rep_apl_cnt/m6_rep_apl_cnt else NULL end as m6_stg_pln_ovd_1d_3d_rep_apl_cnt_rat  
       ,case when m6_rep_apl_cnt>0 then m6_stg_pln_his_ovd_rep_apl_cnt/m6_rep_apl_cnt else NULL end as m6_stg_pln_his_ovd_rep_apl_cnt_rat  
       ,case when m6_rep_apl_suc_cnt>0 then m6_stg_pln_d0_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else NULL end as m6_stg_pln_d0_rep_apl_suc_cnt_rat
       ,case when m6_rep_apl_suc_cnt>0 then m6_stg_pln_adv_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else NULL end as m6_stg_pln_adv_rep_apl_suc_cnt_rat      
       ,case when m6_rep_apl_suc_cnt>0 then m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else NULL end as m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat  
       ,case when m6_rep_apl_suc_cnt>0 then m6_stg_pln_his_ovd_rep_apl_suc_cnt/m6_rep_apl_suc_cnt else NULL end as m6_stg_pln_his_ovd_rep_apl_suc_cnt_rat         
       ,case when m6_rep_apl_fal_cnt>0 then m6_stg_pln_d0_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else NULL end as m6_stg_pln_d0_rep_apl_fal_cnt_rat
       ,case when m6_rep_apl_fal_cnt>0 then m6_stg_pln_adv_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else NULL end as m6_stg_pln_adv_rep_apl_fal_cnt_rat      
       ,case when m6_rep_apl_fal_cnt>0 then m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else NULL end as m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat  
       ,case when m6_rep_apl_fal_cnt>0 then m6_stg_pln_his_ovd_rep_apl_fal_cnt/m6_rep_apl_fal_cnt else NULL end as m6_stg_pln_his_ovd_rep_apl_fal_cnt_rat   

       ,case when m6_stg_pln_d0_rep_apl_suc_cnt>0 then m6_stg_pln_d0_manual_rep_apl_suc_cnt/m6_stg_pln_d0_rep_apl_suc_cnt else NULL end as m6_stg_pln_d0_manual_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_d0_rep_apl_suc_cnt>0 then m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt/m6_stg_pln_d0_rep_apl_suc_cnt else NULL end as m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_d0_rep_apl_suc_cnt>0 then m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt/m6_stg_pln_d0_rep_apl_suc_cnt else NULL end as m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_d0_rep_apl_suc_cnt>0 then m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt/m6_stg_pln_d0_rep_apl_suc_cnt else NULL end as m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat 
       
       ,case when m6_stg_pln_adv_rep_apl_suc_cnt>0 then m6_stg_pln_adv_manual_rep_apl_suc_cnt/m6_stg_pln_adv_rep_apl_suc_cnt else NULL end as m6_stg_pln_adv_manual_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_adv_rep_apl_suc_cnt>0 then m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt/m6_stg_pln_adv_rep_apl_suc_cnt else NULL end as m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_adv_rep_apl_suc_cnt>0 then m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt/m6_stg_pln_adv_rep_apl_suc_cnt else NULL end as m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_adv_rep_apl_suc_cnt>0 then m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt/m6_stg_pln_adv_rep_apl_suc_cnt else NULL end as m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat   

       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt>0 then m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt else NULL end as m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat   
       ,case when m6_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt/m6_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt/m6_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt/m6_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat  
       ,case when m6_stg_pln_his_ovd_rep_apl_suc_cnt>0 then m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt/m6_stg_pln_his_ovd_rep_apl_suc_cnt else NULL end as m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat 

       ,case when m6_stg_pln_d0_rep_apl_fal_cnt>0 then m6_stg_pln_d0_manual_rep_apl_fal_cnt/m6_stg_pln_d0_rep_apl_fal_cnt else NULL end as m6_stg_pln_d0_manual_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_d0_rep_apl_fal_cnt>0 then m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt/m6_stg_pln_d0_rep_apl_fal_cnt else NULL end as m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_d0_rep_apl_fal_cnt>0 then m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt/m6_stg_pln_d0_rep_apl_fal_cnt else NULL end as m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat  

       ,case when m6_stg_pln_adv_rep_apl_fal_cnt>0 then m6_stg_pln_adv_manual_rep_apl_fal_cnt/m6_stg_pln_adv_rep_apl_fal_cnt else NULL end as m6_stg_pln_adv_manual_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_adv_rep_apl_fal_cnt>0 then m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt/m6_stg_pln_adv_rep_apl_fal_cnt else NULL end as m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt>0 then m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt/m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt else NULL end as m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt/m6_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt/m6_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat  
       ,case when m6_stg_pln_his_ovd_rep_apl_fal_cnt>0 then m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt/m6_stg_pln_his_ovd_rep_apl_fal_cnt else NULL end as m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat  
from dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp1 as a
left join 
(
    select uid
           ,mdl_dte
           ,m1_rep_apl_cnt
           ,m3_rep_apl_cnt
           ,m6_rep_apl_cnt
           ,m1_rep_apl_suc_cnt
           ,m3_rep_apl_suc_cnt
           ,m6_rep_apl_suc_cnt
           ,m1_rep_apl_fal_cnt
           ,m3_rep_apl_fal_cnt
           ,m6_rep_apl_fal_cnt
    from dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_1
    where ds = '${bizdate}'
) as b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;




-- 合并
insert overwrite table dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3 partition(ds = '${bizdate}')
select 
    a.uid
    ,a.mdl_dte
    ,a.m1_stg_pln_d0_rep_apl_cnt
    ,a.m1_stg_pln_adv_rep_apl_cnt
    ,a.m1_stg_pln_ovd_1d_3d_rep_apl_cnt
    ,a.m1_stg_pln_his_ovd_rep_apl_cnt
    ,a.m1_stg_pln_d0_rep_apl_suc_cnt
    ,a.m1_stg_pln_d0_manual_rep_apl_suc_cnt
    ,a.m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt
    ,a.m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt
    ,a.m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt
    ,a.m1_stg_pln_adv_rep_apl_suc_cnt
    ,a.m1_stg_pln_adv_manual_rep_apl_suc_cnt
    ,a.m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt
    ,a.m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt
    ,a.m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt
    ,a.m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt
    ,a.m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt
    ,a.m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt
    ,a.m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt
    ,a.m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt
    ,a.m1_stg_pln_his_ovd_rep_apl_suc_cnt
    ,a.m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt
    ,a.m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt
    ,a.m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt
    ,a.m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt
    ,a.m1_stg_pln_d0_rep_apl_fal_cnt
    ,a.m1_stg_pln_adv_rep_apl_fal_cnt
    ,a.m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt
    ,a.m1_stg_pln_his_ovd_rep_apl_fal_cnt
    ,a.m1_stg_pln_d0_manual_rep_apl_fal_cnt
    ,a.m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt
    ,a.m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt
    ,a.m1_stg_pln_adv_manual_rep_apl_fal_cnt
    ,a.m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt
    ,a.m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt
    ,a.m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt
    ,a.m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt
    ,a.m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt
    ,a.m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt
    ,a.m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt
    ,a.m3_stg_pln_d0_rep_apl_cnt
    ,a.m3_stg_pln_adv_rep_apl_cnt
    ,a.m3_stg_pln_ovd_1d_3d_rep_apl_cnt
    ,a.m3_stg_pln_his_ovd_rep_apl_cnt
    ,a.m3_stg_pln_d0_rep_apl_suc_cnt
    ,a.m3_stg_pln_d0_manual_rep_apl_suc_cnt
    ,a.m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt
    ,a.m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt
    ,a.m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt
    ,a.m3_stg_pln_adv_rep_apl_suc_cnt
    ,a.m3_stg_pln_adv_manual_rep_apl_suc_cnt
    ,a.m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt
    ,a.m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt
    ,a.m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt
    ,a.m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt
    ,a.m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt
    ,a.m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt
    ,a.m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt
    ,a.m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt
    ,a.m3_stg_pln_his_ovd_rep_apl_suc_cnt
    ,a.m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt
    ,a.m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt
    ,a.m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt
    ,a.m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt
    ,a.m3_stg_pln_d0_rep_apl_fal_cnt
    ,a.m3_stg_pln_adv_rep_apl_fal_cnt
    ,a.m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt
    ,a.m3_stg_pln_his_ovd_rep_apl_fal_cnt
    ,a.m3_stg_pln_d0_manual_rep_apl_fal_cnt
    ,a.m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt
    ,a.m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt
    ,a.m3_stg_pln_adv_manual_rep_apl_fal_cnt
    ,a.m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt
    ,a.m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt
    ,a.m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt
    ,a.m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt
    ,a.m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt
    ,a.m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt
    ,a.m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt
    ,a.m6_stg_pln_d0_rep_apl_cnt
    ,a.m6_stg_pln_adv_rep_apl_cnt
    ,a.m6_stg_pln_ovd_1d_3d_rep_apl_cnt
    ,a.m6_stg_pln_his_ovd_rep_apl_cnt
    ,a.m6_stg_pln_d0_rep_apl_suc_cnt
    ,a.m6_stg_pln_d0_manual_rep_apl_suc_cnt
    ,a.m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt
    ,a.m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt
    ,a.m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt
    ,a.m6_stg_pln_adv_rep_apl_suc_cnt
    ,a.m6_stg_pln_adv_manual_rep_apl_suc_cnt
    ,a.m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt
    ,a.m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt
    ,a.m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt
    ,a.m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt
    ,a.m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt
    ,a.m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt
    ,a.m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt
    ,a.m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt
    ,a.m6_stg_pln_his_ovd_rep_apl_suc_cnt
    ,a.m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt
    ,a.m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt
    ,a.m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt
    ,a.m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt
    ,a.m6_stg_pln_d0_rep_apl_fal_cnt
    ,a.m6_stg_pln_adv_rep_apl_fal_cnt
    ,a.m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt
    ,a.m6_stg_pln_his_ovd_rep_apl_fal_cnt
    ,a.m6_stg_pln_d0_manual_rep_apl_fal_cnt
    ,a.m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt
    ,a.m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt
    ,a.m6_stg_pln_adv_manual_rep_apl_fal_cnt
    ,a.m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt
    ,a.m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt
    ,a.m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt
    ,a.m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt
    ,a.m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt
    ,a.m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt
    ,a.m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt
    ,m1_stg_pln_d0_rep_apl_cnt_rat
    ,m1_stg_pln_adv_rep_apl_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_rep_apl_cnt_rat
    ,m1_stg_pln_his_ovd_rep_apl_cnt_rat
    ,m1_stg_pln_d0_rep_apl_suc_cnt_rat
    ,m1_stg_pln_adv_rep_apl_suc_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat
    ,m1_stg_pln_his_ovd_rep_apl_suc_cnt_rat
    ,m1_stg_pln_d0_rep_apl_fal_cnt_rat
    ,m1_stg_pln_adv_rep_apl_fal_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat
    ,m1_stg_pln_his_ovd_rep_apl_fal_cnt_rat
    ,m1_stg_pln_d0_manual_rep_apl_suc_cnt_rat
    ,m1_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat
    ,m1_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat
    ,m1_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat
    ,m1_stg_pln_adv_manual_rep_apl_suc_cnt_rat
    ,m1_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat
    ,m1_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat
    ,m1_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat
    ,m1_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat
    ,m1_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat
    ,m1_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat
    ,m1_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat
    ,m1_stg_pln_d0_manual_rep_apl_fal_cnt_rat
    ,m1_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat
    ,m1_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat
    ,m1_stg_pln_adv_manual_rep_apl_fal_cnt_rat
    ,m1_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat
    ,m1_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat
    ,m1_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat
    ,m1_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat
    ,m1_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat
    ,m3_stg_pln_d0_rep_apl_cnt_rat
    ,m3_stg_pln_adv_rep_apl_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_rep_apl_cnt_rat
    ,m3_stg_pln_his_ovd_rep_apl_cnt_rat
    ,m3_stg_pln_d0_rep_apl_suc_cnt_rat
    ,m3_stg_pln_adv_rep_apl_suc_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat
    ,m3_stg_pln_his_ovd_rep_apl_suc_cnt_rat
    ,m3_stg_pln_d0_rep_apl_fal_cnt_rat
    ,m3_stg_pln_adv_rep_apl_fal_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat
    ,m3_stg_pln_his_ovd_rep_apl_fal_cnt_rat
    ,m3_stg_pln_d0_manual_rep_apl_suc_cnt_rat
    ,m3_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat
    ,m3_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat
    ,m3_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat
    ,m3_stg_pln_adv_manual_rep_apl_suc_cnt_rat
    ,m3_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat
    ,m3_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat
    ,m3_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat
    ,m3_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat
    ,m3_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat
    ,m3_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat
    ,m3_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat
    ,m3_stg_pln_d0_manual_rep_apl_fal_cnt_rat
    ,m3_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat
    ,m3_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat
    ,m3_stg_pln_adv_manual_rep_apl_fal_cnt_rat
    ,m3_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat
    ,m3_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat
    ,m3_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat
    ,m3_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat
    ,m3_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat
    ,m6_stg_pln_d0_rep_apl_cnt_rat
    ,m6_stg_pln_adv_rep_apl_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_rep_apl_cnt_rat
    ,m6_stg_pln_his_ovd_rep_apl_cnt_rat
    ,m6_stg_pln_d0_rep_apl_suc_cnt_rat
    ,m6_stg_pln_adv_rep_apl_suc_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_rep_apl_suc_cnt_rat
    ,m6_stg_pln_his_ovd_rep_apl_suc_cnt_rat
    ,m6_stg_pln_d0_rep_apl_fal_cnt_rat
    ,m6_stg_pln_adv_rep_apl_fal_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_rep_apl_fal_cnt_rat
    ,m6_stg_pln_his_ovd_rep_apl_fal_cnt_rat
    ,m6_stg_pln_d0_manual_rep_apl_suc_cnt_rat
    ,m6_stg_pln_d0_ao_offline_rep_apl_suc_cnt_rat
    ,m6_stg_pln_d0_normal_batch_rep_apl_suc_cnt_rat
    ,m6_stg_pln_d0_manual_deduct_rep_apl_suc_cnt_rat
    ,m6_stg_pln_adv_manual_rep_apl_suc_cnt_rat
    ,m6_stg_pln_adv_ao_offline_rep_apl_suc_cnt_rat
    ,m6_stg_pln_adv_normal_batch_rep_apl_suc_cnt_rat
    ,m6_stg_pln_adv_manual_deduct_rep_apl_suc_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_manual_rep_apl_suc_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_ao_offline_rep_apl_suc_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_suc_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_suc_cnt_rat
    ,m6_stg_pln_his_ovd_manual_rep_apl_suc_cnt_rat
    ,m6_stg_pln_his_ovd_ao_offline_rep_apl_suc_cnt_rat
    ,m6_stg_pln_his_ovd_normal_batch_rep_apl_suc_cnt_rat
    ,m6_stg_pln_his_ovd_manual_deduct_rep_apl_suc_cnt_rat
    ,m6_stg_pln_d0_manual_rep_apl_fal_cnt_rat
    ,m6_stg_pln_d0_normal_batch_rep_apl_fal_cnt_rat
    ,m6_stg_pln_d0_manual_deduct_rep_apl_fal_cnt_rat
    ,m6_stg_pln_adv_manual_rep_apl_fal_cnt_rat
    ,m6_stg_pln_adv_manual_deduct_rep_apl_fal_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_manual_rep_apl_fal_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_normal_batch_rep_apl_fal_cnt_rat
    ,m6_stg_pln_ovd_1d_3d_manual_deduct_rep_apl_fal_cnt_rat
    ,m6_stg_pln_his_ovd_manual_rep_apl_fal_cnt_rat
    ,m6_stg_pln_his_ovd_normal_batch_rep_apl_fal_cnt_rat
    ,m6_stg_pln_his_ovd_manual_deduct_rep_apl_fal_cnt_rat
from dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp1 as a
left join dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_3_tmp2 as b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;
-- feature-copilot:node-end ordinal=0
