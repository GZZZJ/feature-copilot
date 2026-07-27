-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_repayment_deduct_info_df
-- node_id: n_4291055955200311296
-- task_name: dwa_risk_dz_model_final_repayment_deduct_info_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_repayment_deduct_info_df.json
-- source_json_sha256: 0685fb3890b4d615d5f431a2e02e67a8d73c86fcbb1883c4d994a8e69ef35385
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp1
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_stg_pln_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_detail
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_tmp
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsrepayali_repayengine_deduct_bill_df
-- upstream_table: cdmx.cdmx_fct_heavy_payment_deduct_df
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsrepayali_repayengine_repay_apply_stage_plan_item_di
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp3
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp4
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp1
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 贷中宽表_扣款余额不足数据
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 刘诗涵
--创建日期: 2022-12-13 19:02:30
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
m1_payment_not_eng_mdl_crt_ddf_min INT comment '近1个月扣款余额不足距今天数_min',
m1_payment_not_eng_mdl_crt_ddf_max INT comment '近1个月扣款余额不足距今天数_max',
m1_payment_not_eng_mdl_crt_ddf_avg DOUBLE comment '近1个月扣款余额不足距今天数_avg',
m1_payment_not_eng_inteday_min INT comment '近1个月扣款余额不足间隔天数_min',
m1_payment_not_eng_inteday_max INT comment '近1个月扣款余额不足间隔天数_max',
m1_payment_not_eng_inteday_avg DOUBLE comment '近1个月扣款余额不足间隔天数_avg',
m3_payment_not_eng_mdl_crt_ddf_min INT comment '近3个月扣款余额不足距今天数_min',
m3_payment_not_eng_mdl_crt_ddf_max INT comment '近3个月扣款余额不足距今天数_max',
m3_payment_not_eng_mdl_crt_ddf_avg DOUBLE comment '近3个月扣款余额不足距今天数_avg',
m3_payment_not_eng_inteday_min INT comment '近3个月扣款余额不足间隔天数_min',
m3_payment_not_eng_inteday_max INT comment '近3个月扣款余额不足间隔天数_max',
m3_payment_not_eng_inteday_avg DOUBLE comment '近3个月扣款余额不足间隔天数_avg',
m6_payment_not_eng_mdl_crt_ddf_min INT comment '近6个月扣款余额不足距今天数_min',
m6_payment_not_eng_mdl_crt_ddf_max INT comment '近6个月扣款余额不足距今天数_max',
m6_payment_not_eng_mdl_crt_ddf_avg DOUBLE comment '近6个月扣款余额不足距今天数_avg',
m6_payment_not_eng_inteday_min INT comment '近6个月扣款余额不足间隔天数_min',
m6_payment_not_eng_inteday_max INT comment '近6个月扣款余额不足间隔天数_max',
m6_payment_not_eng_inteday_avg DOUBLE comment '近6个月扣款余额不足间隔天数_avg',
m1_pmt_not_eng_stg_pln_cnt BIGINT comment '近1个月出现扣款余额不足的分期计划数',
m1_pmt_not_eng_equal_1_stg_pln_cnt BIGINT comment '近1个月扣款余额不足等于1次的分期计划数',
m1_pmt_not_eng_equal_2_stg_pln_cnt BIGINT comment '近1个月扣款余额不足等于2次的分期计划数',
m1_pmt_not_eng_equal_3_stg_pln_cnt BIGINT comment '近1个月扣款余额不足等于3次的分期计划数',
m1_pmt_not_eng_mor_3_stg_pln_cnt BIGINT comment '近1个月扣款余额不足大于3次的分期计划数',
m1_stg_pln_pmt_not_eng_cnt_sum BIGINT comment '近1个月单次分期计划中出现扣款余额不足的次数_sum',
m1_stg_pln_pmt_not_eng_cnt_max BIGINT comment '近1个月单次分期计划中出现扣款余额不足的次数_max',
m1_stg_pln_pmt_not_eng_cnt_min BIGINT comment '近1个月单次分期计划中出现扣款余额不足的次数_min',
m1_stg_pln_pmt_not_eng_cnt_avg DOUBLE comment '近1个月单次分期计划中出现扣款余额不足的次数_avg',
m1_pmt_not_eng_stg_pln_amt_sum DOUBLE comment '近1个月出现扣款余额不足的分期计划金额',
m1_pmt_not_eng_equal_1_stg_pln_amt_sum DOUBLE comment '近1个月扣款余额不足等于1次的分期计划金额_sum',
m1_pmt_not_eng_equal_2_stg_pln_amt_sum DOUBLE comment '近1个月扣款余额不足等于2次的分期计划金额_sum',
m1_pmt_not_eng_equal_3_stg_pln_amt_sum DOUBLE comment '近1个月扣款余额不足等于3次的分期计划金额_sum',
m1_pmt_not_eng_mor_3_stg_pln_amt_sum DOUBLE comment '近1个月扣款余额不足大于3次的分期计划金额_sum',
m1_stg_pln_pmt_not_eng_amt_max DOUBLE comment '近1个月单次分期计划中出现扣款余额不足的应还金额_max',
m1_stg_pln_pmt_not_eng_amt_min DOUBLE comment '近1个月单次分期计划中出现扣款余额不足的应还金额_min',
m1_stg_pln_pmt_not_eng_amt_avg DOUBLE comment '近1个月单次分期计划中出现扣款余额不足的应还金额_avg',
m1_stg_pln_crd_cnt_max BIGINT comment '近1个月单次分期计划中使用的银行卡数_max',
m1_stg_pln_crd_cnt_min BIGINT comment '近1个月单次分期计划中使用的银行卡数_min',
m1_stg_pln_crd_cnt_avg DOUBLE comment '近1个月单次分期计划中使用的银行卡数_avg',
m1_stg_pln_bnk_cnt_max BIGINT comment '近1个月单次分期计划中使用的银行卡类型数_max',
m1_stg_pln_bnk_cnt_min BIGINT comment '近1个月单次分期计划中使用的银行卡类型数_min',
m1_stg_pln_bnk_cnt_avg DOUBLE comment '近1个月单次分期计划中使用的银行卡类型数_avg',
m1_pmt_not_eng_stg_pln_d0_cnt BIGINT comment '近1个月出现扣款余额不足的D0还款分期计划数',
m1_pmt_not_eng_equal_1_stg_pln_d0_cnt BIGINT comment '近1个月扣款余额不足等于1次的D0还款分期计划数',
m1_pmt_not_eng_equal_2_stg_pln_d0_cnt BIGINT comment '近1个月扣款余额不足等于2次的D0还款分期计划数',
m1_pmt_not_eng_equal_3_stg_pln_d0_cnt BIGINT comment '近1个月扣款余额不足等于3次的D0还款分期计划数',
m1_pmt_not_eng_mor_3_stg_pln_d0_cnt BIGINT comment '近1个月扣款余额不足大于3次的D0还款分期计划数',
m1_pmt_not_eng_stg_pln_d0_amt_sum DOUBLE comment '近1个月出现扣款余额不足的D0还款分期计划金额',
m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum DOUBLE comment '近1个月扣款余额不足等于1次的D0还款分期计划金额',
m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum DOUBLE comment '近1个月扣款余额不足等于2次的D0还款分期计划金额',
m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum DOUBLE comment '近1个月扣款余额不足等于3次的D0还款分期计划金额',
m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum DOUBLE comment '近1个月扣款余额不足大于3次的D0还款分期计划金额',
m1_stg_pln_d0_pmt_not_eng_cnt_sum BIGINT comment '近1个月D0还款分期计划中扣款余额不足次数_sum',
m1_stg_pln_d0_pmt_not_eng_cnt_max BIGINT comment '近1个月D0还款分期计划中扣款余额不足次数_max',
m1_stg_pln_d0_pmt_not_eng_cnt_min BIGINT comment '近1个月D0还款分期计划中扣款余额不足次数_min',
m1_stg_pln_d0_pmt_not_eng_cnt_avg DOUBLE comment '近1个月D0还款分期计划中扣款余额不足次数_avg',
m3_pmt_not_eng_stg_pln_cnt BIGINT comment '近3个月出现扣款余额不足的分期计划数',
m3_pmt_not_eng_equal_1_stg_pln_cnt BIGINT comment '近3个月扣款余额不足等于1次的分期计划数',
m3_pmt_not_eng_equal_2_stg_pln_cnt BIGINT comment '近3个月扣款余额不足等于2次的分期计划数',
m3_pmt_not_eng_equal_3_stg_pln_cnt BIGINT comment '近3个月扣款余额不足等于3次的分期计划数',
m3_pmt_not_eng_mor_3_stg_pln_cnt BIGINT comment '近3个月扣款余额不足大于3次的分期计划数',
m3_stg_pln_pmt_not_eng_cnt_sum BIGINT comment '近3个月单次分期计划中出现扣款余额不足的次数_sum',
m3_stg_pln_pmt_not_eng_cnt_max BIGINT comment '近3个月单次分期计划中出现扣款余额不足的次数_max',
m3_stg_pln_pmt_not_eng_cnt_min BIGINT comment '近3个月单次分期计划中出现扣款余额不足的次数_min',
m3_stg_pln_pmt_not_eng_cnt_avg DOUBLE comment '近3个月单次分期计划中出现扣款余额不足的次数_avg',
m3_pmt_not_eng_stg_pln_amt_sum DOUBLE comment '近3个月出现扣款余额不足的分期计划金额',
m3_pmt_not_eng_equal_1_stg_pln_amt_sum DOUBLE comment '近3个月扣款余额不足等于1次的分期计划金额_sum',
m3_pmt_not_eng_equal_2_stg_pln_amt_sum DOUBLE comment '近3个月扣款余额不足等于2次的分期计划金额_sum',
m3_pmt_not_eng_equal_3_stg_pln_amt_sum DOUBLE comment '近3个月扣款余额不足等于3次的分期计划金额_sum',
m3_pmt_not_eng_mor_3_stg_pln_amt_sum DOUBLE comment '近3个月扣款余额不足大于3次的分期计划金额_sum',
m3_stg_pln_pmt_not_eng_amt_max DOUBLE comment '近3个月单次分期计划中出现扣款余额不足的应还金额_max',
m3_stg_pln_pmt_not_eng_amt_min DOUBLE comment '近3个月单次分期计划中出现扣款余额不足的应还金额_min',
m3_stg_pln_pmt_not_eng_amt_avg DOUBLE comment '近3个月单次分期计划中出现扣款余额不足的应还金额_avg',
m3_stg_pln_crd_cnt_max BIGINT comment '近3个月单次分期计划中使用的银行卡数_max',
m3_stg_pln_crd_cnt_min BIGINT comment '近3个月单次分期计划中使用的银行卡数_min',
m3_stg_pln_crd_cnt_avg DOUBLE comment '近3个月单次分期计划中使用的银行卡数_avg',
m3_stg_pln_bnk_cnt_max BIGINT comment '近3个月单次分期计划中使用的银行卡类型数_max',
m3_stg_pln_bnk_cnt_min BIGINT comment '近3个月单次分期计划中使用的银行卡类型数_min',
m3_stg_pln_bnk_cnt_avg DOUBLE comment '近3个月单次分期计划中使用的银行卡类型数_avg',
m3_pmt_not_eng_stg_pln_d0_cnt BIGINT comment '近3个月出现扣款余额不足的D0还款分期计划数',
m3_pmt_not_eng_equal_1_stg_pln_d0_cnt BIGINT comment '近3个月扣款余额不足等于1次的D0还款分期计划数',
m3_pmt_not_eng_equal_2_stg_pln_d0_cnt BIGINT comment '近3个月扣款余额不足等于2次的D0还款分期计划数',
m3_pmt_not_eng_equal_3_stg_pln_d0_cnt BIGINT comment '近3个月扣款余额不足等于3次的D0还款分期计划数',
m3_pmt_not_eng_mor_3_stg_pln_d0_cnt BIGINT comment '近3个月扣款余额不足大于3次的D0还款分期计划数',
m3_pmt_not_eng_stg_pln_d0_amt_sum DOUBLE comment '近3个月出现扣款余额不足的D0还款分期计划金额',
m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum DOUBLE comment '近3个月扣款余额不足等于1次的D0还款分期计划金额',
m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum DOUBLE comment '近3个月扣款余额不足等于2次的D0还款分期计划金额',
m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum DOUBLE comment '近3个月扣款余额不足等于3次的D0还款分期计划金额',
m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum DOUBLE comment '近3个月扣款余额不足大于3次的D0还款分期计划金额',
m3_stg_pln_d0_pmt_not_eng_cnt_sum BIGINT comment '近3个月D0还款分期计划中扣款余额不足次数_sum',
m3_stg_pln_d0_pmt_not_eng_cnt_max BIGINT comment '近3个月D0还款分期计划中扣款余额不足次数_max',
m3_stg_pln_d0_pmt_not_eng_cnt_min BIGINT comment '近3个月D0还款分期计划中扣款余额不足次数_min',
m3_stg_pln_d0_pmt_not_eng_cnt_avg DOUBLE comment '近3个月D0还款分期计划中扣款余额不足次数_avg',
m6_pmt_not_eng_stg_pln_cnt BIGINT comment '近6个月出现扣款余额不足的分期计划数',
m6_pmt_not_eng_equal_1_stg_pln_cnt BIGINT comment '近6个月扣款余额不足等于1次的分期计划数',
m6_pmt_not_eng_equal_2_stg_pln_cnt BIGINT comment '近6个月扣款余额不足等于2次的分期计划数',
m6_pmt_not_eng_equal_3_stg_pln_cnt BIGINT comment '近6个月扣款余额不足等于3次的分期计划数',
m6_pmt_not_eng_mor_3_stg_pln_cnt BIGINT comment '近6个月扣款余额不足大于3次的分期计划数',
m6_stg_pln_pmt_not_eng_cnt_sum BIGINT comment '近6个月单次分期计划中出现扣款余额不足的次数_sum',
m6_stg_pln_pmt_not_eng_cnt_max BIGINT comment '近6个月单次分期计划中出现扣款余额不足的次数_max',
m6_stg_pln_pmt_not_eng_cnt_min BIGINT comment '近6个月单次分期计划中出现扣款余额不足的次数_min',
m6_stg_pln_pmt_not_eng_cnt_avg DOUBLE comment '近6个月单次分期计划中出现扣款余额不足的次数_avg',
m6_pmt_not_eng_stg_pln_amt_sum DOUBLE comment '近6个月出现扣款余额不足的分期计划金额',
m6_pmt_not_eng_equal_1_stg_pln_amt_sum DOUBLE comment '近6个月扣款余额不足等于1次的分期计划金额_sum',
m6_pmt_not_eng_equal_2_stg_pln_amt_sum DOUBLE comment '近6个月扣款余额不足等于2次的分期计划金额_sum',
m6_pmt_not_eng_equal_3_stg_pln_amt_sum DOUBLE comment '近6个月扣款余额不足等于3次的分期计划金额_sum',
m6_pmt_not_eng_mor_3_stg_pln_amt_sum DOUBLE comment '近6个月扣款余额不足大于3次的分期计划金额_sum',
m6_stg_pln_pmt_not_eng_amt_max DOUBLE comment '近6个月单次分期计划中出现扣款余额不足的应还金额_max',
m6_stg_pln_pmt_not_eng_amt_min DOUBLE comment '近6个月单次分期计划中出现扣款余额不足的应还金额_min',
m6_stg_pln_pmt_not_eng_amt_avg DOUBLE comment '近6个月单次分期计划中出现扣款余额不足的应还金额_avg',
m6_stg_pln_crd_cnt_max BIGINT comment '近6个月单次分期计划中使用的银行卡数_max',
m6_stg_pln_crd_cnt_min BIGINT comment '近6个月单次分期计划中使用的银行卡数_min',
m6_stg_pln_crd_cnt_avg DOUBLE comment '近6个月单次分期计划中使用的银行卡数_avg',
m6_stg_pln_bnk_cnt_max BIGINT comment '近6个月单次分期计划中使用的银行卡类型数_max',
m6_stg_pln_bnk_cnt_min BIGINT comment '近6个月单次分期计划中使用的银行卡类型数_min',
m6_stg_pln_bnk_cnt_avg DOUBLE comment '近6个月单次分期计划中使用的银行卡类型数_avg',
m6_pmt_not_eng_stg_pln_d0_cnt BIGINT comment '近6个月出现扣款余额不足的D0还款分期计划数',
m6_pmt_not_eng_equal_1_stg_pln_d0_cnt BIGINT comment '近6个月扣款余额不足等于1次的D0还款分期计划数',
m6_pmt_not_eng_equal_2_stg_pln_d0_cnt BIGINT comment '近6个月扣款余额不足等于2次的D0还款分期计划数',
m6_pmt_not_eng_equal_3_stg_pln_d0_cnt BIGINT comment '近6个月扣款余额不足等于3次的D0还款分期计划数',
m6_pmt_not_eng_mor_3_stg_pln_d0_cnt BIGINT comment '近6个月扣款余额不足大于3次的D0还款分期计划数',
m6_pmt_not_eng_stg_pln_d0_amt_sum DOUBLE comment '近6个月出现扣款余额不足的D0还款分期计划金额',
m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum DOUBLE comment '近6个月扣款余额不足等于1次的D0还款分期计划金额',
m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum DOUBLE comment '近6个月扣款余额不足等于2次的D0还款分期计划金额',
m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum DOUBLE comment '近6个月扣款余额不足等于3次的D0还款分期计划金额',
m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum DOUBLE comment '近6个月扣款余额不足大于3次的D0还款分期计划金额',
m6_stg_pln_d0_pmt_not_eng_cnt_sum BIGINT comment '近6个月D0还款分期计划中扣款余额不足次数_sum',
m6_stg_pln_d0_pmt_not_eng_cnt_max BIGINT comment '近6个月D0还款分期计划中扣款余额不足次数_max',
m6_stg_pln_d0_pmt_not_eng_cnt_min BIGINT comment '近6个月D0还款分期计划中扣款余额不足次数_min',
m6_stg_pln_d0_pmt_not_eng_cnt_avg DOUBLE comment '近6个月D0还款分期计划中扣款余额不足次数_avg',
m1_pmt_not_eng_stg_pln_cnt_rat DOUBLE comment '近1个月出现扣款余额不足的分期计划数占比',
m1_pmt_not_eng_equal_1_stg_pln_cnt_rat DOUBLE comment '近1个月扣款余额不足等于1次的分期计划数占比',
m1_pmt_not_eng_equal_2_stg_pln_cnt_rat DOUBLE comment '近1个月扣款余额不足等于2次的分期计划数占比',
m1_pmt_not_eng_equal_3_stg_pln_cnt_rat DOUBLE comment '近1个月扣款余额不足等于3次的分期计划数占比',
m1_pmt_not_eng_mor_3_stg_pln_cnt_rat DOUBLE comment '近1个月扣款余额不足大于3次的分期计划数占比',
m1_pmt_not_eng_stg_pln_amt_rat DOUBLE comment '近1个月出现扣款余额不足的分期计划金额占比',
m1_pmt_not_eng_equal_1_stg_pln_amt_rat DOUBLE comment '近1个月扣款余额不足等于1次的分期计划金额占比',
m1_pmt_not_eng_equal_2_stg_pln_amt_rat DOUBLE comment '近1个月扣款余额不足等于2次的分期计划金额占比',
m1_pmt_not_eng_equal_3_stg_pln_amt_rat DOUBLE comment '近1个月扣款余额不足等于3次的分期计划金额占比',
m1_pmt_not_eng_mor_3_stg_pln_amt_rat DOUBLE comment '近1个月扣款余额不足大于3次的分期计划金额占比',
m1_pmt_not_eng_stg_pln_d0_cnt_rat DOUBLE comment '近1个月出现扣款余额不足的D0还款分期计划数占比',
m1_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat DOUBLE comment '近1个月扣款余额不足等于1次的D0还款分期计划数占比',
m1_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat DOUBLE comment '近1个月扣款余额不足等于2次的D0还款分期计划数占比',
m1_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat DOUBLE comment '近1个月扣款余额不足等于3次的D0还款分期计划数占比',
m1_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat DOUBLE comment '近1个月扣款余额不足大于3次的D0还款分期计划数占比',
m1_pmt_not_eng_stg_pln_d0_amt_sum_rat DOUBLE comment '近1个月出现扣款余额不足的D0还款分期计划金额总和占比',
m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat DOUBLE comment '近1个月扣款余额不足等于1次的D0还款分期计划金额总和占比',
m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat DOUBLE comment '近1个月扣款余额不足等于2次的D0还款分期计划金额总和占比',
m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat DOUBLE comment '近1个月扣款余额不足等于3次的D0还款分期计划金额总和占比',
m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat DOUBLE comment '近1个月扣款余额不足大于3次的D0还款分期计划金额总和占比',
m3_pmt_not_eng_stg_pln_cnt_rat DOUBLE comment '近3个月出现扣款余额不足的分期计划数占比',
m3_pmt_not_eng_equal_1_stg_pln_cnt_rat DOUBLE comment '近3个月扣款余额不足等于1次的分期计划数占比',
m3_pmt_not_eng_equal_2_stg_pln_cnt_rat DOUBLE comment '近3个月扣款余额不足等于2次的分期计划数占比',
m3_pmt_not_eng_equal_3_stg_pln_cnt_rat DOUBLE comment '近3个月扣款余额不足等于3次的分期计划数占比',
m3_pmt_not_eng_mor_3_stg_pln_cnt_rat DOUBLE comment '近3个月扣款余额不足大于3次的分期计划数占比',
m3_pmt_not_eng_stg_pln_amt_rat DOUBLE comment '近3个月出现扣款余额不足的分期计划金额占比',
m3_pmt_not_eng_equal_1_stg_pln_amt_rat DOUBLE comment '近3个月扣款余额不足等于1次的分期计划金额占比',
m3_pmt_not_eng_equal_2_stg_pln_amt_rat DOUBLE comment '近3个月扣款余额不足等于2次的分期计划金额占比',
m3_pmt_not_eng_equal_3_stg_pln_amt_rat DOUBLE comment '近3个月扣款余额不足等于3次的分期计划金额占比',
m3_pmt_not_eng_mor_3_stg_pln_amt_rat DOUBLE comment '近3个月扣款余额不足大于3次的分期计划金额占比',
m3_pmt_not_eng_stg_pln_d0_cnt_rat DOUBLE comment '近3个月出现扣款余额不足的D0还款分期计划数占比',
m3_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat DOUBLE comment '近3个月扣款余额不足等于1次的D0还款分期计划数占比',
m3_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat DOUBLE comment '近3个月扣款余额不足等于2次的D0还款分期计划数占比',
m3_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat DOUBLE comment '近3个月扣款余额不足等于3次的D0还款分期计划数占比',
m3_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat DOUBLE comment '近3个月扣款余额不足大于3次的D0还款分期计划数占比',
m3_pmt_not_eng_stg_pln_d0_amt_sum_rat DOUBLE comment '近3个月出现扣款余额不足的D0还款分期计划金额总和占比',
m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat DOUBLE comment '近3个月扣款余额不足等于1次的D0还款分期计划金额总和占比',
m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat DOUBLE comment '近3个月扣款余额不足等于2次的D0还款分期计划金额总和占比',
m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat DOUBLE comment '近3个月扣款余额不足等于3次的D0还款分期计划金额总和占比',
m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat DOUBLE comment '近3个月扣款余额不足大于3次的D0还款分期计划金额总和占比',
m6_pmt_not_eng_stg_pln_cnt_rat DOUBLE comment '近6个月出现扣款余额不足的分期计划数占比',
m6_pmt_not_eng_equal_1_stg_pln_cnt_rat DOUBLE comment '近6个月扣款余额不足等于1次的分期计划数占比',
m6_pmt_not_eng_equal_2_stg_pln_cnt_rat DOUBLE comment '近6个月扣款余额不足等于2次的分期计划数占比',
m6_pmt_not_eng_equal_3_stg_pln_cnt_rat DOUBLE comment '近6个月扣款余额不足等于3次的分期计划数占比',
m6_pmt_not_eng_mor_3_stg_pln_cnt_rat DOUBLE comment '近6个月扣款余额不足大于3次的分期计划数占比',
m6_pmt_not_eng_stg_pln_amt_rat DOUBLE comment '近6个月出现扣款余额不足的分期计划金额占比',
m6_pmt_not_eng_equal_1_stg_pln_amt_rat DOUBLE comment '近6个月扣款余额不足等于1次的分期计划金额占比',
m6_pmt_not_eng_equal_2_stg_pln_amt_rat DOUBLE comment '近6个月扣款余额不足等于2次的分期计划金额占比',
m6_pmt_not_eng_equal_3_stg_pln_amt_rat DOUBLE comment '近6个月扣款余额不足等于3次的分期计划金额占比',
m6_pmt_not_eng_mor_3_stg_pln_amt_rat DOUBLE comment '近6个月扣款余额不足大于3次的分期计划金额占比',
m6_pmt_not_eng_stg_pln_d0_cnt_rat DOUBLE comment '近6个月出现扣款余额不足的D0还款分期计划数占比',
m6_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat DOUBLE comment '近6个月扣款余额不足等于1次的D0还款分期计划数占比',
m6_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat DOUBLE comment '近6个月扣款余额不足等于2次的D0还款分期计划数占比',
m6_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat DOUBLE comment '近6个月扣款余额不足等于3次的D0还款分期计划数占比',
m6_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat DOUBLE comment '近6个月扣款余额不足大于3次的D0还款分期计划数占比',
m6_pmt_not_eng_stg_pln_d0_amt_sum_rat DOUBLE comment '近6个月出现扣款余额不足的D0还款分期计划金额总和占比',
m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat DOUBLE comment '近6个月扣款余额不足等于1次的D0还款分期计划金额总和占比',
m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat DOUBLE comment '近6个月扣款余额不足等于2次的D0还款分期计划金额总和占比',
m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat DOUBLE comment '近6个月扣款余额不足等于3次的D0还款分期计划金额总和占比',
m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat DOUBLE comment '近6个月扣款余额不足大于3次的D0还款分期计划金额总和占比',
pmt_not_eng_stg_pln_cnt_1m_3m_rat DOUBLE comment '近1m-3m出现扣款余额不足的分期计划数占比',
pmt_not_eng_stg_pln_cnt_3m_6m_rat DOUBLE comment '近3m-6m出现扣款余额不足的分期计划数占比',
pmt_not_eng_stg_pln_cnt_1m_3m_rat_trend INT comment '近1m-3m出现扣款余额不足的分期计划数占比趋势',
pmt_not_eng_stg_pln_cnt_3m_6m_rat_trend INT comment '近3m-6m出现扣款余额不足的分期计划数占比趋势',
m1_pmt_not_eng_cnt_pday_max BIGINT comment '近1个月单天扣款余额不足次数_max',
m1_pmt_not_eng_cnt_pday_min BIGINT comment '近1个月单天扣款余额不足次数_min',
m1_pmt_not_eng_cnt_pday_mor_0_day_cnt BIGINT comment '近1个月单天扣款余额不足次数大于0次的天数',
m1_pmt_not_eng_cnt_pday_equal_1_day_cnt BIGINT comment '近1个月单天扣款余额不足次数等于1次的天数',
m1_pmt_not_eng_cnt_pday_mor_1_day_cnt BIGINT comment '近1个月单天扣款余额不足次数大于1次的天数',
m1_pmt_not_eng_amt_pday_max DECIMAL(37,10) comment '近1个月单天扣款余额不足金额_max',
m1_pmt_not_eng_amt_pday_min DECIMAL(37,10) comment '近1个月单天扣款余额不足金额_min',
m3_pmt_not_eng_cnt_pday_max BIGINT comment '近3个月单天扣款余额不足次数_max',
m3_pmt_not_eng_cnt_pday_min BIGINT comment '近3个月单天扣款余额不足次数_min',
m3_pmt_not_eng_cnt_pday_mor_0_day_cnt BIGINT comment '近3个月单天扣款余额不足次数大于0次的天数',
m3_pmt_not_eng_cnt_pday_equal_1_day_cnt BIGINT comment '近3个月单天扣款余额不足次数等于1次的天数',
m3_pmt_not_eng_cnt_pday_mor_1_day_cnt BIGINT comment '近3个月单天扣款余额不足次数大于1次的天数',
m3_pmt_not_eng_amt_pday_max DECIMAL(37,10) comment '近3个月单天扣款余额不足金额_max',
m3_pmt_not_eng_amt_pday_min DECIMAL(37,10) comment '近3个月单天扣款余额不足金额_min',
m6_pmt_not_eng_cnt_pday_max BIGINT comment '近6个月单天扣款余额不足次数_max',
m6_pmt_not_eng_cnt_pday_min BIGINT comment '近6个月单天扣款余额不足次数_min',
m6_pmt_not_eng_cnt_pday_mor_0_day_cnt BIGINT comment '近6个月单天扣款余额不足次数大于0次的天数',
m6_pmt_not_eng_cnt_pday_equal_1_day_cnt BIGINT comment '近6个月单天扣款余额不足次数等于1次的天数',
m6_pmt_not_eng_cnt_pday_mor_1_day_cnt BIGINT comment '近6个月单天扣款余额不足次数大于1次的天数',
m6_pmt_not_eng_amt_pday_max DECIMAL(37,10) comment '近6个月单天扣款余额不足金额_max',
m6_pmt_not_eng_amt_pday_min DECIMAL(37,10) comment '近6个月单天扣款余额不足金额_min'
)comment '贷中宽表_扣款余额不足数据'
partitioned by (ds string)
;
-- set odps.task.wlm.quota=默认后付费Quota; 

-- 主表
drop table if exists ${dwa_risk}.dwa_risk_f_dz_model_data_base_tmp;
create table ${dwa_risk}.dwa_risk_f_dz_model_data_base_tmp as
select uid
        ,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from 
(
        select  uid
        ,case when loan_success_flag = 1 then 'success'
              when apply_status in ('LEND_FAIL', 'LOAN_DENIED')  then 'fail'
              when order_status ='R'  then 'fail'
         else 'else' 
         end ord_stt_flg
        from ${dwt}.dwt_heavy_order_df 
        where ds = '${bizdate}'
) as a
where ord_stt_flg = 'success'
group by uid;

set odps.task.wlm.quota = Quote_dataphin_other;
set odps.stage.mapper.split.size=64; 
-- 明细层1
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp1;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp1 as
select  model_data.uid
        ,date(model_data.mdl_dte) as mdl_dte
        ,b.trans_serial
        ,b.biz_srl
        ,b.bnk_nam --扣款银行
        ,b.crd_no --扣款卡号sha256值
        ,b.int_flg --主动还款标识:1-主动还款、0-被动还款、未知-未知
        ,b.trs_msg --交易信息
        ,b.trs_rsl --交易结果:FAILED-失败、SUCCESS-成功、UNKNOWN-未知
        ,b.trs_amt --交易金额
        ,b.crt_tim --创建时间
        ,to_date(b.crt_tim) as crt_dat
        --时间切片flag
        ,datediff(mdl_dte,to_date(b.crt_tim)) as ddf_mdl_crt_dte
        ,case when to_date(crt_tim) >= add_months(model_data.mdl_dte ,-1) then 1 else 0 end as rep_deduct_m1_flg
        ,case when to_date(crt_tim) >= add_months(model_data.mdl_dte ,-3) then 1 else 0 end as rep_deduct_m3_flg
        ,case when to_date(crt_tim) >= add_months(model_data.mdl_dte ,-6) then 1 else 0 end as rep_deduct_m6_flg 
        -- 交易信息标识处理
        ,case when trs_msg like '%余额不足%' then 1 else 0 end as balance_not_egh_flg
        ,c.repay_apply_no
from    
(
    select uid,mdl_dte
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base_tmp
    group by uid,mdl_dte
) as model_data
left join  
(
        select *
        from
        (
                select *
                        ,row_number() over(partition by uid,biz_srl order by crt_tim desc,payment_flg asc) as n --deduct_bill_no存在一对多，取最新的一条数据,存在同一时间多条记录
                from
                (
                        select  uid as uid
                                ,trans_serial
                                ,deduct_bill_no as biz_srl
                                ,deduct_bank as bnk_nam
                                ,deduct_card_no_sha256 as crd_no
                                ,initiative_flag as int_flg
                                ,trans_message as trs_msg
                                ,trans_result as trs_rsl
                                ,amount - refund_amount as trs_amt
                                ,crt_time as crt_tim
                                ,case when trans_message = 'SUCCESS' then 1
                                      when trans_message like '%余额不足%' then 2
                                      when (trans_message not like '%余额不足%') and (trans_message in ('FAILED', 'UNKNOWN')) then 3 else 4 end as payment_flg
                        from  ${cdmx}.cdmx_fct_heavy_payment_deduct_df a
                        where ds = '${bizdate}'
                        and to_date(crt_time) between add_months(date_add(to_date('${bizdate}','yyyymmdd') ,0),-6) and date_add(to_date('${bizdate}','yyyymmdd') ,0) --最小评分日和最大评分日
                        and nvl(third_party_channel,'') <> 'NowPay'
                        ---deduct_use = 'REPAY'
                        and deduct_bill_no is not null
                ) as a     
        ) as aa
        where n = 1
) as b
on  model_data.uid = b.uid
left join
(
    select deduct_bill_no as biz_srl,repay_apply_no
    from ${ods_pdw_loan}.ods_pdw_loan_dsrepayali_repayengine_deduct_bill_df
    where ds = '${bizdate}'
    group by deduct_bill_no,repay_apply_no
) as c
on b.biz_srl = c.biz_srl
where to_date(b.crt_tim) < date(model_data.mdl_dte)
and to_date(b.crt_tim) >= add_months(model_data.mdl_dte ,-6)
;

set odps.task.wlm.quota = Quote_dataphin_other;
set odps.stage.mapper.split.size=64; 
-- 还款-订单关联表
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp2 as
select  * 
        --实还日和应还日的间隔
        ,datediff(date(rep_tim_new) ,due_date) as ddf_rep_tim_dte
from    
(
        select  a.uid
                ,a.mdl_dte
                ,b.repay_apply_no
                ,b.order_no
                ,b.stg_pln_no
                ,c.bsy_typ
                ,c.stg_typ
                ,c.stage_no
                ,c.due_date
                ,c.rep_tim
                ,c.schedule_total_amount -- 应还本息
                ,c.ded_typ
                ,c.prc_amt
                -- 加工实还款时间
                ,case when date(c.rep_tim) <= date(a.mdl_dte) then date(c.rep_tim)
                        else a.mdl_dte end as rep_tim_new
        from    
        (
                select uid,mdl_dte,repay_apply_no
                from ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp1
                where repay_apply_no is not null
                group by uid,mdl_dte,repay_apply_no
        ) as a
        inner join  
        (
                select repay_apply_no -- 申请编号
                        ,stage_plan_no as stg_pln_no --分期编号
                        ,stage_order_no as order_no -- 订单号
                from  ${ods_pdw_loan}.ods_pdw_loan_dsrepayali_repayengine_repay_apply_stage_plan_item_di       --还款项（分期计划）
                where ds >= '20210101'
        ) as b
        on a.repay_apply_no = b.repay_apply_no
        inner join  
        (
                select  a.uid
                        ,a.order_no
                        ,a.stage_plan_no as stg_pln_no
                        ,a.original_biz_type as bsy_typ
                        ,a.original_biz_type as stg_stt --放款成功取<>'R'
                        ,coalesce(b.init_total_stage,b.apply_total_stage) as stg_typ
                        ,a.stage_no
                        ,a.schedule_pay_principal as prc_amt
                        ,a.due_date -- 到期日
                        ,a.settlement_time as rep_tim -- 还款时间
                        ,a.current_overdue_status as ovd_stt -- 逾期状态
                        ,a.original_repay_type as ded_typ -- 扣款类型
                        ,a.schedule_pay_total_amount as schedule_total_amount -- 应还本息
                from cdmx.cdmx_fct_heavy_stage_plan_df a
                left join
                    dwt.dwt_heavy_order_df b
                on a.order_no = b.order_no and b.ds='${bizdate}'
                where a.ds = '${bizdate}'
                and a.original_stage_plan_status <> 'R'
        ) as c
        on b.order_no = c.order_no and b.stg_pln_no = c.stg_pln_no
        where b.repay_apply_no is not null
          and c.stg_pln_no is not null
) t
;

set odps.stage.mapper.split.size=64; 
set odps.task.wlm.quota = Quote_dataphin_other;

-- 明细层2
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail as
select  t1.uid
        ,t1.mdl_dte
        ,t1.trans_serial
        ,t1.biz_srl
        ,t1.bnk_nam
        ,t1.crd_no
        ,t1.int_flg
        ,t1.trs_msg
        ,t1.trs_rsl
        ,t1.trs_amt
        ,t1.crt_tim
        ,t1.crt_dat
        ,t1.ddf_mdl_crt_dte
        ,t1.rep_deduct_m1_flg
        ,t1.rep_deduct_m3_flg
        ,t1.rep_deduct_m6_flg
        ,t1.balance_not_egh_flg
        ,t1.repay_apply_no
        ,t2.order_no
        ,t2.stg_pln_no
        ,t2.bsy_typ 
        ,t2.stage_no
        ,t2.due_date
        ,t2.rep_tim
        ,t2.rep_tim_new
        -- ,t2.prc_amt
        ,t2.schedule_total_amount
        ,t2.ded_typ
        ,t2.ddf_rep_tim_dte -- 打标签--还款时间类型
        ,case   when ddf_rep_tim_dte < 0 then '提前还款'
                when ddf_rep_tim_dte = 0 then 'D0还款'
                when ddf_rep_tim_dte > 30 then '历史逾期30天以上（m2+）'
                when ddf_rep_tim_dte > 14 then '历史逾期15-30天'
                when ddf_rep_tim_dte > 7 then '历史逾期8-14天'
                when ddf_rep_tim_dte > 3 then '历史逾期4-7天'
                when ddf_rep_tim_dte > 0 then '历史逾期1-3天'
                else '其他'
        end as rep_tim_type
from  ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp1 as t1
left join ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp2 as t2
on t1.repay_apply_no = t2.repay_apply_no
where t2.stg_pln_no is not null
;


-- set odps.task.wlm.quota=默认后付费Quota; 

-- by crt_dat 时间间隔类变量衍生
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp1 as
select uid
        ,mdl_dte
        -- /*时间间隔*/
        ,min(case when rep_deduct_m1_flg = 1 then ddf_mdl_crt_dte else null end) as m1_payment_not_eng_mdl_crt_ddf_min
        ,max(case when rep_deduct_m1_flg = 1 then ddf_mdl_crt_dte else null end) as m1_payment_not_eng_mdl_crt_ddf_max
        ,avg(case when rep_deduct_m1_flg = 1 then ddf_mdl_crt_dte else null end) as m1_payment_not_eng_mdl_crt_ddf_avg
        ,min(case when rep_deduct_m1_flg = 1 then delta_days else null end) as m1_payment_not_eng_inteday_min
        ,max(case when rep_deduct_m1_flg = 1 then delta_days else null end) as m1_payment_not_eng_inteday_max
        ,avg(case when rep_deduct_m1_flg = 1 then delta_days else null end) as m1_payment_not_eng_inteday_avg
        ,min(case when rep_deduct_m3_flg = 1 then ddf_mdl_crt_dte else null end) as m3_payment_not_eng_mdl_crt_ddf_min
        ,max(case when rep_deduct_m3_flg = 1 then ddf_mdl_crt_dte else null end) as m3_payment_not_eng_mdl_crt_ddf_max
        ,avg(case when rep_deduct_m3_flg = 1 then ddf_mdl_crt_dte else null end) as m3_payment_not_eng_mdl_crt_ddf_avg
        ,min(case when rep_deduct_m3_flg = 1 then delta_days else null end) as m3_payment_not_eng_inteday_min
        ,max(case when rep_deduct_m3_flg = 1 then delta_days else null end) as m3_payment_not_eng_inteday_max
        ,avg(case when rep_deduct_m3_flg = 1 then delta_days else null end) as m3_payment_not_eng_inteday_avg
        ,min(case when rep_deduct_m6_flg = 1 then ddf_mdl_crt_dte else null end) as m6_payment_not_eng_mdl_crt_ddf_min
        ,max(case when rep_deduct_m6_flg = 1 then ddf_mdl_crt_dte else null end) as m6_payment_not_eng_mdl_crt_ddf_max
        ,avg(case when rep_deduct_m6_flg = 1 then ddf_mdl_crt_dte else null end) as m6_payment_not_eng_mdl_crt_ddf_avg
        ,min(case when rep_deduct_m6_flg = 1 then delta_days else null end) as m6_payment_not_eng_inteday_min
        ,max(case when rep_deduct_m6_flg = 1 then delta_days else null end) as m6_payment_not_eng_inteday_max
        ,avg(case when rep_deduct_m6_flg = 1 then delta_days else null end) as m6_payment_not_eng_inteday_avg
from
(
        select uid
                ,mdl_dte
                ,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg
                ,crt_dat
                ,ddf_mdl_crt_dte
                ,datediff(lead(crt_dat,1,NULL) over(partition by uid,mdl_dte order by crt_dat asc),crt_dat) as delta_days -- 时间间隔
        from 
        (
                select uid,mdl_dte,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg,ddf_mdl_crt_dte,crt_dat
                from ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail_tmp1
                where balance_not_egh_flg = 1
                -- and uid in
                -- (
                --         '0a80bddf-7e34-4bfb-bff9-99aa84407895',--当前逾期
                --         '00177381-4a78-40ca-a405-c59c56230bdc',--未逾期
                --         '00bbd98b-ea5f-4bbd-a264-39a8a3dc2259',--未逾期
                --         '0172a8f9-610e-48aa-8bbe-b020bae9d419',--未逾期
                --         '00207efa-3256-4c66-aef7-ddbd60b07044',--未来逾期
                --         '26d570c0-07a5-4cc4-9905-4d9fece93c92'--未来逾期
                -- ) 
                group by uid,mdl_dte,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg,ddf_mdl_crt_dte,crt_dat
        ) as a
) as aa
group by uid
        ,mdl_dte
;


set odps.task.wlm.quota = Quote_dataphin_other;
-- by 分期计划
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_stg_pln_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_stg_pln_tmp2 as
select uid
        ,mdl_dte
        ,stg_pln_no
        ,rep_deduct_m1_flg
        ,rep_deduct_m3_flg
        ,rep_deduct_m6_flg
        ,schedule_total_amount
        ,rep_tim_type
        ,due_date
        ,rep_tim
        ,rep_tim_new
        ,count(case when balance_not_egh_flg = 1 then biz_srl else null end) as stg_pln_pmt_not_eng_cnt
        ,count(distinct crd_no) as stg_pln_crd_cnt
        ,count(distinct bnk_nam) as stg_pln_bnk_cnt
from ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail
where stg_pln_no is not null 
-- and uid in
-- (
--         '0a80bddf-7e34-4bfb-bff9-99aa84407895',--当前逾期
--         '00177381-4a78-40ca-a405-c59c56230bdc',--未逾期
--         '00bbd98b-ea5f-4bbd-a264-39a8a3dc2259',--未逾期
--         '0172a8f9-610e-48aa-8bbe-b020bae9d419',--未逾期
--         '00207efa-3256-4c66-aef7-ddbd60b07044',--未来逾期
--         '26d570c0-07a5-4cc4-9905-4d9fece93c92'--未来逾期
-- ) 
group by uid
        ,mdl_dte
        ,stg_pln_no
        ,rep_deduct_m1_flg
        ,rep_deduct_m3_flg
        ,rep_deduct_m6_flg
        ,schedule_total_amount
        ,rep_tim_type
        ,due_date
        ,rep_tim
        ,rep_tim_new
;


-- set odps.task.wlm.quota=默认后付费Quota; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp2 as
select uid
        ,mdl_dte
        --------------/*所有分期计划*/------------------
        -- 分期数
        ,count(case when rep_deduct_m1_flg = 1 then stg_pln_no else null end) as m1_stg_pln_cnt
        ,count(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then stg_pln_no else null end) as m1_pmt_not_eng_stg_pln_cnt
        ,count(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt=1 then stg_pln_no else null end) as m1_pmt_not_eng_equal_1_stg_pln_cnt
        ,count(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt=2 then stg_pln_no else null end) as m1_pmt_not_eng_equal_2_stg_pln_cnt
        ,count(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt=3 then stg_pln_no else null end) as m1_pmt_not_eng_equal_3_stg_pln_cnt
        ,count(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>3 then stg_pln_no else null end) as m1_pmt_not_eng_mor_3_stg_pln_cnt
        -- 扣款余额不足次数
        ,sum(case when rep_deduct_m1_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_pmt_not_eng_cnt_sum
        ,max(case when rep_deduct_m1_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_pmt_not_eng_cnt_max
        ,min(case when rep_deduct_m1_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_pmt_not_eng_cnt_min
        ,avg(case when rep_deduct_m1_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_pmt_not_eng_cnt_avg
        -- 扣款余额不足金额
        ,sum(case when rep_deduct_m1_flg = 1 then schedule_total_amount else 0 end) as m1_stg_pln_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m1_pmt_not_eng_stg_pln_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt=1 then schedule_total_amount else 0 end) as m1_pmt_not_eng_equal_1_stg_pln_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt=2 then schedule_total_amount else 0 end) as m1_pmt_not_eng_equal_2_stg_pln_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt=3 then schedule_total_amount else 0 end) as m1_pmt_not_eng_equal_3_stg_pln_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>3 then schedule_total_amount else 0 end) as m1_pmt_not_eng_mor_3_stg_pln_amt_sum

        ,max(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m1_stg_pln_pmt_not_eng_amt_max
        ,min(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else null end) as m1_stg_pln_pmt_not_eng_amt_min
        ,avg(case when rep_deduct_m1_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else null end) as m1_stg_pln_pmt_not_eng_amt_avg
        -- 银行卡数量
        ,max(case when rep_deduct_m1_flg = 1 then stg_pln_crd_cnt else null end) as m1_stg_pln_crd_cnt_max
        ,min(case when rep_deduct_m1_flg = 1 then stg_pln_crd_cnt else null end) as m1_stg_pln_crd_cnt_min
        ,avg(case when rep_deduct_m1_flg = 1 then stg_pln_crd_cnt else null end) as m1_stg_pln_crd_cnt_avg 
        -- 银行卡类型数量
        ,max(case when rep_deduct_m1_flg = 1 then stg_pln_bnk_cnt else null end) as m1_stg_pln_bnk_cnt_max
        ,min(case when rep_deduct_m1_flg = 1 then stg_pln_bnk_cnt else null end) as m1_stg_pln_bnk_cnt_min
        ,avg(case when rep_deduct_m1_flg = 1 then stg_pln_bnk_cnt else null end) as m1_stg_pln_bnk_cnt_avg   

        --------------/*D0还款分期计划*/------------------
        -- 分期数
        ,count(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_no else null end) as m1_stg_pln_d0_cnt
        ,count(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>0 then stg_pln_no else null end) as m1_pmt_not_eng_stg_pln_d0_cnt
        ,count(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=1 then stg_pln_no else null end) as m1_pmt_not_eng_equal_1_stg_pln_d0_cnt
        ,count(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=2 then stg_pln_no else null end) as m1_pmt_not_eng_equal_2_stg_pln_d0_cnt
        ,count(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=3 then stg_pln_no else null end) as m1_pmt_not_eng_equal_3_stg_pln_d0_cnt
        ,count(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>3 then stg_pln_no else null end) as m1_pmt_not_eng_mor_3_stg_pln_d0_cnt
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' then schedule_total_amount else 0 end) as m1_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m1_pmt_not_eng_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=1 then schedule_total_amount else 0 end) as m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=2 then schedule_total_amount else 0 end) as m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=3 then schedule_total_amount else 0 end) as m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>3 then schedule_total_amount else 0 end) as m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum

        -- 扣款余额不足次数
        ,sum(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_d0_pmt_not_eng_cnt_sum
        ,max(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_d0_pmt_not_eng_cnt_max
        ,min(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_d0_pmt_not_eng_cnt_min
        ,avg(case when rep_deduct_m1_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m1_stg_pln_d0_pmt_not_eng_cnt_avg

        --------------/*所有分期计划*/------------------
        -- 分期数
        ,count(case when rep_deduct_m3_flg = 1 then stg_pln_no else null end) as m3_stg_pln_cnt
        ,count(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then stg_pln_no else null end) as m3_pmt_not_eng_stg_pln_cnt
        ,count(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt=1 then stg_pln_no else null end) as m3_pmt_not_eng_equal_1_stg_pln_cnt
        ,count(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt=2 then stg_pln_no else null end) as m3_pmt_not_eng_equal_2_stg_pln_cnt
        ,count(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt=3 then stg_pln_no else null end) as m3_pmt_not_eng_equal_3_stg_pln_cnt
        ,count(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>3 then stg_pln_no else null end) as m3_pmt_not_eng_mor_3_stg_pln_cnt
        -- 扣款余额不足次数
        ,sum(case when rep_deduct_m3_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_pmt_not_eng_cnt_sum
        ,max(case when rep_deduct_m3_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_pmt_not_eng_cnt_max
        ,min(case when rep_deduct_m3_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_pmt_not_eng_cnt_min
        ,avg(case when rep_deduct_m3_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_pmt_not_eng_cnt_avg
        -- 扣款余额不足金额
        ,sum(case when rep_deduct_m3_flg = 1 then schedule_total_amount else 0 end) as m3_stg_pln_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m3_pmt_not_eng_stg_pln_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt=1 then schedule_total_amount else 0 end) as m3_pmt_not_eng_equal_1_stg_pln_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt=2 then schedule_total_amount else 0 end) as m3_pmt_not_eng_equal_2_stg_pln_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt=3 then schedule_total_amount else 0 end) as m3_pmt_not_eng_equal_3_stg_pln_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>3 then schedule_total_amount else 0 end) as m3_pmt_not_eng_mor_3_stg_pln_amt_sum

        ,max(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m3_stg_pln_pmt_not_eng_amt_max
        ,min(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else null end) as m3_stg_pln_pmt_not_eng_amt_min
        ,avg(case when rep_deduct_m3_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else null end) as m3_stg_pln_pmt_not_eng_amt_avg
        -- 银行卡数量
        ,max(case when rep_deduct_m3_flg = 1 then stg_pln_crd_cnt else null end) as m3_stg_pln_crd_cnt_max
        ,min(case when rep_deduct_m3_flg = 1 then stg_pln_crd_cnt else null end) as m3_stg_pln_crd_cnt_min
        ,avg(case when rep_deduct_m3_flg = 1 then stg_pln_crd_cnt else null end) as m3_stg_pln_crd_cnt_avg 
        -- 银行卡类型数量
        ,max(case when rep_deduct_m3_flg = 1 then stg_pln_bnk_cnt else null end) as m3_stg_pln_bnk_cnt_max
        ,min(case when rep_deduct_m3_flg = 1 then stg_pln_bnk_cnt else null end) as m3_stg_pln_bnk_cnt_min
        ,avg(case when rep_deduct_m3_flg = 1 then stg_pln_bnk_cnt else null end) as m3_stg_pln_bnk_cnt_avg   

        --------------/*D0还款分期计划*/------------------
        -- 分期数
        ,count(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_no else null end) as m3_stg_pln_d0_cnt
        ,count(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>0 then stg_pln_no else null end) as m3_pmt_not_eng_stg_pln_d0_cnt
        ,count(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=1 then stg_pln_no else null end) as m3_pmt_not_eng_equal_1_stg_pln_d0_cnt
        ,count(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=2 then stg_pln_no else null end) as m3_pmt_not_eng_equal_2_stg_pln_d0_cnt
        ,count(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=3 then stg_pln_no else null end) as m3_pmt_not_eng_equal_3_stg_pln_d0_cnt
        ,count(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>3 then stg_pln_no else null end) as m3_pmt_not_eng_mor_3_stg_pln_d0_cnt
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' then schedule_total_amount else 0 end) as m3_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m3_pmt_not_eng_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=1 then schedule_total_amount else 0 end) as m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=2 then schedule_total_amount else 0 end) as m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=3 then schedule_total_amount else 0 end) as m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>3 then schedule_total_amount else 0 end) as m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum

        -- 扣款余额不足次数
        ,sum(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_d0_pmt_not_eng_cnt_sum
        ,max(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_d0_pmt_not_eng_cnt_max
        ,min(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_d0_pmt_not_eng_cnt_min
        ,avg(case when rep_deduct_m3_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m3_stg_pln_d0_pmt_not_eng_cnt_avg

        --------------/*所有分期计划*/------------------
        -- 分期数
        ,count(case when rep_deduct_m6_flg = 1 then stg_pln_no else null end) as m6_stg_pln_cnt
        ,count(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then stg_pln_no else null end) as m6_pmt_not_eng_stg_pln_cnt
        ,count(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt=1 then stg_pln_no else null end) as m6_pmt_not_eng_equal_1_stg_pln_cnt
        ,count(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt=2 then stg_pln_no else null end) as m6_pmt_not_eng_equal_2_stg_pln_cnt
        ,count(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt=3 then stg_pln_no else null end) as m6_pmt_not_eng_equal_3_stg_pln_cnt
        ,count(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>3 then stg_pln_no else null end) as m6_pmt_not_eng_mor_3_stg_pln_cnt
        -- 扣款余额不足次数
        ,sum(case when rep_deduct_m6_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_pmt_not_eng_cnt_sum
        ,max(case when rep_deduct_m6_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_pmt_not_eng_cnt_max
        ,min(case when rep_deduct_m6_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_pmt_not_eng_cnt_min
        ,avg(case when rep_deduct_m6_flg = 1 then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_pmt_not_eng_cnt_avg
        -- 扣款余额不足金额
        ,sum(case when rep_deduct_m6_flg = 1 then schedule_total_amount else 0 end) as m6_stg_pln_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m6_pmt_not_eng_stg_pln_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt=1 then schedule_total_amount else 0 end) as m6_pmt_not_eng_equal_1_stg_pln_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt=2 then schedule_total_amount else 0 end) as m6_pmt_not_eng_equal_2_stg_pln_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt=3 then schedule_total_amount else 0 end) as m6_pmt_not_eng_equal_3_stg_pln_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>3 then schedule_total_amount else 0 end) as m6_pmt_not_eng_mor_3_stg_pln_amt_sum

        ,max(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m6_stg_pln_pmt_not_eng_amt_max
        ,min(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else null end) as m6_stg_pln_pmt_not_eng_amt_min
        ,avg(case when rep_deduct_m6_flg = 1 and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else null end) as m6_stg_pln_pmt_not_eng_amt_avg
        -- 银行卡数量
        ,max(case when rep_deduct_m6_flg = 1 then stg_pln_crd_cnt else null end) as m6_stg_pln_crd_cnt_max
        ,min(case when rep_deduct_m6_flg = 1 then stg_pln_crd_cnt else null end) as m6_stg_pln_crd_cnt_min
        ,avg(case when rep_deduct_m6_flg = 1 then stg_pln_crd_cnt else null end) as m6_stg_pln_crd_cnt_avg 
        -- 银行卡类型数量
        ,max(case when rep_deduct_m6_flg = 1 then stg_pln_bnk_cnt else null end) as m6_stg_pln_bnk_cnt_max
        ,min(case when rep_deduct_m6_flg = 1 then stg_pln_bnk_cnt else null end) as m6_stg_pln_bnk_cnt_min
        ,avg(case when rep_deduct_m6_flg = 1 then stg_pln_bnk_cnt else null end) as m6_stg_pln_bnk_cnt_avg   

        --------------/*D0还款分期计划*/------------------
        -- 分期数
        ,count(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_no else null end) as m6_stg_pln_d0_cnt
        ,count(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>0 then stg_pln_no else null end) as m6_pmt_not_eng_stg_pln_d0_cnt
        ,count(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=1 then stg_pln_no else null end) as m6_pmt_not_eng_equal_1_stg_pln_d0_cnt
        ,count(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=2 then stg_pln_no else null end) as m6_pmt_not_eng_equal_2_stg_pln_d0_cnt
        ,count(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=3 then stg_pln_no else null end) as m6_pmt_not_eng_equal_3_stg_pln_d0_cnt
        ,count(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>3 then stg_pln_no else null end) as m6_pmt_not_eng_mor_3_stg_pln_d0_cnt
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' then schedule_total_amount else 0 end) as m6_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>0 then schedule_total_amount else 0 end) as m6_pmt_not_eng_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=1 then schedule_total_amount else 0 end) as m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=2 then schedule_total_amount else 0 end) as m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt=3 then schedule_total_amount else 0 end) as m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' and stg_pln_pmt_not_eng_cnt>3 then schedule_total_amount else 0 end) as m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum

        -- 扣款余额不足次数
        ,sum(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_d0_pmt_not_eng_cnt_sum
        ,max(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_d0_pmt_not_eng_cnt_max
        ,min(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_d0_pmt_not_eng_cnt_min
        ,avg(case when rep_deduct_m6_flg = 1 and rep_tim_type = 'D0还款' then stg_pln_pmt_not_eng_cnt else null end) as m6_stg_pln_d0_pmt_not_eng_cnt_avg
from ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_stg_pln_tmp2
-- where uid in
-- (
--         '0a80bddf-7e34-4bfb-bff9-99aa84407895',--当前逾期
--         '00177381-4a78-40ca-a405-c59c56230bdc',--未逾期
--         '00bbd98b-ea5f-4bbd-a264-39a8a3dc2259',--未逾期
--         '0172a8f9-610e-48aa-8bbe-b020bae9d419',--未逾期
--         '00207efa-3256-4c66-aef7-ddbd60b07044',--未来逾期
--         '26d570c0-07a5-4cc4-9905-4d9fece93c92'--未来逾期
-- ) 
group by uid,mdl_dte
;



-- 占比/趋势
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp3 as
select *
       --------------/*趋势*/------------------ 
       ,case when m1_pmt_not_eng_stg_pln_cnt_rat is null or pmt_not_eng_stg_pln_cnt_1m_3m_rat is null then null
             when m1_pmt_not_eng_stg_pln_cnt_rat>pmt_not_eng_stg_pln_cnt_1m_3m_rat then 1 
             else 0 end as pmt_not_eng_stg_pln_cnt_1m_3m_rat_trend
       ,case when m3_pmt_not_eng_stg_pln_cnt_rat is null or pmt_not_eng_stg_pln_cnt_3m_6m_rat is null then null
             when m3_pmt_not_eng_stg_pln_cnt_rat>pmt_not_eng_stg_pln_cnt_3m_6m_rat then 1 
             else 0 end as pmt_not_eng_stg_pln_cnt_3m_6m_rat_trend
from
(
        select uid
                ,mdl_dte
                --------------/*占比*/------------------
                -- 余额不足次数
                ,case when m1_stg_pln_cnt > 0 then m1_pmt_not_eng_stg_pln_cnt/m1_stg_pln_cnt else null end as m1_pmt_not_eng_stg_pln_cnt_rat
                ,case when m1_stg_pln_cnt > 0 then m1_pmt_not_eng_equal_1_stg_pln_cnt/m1_stg_pln_cnt else null end as m1_pmt_not_eng_equal_1_stg_pln_cnt_rat
                ,case when m1_stg_pln_cnt > 0 then m1_pmt_not_eng_equal_2_stg_pln_cnt/m1_stg_pln_cnt else null end as m1_pmt_not_eng_equal_2_stg_pln_cnt_rat
                ,case when m1_stg_pln_cnt > 0 then m1_pmt_not_eng_equal_3_stg_pln_cnt/m1_stg_pln_cnt else null end as m1_pmt_not_eng_equal_3_stg_pln_cnt_rat
                ,case when m1_stg_pln_cnt > 0 then m1_pmt_not_eng_mor_3_stg_pln_cnt/m1_stg_pln_cnt else null end as m1_pmt_not_eng_mor_3_stg_pln_cnt_rat
                -- 余额不足金额
                ,case when m1_stg_pln_amt_sum > 0 then m1_pmt_not_eng_stg_pln_amt_sum/m1_stg_pln_amt_sum else null end as m1_pmt_not_eng_stg_pln_amt_rat
                ,case when m1_stg_pln_amt_sum > 0 then m1_pmt_not_eng_equal_1_stg_pln_amt_sum/m1_stg_pln_amt_sum else null end as m1_pmt_not_eng_equal_1_stg_pln_amt_rat
                ,case when m1_stg_pln_amt_sum > 0 then m1_pmt_not_eng_equal_2_stg_pln_amt_sum/m1_stg_pln_amt_sum else null end as m1_pmt_not_eng_equal_2_stg_pln_amt_rat
                ,case when m1_stg_pln_amt_sum > 0 then m1_pmt_not_eng_equal_3_stg_pln_amt_sum/m1_stg_pln_amt_sum else null end as m1_pmt_not_eng_equal_3_stg_pln_amt_rat
                ,case when m1_stg_pln_amt_sum > 0 then m1_pmt_not_eng_mor_3_stg_pln_amt_sum/m1_stg_pln_amt_sum else null end as m1_pmt_not_eng_mor_3_stg_pln_amt_rat
                --D0还款
                ,case when m1_stg_pln_d0_cnt > 0 then m1_pmt_not_eng_stg_pln_d0_cnt/m1_stg_pln_d0_cnt else null end as m1_pmt_not_eng_stg_pln_d0_cnt_rat
                ,case when m1_stg_pln_d0_cnt > 0 then m1_pmt_not_eng_equal_1_stg_pln_d0_cnt/m1_stg_pln_d0_cnt else null end as m1_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat
                ,case when m1_stg_pln_d0_cnt > 0 then m1_pmt_not_eng_equal_2_stg_pln_d0_cnt/m1_stg_pln_d0_cnt else null end as m1_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat
                ,case when m1_stg_pln_d0_cnt > 0 then m1_pmt_not_eng_equal_3_stg_pln_d0_cnt/m1_stg_pln_d0_cnt else null end as m1_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat
                ,case when m1_stg_pln_d0_cnt > 0 then m1_pmt_not_eng_mor_3_stg_pln_d0_cnt/m1_stg_pln_d0_cnt else null end as m1_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat
                ,case when m1_stg_pln_d0_amt_sum > 0 then m1_pmt_not_eng_stg_pln_d0_amt_sum/m1_stg_pln_d0_amt_sum else null end as m1_pmt_not_eng_stg_pln_d0_amt_sum_rat
                ,case when m1_stg_pln_d0_amt_sum > 0 then m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum/m1_stg_pln_d0_amt_sum else null end as m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat
                ,case when m1_stg_pln_d0_amt_sum > 0 then m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum/m1_stg_pln_d0_amt_sum else null end as m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat
                ,case when m1_stg_pln_d0_amt_sum > 0 then m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum/m1_stg_pln_d0_amt_sum else null end as m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat
                ,case when m1_stg_pln_d0_amt_sum > 0 then m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum/m1_stg_pln_d0_amt_sum else null end as m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat


                -- 余额不足次数
                ,case when m3_stg_pln_cnt > 0 then m3_pmt_not_eng_stg_pln_cnt/m3_stg_pln_cnt else null end as m3_pmt_not_eng_stg_pln_cnt_rat
                ,case when m3_stg_pln_cnt > 0 then m3_pmt_not_eng_equal_1_stg_pln_cnt/m3_stg_pln_cnt else null end as m3_pmt_not_eng_equal_1_stg_pln_cnt_rat
                ,case when m3_stg_pln_cnt > 0 then m3_pmt_not_eng_equal_2_stg_pln_cnt/m3_stg_pln_cnt else null end as m3_pmt_not_eng_equal_2_stg_pln_cnt_rat
                ,case when m3_stg_pln_cnt > 0 then m3_pmt_not_eng_equal_3_stg_pln_cnt/m3_stg_pln_cnt else null end as m3_pmt_not_eng_equal_3_stg_pln_cnt_rat
                ,case when m3_stg_pln_cnt > 0 then m3_pmt_not_eng_mor_3_stg_pln_cnt/m3_stg_pln_cnt else null end as m3_pmt_not_eng_mor_3_stg_pln_cnt_rat
                -- 余额不足金额
                ,case when m3_stg_pln_amt_sum > 0 then m3_pmt_not_eng_stg_pln_amt_sum/m3_stg_pln_amt_sum else null end as m3_pmt_not_eng_stg_pln_amt_rat
                ,case when m3_stg_pln_amt_sum > 0 then m3_pmt_not_eng_equal_1_stg_pln_amt_sum/m3_stg_pln_amt_sum else null end as m3_pmt_not_eng_equal_1_stg_pln_amt_rat
                ,case when m3_stg_pln_amt_sum > 0 then m3_pmt_not_eng_equal_2_stg_pln_amt_sum/m3_stg_pln_amt_sum else null end as m3_pmt_not_eng_equal_2_stg_pln_amt_rat
                ,case when m3_stg_pln_amt_sum > 0 then m3_pmt_not_eng_equal_3_stg_pln_amt_sum/m3_stg_pln_amt_sum else null end as m3_pmt_not_eng_equal_3_stg_pln_amt_rat
                ,case when m3_stg_pln_amt_sum > 0 then m3_pmt_not_eng_mor_3_stg_pln_amt_sum/m3_stg_pln_amt_sum else null end as m3_pmt_not_eng_mor_3_stg_pln_amt_rat
                --D0还款
                ,case when m3_stg_pln_d0_cnt > 0 then m3_pmt_not_eng_stg_pln_d0_cnt/m3_stg_pln_d0_cnt else null end as m3_pmt_not_eng_stg_pln_d0_cnt_rat
                ,case when m3_stg_pln_d0_cnt > 0 then m3_pmt_not_eng_equal_1_stg_pln_d0_cnt/m3_stg_pln_d0_cnt else null end as m3_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat
                ,case when m3_stg_pln_d0_cnt > 0 then m3_pmt_not_eng_equal_2_stg_pln_d0_cnt/m3_stg_pln_d0_cnt else null end as m3_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat
                ,case when m3_stg_pln_d0_cnt > 0 then m3_pmt_not_eng_equal_3_stg_pln_d0_cnt/m3_stg_pln_d0_cnt else null end as m3_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat
                ,case when m3_stg_pln_d0_cnt > 0 then m3_pmt_not_eng_mor_3_stg_pln_d0_cnt/m3_stg_pln_d0_cnt else null end as m3_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat
                ,case when m3_stg_pln_d0_amt_sum > 0 then m3_pmt_not_eng_stg_pln_d0_amt_sum/m3_stg_pln_d0_amt_sum else null end as m3_pmt_not_eng_stg_pln_d0_amt_sum_rat
                ,case when m3_stg_pln_d0_amt_sum > 0 then m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum/m3_stg_pln_d0_amt_sum else null end as m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat
                ,case when m3_stg_pln_d0_amt_sum > 0 then m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum/m3_stg_pln_d0_amt_sum else null end as m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat
                ,case when m3_stg_pln_d0_amt_sum > 0 then m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum/m3_stg_pln_d0_amt_sum else null end as m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat
                ,case when m3_stg_pln_d0_amt_sum > 0 then m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum/m3_stg_pln_d0_amt_sum else null end as m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat

                -- 余额不足次数
                ,case when m6_stg_pln_cnt > 0 then m6_pmt_not_eng_stg_pln_cnt/m6_stg_pln_cnt else null end as m6_pmt_not_eng_stg_pln_cnt_rat
                ,case when m6_stg_pln_cnt > 0 then m6_pmt_not_eng_equal_1_stg_pln_cnt/m6_stg_pln_cnt else null end as m6_pmt_not_eng_equal_1_stg_pln_cnt_rat
                ,case when m6_stg_pln_cnt > 0 then m6_pmt_not_eng_equal_2_stg_pln_cnt/m6_stg_pln_cnt else null end as m6_pmt_not_eng_equal_2_stg_pln_cnt_rat
                ,case when m6_stg_pln_cnt > 0 then m6_pmt_not_eng_equal_3_stg_pln_cnt/m6_stg_pln_cnt else null end as m6_pmt_not_eng_equal_3_stg_pln_cnt_rat
                ,case when m6_stg_pln_cnt > 0 then m6_pmt_not_eng_mor_3_stg_pln_cnt/m6_stg_pln_cnt else null end as m6_pmt_not_eng_mor_3_stg_pln_cnt_rat
                -- 余额不足金额
                ,case when m6_stg_pln_amt_sum > 0 then m6_pmt_not_eng_stg_pln_amt_sum/m6_stg_pln_amt_sum else null end as m6_pmt_not_eng_stg_pln_amt_rat
                ,case when m6_stg_pln_amt_sum > 0 then m6_pmt_not_eng_equal_1_stg_pln_amt_sum/m6_stg_pln_amt_sum else null end as m6_pmt_not_eng_equal_1_stg_pln_amt_rat
                ,case when m6_stg_pln_amt_sum > 0 then m6_pmt_not_eng_equal_2_stg_pln_amt_sum/m6_stg_pln_amt_sum else null end as m6_pmt_not_eng_equal_2_stg_pln_amt_rat
                ,case when m6_stg_pln_amt_sum > 0 then m6_pmt_not_eng_equal_3_stg_pln_amt_sum/m6_stg_pln_amt_sum else null end as m6_pmt_not_eng_equal_3_stg_pln_amt_rat
                ,case when m6_stg_pln_amt_sum > 0 then m6_pmt_not_eng_mor_3_stg_pln_amt_sum/m6_stg_pln_amt_sum else null end as m6_pmt_not_eng_mor_3_stg_pln_amt_rat
                --D0还款
                ,case when m6_stg_pln_d0_cnt > 0 then m6_pmt_not_eng_stg_pln_d0_cnt/m6_stg_pln_d0_cnt else null end as m6_pmt_not_eng_stg_pln_d0_cnt_rat
                ,case when m6_stg_pln_d0_cnt > 0 then m6_pmt_not_eng_equal_1_stg_pln_d0_cnt/m6_stg_pln_d0_cnt else null end as m6_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat
                ,case when m6_stg_pln_d0_cnt > 0 then m6_pmt_not_eng_equal_2_stg_pln_d0_cnt/m6_stg_pln_d0_cnt else null end as m6_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat
                ,case when m6_stg_pln_d0_cnt > 0 then m6_pmt_not_eng_equal_3_stg_pln_d0_cnt/m6_stg_pln_d0_cnt else null end as m6_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat
                ,case when m6_stg_pln_d0_cnt > 0 then m6_pmt_not_eng_mor_3_stg_pln_d0_cnt/m6_stg_pln_d0_cnt else null end as m6_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat
                ,case when m6_stg_pln_d0_amt_sum > 0 then m6_pmt_not_eng_stg_pln_d0_amt_sum/m6_stg_pln_d0_amt_sum else null end as m6_pmt_not_eng_stg_pln_d0_amt_sum_rat
                ,case when m6_stg_pln_d0_amt_sum > 0 then m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum/m6_stg_pln_d0_amt_sum else null end as m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat
                ,case when m6_stg_pln_d0_amt_sum > 0 then m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum/m6_stg_pln_d0_amt_sum else null end as m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat
                ,case when m6_stg_pln_d0_amt_sum > 0 then m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum/m6_stg_pln_d0_amt_sum else null end as m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat
                ,case when m6_stg_pln_d0_amt_sum > 0 then m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum/m6_stg_pln_d0_amt_sum else null end as m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat

                -- 趋势
                ,case when stg_pln_cnt_1m_3m > 0 then pmt_not_eng_stg_pln_cnt_1m_3m/stg_pln_cnt_1m_3m else null end as pmt_not_eng_stg_pln_cnt_1m_3m_rat
                ,case when stg_pln_cnt_3m_6m > 0 then pmt_not_eng_stg_pln_cnt_3m_6m/stg_pln_cnt_3m_6m else null end as pmt_not_eng_stg_pln_cnt_3m_6m_rat
        from 
        (
                select *
                        ,m3_stg_pln_cnt-m1_stg_pln_cnt as stg_pln_cnt_1m_3m
                        ,m6_stg_pln_cnt-m3_stg_pln_cnt as stg_pln_cnt_3m_6m
                        ,m3_pmt_not_eng_stg_pln_cnt-m1_pmt_not_eng_stg_pln_cnt as pmt_not_eng_stg_pln_cnt_1m_3m
                        ,m6_pmt_not_eng_stg_pln_cnt-m3_pmt_not_eng_stg_pln_cnt as pmt_not_eng_stg_pln_cnt_3m_6m
                from ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp2
                -- where uid in
                -- (
                --         '0a80bddf-7e34-4bfb-bff9-99aa84407895',--当前逾期
                --         '00177381-4a78-40ca-a405-c59c56230bdc',--未逾期
                --         '00bbd98b-ea5f-4bbd-a264-39a8a3dc2259',--未逾期
                --         '0172a8f9-610e-48aa-8bbe-b020bae9d419',--未逾期
                --         '00207efa-3256-4c66-aef7-ddbd60b07044',--未来逾期
                --         '26d570c0-07a5-4cc4-9905-4d9fece93c92'--未来逾期
                -- )       
        ) as a
) as aa
;

set odps.task.wlm.quota = Quote_dataphin_other;

-- by crt_dat统计
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp4;
create table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp4 as
select uid
         ,mdl_dte
         ,max(case when rep_deduct_m1_flg = 1 then pmt_not_cnt_pday else null end) as m1_pmt_not_eng_cnt_pday_max
         ,min(case when rep_deduct_m1_flg = 1 then pmt_not_cnt_pday else null end) as m1_pmt_not_eng_cnt_pday_min
         ,count(distinct case when rep_deduct_m1_flg = 1 and pmt_not_cnt_pday > 0 then crt_dat else null end) as m1_pmt_not_eng_cnt_pday_mor_0_day_cnt
         ,count(distinct case when rep_deduct_m1_flg = 1 and pmt_not_cnt_pday = 1 then crt_dat else null end) as m1_pmt_not_eng_cnt_pday_equal_1_day_cnt
         ,count(distinct case when rep_deduct_m1_flg = 1 and pmt_not_cnt_pday > 1 then crt_dat else null end) as m1_pmt_not_eng_cnt_pday_mor_1_day_cnt
         ,max(case when rep_deduct_m1_flg = 1 then sum_pmt_not_eng_amt_pday else null end) as m1_pmt_not_eng_amt_pday_max
         ,min(case when rep_deduct_m1_flg = 1 then sum_pmt_not_eng_amt_pday else null end) as m1_pmt_not_eng_amt_pday_min

         ,max(case when rep_deduct_m3_flg = 1 then pmt_not_cnt_pday else null end) as m3_pmt_not_eng_cnt_pday_max
         ,min(case when rep_deduct_m3_flg = 1 then pmt_not_cnt_pday else null end) as m3_pmt_not_eng_cnt_pday_min
         ,count(distinct case when rep_deduct_m3_flg = 1 and pmt_not_cnt_pday > 0 then crt_dat else null end) as m3_pmt_not_eng_cnt_pday_mor_0_day_cnt
         ,count(distinct case when rep_deduct_m3_flg = 1 and pmt_not_cnt_pday = 1 then crt_dat else null end) as m3_pmt_not_eng_cnt_pday_equal_1_day_cnt
         ,count(distinct case when rep_deduct_m3_flg = 1 and pmt_not_cnt_pday > 1 then crt_dat else null end) as m3_pmt_not_eng_cnt_pday_mor_1_day_cnt
         ,max(case when rep_deduct_m3_flg = 1 then sum_pmt_not_eng_amt_pday else null end) as m3_pmt_not_eng_amt_pday_max
         ,min(case when rep_deduct_m3_flg = 1 then sum_pmt_not_eng_amt_pday else null end) as m3_pmt_not_eng_amt_pday_min

         ,max(case when rep_deduct_m6_flg = 1 then pmt_not_cnt_pday else null end) as m6_pmt_not_eng_cnt_pday_max
         ,min(case when rep_deduct_m6_flg = 1 then pmt_not_cnt_pday else null end) as m6_pmt_not_eng_cnt_pday_min
         ,count(distinct case when rep_deduct_m6_flg = 1 and pmt_not_cnt_pday > 0 then crt_dat else null end) as m6_pmt_not_eng_cnt_pday_mor_0_day_cnt
         ,count(distinct case when rep_deduct_m6_flg = 1 and pmt_not_cnt_pday = 1 then crt_dat else null end) as m6_pmt_not_eng_cnt_pday_equal_1_day_cnt
         ,count(distinct case when rep_deduct_m6_flg = 1 and pmt_not_cnt_pday > 1 then crt_dat else null end) as m6_pmt_not_eng_cnt_pday_mor_1_day_cnt
         ,max(case when rep_deduct_m6_flg = 1 then sum_pmt_not_eng_amt_pday else null end) as m6_pmt_not_eng_amt_pday_max
         ,min(case when rep_deduct_m6_flg = 1 then sum_pmt_not_eng_amt_pday else null end) as m6_pmt_not_eng_amt_pday_min
from 
(
        select uid,mdl_dte,crt_dat,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg
                ,count(distinct biz_srl) as pmt_not_cnt_pday
                ,count(distinct crd_no) as pmt_not_eng_crd_cnt_pday
                ,sum(trs_amt) as sum_pmt_not_eng_amt_pday
        from
        (
                select uid,mdl_dte,stg_pln_no,crt_dat,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg,rep_tim_type,trs_amt,crd_no,biz_srl
                from ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_detail
                where stg_pln_no is not null 
                and balance_not_egh_flg = 1
                -- and uid in
                --         (
                --                '0a80bddf-7e34-4bfb-bff9-99aa84407895',--当前逾期
                --         '00177381-4a78-40ca-a405-c59c56230bdc',--未逾期
                --         '00bbd98b-ea5f-4bbd-a264-39a8a3dc2259',--未逾期
                --         '0172a8f9-610e-48aa-8bbe-b020bae9d419',--未逾期
                --         '00207efa-3256-4c66-aef7-ddbd60b07044',--未来逾期
                --         '26d570c0-07a5-4cc4-9905-4d9fece93c92'--未来逾期
                --         )   
                group by uid,mdl_dte,stg_pln_no,crt_dat,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg,rep_tim_type,trs_amt,crd_no,biz_srl
        ) as a
        group by uid,mdl_dte,crt_dat,rep_deduct_m1_flg,rep_deduct_m3_flg,rep_deduct_m6_flg
) as aa
group by uid
         ,mdl_dte
;

-- set odps.task.wlm.quota=默认后付费Quota; 
-- 汇总
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df partition(ds = '${bizdate}')
select model_data.uid, 
        model_data.mdl_dte, 
        m1_payment_not_eng_mdl_crt_ddf_min, 
        m1_payment_not_eng_mdl_crt_ddf_max, 
        m1_payment_not_eng_mdl_crt_ddf_avg, 
        m1_payment_not_eng_inteday_min, 
        m1_payment_not_eng_inteday_max, 
        m1_payment_not_eng_inteday_avg, 
        m3_payment_not_eng_mdl_crt_ddf_min, 
        m3_payment_not_eng_mdl_crt_ddf_max, 
        m3_payment_not_eng_mdl_crt_ddf_avg, 
        m3_payment_not_eng_inteday_min, 
        m3_payment_not_eng_inteday_max, 
        m3_payment_not_eng_inteday_avg, 
        m6_payment_not_eng_mdl_crt_ddf_min, 
        m6_payment_not_eng_mdl_crt_ddf_max, 
        m6_payment_not_eng_mdl_crt_ddf_avg, 
        m6_payment_not_eng_inteday_min, 
        m6_payment_not_eng_inteday_max, 
        m6_payment_not_eng_inteday_avg,

        -- m1_stg_pln_cnt, 
        m1_pmt_not_eng_stg_pln_cnt, 
        m1_pmt_not_eng_equal_1_stg_pln_cnt, 
        m1_pmt_not_eng_equal_2_stg_pln_cnt, 
        m1_pmt_not_eng_equal_3_stg_pln_cnt, 
        m1_pmt_not_eng_mor_3_stg_pln_cnt, 
        m1_stg_pln_pmt_not_eng_cnt_sum, 
        m1_stg_pln_pmt_not_eng_cnt_max, 
        m1_stg_pln_pmt_not_eng_cnt_min, 
        m1_stg_pln_pmt_not_eng_cnt_avg, 
        -- m1_stg_pln_amt_sum, 
        m1_pmt_not_eng_stg_pln_amt_sum, 
        m1_pmt_not_eng_equal_1_stg_pln_amt_sum, 
        m1_pmt_not_eng_equal_2_stg_pln_amt_sum, 
        m1_pmt_not_eng_equal_3_stg_pln_amt_sum, 
        m1_pmt_not_eng_mor_3_stg_pln_amt_sum, 
        m1_stg_pln_pmt_not_eng_amt_max, 
        m1_stg_pln_pmt_not_eng_amt_min, 
        m1_stg_pln_pmt_not_eng_amt_avg, 
        m1_stg_pln_crd_cnt_max, 
        m1_stg_pln_crd_cnt_min, 
        m1_stg_pln_crd_cnt_avg, 
        m1_stg_pln_bnk_cnt_max, 
        m1_stg_pln_bnk_cnt_min, 
        m1_stg_pln_bnk_cnt_avg, 
        -- m1_stg_pln_d0_cnt, 
        m1_pmt_not_eng_stg_pln_d0_cnt, 
        m1_pmt_not_eng_equal_1_stg_pln_d0_cnt, 
        m1_pmt_not_eng_equal_2_stg_pln_d0_cnt, 
        m1_pmt_not_eng_equal_3_stg_pln_d0_cnt, 
        m1_pmt_not_eng_mor_3_stg_pln_d0_cnt, 
        -- m1_stg_pln_d0_amt_sum, 
        m1_pmt_not_eng_stg_pln_d0_amt_sum, 
        m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum, 
        m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum, 
        m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum, 
        m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum, 
        m1_stg_pln_d0_pmt_not_eng_cnt_sum, 
        m1_stg_pln_d0_pmt_not_eng_cnt_max, 
        m1_stg_pln_d0_pmt_not_eng_cnt_min, 
        m1_stg_pln_d0_pmt_not_eng_cnt_avg, 
        -- m3_stg_pln_cnt, 
        m3_pmt_not_eng_stg_pln_cnt, 
        m3_pmt_not_eng_equal_1_stg_pln_cnt, 
        m3_pmt_not_eng_equal_2_stg_pln_cnt, 
        m3_pmt_not_eng_equal_3_stg_pln_cnt, 
        m3_pmt_not_eng_mor_3_stg_pln_cnt, 
        m3_stg_pln_pmt_not_eng_cnt_sum, 
        m3_stg_pln_pmt_not_eng_cnt_max, 
        m3_stg_pln_pmt_not_eng_cnt_min, 
        m3_stg_pln_pmt_not_eng_cnt_avg, 
        -- m3_stg_pln_amt_sum, 
        m3_pmt_not_eng_stg_pln_amt_sum, 
        m3_pmt_not_eng_equal_1_stg_pln_amt_sum, 
        m3_pmt_not_eng_equal_2_stg_pln_amt_sum, 
        m3_pmt_not_eng_equal_3_stg_pln_amt_sum, 
        m3_pmt_not_eng_mor_3_stg_pln_amt_sum, 
        m3_stg_pln_pmt_not_eng_amt_max, 
        m3_stg_pln_pmt_not_eng_amt_min, 
        m3_stg_pln_pmt_not_eng_amt_avg, 
        m3_stg_pln_crd_cnt_max, 
        m3_stg_pln_crd_cnt_min, 
        m3_stg_pln_crd_cnt_avg, 
        m3_stg_pln_bnk_cnt_max, 
        m3_stg_pln_bnk_cnt_min, 
        m3_stg_pln_bnk_cnt_avg, 
        -- m3_stg_pln_d0_cnt, 
        m3_pmt_not_eng_stg_pln_d0_cnt, 
        m3_pmt_not_eng_equal_1_stg_pln_d0_cnt, 
        m3_pmt_not_eng_equal_2_stg_pln_d0_cnt, 
        m3_pmt_not_eng_equal_3_stg_pln_d0_cnt, 
        m3_pmt_not_eng_mor_3_stg_pln_d0_cnt, 
        -- m3_stg_pln_d0_amt_sum, 
        m3_pmt_not_eng_stg_pln_d0_amt_sum, 
        m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum, 
        m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum, 
        m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum, 
        m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum, 
        m3_stg_pln_d0_pmt_not_eng_cnt_sum, 
        m3_stg_pln_d0_pmt_not_eng_cnt_max, 
        m3_stg_pln_d0_pmt_not_eng_cnt_min, 
        m3_stg_pln_d0_pmt_not_eng_cnt_avg, 
        -- m6_stg_pln_cnt, 
        m6_pmt_not_eng_stg_pln_cnt, 
        m6_pmt_not_eng_equal_1_stg_pln_cnt, 
        m6_pmt_not_eng_equal_2_stg_pln_cnt, 
        m6_pmt_not_eng_equal_3_stg_pln_cnt, 
        m6_pmt_not_eng_mor_3_stg_pln_cnt, 
        m6_stg_pln_pmt_not_eng_cnt_sum, 
        m6_stg_pln_pmt_not_eng_cnt_max, 
        m6_stg_pln_pmt_not_eng_cnt_min, 
        m6_stg_pln_pmt_not_eng_cnt_avg, 
        -- m6_stg_pln_amt_sum, 
        m6_pmt_not_eng_stg_pln_amt_sum, 
        m6_pmt_not_eng_equal_1_stg_pln_amt_sum, 
        m6_pmt_not_eng_equal_2_stg_pln_amt_sum, 
        m6_pmt_not_eng_equal_3_stg_pln_amt_sum, 
        m6_pmt_not_eng_mor_3_stg_pln_amt_sum, 
        m6_stg_pln_pmt_not_eng_amt_max, 
        m6_stg_pln_pmt_not_eng_amt_min, 
        m6_stg_pln_pmt_not_eng_amt_avg, 
        m6_stg_pln_crd_cnt_max, 
        m6_stg_pln_crd_cnt_min, 
        m6_stg_pln_crd_cnt_avg, 
        m6_stg_pln_bnk_cnt_max, 
        m6_stg_pln_bnk_cnt_min, 
        m6_stg_pln_bnk_cnt_avg, 
        -- m6_stg_pln_d0_cnt, 
        m6_pmt_not_eng_stg_pln_d0_cnt, 
        m6_pmt_not_eng_equal_1_stg_pln_d0_cnt, 
        m6_pmt_not_eng_equal_2_stg_pln_d0_cnt, 
        m6_pmt_not_eng_equal_3_stg_pln_d0_cnt, 
        m6_pmt_not_eng_mor_3_stg_pln_d0_cnt, 
        -- m6_stg_pln_d0_amt_sum, 
        m6_pmt_not_eng_stg_pln_d0_amt_sum, 
        m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum, 
        m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum, 
        m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum, 
        m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum, 
        m6_stg_pln_d0_pmt_not_eng_cnt_sum, 
        m6_stg_pln_d0_pmt_not_eng_cnt_max, 
        m6_stg_pln_d0_pmt_not_eng_cnt_min, 
        m6_stg_pln_d0_pmt_not_eng_cnt_avg,

        m1_pmt_not_eng_stg_pln_cnt_rat, 
        m1_pmt_not_eng_equal_1_stg_pln_cnt_rat, 
        m1_pmt_not_eng_equal_2_stg_pln_cnt_rat, 
        m1_pmt_not_eng_equal_3_stg_pln_cnt_rat, 
        m1_pmt_not_eng_mor_3_stg_pln_cnt_rat, 
        m1_pmt_not_eng_stg_pln_amt_rat, 
        m1_pmt_not_eng_equal_1_stg_pln_amt_rat, 
        m1_pmt_not_eng_equal_2_stg_pln_amt_rat, 
        m1_pmt_not_eng_equal_3_stg_pln_amt_rat, 
        m1_pmt_not_eng_mor_3_stg_pln_amt_rat, 
        m1_pmt_not_eng_stg_pln_d0_cnt_rat, 
        m1_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat, 
        m1_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat, 
        m1_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat, 
        m1_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat, 
        m1_pmt_not_eng_stg_pln_d0_amt_sum_rat, 
        m1_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat, 
        m1_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat, 
        m1_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat, 
        m1_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat, 
        m3_pmt_not_eng_stg_pln_cnt_rat, 
        m3_pmt_not_eng_equal_1_stg_pln_cnt_rat, 
        m3_pmt_not_eng_equal_2_stg_pln_cnt_rat, 
        m3_pmt_not_eng_equal_3_stg_pln_cnt_rat, 
        m3_pmt_not_eng_mor_3_stg_pln_cnt_rat, 
        m3_pmt_not_eng_stg_pln_amt_rat, 
        m3_pmt_not_eng_equal_1_stg_pln_amt_rat, 
        m3_pmt_not_eng_equal_2_stg_pln_amt_rat, 
        m3_pmt_not_eng_equal_3_stg_pln_amt_rat, 
        m3_pmt_not_eng_mor_3_stg_pln_amt_rat, 
        m3_pmt_not_eng_stg_pln_d0_cnt_rat, 
        m3_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat, 
        m3_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat, 
        m3_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat, 
        m3_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat, 
        m3_pmt_not_eng_stg_pln_d0_amt_sum_rat, 
        m3_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat, 
        m3_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat, 
        m3_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat, 
        m3_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat, 
        m6_pmt_not_eng_stg_pln_cnt_rat, 
        m6_pmt_not_eng_equal_1_stg_pln_cnt_rat, 
        m6_pmt_not_eng_equal_2_stg_pln_cnt_rat, 
        m6_pmt_not_eng_equal_3_stg_pln_cnt_rat, 
        m6_pmt_not_eng_mor_3_stg_pln_cnt_rat, 
        m6_pmt_not_eng_stg_pln_amt_rat, 
        m6_pmt_not_eng_equal_1_stg_pln_amt_rat, 
        m6_pmt_not_eng_equal_2_stg_pln_amt_rat, 
        m6_pmt_not_eng_equal_3_stg_pln_amt_rat, 
        m6_pmt_not_eng_mor_3_stg_pln_amt_rat, 
        m6_pmt_not_eng_stg_pln_d0_cnt_rat, 
        m6_pmt_not_eng_equal_1_stg_pln_d0_cnt_rat, 
        m6_pmt_not_eng_equal_2_stg_pln_d0_cnt_rat, 
        m6_pmt_not_eng_equal_3_stg_pln_d0_cnt_rat, 
        m6_pmt_not_eng_mor_3_stg_pln_d0_cnt_rat, 
        m6_pmt_not_eng_stg_pln_d0_amt_sum_rat, 
        m6_pmt_not_eng_equal_1_stg_pln_d0_amt_sum_rat, 
        m6_pmt_not_eng_equal_2_stg_pln_d0_amt_sum_rat, 
        m6_pmt_not_eng_equal_3_stg_pln_d0_amt_sum_rat, 
        m6_pmt_not_eng_mor_3_stg_pln_d0_amt_sum_rat, 
        pmt_not_eng_stg_pln_cnt_1m_3m_rat, 
        pmt_not_eng_stg_pln_cnt_3m_6m_rat, 
        pmt_not_eng_stg_pln_cnt_1m_3m_rat_trend, 
        pmt_not_eng_stg_pln_cnt_3m_6m_rat_trend,

        m1_pmt_not_eng_cnt_pday_max, 
        m1_pmt_not_eng_cnt_pday_min, 
        m1_pmt_not_eng_cnt_pday_mor_0_day_cnt, 
        m1_pmt_not_eng_cnt_pday_equal_1_day_cnt, 
        m1_pmt_not_eng_cnt_pday_mor_1_day_cnt, 
        m1_pmt_not_eng_amt_pday_max, 
        m1_pmt_not_eng_amt_pday_min, 
        m3_pmt_not_eng_cnt_pday_max, 
        m3_pmt_not_eng_cnt_pday_min, 
        m3_pmt_not_eng_cnt_pday_mor_0_day_cnt, 
        m3_pmt_not_eng_cnt_pday_equal_1_day_cnt, 
        m3_pmt_not_eng_cnt_pday_mor_1_day_cnt, 
        m3_pmt_not_eng_amt_pday_max, 
        m3_pmt_not_eng_amt_pday_min, 
        m6_pmt_not_eng_cnt_pday_max, 
        m6_pmt_not_eng_cnt_pday_min, 
        m6_pmt_not_eng_cnt_pday_mor_0_day_cnt, 
        m6_pmt_not_eng_cnt_pday_equal_1_day_cnt, 
        m6_pmt_not_eng_cnt_pday_mor_1_day_cnt, 
        m6_pmt_not_eng_amt_pday_max, 
        m6_pmt_not_eng_amt_pday_min
        
from 
(
    select uid,mdl_dte
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base_tmp
    -- where uid in
    --             (
    --                     '0a80bddf-7e34-4bfb-bff9-99aa84407895',--当前逾期
    --                     '00177381-4a78-40ca-a405-c59c56230bdc',--未逾期
    --                     '00bbd98b-ea5f-4bbd-a264-39a8a3dc2259',--未逾期
    --                     '0172a8f9-610e-48aa-8bbe-b020bae9d419',--未逾期
    --                     '00207efa-3256-4c66-aef7-ddbd60b07044',--未来逾期
    --                     '26d570c0-07a5-4cc4-9905-4d9fece93c92'--未来逾期
    --             ) 
    group by uid,mdl_dte
) model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp1 as t1
on model_data.uid = t1.uid and model_data.mdl_dte = t1.mdl_dte
left join ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp2 as t2
on model_data.uid = t2.uid and model_data.mdl_dte = t2.mdl_dte
left join ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp3 as t3
on model_data.uid = t3.uid and model_data.mdl_dte = t3.mdl_dte
left join ${dwa_risk}.dwa_risk_dz_model_final_repayment_deduct_info_df_tmp4 as t4
on model_data.uid = t4.uid and model_data.mdl_dte = t4.mdl_dte
;
-- feature-copilot:node-end ordinal=0
