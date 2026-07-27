-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_rep_apply_summary_2
-- node_id: n_4039774529858306048
-- task_name: dwa_risk_dz_model_final_rep_apply_summary_2
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_rep_apply_summary_2.json
-- source_json_sha256: 7dd65365aa6f694ad9722d8ff78f9c0d45a930e7d7c04b1f317160bda56e8375
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_2_tmp
-- upstream_table: dwa_risk.dwa_risk_f_repay_apply_stage_plan_detail
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_2_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_rep_apply_summary_2_tmp1

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 任俊峰
--创建日期: 2022-09-22 15:35:54
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
m1_rep_apl_stg_pln_cnt_max double comment '近1个月单次扣款偿还分期数_max',
m1_rep_apl_stg_pln_cnt_min double comment '近1个月单次扣款偿还分期数_min',
m1_rep_apl_stg_pln_cnt_avg double comment '近1个月单次扣款偿还分期数_avg',
m1_rep_apl_stg_pln_cnt_sum double comment '近1个月单次扣款偿还分期数_sum',
m1_manual_rep_apl_stg_pln_cnt_max double comment '近1个月用户主动还款_单次扣款偿还分期数_max',
m1_manual_rep_apl_stg_pln_cnt_min double comment '近1个月用户主动还款_单次扣款偿还分期数_min',
m1_manual_rep_apl_stg_pln_cnt_avg double comment '近1个月用户主动还款_单次扣款偿还分期数_avg',
m1_manual_rep_apl_stg_pln_cnt_sum double comment '近1个月用户主动还款_单次扣款偿还分期数_sum',
m1_ao_offline_rep_apl_stg_pln_cnt_max double comment '近1个月(数禾对公)线下还款_单次扣款偿还分期数_max',
m1_ao_offline_rep_apl_stg_pln_cnt_min double comment '近1个月(数禾对公)线下还款_单次扣款偿还分期数_min',
m1_ao_offline_rep_apl_stg_pln_cnt_avg double comment '近1个月(数禾对公)线下还款_单次扣款偿还分期数_avg',
m1_ao_offline_rep_apl_stg_pln_cnt_sum double comment '近1个月(数禾对公)线下还款_单次扣款偿还分期数_sum',
m1_manual_deduct_rep_apl_stg_pln_cnt_max double comment '近1个月人工扣款_单次扣款偿还分期数_max',
m1_manual_deduct_rep_apl_stg_pln_cnt_min double comment '近1个月人工扣款_单次扣款偿还分期数_min',
m1_manual_deduct_rep_apl_stg_pln_cnt_avg double comment '近1个月人工扣款_单次扣款偿还分期数_avg',
m1_manual_deduct_rep_apl_stg_pln_cnt_sum double comment '近1个月人工扣款_单次扣款偿还分期数_sum',
m1_normal_batch_rep_apl_stg_pln_cnt_max double comment '近1个月常规批扣_单次扣款偿还分期数_max',
m1_normal_batch_rep_apl_stg_pln_cnt_min double comment '近1个月常规批扣_单次扣款偿还分期数_min',
m1_normal_batch_rep_apl_stg_pln_cnt_avg double comment '近1个月常规批扣_单次扣款偿还分期数_avg',
m1_normal_batch_rep_apl_stg_pln_cnt_sum double comment '近1个月常规批扣_单次扣款偿还分期数_sum',
m1_add_bathch_rep_apl_stg_pln_cnt_max double comment '近1个月逾期批扣_单次扣款偿还分期数_max',
m1_add_bathch_rep_apl_stg_pln_cnt_min double comment '近1个月逾期批扣_单次扣款偿还分期数_min',
m1_add_bathch_rep_apl_stg_pln_cnt_avg double comment '近1个月逾期批扣_单次扣款偿还分期数_avg',
m1_add_bathch_rep_apl_stg_pln_cnt_sum double comment '近1个月逾期批扣_单次扣款偿还分期数_sum',
m1_rep_apl_suc_stg_pln_cnt_max double comment '近1个月单次扣款成功偿还分期数_max',
m1_rep_apl_suc_stg_pln_cnt_min double comment '近1个月单次扣款成功偿还分期数_min',
m1_rep_apl_suc_stg_pln_cnt_avg double comment '近1个月单次扣款成功偿还分期数_avg',
m1_rep_apl_suc_stg_pln_cnt_sum double comment '近1个月单次扣款成功偿还分期数_sum',
m1_manual_rep_apl_suc_stg_pln_cnt_max double comment '近1个月用户主动还款_单次扣款成功偿还分期数_max',
m1_manual_rep_apl_suc_stg_pln_cnt_min double comment '近1个月用户主动还款_单次扣款成功偿还分期数_min',
m1_manual_rep_apl_suc_stg_pln_cnt_avg double comment '近1个月用户主动还款_单次扣款成功偿还分期数_avg',
m1_manual_rep_apl_suc_stg_pln_cnt_sum double comment '近1个月用户主动还款_单次扣款成功偿还分期数_sum',
m1_ao_offline_rep_apl_suc_stg_pln_cnt_max double comment '近1个月(数禾对公)线下还款_单次扣款成功偿还分期数_max',
m1_ao_offline_rep_apl_suc_stg_pln_cnt_min double comment '近1个月(数禾对公)线下还款_单次扣款成功偿还分期数_min',
m1_ao_offline_rep_apl_suc_stg_pln_cnt_avg double comment '近1个月(数禾对公)线下还款_单次扣款成功偿还分期数_avg',
m1_ao_offline_rep_apl_suc_stg_pln_cnt_sum double comment '近1个月(数禾对公)线下还款_单次扣款成功偿还分期数_sum',
m1_manual_deduct_rep_apl_suc_stg_pln_cnt_max double comment '近1个月人工扣款_单次扣款成功偿还分期数_max',
m1_manual_deduct_rep_apl_suc_stg_pln_cnt_min double comment '近1个月人工扣款_单次扣款成功偿还分期数_min',
m1_manual_deduct_rep_apl_suc_stg_pln_cnt_avg double comment '近1个月人工扣款_单次扣款成功偿还分期数_avg',
m1_manual_deduct_rep_apl_suc_stg_pln_cnt_sum double comment '近1个月人工扣款_单次扣款成功偿还分期数_sum',
m1_normal_batch_rep_apl_suc_stg_pln_cnt_max double comment '近1个月常规批扣_单次扣款成功偿还分期数_max',
m1_normal_batch_rep_apl_suc_stg_pln_cnt_min double comment '近1个月常规批扣_单次扣款成功偿还分期数_min',
m1_normal_batch_rep_apl_suc_stg_pln_cnt_avg double comment '近1个月常规批扣_单次扣款成功偿还分期数_avg',
m1_normal_batch_rep_apl_suc_stg_pln_cnt_sum double comment '近1个月常规批扣_单次扣款成功偿还分期数_sum',
m1_add_bathch_rep_apl_suc_stg_pln_cnt_max double comment '近1个月逾期批扣_单次扣款成功偿还分期数_max',
m1_add_bathch_rep_apl_suc_stg_pln_cnt_min double comment '近1个月逾期批扣_单次扣款成功偿还分期数_min',
m1_add_bathch_rep_apl_suc_stg_pln_cnt_avg double comment '近1个月逾期批扣_单次扣款成功偿还分期数_avg',
m1_add_bathch_rep_apl_suc_stg_pln_cnt_sum double comment '近1个月逾期批扣_单次扣款成功偿还分期数_sum',
m1_rep_apl_fal_stg_pln_cnt_max double comment '近1个月单次扣款失败偿还分期数_max',
m1_rep_apl_fal_stg_pln_cnt_min double comment '近1个月单次扣款失败偿还分期数_min',
m1_rep_apl_fal_stg_pln_cnt_avg double comment '近1个月单次扣款失败偿还分期数_avg',
m1_rep_apl_fal_stg_pln_cnt_sum double comment '近1个月单次扣款失败偿还分期数_sum',
m1_manual_rep_apl_fal_stg_pln_cnt_max double comment '近1个月用户主动还款_单次扣款失败偿还分期数_max',
m1_manual_rep_apl_fal_stg_pln_cnt_min double comment '近1个月用户主动还款_单次扣款失败偿还分期数_min',
m1_manual_rep_apl_fal_stg_pln_cnt_avg double comment '近1个月用户主动还款_单次扣款失败偿还分期数_avg',
m1_manual_rep_apl_fal_stg_pln_cnt_sum double comment '近1个月用户主动还款_单次扣款失败偿还分期数_sum',
m1_ao_offline_rep_apl_fal_stg_pln_cnt_max double comment '近1个月(数禾对公)线下还款_单次扣款失败偿还分期数_max',
m1_ao_offline_rep_apl_fal_stg_pln_cnt_min double comment '近1个月(数禾对公)线下还款_单次扣款失败偿还分期数_min',
m1_ao_offline_rep_apl_fal_stg_pln_cnt_avg double comment '近1个月(数禾对公)线下还款_单次扣款失败偿还分期数_avg',
m1_ao_offline_rep_apl_fal_stg_pln_cnt_sum double comment '近1个月(数禾对公)线下还款_单次扣款失败偿还分期数_sum',
m1_manual_deduct_rep_apl_fal_stg_pln_cnt_max double comment '近1个月人工扣款_单次扣款失败偿还分期数_max',
m1_manual_deduct_rep_apl_fal_stg_pln_cnt_min double comment '近1个月人工扣款_单次扣款失败偿还分期数_min',
m1_manual_deduct_rep_apl_fal_stg_pln_cnt_avg double comment '近1个月人工扣款_单次扣款失败偿还分期数_avg',
m1_manual_deduct_rep_apl_fal_stg_pln_cnt_sum double comment '近1个月人工扣款_单次扣款失败偿还分期数_sum',
m1_normal_batch_rep_apl_fal_stg_pln_cnt_max double comment '近1个月常规批扣_单次扣款失败偿还分期数_max',
m1_normal_batch_rep_apl_fal_stg_pln_cnt_min double comment '近1个月常规批扣_单次扣款失败偿还分期数_min',
m1_normal_batch_rep_apl_fal_stg_pln_cnt_avg double comment '近1个月常规批扣_单次扣款失败偿还分期数_avg',
m1_normal_batch_rep_apl_fal_stg_pln_cnt_sum double comment '近1个月常规批扣_单次扣款失败偿还分期数_sum',
m1_add_bathch_rep_apl_fal_stg_pln_cnt_max double comment '近1个月逾期批扣_单次扣款失败偿还分期数_max',
m1_add_bathch_rep_apl_fal_stg_pln_cnt_min double comment '近1个月逾期批扣_单次扣款失败偿还分期数_min',
m1_add_bathch_rep_apl_fal_stg_pln_cnt_avg double comment '近1个月逾期批扣_单次扣款失败偿还分期数_avg',
m1_add_bathch_rep_apl_fal_stg_pln_cnt_sum double comment '近1个月逾期批扣_单次扣款失败偿还分期数_sum',
m3_rep_apl_stg_pln_cnt_max double comment '近3个月单次扣款偿还分期数_max',
m3_rep_apl_stg_pln_cnt_min double comment '近3个月单次扣款偿还分期数_min',
m3_rep_apl_stg_pln_cnt_avg double comment '近3个月单次扣款偿还分期数_avg',
m3_rep_apl_stg_pln_cnt_sum double comment '近3个月单次扣款偿还分期数_sum',
m3_manual_rep_apl_stg_pln_cnt_max double comment '近3个月用户主动还款_单次扣款偿还分期数_max',
m3_manual_rep_apl_stg_pln_cnt_min double comment '近3个月用户主动还款_单次扣款偿还分期数_min',
m3_manual_rep_apl_stg_pln_cnt_avg double comment '近3个月用户主动还款_单次扣款偿还分期数_avg',
m3_manual_rep_apl_stg_pln_cnt_sum double comment '近3个月用户主动还款_单次扣款偿还分期数_sum',
m3_ao_offline_rep_apl_stg_pln_cnt_max double comment '近3个月(数禾对公)线下还款_单次扣款偿还分期数_max',
m3_ao_offline_rep_apl_stg_pln_cnt_min double comment '近3个月(数禾对公)线下还款_单次扣款偿还分期数_min',
m3_ao_offline_rep_apl_stg_pln_cnt_avg double comment '近3个月(数禾对公)线下还款_单次扣款偿还分期数_avg',
m3_ao_offline_rep_apl_stg_pln_cnt_sum double comment '近3个月(数禾对公)线下还款_单次扣款偿还分期数_sum',
m3_manual_deduct_rep_apl_stg_pln_cnt_max double comment '近3个月人工扣款_单次扣款偿还分期数_max',
m3_manual_deduct_rep_apl_stg_pln_cnt_min double comment '近3个月人工扣款_单次扣款偿还分期数_min',
m3_manual_deduct_rep_apl_stg_pln_cnt_avg double comment '近3个月人工扣款_单次扣款偿还分期数_avg',
m3_manual_deduct_rep_apl_stg_pln_cnt_sum double comment '近3个月人工扣款_单次扣款偿还分期数_sum',
m3_normal_batch_rep_apl_stg_pln_cnt_max double comment '近3个月常规批扣_单次扣款偿还分期数_max',
m3_normal_batch_rep_apl_stg_pln_cnt_min double comment '近3个月常规批扣_单次扣款偿还分期数_min',
m3_normal_batch_rep_apl_stg_pln_cnt_avg double comment '近3个月常规批扣_单次扣款偿还分期数_avg',
m3_normal_batch_rep_apl_stg_pln_cnt_sum double comment '近3个月常规批扣_单次扣款偿还分期数_sum',
m3_add_bathch_rep_apl_stg_pln_cnt_max double comment '近3个月逾期批扣_单次扣款偿还分期数_max',
m3_add_bathch_rep_apl_stg_pln_cnt_min double comment '近3个月逾期批扣_单次扣款偿还分期数_min',
m3_add_bathch_rep_apl_stg_pln_cnt_avg double comment '近3个月逾期批扣_单次扣款偿还分期数_avg',
m3_add_bathch_rep_apl_stg_pln_cnt_sum double comment '近3个月逾期批扣_单次扣款偿还分期数_sum',
m3_rep_apl_suc_stg_pln_cnt_max double comment '近3个月单次扣款成功偿还分期数_max',
m3_rep_apl_suc_stg_pln_cnt_min double comment '近3个月单次扣款成功偿还分期数_min',
m3_rep_apl_suc_stg_pln_cnt_avg double comment '近3个月单次扣款成功偿还分期数_avg',
m3_rep_apl_suc_stg_pln_cnt_sum double comment '近3个月单次扣款成功偿还分期数_sum',
m3_manual_rep_apl_suc_stg_pln_cnt_max double comment '近3个月用户主动还款_单次扣款成功偿还分期数_max',
m3_manual_rep_apl_suc_stg_pln_cnt_min double comment '近3个月用户主动还款_单次扣款成功偿还分期数_min',
m3_manual_rep_apl_suc_stg_pln_cnt_avg double comment '近3个月用户主动还款_单次扣款成功偿还分期数_avg',
m3_manual_rep_apl_suc_stg_pln_cnt_sum double comment '近3个月用户主动还款_单次扣款成功偿还分期数_sum',
m3_ao_offline_rep_apl_suc_stg_pln_cnt_max double comment '近3个月(数禾对公)线下还款_单次扣款成功偿还分期数_max',
m3_ao_offline_rep_apl_suc_stg_pln_cnt_min double comment '近3个月(数禾对公)线下还款_单次扣款成功偿还分期数_min',
m3_ao_offline_rep_apl_suc_stg_pln_cnt_avg double comment '近3个月(数禾对公)线下还款_单次扣款成功偿还分期数_avg',
m3_ao_offline_rep_apl_suc_stg_pln_cnt_sum double comment '近3个月(数禾对公)线下还款_单次扣款成功偿还分期数_sum',
m3_manual_deduct_rep_apl_suc_stg_pln_cnt_max double comment '近3个月人工扣款_单次扣款成功偿还分期数_max',
m3_manual_deduct_rep_apl_suc_stg_pln_cnt_min double comment '近3个月人工扣款_单次扣款成功偿还分期数_min',
m3_manual_deduct_rep_apl_suc_stg_pln_cnt_avg double comment '近3个月人工扣款_单次扣款成功偿还分期数_avg',
m3_manual_deduct_rep_apl_suc_stg_pln_cnt_sum double comment '近3个月人工扣款_单次扣款成功偿还分期数_sum',
m3_normal_batch_rep_apl_suc_stg_pln_cnt_max double comment '近3个月常规批扣_单次扣款成功偿还分期数_max',
m3_normal_batch_rep_apl_suc_stg_pln_cnt_min double comment '近3个月常规批扣_单次扣款成功偿还分期数_min',
m3_normal_batch_rep_apl_suc_stg_pln_cnt_avg double comment '近3个月常规批扣_单次扣款成功偿还分期数_avg',
m3_normal_batch_rep_apl_suc_stg_pln_cnt_sum double comment '近3个月常规批扣_单次扣款成功偿还分期数_sum',
m3_add_bathch_rep_apl_suc_stg_pln_cnt_max double comment '近3个月逾期批扣_单次扣款成功偿还分期数_max',
m3_add_bathch_rep_apl_suc_stg_pln_cnt_min double comment '近3个月逾期批扣_单次扣款成功偿还分期数_min',
m3_add_bathch_rep_apl_suc_stg_pln_cnt_avg double comment '近3个月逾期批扣_单次扣款成功偿还分期数_avg',
m3_add_bathch_rep_apl_suc_stg_pln_cnt_sum double comment '近3个月逾期批扣_单次扣款成功偿还分期数_sum',
m3_rep_apl_fal_stg_pln_cnt_max double comment '近3个月单次扣款失败偿还分期数_max',
m3_rep_apl_fal_stg_pln_cnt_min double comment '近3个月单次扣款失败偿还分期数_min',
m3_rep_apl_fal_stg_pln_cnt_avg double comment '近3个月单次扣款失败偿还分期数_avg',
m3_rep_apl_fal_stg_pln_cnt_sum double comment '近3个月单次扣款失败偿还分期数_sum',
m3_manual_rep_apl_fal_stg_pln_cnt_max double comment '近3个月用户主动还款_单次扣款失败偿还分期数_max',
m3_manual_rep_apl_fal_stg_pln_cnt_min double comment '近3个月用户主动还款_单次扣款失败偿还分期数_min',
m3_manual_rep_apl_fal_stg_pln_cnt_avg double comment '近3个月用户主动还款_单次扣款失败偿还分期数_avg',
m3_manual_rep_apl_fal_stg_pln_cnt_sum double comment '近3个月用户主动还款_单次扣款失败偿还分期数_sum',
m3_ao_offline_rep_apl_fal_stg_pln_cnt_max double comment '近3个月(数禾对公)线下还款_单次扣款失败偿还分期数_max',
m3_ao_offline_rep_apl_fal_stg_pln_cnt_min double comment '近3个月(数禾对公)线下还款_单次扣款失败偿还分期数_min',
m3_ao_offline_rep_apl_fal_stg_pln_cnt_avg double comment '近3个月(数禾对公)线下还款_单次扣款失败偿还分期数_avg',
m3_ao_offline_rep_apl_fal_stg_pln_cnt_sum double comment '近3个月(数禾对公)线下还款_单次扣款失败偿还分期数_sum',
m3_manual_deduct_rep_apl_fal_stg_pln_cnt_max double comment '近3个月人工扣款_单次扣款失败偿还分期数_max',
m3_manual_deduct_rep_apl_fal_stg_pln_cnt_min double comment '近3个月人工扣款_单次扣款失败偿还分期数_min',
m3_manual_deduct_rep_apl_fal_stg_pln_cnt_avg double comment '近3个月人工扣款_单次扣款失败偿还分期数_avg',
m3_manual_deduct_rep_apl_fal_stg_pln_cnt_sum double comment '近3个月人工扣款_单次扣款失败偿还分期数_sum',
m3_normal_batch_rep_apl_fal_stg_pln_cnt_max double comment '近3个月常规批扣_单次扣款失败偿还分期数_max',
m3_normal_batch_rep_apl_fal_stg_pln_cnt_min double comment '近3个月常规批扣_单次扣款失败偿还分期数_min',
m3_normal_batch_rep_apl_fal_stg_pln_cnt_avg double comment '近3个月常规批扣_单次扣款失败偿还分期数_avg',
m3_normal_batch_rep_apl_fal_stg_pln_cnt_sum double comment '近3个月常规批扣_单次扣款失败偿还分期数_sum',
m3_add_bathch_rep_apl_fal_stg_pln_cnt_max double comment '近3个月逾期批扣_单次扣款失败偿还分期数_max',
m3_add_bathch_rep_apl_fal_stg_pln_cnt_min double comment '近3个月逾期批扣_单次扣款失败偿还分期数_min',
m3_add_bathch_rep_apl_fal_stg_pln_cnt_avg double comment '近3个月逾期批扣_单次扣款失败偿还分期数_avg',
m3_add_bathch_rep_apl_fal_stg_pln_cnt_sum double comment '近3个月逾期批扣_单次扣款失败偿还分期数_sum',
m6_rep_apl_stg_pln_cnt_max double comment '近6个月单次扣款偿还分期数_max',
m6_rep_apl_stg_pln_cnt_min double comment '近6个月单次扣款偿还分期数_min',
m6_rep_apl_stg_pln_cnt_avg double comment '近6个月单次扣款偿还分期数_avg',
m6_rep_apl_stg_pln_cnt_sum double comment '近6个月单次扣款偿还分期数_sum',
m6_manual_rep_apl_stg_pln_cnt_max double comment '近6个月用户主动还款_单次扣款偿还分期数_max',
m6_manual_rep_apl_stg_pln_cnt_min double comment '近6个月用户主动还款_单次扣款偿还分期数_min',
m6_manual_rep_apl_stg_pln_cnt_avg double comment '近6个月用户主动还款_单次扣款偿还分期数_avg',
m6_manual_rep_apl_stg_pln_cnt_sum double comment '近6个月用户主动还款_单次扣款偿还分期数_sum',
m6_ao_offline_rep_apl_stg_pln_cnt_max double comment '近6个月(数禾对公)线下还款_单次扣款偿还分期数_max',
m6_ao_offline_rep_apl_stg_pln_cnt_min double comment '近6个月(数禾对公)线下还款_单次扣款偿还分期数_min',
m6_ao_offline_rep_apl_stg_pln_cnt_avg double comment '近6个月(数禾对公)线下还款_单次扣款偿还分期数_avg',
m6_ao_offline_rep_apl_stg_pln_cnt_sum double comment '近6个月(数禾对公)线下还款_单次扣款偿还分期数_sum',
m6_manual_deduct_rep_apl_stg_pln_cnt_max double comment '近6个月人工扣款_单次扣款偿还分期数_max',
m6_manual_deduct_rep_apl_stg_pln_cnt_min double comment '近6个月人工扣款_单次扣款偿还分期数_min',
m6_manual_deduct_rep_apl_stg_pln_cnt_avg double comment '近6个月人工扣款_单次扣款偿还分期数_avg',
m6_manual_deduct_rep_apl_stg_pln_cnt_sum double comment '近6个月人工扣款_单次扣款偿还分期数_sum',
m6_normal_batch_rep_apl_stg_pln_cnt_max double comment '近6个月常规批扣_单次扣款偿还分期数_max',
m6_normal_batch_rep_apl_stg_pln_cnt_min double comment '近6个月常规批扣_单次扣款偿还分期数_min',
m6_normal_batch_rep_apl_stg_pln_cnt_avg double comment '近6个月常规批扣_单次扣款偿还分期数_avg',
m6_normal_batch_rep_apl_stg_pln_cnt_sum double comment '近6个月常规批扣_单次扣款偿还分期数_sum',
m6_add_bathch_rep_apl_stg_pln_cnt_max double comment '近6个月逾期批扣_单次扣款偿还分期数_max',
m6_add_bathch_rep_apl_stg_pln_cnt_min double comment '近6个月逾期批扣_单次扣款偿还分期数_min',
m6_add_bathch_rep_apl_stg_pln_cnt_avg double comment '近6个月逾期批扣_单次扣款偿还分期数_avg',
m6_add_bathch_rep_apl_stg_pln_cnt_sum double comment '近6个月逾期批扣_单次扣款偿还分期数_sum',
m6_rep_apl_suc_stg_pln_cnt_max double comment '近6个月单次扣款成功偿还分期数_max',
m6_rep_apl_suc_stg_pln_cnt_min double comment '近6个月单次扣款成功偿还分期数_min',
m6_rep_apl_suc_stg_pln_cnt_avg double comment '近6个月单次扣款成功偿还分期数_avg',
m6_rep_apl_suc_stg_pln_cnt_sum double comment '近6个月单次扣款成功偿还分期数_sum',
m6_manual_rep_apl_suc_stg_pln_cnt_max double comment '近6个月用户主动还款_单次扣款成功偿还分期数_max',
m6_manual_rep_apl_suc_stg_pln_cnt_min double comment '近6个月用户主动还款_单次扣款成功偿还分期数_min',
m6_manual_rep_apl_suc_stg_pln_cnt_avg double comment '近6个月用户主动还款_单次扣款成功偿还分期数_avg',
m6_manual_rep_apl_suc_stg_pln_cnt_sum double comment '近6个月用户主动还款_单次扣款成功偿还分期数_sum',
m6_ao_offline_rep_apl_suc_stg_pln_cnt_max double comment '近6个月(数禾对公)线下还款_单次扣款成功偿还分期数_max',
m6_ao_offline_rep_apl_suc_stg_pln_cnt_min double comment '近6个月(数禾对公)线下还款_单次扣款成功偿还分期数_min',
m6_ao_offline_rep_apl_suc_stg_pln_cnt_avg double comment '近6个月(数禾对公)线下还款_单次扣款成功偿还分期数_avg',
m6_ao_offline_rep_apl_suc_stg_pln_cnt_sum double comment '近6个月(数禾对公)线下还款_单次扣款成功偿还分期数_sum',
m6_manual_deduct_rep_apl_suc_stg_pln_cnt_max double comment '近6个月人工扣款_单次扣款成功偿还分期数_max',
m6_manual_deduct_rep_apl_suc_stg_pln_cnt_min double comment '近6个月人工扣款_单次扣款成功偿还分期数_min',
m6_manual_deduct_rep_apl_suc_stg_pln_cnt_avg double comment '近6个月人工扣款_单次扣款成功偿还分期数_avg',
m6_manual_deduct_rep_apl_suc_stg_pln_cnt_sum double comment '近6个月人工扣款_单次扣款成功偿还分期数_sum',
m6_normal_batch_rep_apl_suc_stg_pln_cnt_max double comment '近6个月常规批扣_单次扣款成功偿还分期数_max',
m6_normal_batch_rep_apl_suc_stg_pln_cnt_min double comment '近6个月常规批扣_单次扣款成功偿还分期数_min',
m6_normal_batch_rep_apl_suc_stg_pln_cnt_avg double comment '近6个月常规批扣_单次扣款成功偿还分期数_avg',
m6_normal_batch_rep_apl_suc_stg_pln_cnt_sum double comment '近6个月常规批扣_单次扣款成功偿还分期数_sum',
m6_add_bathch_rep_apl_suc_stg_pln_cnt_max double comment '近6个月逾期批扣_单次扣款成功偿还分期数_max',
m6_add_bathch_rep_apl_suc_stg_pln_cnt_min double comment '近6个月逾期批扣_单次扣款成功偿还分期数_min',
m6_add_bathch_rep_apl_suc_stg_pln_cnt_avg double comment '近6个月逾期批扣_单次扣款成功偿还分期数_avg',
m6_add_bathch_rep_apl_suc_stg_pln_cnt_sum double comment '近6个月逾期批扣_单次扣款成功偿还分期数_sum',
m6_rep_apl_fal_stg_pln_cnt_max double comment '近6个月单次扣款失败偿还分期数_max',
m6_rep_apl_fal_stg_pln_cnt_min double comment '近6个月单次扣款失败偿还分期数_min',
m6_rep_apl_fal_stg_pln_cnt_avg double comment '近6个月单次扣款失败偿还分期数_avg',
m6_rep_apl_fal_stg_pln_cnt_sum double comment '近6个月单次扣款失败偿还分期数_sum',
m6_manual_rep_apl_fal_stg_pln_cnt_max double comment '近6个月用户主动还款_单次扣款失败偿还分期数_max',
m6_manual_rep_apl_fal_stg_pln_cnt_min double comment '近6个月用户主动还款_单次扣款失败偿还分期数_min',
m6_manual_rep_apl_fal_stg_pln_cnt_avg double comment '近6个月用户主动还款_单次扣款失败偿还分期数_avg',
m6_manual_rep_apl_fal_stg_pln_cnt_sum double comment '近6个月用户主动还款_单次扣款失败偿还分期数_sum',
m6_ao_offline_rep_apl_fal_stg_pln_cnt_max double comment '近6个月(数禾对公)线下还款_单次扣款失败偿还分期数_max',
m6_ao_offline_rep_apl_fal_stg_pln_cnt_min double comment '近6个月(数禾对公)线下还款_单次扣款失败偿还分期数_min',
m6_ao_offline_rep_apl_fal_stg_pln_cnt_avg double comment '近6个月(数禾对公)线下还款_单次扣款失败偿还分期数_avg',
m6_ao_offline_rep_apl_fal_stg_pln_cnt_sum double comment '近6个月(数禾对公)线下还款_单次扣款失败偿还分期数_sum',
m6_manual_deduct_rep_apl_fal_stg_pln_cnt_max double comment '近6个月人工扣款_单次扣款失败偿还分期数_max',
m6_manual_deduct_rep_apl_fal_stg_pln_cnt_min double comment '近6个月人工扣款_单次扣款失败偿还分期数_min',
m6_manual_deduct_rep_apl_fal_stg_pln_cnt_avg double comment '近6个月人工扣款_单次扣款失败偿还分期数_avg',
m6_manual_deduct_rep_apl_fal_stg_pln_cnt_sum double comment '近6个月人工扣款_单次扣款失败偿还分期数_sum',
m6_normal_batch_rep_apl_fal_stg_pln_cnt_max double comment '近6个月常规批扣_单次扣款失败偿还分期数_max',
m6_normal_batch_rep_apl_fal_stg_pln_cnt_min double comment '近6个月常规批扣_单次扣款失败偿还分期数_min',
m6_normal_batch_rep_apl_fal_stg_pln_cnt_avg double comment '近6个月常规批扣_单次扣款失败偿还分期数_avg',
m6_normal_batch_rep_apl_fal_stg_pln_cnt_sum double comment '近6个月常规批扣_单次扣款失败偿还分期数_sum',
m6_add_bathch_rep_apl_fal_stg_pln_cnt_max double comment '近6个月逾期批扣_单次扣款失败偿还分期数_max',
m6_add_bathch_rep_apl_fal_stg_pln_cnt_min double comment '近6个月逾期批扣_单次扣款失败偿还分期数_min',
m6_add_bathch_rep_apl_fal_stg_pln_cnt_avg double comment '近6个月逾期批扣_单次扣款失败偿还分期数_avg',
m6_add_bathch_rep_apl_fal_stg_pln_cnt_sum double comment '近6个月逾期批扣_单次扣款失败偿还分期数_sum',
m1_rep_apl_amt_rat_mor_1_cnt double comment '近1个月扣款金额比例大于1的次数',
m1_rep_apl_amt_rat_equal_1_cnt double comment '近1个月扣款金额比例小于1的次数',
m1_rep_apl_amt_rat_les_1_cnt double comment '近1个月扣款金额比例小于1的次数',
m3_rep_apl_amt_rat_mor_1_cnt double comment '近3个月扣款金额比例大于1的次数',
m3_rep_apl_amt_rat_equal_1_cnt double comment '近3个月扣款金额比例小于1的次数',
m3_rep_apl_amt_rat_les_1_cnt double comment '近3个月扣款金额比例小于1的次数',
m6_rep_apl_amt_rat_mor_1_cnt double comment '近6个月扣款金额比例大于1的次数',
m6_rep_apl_amt_rat_equal_1_cnt double comment '近6个月扣款金额比例小于1的次数',
m6_rep_apl_amt_rat_les_1_cnt double comment '近6个月扣款金额比例小于1的次数',
m1_rep_apl_suc_amt_rat_mor_1_cnt double comment '近1个月扣款成功金额比例大于1的次数',
m1_rep_apl_suc_amt_rat_equal_1_cnt double comment '近1个月扣款成功金额比例小于1的次数',
m1_rep_apl_suc_amt_rat_les_1_cnt double comment '近1个月扣款成功金额比例小于1的次数',
m3_rep_apl_suc_amt_rat_mor_1_cnt double comment '近3个月扣款成功金额比例大于1的次数',
m3_rep_apl_suc_amt_rat_equal_1_cnt double comment '近3个月扣款成功金额比例小于1的次数',
m3_rep_apl_suc_amt_rat_les_1_cnt double comment '近3个月扣款成功金额比例小于1的次数',
m6_rep_apl_suc_amt_rat_mor_1_cnt double comment '近6个月扣款成功金额比例大于1的次数',
m6_rep_apl_suc_amt_rat_equal_1_cnt double comment '近6个月扣款成功金额比例小于1的次数',
m6_rep_apl_suc_amt_rat_les_1_cnt double comment '近6个月扣款成功金额比例小于1的次数',
m1_rep_apl_fal_amt_rat_mor_1_cnt double comment '近1个月扣款失败金额比例大于1的次数',
m1_rep_apl_fal_amt_rat_equal_1_cnt double comment '近1个月扣款失败金额比例小于1的次数',
m1_rep_apl_fal_amt_rat_les_1_cnt double comment '近1个月扣款失败金额比例小于1的次数',
m3_rep_apl_fal_amt_rat_mor_1_cnt double comment '近3个月扣款失败金额比例大于1的次数',
m3_rep_apl_fal_amt_rat_equal_1_cnt double comment '近3个月扣款失败金额比例小于1的次数',
m3_rep_apl_fal_amt_rat_les_1_cnt double comment '近3个月扣款失败金额比例小于1的次数',
m6_rep_apl_fal_amt_rat_mor_1_cnt double comment '近6个月扣款失败金额比例大于1的次数',
m6_rep_apl_fal_amt_rat_equal_1_cnt double comment '近6个月扣款失败金额比例小于1的次数',
m6_rep_apl_fal_amt_rat_les_1_cnt double comment '近6个月扣款失败金额比例小于1的次数',
m1_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近1个月扣款_偿还分期数大于1',
m1_manual_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近1个月用户主动还款_扣款_偿还分期数大于1',
m1_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近1个月(数禾对公)线下还款_扣款_偿还分期数大于1',
m1_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近1个月人工扣款_扣款_偿还分期数大于1',
m1_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近1个月常规批扣_扣款_偿还分期数大于1',
m1_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近1个月扣款成功_偿还分期数大于1',
m1_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近1个月用户主动还款_扣款成功_偿还分期数大于1',
m1_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近1个月(数禾对公)线下还款_扣款成功_偿还分期数大于1',
m1_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近1个月人工扣款_扣款成功_偿还分期数大于1',
m1_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近1个月常规批扣_扣款成功_偿还分期数大于1',
m1_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近1个月扣款失败_偿还分期数大于1',
m1_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近1个月用户主动还款_扣款失败_偿还分期数大于1',
m1_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近1个月(数禾对公)线下还款_扣款失败_偿还分期数大于1',
m1_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近1个月人工扣款_扣款失败_偿还分期数大于1',
m1_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近1个月常规批扣_扣款失败_偿还分期数大于1',
m3_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近3个月扣款_偿还分期数大于1',
m3_manual_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近3个月用户主动还款_扣款_偿还分期数大于1',
m3_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近3个月(数禾对公)线下还款_扣款_偿还分期数大于1',
m3_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近3个月人工扣款_扣款_偿还分期数大于1',
m3_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近3个月常规批扣_扣款_偿还分期数大于1',
m3_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近3个月扣款成功_偿还分期数大于1',
m3_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近3个月用户主动还款_扣款成功_偿还分期数大于1',
m3_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近3个月(数禾对公)线下还款_扣款成功_偿还分期数大于1',
m3_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近3个月人工扣款_扣款成功_偿还分期数大于1',
m3_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近3个月常规批扣_扣款成功_偿还分期数大于1',
m3_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近3个月扣款失败_偿还分期数大于1',
m3_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近3个月用户主动还款_扣款失败_偿还分期数大于1',
m3_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近3个月(数禾对公)线下还款_扣款失败_偿还分期数大于1',
m3_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近3个月人工扣款_扣款失败_偿还分期数大于1',
m3_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近3个月常规批扣_扣款失败_偿还分期数大于1',
m6_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近6个月扣款_偿还分期数大于1',
m6_manual_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近6个月用户主动还款_扣款_偿还分期数大于1',
m6_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近6个月(数禾对公)线下还款_扣款_偿还分期数大于1',
m6_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近6个月人工扣款_扣款_偿还分期数大于1',
m6_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt double comment '近6个月常规批扣_扣款_偿还分期数大于1',
m6_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近6个月扣款成功_偿还分期数大于1',
m6_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近6个月用户主动还款_扣款成功_偿还分期数大于1',
m6_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近6个月(数禾对公)线下还款_扣款成功_偿还分期数大于1',
m6_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近6个月人工扣款_扣款成功_偿还分期数大于1',
m6_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt double comment '近6个月常规批扣_扣款成功_偿还分期数大于1',
m6_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近6个月扣款失败_偿还分期数大于1',
m6_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近6个月用户主动还款_扣款失败_偿还分期数大于1',
m6_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近6个月(数禾对公)线下还款_扣款失败_偿还分期数大于1',
m6_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近6个月人工扣款_扣款失败_偿还分期数大于1',
m6_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt double comment '近6个月常规批扣_扣款失败_偿还分期数大于1'
)comment 'dwa_risk_dz_model_final_rep_apply_summary_2'
partitioned by (ds string)
;


set odps.stage.mapper.split.size=20;
-- by 单次扣款记录明细
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp;
create table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp as 
select uid
       ,mdl_dte

       ,repay_apply_no
       ,repay_status

       -- 时间标签
       ,max(m1_flg) as m1_flg
       ,max(m3_flg) as m3_flg
       ,max(m6_flg) as m6_flg

       -- 分期计划数 -- 
       ,count(stg_pln_no) as rep_apl_stg_pln_cnt
       ,count(case when rpy_desc = '(用户)主动还款' then stg_pln_no else NULL end) as manual_rep_apl_stg_pln_cnt
       ,count(case when rpy_desc = '(数禾对公)线下还款' then stg_pln_no else NULL end) as ao_offline_rep_apl_stg_pln_cnt
       ,count(case when rpy_desc = '人工扣款' then stg_pln_no else NULL end) as manual_deduct_rep_apl_stg_pln_cnt
       ,count(case when rpy_desc = '常规批扣' then stg_pln_no else NULL end) as normal_batch_rep_apl_stg_pln_cnt
       ,count(case when rpy_desc = '逾期批扣' then stg_pln_no else NULL end) as add_bathch_rep_apl_stg_pln_cnt

       ,count(case when repay_status like '%SUCCESS%' then stg_pln_no else NULL end) as rep_apl_suc_stg_pln_cnt
       ,count(case when rpy_desc = '(用户)主动还款' and repay_status like '%SUCCESS%' then stg_pln_no else NULL end) as manual_rep_apl_suc_stg_pln_cnt
       ,count(case when rpy_desc = '(数禾对公)线下还款' and repay_status like '%SUCCESS%' then stg_pln_no else NULL end) as ao_offline_rep_apl_suc_stg_pln_cnt
       ,count(case when rpy_desc = '人工扣款' and repay_status like '%SUCCESS%' then stg_pln_no else NULL end) as manual_deduct_rep_apl_suc_stg_pln_cnt
       ,count(case when rpy_desc = '常规批扣' and repay_status like '%SUCCESS%' then stg_pln_no else NULL end) as normal_batch_rep_apl_suc_stg_pln_cnt
       ,count(case when rpy_desc = '逾期批扣' and repay_status like '%SUCCESS%' then stg_pln_no else NULL end) as add_bathch_rep_apl_suc_stg_pln_cnt

       ,count(case when repay_status = 'FAILURE' then stg_pln_no else NULL end) as rep_apl_fal_stg_pln_cnt
       ,count(case when rpy_desc = '(用户)主动还款' and repay_status = 'FAILURE' then stg_pln_no else NULL end) as manual_rep_apl_fal_stg_pln_cnt
       ,count(case when rpy_desc = '(数禾对公)线下还款' and repay_status = 'FAILURE' then stg_pln_no else NULL end) as ao_offline_rep_apl_fal_stg_pln_cnt
       ,count(case when rpy_desc = '人工扣款' and repay_status = 'FAILURE' then stg_pln_no else NULL end) as manual_deduct_rep_apl_fal_stg_pln_cnt
       ,count(case when rpy_desc = '常规批扣' and repay_status = 'FAILURE' then stg_pln_no else NULL end) as normal_batch_rep_apl_fal_stg_pln_cnt
       ,count(case when rpy_desc = '逾期批扣' and repay_status = 'FAILURE' then stg_pln_no else NULL end) as add_bathch_rep_apl_fal_stg_pln_cnt

       -- 金额 --
       ,max(case when cast(rep_amt as int)>cast(amt as int) then 1 else 0 end) as rep_apl_amt_rat_mor_1
       ,max(case when cast(rep_amt as int)=cast(amt as int) then 1 else 0 end) as rep_apl_amt_rat_equal_1
       ,max(case when cast(rep_amt as int)<cast(amt as int) then 1 else 0 end) as rep_apl_amt_rat_les_1
from 
(
	select uid
        , mdl_dte
        , repay_apply_no, stg_pln_no
		, repay_status, rpy_desc, rep_amt, amt
        , m1_flg, m3_flg, m6_flg
	from ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail
    where repay_type = 'STAGE'
	group by uid
        , mdl_dte
        , repay_apply_no, stg_pln_no
		, repay_status, rpy_desc, rep_amt, amt
        , m1_flg, m3_flg, m6_flg
) a
-- and uid = '1dbe7d71-5079-475c-a968-ebeabc6cda5a'
group by uid
         ,mdl_dte
         ,repay_apply_no
         ,repay_status
;


-- 单次扣款的分期计划汇总
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp1 as
select uid
       ,mdl_dte

       -- 单次扣款-分期计划数 --
       ,max(case when m1_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m1_rep_apl_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m1_rep_apl_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m1_rep_apl_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m1_rep_apl_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m1_manual_rep_apl_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m1_manual_rep_apl_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m1_manual_rep_apl_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m1_manual_rep_apl_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_stg_pln_cnt_sum   

       ,max(case when m1_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m1_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m1_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m1_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m1_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_suc_stg_pln_cnt_sum
       
       ,max(case when m1_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_suc_stg_pln_cnt_sum   

       ,max(case when m1_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m1_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m1_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m1_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m1_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m1_ao_offline_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m1_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m1_manual_deduct_rep_apl_fal_stg_pln_cnt_sum
       
       ,max(case when m1_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_normal_batch_rep_apl_fal_stg_pln_cnt_sum   

       ,max(case when m1_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m1_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m1_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m1_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m1_add_bathch_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m3_rep_apl_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m3_rep_apl_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m3_rep_apl_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m3_rep_apl_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m3_manual_rep_apl_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m3_manual_rep_apl_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m3_manual_rep_apl_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m3_manual_rep_apl_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_stg_pln_cnt_sum   

       ,max(case when m3_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m3_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m3_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m3_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m3_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_suc_stg_pln_cnt_sum
       
       ,max(case when m3_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_suc_stg_pln_cnt_sum   

       ,max(case when m3_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m3_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m3_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m3_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m3_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m3_ao_offline_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m3_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m3_manual_deduct_rep_apl_fal_stg_pln_cnt_sum
       
       ,max(case when m3_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_normal_batch_rep_apl_fal_stg_pln_cnt_sum   

       ,max(case when m3_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m3_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m3_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m3_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m3_add_bathch_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m6_rep_apl_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m6_rep_apl_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m6_rep_apl_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then rep_apl_stg_pln_cnt else NULL end) as m6_rep_apl_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m6_manual_rep_apl_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m6_manual_rep_apl_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m6_manual_rep_apl_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then manual_rep_apl_stg_pln_cnt else NULL end) as m6_manual_rep_apl_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then ao_offline_rep_apl_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then manual_deduct_rep_apl_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then normal_batch_rep_apl_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_stg_pln_cnt_sum   

       ,max(case when m6_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then add_bathch_rep_apl_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m6_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m6_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m6_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then rep_apl_suc_stg_pln_cnt else NULL end) as m6_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then manual_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then ao_offline_rep_apl_suc_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then manual_deduct_rep_apl_suc_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_suc_stg_pln_cnt_sum
       
       ,max(case when m6_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then normal_batch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_suc_stg_pln_cnt_sum   

       ,max(case when m6_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_suc_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_suc_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_suc_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then add_bathch_rep_apl_suc_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_suc_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m6_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m6_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m6_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then rep_apl_fal_stg_pln_cnt else NULL end) as m6_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then manual_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then ao_offline_rep_apl_fal_stg_pln_cnt else NULL end) as m6_ao_offline_rep_apl_fal_stg_pln_cnt_sum

       ,max(case when m6_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then manual_deduct_rep_apl_fal_stg_pln_cnt else NULL end) as m6_manual_deduct_rep_apl_fal_stg_pln_cnt_sum
       
       ,max(case when m6_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then normal_batch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_normal_batch_rep_apl_fal_stg_pln_cnt_sum   

       ,max(case when m6_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_fal_stg_pln_cnt_max
       ,min(case when m6_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_fal_stg_pln_cnt_min
       ,avg(case when m6_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_fal_stg_pln_cnt_avg
       ,sum(case when m6_flg = 1 then add_bathch_rep_apl_fal_stg_pln_cnt else NULL end) as m6_add_bathch_rep_apl_fal_stg_pln_cnt_sum

       -- 单次扣款-金额比例-次数 --
       ,sum(case when m1_flg = 1 then rep_apl_amt_rat_mor_1 else NULL end) as m1_rep_apl_amt_rat_mor_1_cnt
       ,sum(case when m1_flg = 1 then rep_apl_amt_rat_equal_1 else NULL end) as m1_rep_apl_amt_rat_equal_1_cnt
       ,sum(case when m1_flg = 1 then rep_apl_amt_rat_les_1 else NULL end) as m1_rep_apl_amt_rat_les_1_cnt
       ,sum(case when m3_flg = 1 then rep_apl_amt_rat_mor_1 else NULL end) as m3_rep_apl_amt_rat_mor_1_cnt
       ,sum(case when m3_flg = 1 then rep_apl_amt_rat_equal_1 else NULL end) as m3_rep_apl_amt_rat_equal_1_cnt
       ,sum(case when m3_flg = 1 then rep_apl_amt_rat_les_1 else NULL end) as m3_rep_apl_amt_rat_les_1_cnt       
       ,sum(case when m6_flg = 1 then rep_apl_amt_rat_mor_1 else NULL end) as m6_rep_apl_amt_rat_mor_1_cnt
       ,sum(case when m6_flg = 1 then rep_apl_amt_rat_equal_1 else NULL end) as m6_rep_apl_amt_rat_equal_1_cnt
       ,sum(case when m6_flg = 1 then rep_apl_amt_rat_les_1 else NULL end) as m6_rep_apl_amt_rat_les_1_cnt 

       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_mor_1 else NULL end) as m1_rep_apl_suc_amt_rat_mor_1_cnt
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_equal_1 else NULL end) as m1_rep_apl_suc_amt_rat_equal_1_cnt
       ,sum(case when m1_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_les_1 else NULL end) as m1_rep_apl_suc_amt_rat_les_1_cnt
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_mor_1 else NULL end) as m3_rep_apl_suc_amt_rat_mor_1_cnt
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_equal_1 else NULL end) as m3_rep_apl_suc_amt_rat_equal_1_cnt
       ,sum(case when m3_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_les_1 else NULL end) as m3_rep_apl_suc_amt_rat_les_1_cnt       
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_mor_1 else NULL end) as m6_rep_apl_suc_amt_rat_mor_1_cnt
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_equal_1 else NULL end) as m6_rep_apl_suc_amt_rat_equal_1_cnt
       ,sum(case when m6_flg = 1 and repay_status like '%SUCCESS%' then rep_apl_amt_rat_les_1 else NULL end) as m6_rep_apl_suc_amt_rat_les_1_cnt               

       ,sum(case when m1_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_mor_1 else NULL end) as m1_rep_apl_fal_amt_rat_mor_1_cnt
       ,sum(case when m1_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_equal_1 else NULL end) as m1_rep_apl_fal_amt_rat_equal_1_cnt
       ,sum(case when m1_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_les_1 else NULL end) as m1_rep_apl_fal_amt_rat_les_1_cnt
       ,sum(case when m3_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_mor_1 else NULL end) as m3_rep_apl_fal_amt_rat_mor_1_cnt
       ,sum(case when m3_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_equal_1 else NULL end) as m3_rep_apl_fal_amt_rat_equal_1_cnt
       ,sum(case when m3_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_les_1 else NULL end) as m3_rep_apl_fal_amt_rat_les_1_cnt       
       ,sum(case when m6_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_mor_1 else NULL end) as m6_rep_apl_fal_amt_rat_mor_1_cnt
       ,sum(case when m6_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_equal_1 else NULL end) as m6_rep_apl_fal_amt_rat_equal_1_cnt
       ,sum(case when m6_flg = 1 and repay_status = 'FAILURE' then rep_apl_amt_rat_les_1 else NULL end) as m6_rep_apl_fal_amt_rat_les_1_cnt                             
from ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp
group by uid
         ,mdl_dte

;




drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp2 as
select uid
       ,mdl_dte

       -- 单次扣款的分期计划数大于1的次数 --
       ,count(case when m1_flg = 1 and rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and manual_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_manual_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and ao_offline_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and manual_deduct_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and normal_batch_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt

       ,count(case when m1_flg = 1 and rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and manual_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and ao_offline_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and manual_deduct_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and normal_batch_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt

       ,count(case when m1_flg = 1 and rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and manual_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and ao_offline_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and manual_deduct_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m1_flg = 1 and normal_batch_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m1_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt

       ,count(case when m3_flg = 1 and rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and manual_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_manual_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and ao_offline_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and manual_deduct_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and normal_batch_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt

       ,count(case when m3_flg = 1 and rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and manual_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and ao_offline_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and manual_deduct_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and normal_batch_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt

       ,count(case when m3_flg = 1 and rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and manual_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and ao_offline_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and manual_deduct_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m3_flg = 1 and normal_batch_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m3_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt

       ,count(case when m6_flg = 1 and rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and manual_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_manual_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and ao_offline_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and manual_deduct_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and normal_batch_rep_apl_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt

       ,count(case when m6_flg = 1 and rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and manual_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and ao_offline_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and manual_deduct_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and normal_batch_rep_apl_suc_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt

       ,count(case when m6_flg = 1 and rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and manual_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and ao_offline_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and manual_deduct_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt
       ,count(case when m6_flg = 1 and normal_batch_rep_apl_fal_stg_pln_cnt>1 then repay_apply_no else NULL end) as m6_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt
from ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp
group by uid
         ,mdl_dte
;


-- 合并
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2 partition (ds = '${bizdate}')
select  
        a.uid
        ,a.mdl_dte
        ,a.m1_rep_apl_stg_pln_cnt_max
        ,a.m1_rep_apl_stg_pln_cnt_min
        ,a.m1_rep_apl_stg_pln_cnt_avg
        ,a.m1_rep_apl_stg_pln_cnt_sum
        ,a.m1_manual_rep_apl_stg_pln_cnt_max
        ,a.m1_manual_rep_apl_stg_pln_cnt_min
        ,a.m1_manual_rep_apl_stg_pln_cnt_avg
        ,a.m1_manual_rep_apl_stg_pln_cnt_sum
        ,a.m1_ao_offline_rep_apl_stg_pln_cnt_max
        ,a.m1_ao_offline_rep_apl_stg_pln_cnt_min
        ,a.m1_ao_offline_rep_apl_stg_pln_cnt_avg
        ,a.m1_ao_offline_rep_apl_stg_pln_cnt_sum
        ,a.m1_manual_deduct_rep_apl_stg_pln_cnt_max
        ,a.m1_manual_deduct_rep_apl_stg_pln_cnt_min
        ,a.m1_manual_deduct_rep_apl_stg_pln_cnt_avg
        ,a.m1_manual_deduct_rep_apl_stg_pln_cnt_sum
        ,a.m1_normal_batch_rep_apl_stg_pln_cnt_max
        ,a.m1_normal_batch_rep_apl_stg_pln_cnt_min
        ,a.m1_normal_batch_rep_apl_stg_pln_cnt_avg
        ,a.m1_normal_batch_rep_apl_stg_pln_cnt_sum
        ,a.m1_add_bathch_rep_apl_stg_pln_cnt_max
        ,a.m1_add_bathch_rep_apl_stg_pln_cnt_min
        ,a.m1_add_bathch_rep_apl_stg_pln_cnt_avg
        ,a.m1_add_bathch_rep_apl_stg_pln_cnt_sum
        ,a.m1_rep_apl_suc_stg_pln_cnt_max
        ,a.m1_rep_apl_suc_stg_pln_cnt_min
        ,a.m1_rep_apl_suc_stg_pln_cnt_avg
        ,a.m1_rep_apl_suc_stg_pln_cnt_sum
        ,a.m1_manual_rep_apl_suc_stg_pln_cnt_max
        ,a.m1_manual_rep_apl_suc_stg_pln_cnt_min
        ,a.m1_manual_rep_apl_suc_stg_pln_cnt_avg
        ,a.m1_manual_rep_apl_suc_stg_pln_cnt_sum
        ,a.m1_ao_offline_rep_apl_suc_stg_pln_cnt_max
        ,a.m1_ao_offline_rep_apl_suc_stg_pln_cnt_min
        ,a.m1_ao_offline_rep_apl_suc_stg_pln_cnt_avg
        ,a.m1_ao_offline_rep_apl_suc_stg_pln_cnt_sum
        ,a.m1_manual_deduct_rep_apl_suc_stg_pln_cnt_max
        ,a.m1_manual_deduct_rep_apl_suc_stg_pln_cnt_min
        ,a.m1_manual_deduct_rep_apl_suc_stg_pln_cnt_avg
        ,a.m1_manual_deduct_rep_apl_suc_stg_pln_cnt_sum
        ,a.m1_normal_batch_rep_apl_suc_stg_pln_cnt_max
        ,a.m1_normal_batch_rep_apl_suc_stg_pln_cnt_min
        ,a.m1_normal_batch_rep_apl_suc_stg_pln_cnt_avg
        ,a.m1_normal_batch_rep_apl_suc_stg_pln_cnt_sum
        ,a.m1_add_bathch_rep_apl_suc_stg_pln_cnt_max
        ,a.m1_add_bathch_rep_apl_suc_stg_pln_cnt_min
        ,a.m1_add_bathch_rep_apl_suc_stg_pln_cnt_avg
        ,a.m1_add_bathch_rep_apl_suc_stg_pln_cnt_sum
        ,a.m1_rep_apl_fal_stg_pln_cnt_max
        ,a.m1_rep_apl_fal_stg_pln_cnt_min
        ,a.m1_rep_apl_fal_stg_pln_cnt_avg
        ,a.m1_rep_apl_fal_stg_pln_cnt_sum
        ,a.m1_manual_rep_apl_fal_stg_pln_cnt_max
        ,a.m1_manual_rep_apl_fal_stg_pln_cnt_min
        ,a.m1_manual_rep_apl_fal_stg_pln_cnt_avg
        ,a.m1_manual_rep_apl_fal_stg_pln_cnt_sum
        ,a.m1_ao_offline_rep_apl_fal_stg_pln_cnt_max
        ,a.m1_ao_offline_rep_apl_fal_stg_pln_cnt_min
        ,a.m1_ao_offline_rep_apl_fal_stg_pln_cnt_avg
        ,a.m1_ao_offline_rep_apl_fal_stg_pln_cnt_sum
        ,a.m1_manual_deduct_rep_apl_fal_stg_pln_cnt_max
        ,a.m1_manual_deduct_rep_apl_fal_stg_pln_cnt_min
        ,a.m1_manual_deduct_rep_apl_fal_stg_pln_cnt_avg
        ,a.m1_manual_deduct_rep_apl_fal_stg_pln_cnt_sum
        ,a.m1_normal_batch_rep_apl_fal_stg_pln_cnt_max
        ,a.m1_normal_batch_rep_apl_fal_stg_pln_cnt_min
        ,a.m1_normal_batch_rep_apl_fal_stg_pln_cnt_avg
        ,a.m1_normal_batch_rep_apl_fal_stg_pln_cnt_sum
        ,a.m1_add_bathch_rep_apl_fal_stg_pln_cnt_max
        ,a.m1_add_bathch_rep_apl_fal_stg_pln_cnt_min
        ,a.m1_add_bathch_rep_apl_fal_stg_pln_cnt_avg
        ,a.m1_add_bathch_rep_apl_fal_stg_pln_cnt_sum
        ,a.m3_rep_apl_stg_pln_cnt_max
        ,a.m3_rep_apl_stg_pln_cnt_min
        ,a.m3_rep_apl_stg_pln_cnt_avg
        ,a.m3_rep_apl_stg_pln_cnt_sum
        ,a.m3_manual_rep_apl_stg_pln_cnt_max
        ,a.m3_manual_rep_apl_stg_pln_cnt_min
        ,a.m3_manual_rep_apl_stg_pln_cnt_avg
        ,a.m3_manual_rep_apl_stg_pln_cnt_sum
        ,a.m3_ao_offline_rep_apl_stg_pln_cnt_max
        ,a.m3_ao_offline_rep_apl_stg_pln_cnt_min
        ,a.m3_ao_offline_rep_apl_stg_pln_cnt_avg
        ,a.m3_ao_offline_rep_apl_stg_pln_cnt_sum
        ,a.m3_manual_deduct_rep_apl_stg_pln_cnt_max
        ,a.m3_manual_deduct_rep_apl_stg_pln_cnt_min
        ,a.m3_manual_deduct_rep_apl_stg_pln_cnt_avg
        ,a.m3_manual_deduct_rep_apl_stg_pln_cnt_sum
        ,a.m3_normal_batch_rep_apl_stg_pln_cnt_max
        ,a.m3_normal_batch_rep_apl_stg_pln_cnt_min
        ,a.m3_normal_batch_rep_apl_stg_pln_cnt_avg
        ,a.m3_normal_batch_rep_apl_stg_pln_cnt_sum
        ,a.m3_add_bathch_rep_apl_stg_pln_cnt_max
        ,a.m3_add_bathch_rep_apl_stg_pln_cnt_min
        ,a.m3_add_bathch_rep_apl_stg_pln_cnt_avg
        ,a.m3_add_bathch_rep_apl_stg_pln_cnt_sum
        ,a.m3_rep_apl_suc_stg_pln_cnt_max
        ,a.m3_rep_apl_suc_stg_pln_cnt_min
        ,a.m3_rep_apl_suc_stg_pln_cnt_avg
        ,a.m3_rep_apl_suc_stg_pln_cnt_sum
        ,a.m3_manual_rep_apl_suc_stg_pln_cnt_max
        ,a.m3_manual_rep_apl_suc_stg_pln_cnt_min
        ,a.m3_manual_rep_apl_suc_stg_pln_cnt_avg
        ,a.m3_manual_rep_apl_suc_stg_pln_cnt_sum
        ,a.m3_ao_offline_rep_apl_suc_stg_pln_cnt_max
        ,a.m3_ao_offline_rep_apl_suc_stg_pln_cnt_min
        ,a.m3_ao_offline_rep_apl_suc_stg_pln_cnt_avg
        ,a.m3_ao_offline_rep_apl_suc_stg_pln_cnt_sum
        ,a.m3_manual_deduct_rep_apl_suc_stg_pln_cnt_max
        ,a.m3_manual_deduct_rep_apl_suc_stg_pln_cnt_min
        ,a.m3_manual_deduct_rep_apl_suc_stg_pln_cnt_avg
        ,a.m3_manual_deduct_rep_apl_suc_stg_pln_cnt_sum
        ,a.m3_normal_batch_rep_apl_suc_stg_pln_cnt_max
        ,a.m3_normal_batch_rep_apl_suc_stg_pln_cnt_min
        ,a.m3_normal_batch_rep_apl_suc_stg_pln_cnt_avg
        ,a.m3_normal_batch_rep_apl_suc_stg_pln_cnt_sum
        ,a.m3_add_bathch_rep_apl_suc_stg_pln_cnt_max
        ,a.m3_add_bathch_rep_apl_suc_stg_pln_cnt_min
        ,a.m3_add_bathch_rep_apl_suc_stg_pln_cnt_avg
        ,a.m3_add_bathch_rep_apl_suc_stg_pln_cnt_sum
        ,a.m3_rep_apl_fal_stg_pln_cnt_max
        ,a.m3_rep_apl_fal_stg_pln_cnt_min
        ,a.m3_rep_apl_fal_stg_pln_cnt_avg
        ,a.m3_rep_apl_fal_stg_pln_cnt_sum
        ,a.m3_manual_rep_apl_fal_stg_pln_cnt_max
        ,a.m3_manual_rep_apl_fal_stg_pln_cnt_min
        ,a.m3_manual_rep_apl_fal_stg_pln_cnt_avg
        ,a.m3_manual_rep_apl_fal_stg_pln_cnt_sum
        ,a.m3_ao_offline_rep_apl_fal_stg_pln_cnt_max
        ,a.m3_ao_offline_rep_apl_fal_stg_pln_cnt_min
        ,a.m3_ao_offline_rep_apl_fal_stg_pln_cnt_avg
        ,a.m3_ao_offline_rep_apl_fal_stg_pln_cnt_sum
        ,a.m3_manual_deduct_rep_apl_fal_stg_pln_cnt_max
        ,a.m3_manual_deduct_rep_apl_fal_stg_pln_cnt_min
        ,a.m3_manual_deduct_rep_apl_fal_stg_pln_cnt_avg
        ,a.m3_manual_deduct_rep_apl_fal_stg_pln_cnt_sum
        ,a.m3_normal_batch_rep_apl_fal_stg_pln_cnt_max
        ,a.m3_normal_batch_rep_apl_fal_stg_pln_cnt_min
        ,a.m3_normal_batch_rep_apl_fal_stg_pln_cnt_avg
        ,a.m3_normal_batch_rep_apl_fal_stg_pln_cnt_sum
        ,a.m3_add_bathch_rep_apl_fal_stg_pln_cnt_max
        ,a.m3_add_bathch_rep_apl_fal_stg_pln_cnt_min
        ,a.m3_add_bathch_rep_apl_fal_stg_pln_cnt_avg
        ,a.m3_add_bathch_rep_apl_fal_stg_pln_cnt_sum
        ,a.m6_rep_apl_stg_pln_cnt_max
        ,a.m6_rep_apl_stg_pln_cnt_min
        ,a.m6_rep_apl_stg_pln_cnt_avg
        ,a.m6_rep_apl_stg_pln_cnt_sum
        ,a.m6_manual_rep_apl_stg_pln_cnt_max
        ,a.m6_manual_rep_apl_stg_pln_cnt_min
        ,a.m6_manual_rep_apl_stg_pln_cnt_avg
        ,a.m6_manual_rep_apl_stg_pln_cnt_sum
        ,a.m6_ao_offline_rep_apl_stg_pln_cnt_max
        ,a.m6_ao_offline_rep_apl_stg_pln_cnt_min
        ,a.m6_ao_offline_rep_apl_stg_pln_cnt_avg
        ,a.m6_ao_offline_rep_apl_stg_pln_cnt_sum
        ,a.m6_manual_deduct_rep_apl_stg_pln_cnt_max
        ,a.m6_manual_deduct_rep_apl_stg_pln_cnt_min
        ,a.m6_manual_deduct_rep_apl_stg_pln_cnt_avg
        ,a.m6_manual_deduct_rep_apl_stg_pln_cnt_sum
        ,a.m6_normal_batch_rep_apl_stg_pln_cnt_max
        ,a.m6_normal_batch_rep_apl_stg_pln_cnt_min
        ,a.m6_normal_batch_rep_apl_stg_pln_cnt_avg
        ,a.m6_normal_batch_rep_apl_stg_pln_cnt_sum
        ,a.m6_add_bathch_rep_apl_stg_pln_cnt_max
        ,a.m6_add_bathch_rep_apl_stg_pln_cnt_min
        ,a.m6_add_bathch_rep_apl_stg_pln_cnt_avg
        ,a.m6_add_bathch_rep_apl_stg_pln_cnt_sum
        ,a.m6_rep_apl_suc_stg_pln_cnt_max
        ,a.m6_rep_apl_suc_stg_pln_cnt_min
        ,a.m6_rep_apl_suc_stg_pln_cnt_avg
        ,a.m6_rep_apl_suc_stg_pln_cnt_sum
        ,a.m6_manual_rep_apl_suc_stg_pln_cnt_max
        ,a.m6_manual_rep_apl_suc_stg_pln_cnt_min
        ,a.m6_manual_rep_apl_suc_stg_pln_cnt_avg
        ,a.m6_manual_rep_apl_suc_stg_pln_cnt_sum
        ,a.m6_ao_offline_rep_apl_suc_stg_pln_cnt_max
        ,a.m6_ao_offline_rep_apl_suc_stg_pln_cnt_min
        ,a.m6_ao_offline_rep_apl_suc_stg_pln_cnt_avg
        ,a.m6_ao_offline_rep_apl_suc_stg_pln_cnt_sum
        ,a.m6_manual_deduct_rep_apl_suc_stg_pln_cnt_max
        ,a.m6_manual_deduct_rep_apl_suc_stg_pln_cnt_min
        ,a.m6_manual_deduct_rep_apl_suc_stg_pln_cnt_avg
        ,a.m6_manual_deduct_rep_apl_suc_stg_pln_cnt_sum
        ,a.m6_normal_batch_rep_apl_suc_stg_pln_cnt_max
        ,a.m6_normal_batch_rep_apl_suc_stg_pln_cnt_min
        ,a.m6_normal_batch_rep_apl_suc_stg_pln_cnt_avg
        ,a.m6_normal_batch_rep_apl_suc_stg_pln_cnt_sum
        ,a.m6_add_bathch_rep_apl_suc_stg_pln_cnt_max
        ,a.m6_add_bathch_rep_apl_suc_stg_pln_cnt_min
        ,a.m6_add_bathch_rep_apl_suc_stg_pln_cnt_avg
        ,a.m6_add_bathch_rep_apl_suc_stg_pln_cnt_sum
        ,a.m6_rep_apl_fal_stg_pln_cnt_max
        ,a.m6_rep_apl_fal_stg_pln_cnt_min
        ,a.m6_rep_apl_fal_stg_pln_cnt_avg
        ,a.m6_rep_apl_fal_stg_pln_cnt_sum
        ,a.m6_manual_rep_apl_fal_stg_pln_cnt_max
        ,a.m6_manual_rep_apl_fal_stg_pln_cnt_min
        ,a.m6_manual_rep_apl_fal_stg_pln_cnt_avg
        ,a.m6_manual_rep_apl_fal_stg_pln_cnt_sum
        ,a.m6_ao_offline_rep_apl_fal_stg_pln_cnt_max
        ,a.m6_ao_offline_rep_apl_fal_stg_pln_cnt_min
        ,a.m6_ao_offline_rep_apl_fal_stg_pln_cnt_avg
        ,a.m6_ao_offline_rep_apl_fal_stg_pln_cnt_sum
        ,a.m6_manual_deduct_rep_apl_fal_stg_pln_cnt_max
        ,a.m6_manual_deduct_rep_apl_fal_stg_pln_cnt_min
        ,a.m6_manual_deduct_rep_apl_fal_stg_pln_cnt_avg
        ,a.m6_manual_deduct_rep_apl_fal_stg_pln_cnt_sum
        ,a.m6_normal_batch_rep_apl_fal_stg_pln_cnt_max
        ,a.m6_normal_batch_rep_apl_fal_stg_pln_cnt_min
        ,a.m6_normal_batch_rep_apl_fal_stg_pln_cnt_avg
        ,a.m6_normal_batch_rep_apl_fal_stg_pln_cnt_sum
        ,a.m6_add_bathch_rep_apl_fal_stg_pln_cnt_max
        ,a.m6_add_bathch_rep_apl_fal_stg_pln_cnt_min
        ,a.m6_add_bathch_rep_apl_fal_stg_pln_cnt_avg
        ,a.m6_add_bathch_rep_apl_fal_stg_pln_cnt_sum
        ,a.m1_rep_apl_amt_rat_mor_1_cnt
        ,a.m1_rep_apl_amt_rat_equal_1_cnt
        ,a.m1_rep_apl_amt_rat_les_1_cnt
        ,a.m3_rep_apl_amt_rat_mor_1_cnt
        ,a.m3_rep_apl_amt_rat_equal_1_cnt
        ,a.m3_rep_apl_amt_rat_les_1_cnt
        ,a.m6_rep_apl_amt_rat_mor_1_cnt
        ,a.m6_rep_apl_amt_rat_equal_1_cnt
        ,a.m6_rep_apl_amt_rat_les_1_cnt
        ,a.m1_rep_apl_suc_amt_rat_mor_1_cnt
        ,a.m1_rep_apl_suc_amt_rat_equal_1_cnt
        ,a.m1_rep_apl_suc_amt_rat_les_1_cnt
        ,a.m3_rep_apl_suc_amt_rat_mor_1_cnt
        ,a.m3_rep_apl_suc_amt_rat_equal_1_cnt
        ,a.m3_rep_apl_suc_amt_rat_les_1_cnt
        ,a.m6_rep_apl_suc_amt_rat_mor_1_cnt
        ,a.m6_rep_apl_suc_amt_rat_equal_1_cnt
        ,a.m6_rep_apl_suc_amt_rat_les_1_cnt
        ,a.m1_rep_apl_fal_amt_rat_mor_1_cnt
        ,a.m1_rep_apl_fal_amt_rat_equal_1_cnt
        ,a.m1_rep_apl_fal_amt_rat_les_1_cnt
        ,a.m3_rep_apl_fal_amt_rat_mor_1_cnt
        ,a.m3_rep_apl_fal_amt_rat_equal_1_cnt
        ,a.m3_rep_apl_fal_amt_rat_les_1_cnt
        ,a.m6_rep_apl_fal_amt_rat_mor_1_cnt
        ,a.m6_rep_apl_fal_amt_rat_equal_1_cnt
        ,a.m6_rep_apl_fal_amt_rat_les_1_cnt
        ,m1_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m1_manual_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m1_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m1_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m1_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m1_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m1_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m1_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m1_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m1_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m1_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m1_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m1_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m1_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m1_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m3_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m3_manual_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m3_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m3_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m3_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m3_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m3_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m3_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m3_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m3_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m3_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m3_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m3_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m3_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m3_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m6_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m6_manual_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m6_ao_offline_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m6_manual_deduct_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m6_normal_batch_rep_apl_stg_pln_cnt_mor_1_cnt
        ,m6_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m6_manual_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m6_ao_offline_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m6_manual_deduct_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m6_normal_batch_rep_apl_suc_stg_pln_cnt_mor_1_cnt
        ,m6_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m6_manual_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m6_ao_offline_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m6_manual_deduct_rep_apl_fal_stg_pln_cnt_mor_1_cnt
        ,m6_normal_batch_rep_apl_fal_stg_pln_cnt_mor_1_cnt       
from ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp1 as a
left join ${dwa_risk}.dwa_risk_dz_model_final_rep_apply_summary_2_tmp2 as b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;
-- feature-copilot:node-end ordinal=0
