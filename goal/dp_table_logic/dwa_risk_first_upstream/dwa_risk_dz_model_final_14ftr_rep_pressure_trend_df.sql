-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df
-- node_id: n_4240587271971733504
-- task_name: dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df.json
-- source_json_sha256: 5ed07a781ec6c902fae39e2bb2d5a6063533bb185c59b3f385b1a610007dd0cf
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp3
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_final_14ftr_rep_pressure_trend_df_data_base_tmp
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp3
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp3
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 贷中宽表_未来还款压力趋势
--功能描述: 基于用户历史及未来还款数据衍生出用户还款压力/行为的趋势性变化情况,注：_cash后缀是基于BT&cash统计，_all后缀是基于('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN','API_ASSET')统计
--创建者: 刘诗涵
--创建日期: 2022-11-15 16:16:08
--修改日期  修改人 修改内容
--yyyymmdd  name    comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
stg_pln_cnt_ftr_cash BIGINT comment '未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_3d_ftr_cash BIGINT comment '近3天未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_7d_ftr_cash BIGINT comment '近7天未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_1m_ftr_cash BIGINT comment '近1个月未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_2m_ftr_cash BIGINT comment '近2个月未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_3m_ftr_cash BIGINT comment '近3个月未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_6m_ftr_cash BIGINT comment '近6个月未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_12m_ftr_cash BIGINT comment '近12个月未来应还分期计划数(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_ftr_cash DECIMAL(28,6) comment '未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_3d_ftr_cash DECIMAL(28,6) comment '近3天未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_7d_ftr_cash DECIMAL(28,6) comment '近7天未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_1m_ftr_cash DECIMAL(28,6) comment '近1个月未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_2m_ftr_cash DECIMAL(28,6) comment '近2个月未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_3m_ftr_cash DECIMAL(28,6) comment '近3个月未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_6m_ftr_cash DECIMAL(28,6) comment '近6个月未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_12m_ftr_cash DECIMAL(28,6) comment '近12个月未来应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_avg_prc_amt_ftr_cash DECIMAL(22,10) comment '未来应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_1m_ftr_cash DECIMAL(22,10) comment '近1个月未来应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_2m_ftr_cash DECIMAL(22,10) comment '近2个月未来应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_3m_ftr_cash DECIMAL(22,10) comment '近3个月未来应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_6m_ftr_cash DECIMAL(22,10) comment '近6个月未来应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_12m_ftr_cash DECIMAL(22,10) comment '近12个月未来应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_min_prc_amt_ftr_cash DECIMAL(18,6) comment '未来应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_1m_ftr_cash DECIMAL(18,6) comment '近1个月未来应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_2m_ftr_cash DECIMAL(18,6) comment '近2个月未来应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_3m_ftr_cash DECIMAL(18,6) comment '近3个月未来应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_6m_ftr_cash DECIMAL(18,6) comment '近6个月未来应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_12m_ftr_cash DECIMAL(18,6) comment '近12个月未来应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_max_prc_amt_ftr_cash DECIMAL(18,6) comment '未来应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_1m_ftr_cash DECIMAL(18,6) comment '近1个月未来应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_2m_ftr_cash DECIMAL(18,6) comment '近2个月未来应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_3m_ftr_cash DECIMAL(18,6) comment '近3个月未来应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_6m_ftr_cash DECIMAL(18,6) comment '近6个月未来应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_12m_ftr_cash DECIMAL(18,6) comment '近12个月未来应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_cnt_ftr_adv_cash BIGINT comment '已提前还款的未来分期计划数_cash',
stg_pln_cnt_1m_ftr_adv_cash BIGINT comment '近1个月已提前还款的未来分期计划数_cash',
stg_pln_cnt_2m_ftr_adv_cash BIGINT comment '近2个月已提前还款的未来分期计划数_cash',
stg_pln_cnt_3m_ftr_adv_cash BIGINT comment '近3个月已提前还款的未来分期计划数_cash',
stg_pln_cnt_6m_ftr_adv_cash BIGINT comment '近6个月已提前还款的未来分期计划数_cash',
stg_pln_cnt_12m_ftr_adv_cash BIGINT comment '近12个月已提前还款的未来分期计划数_cash',
stg_pln_sum_prc_amt_ftr_adv_cash DECIMAL(28,6) comment '已提前还款的未来分期计划金额_sum_cash',
stg_pln_sum_prc_amt_1m_ftr_adv_cash DECIMAL(28,6) comment '近1个月已提前还款的未来分期计划金额_sum_cash',
stg_pln_sum_prc_amt_2m_ftr_adv_cash DECIMAL(28,6) comment '近2个月已提前还款的未来分期计划金额_sum_cash',
stg_pln_sum_prc_amt_3m_ftr_adv_cash DECIMAL(28,6) comment '近3个月已提前还款的未来分期计划金额_sum_cash',
stg_pln_sum_prc_amt_6m_ftr_adv_cash DECIMAL(28,6) comment '近6个月已提前还款的未来分期计划金额_sum_cash',
stg_pln_sum_prc_amt_12m_ftr_adv_cash DECIMAL(28,6) comment '近12个月已提前还款的未来分期计划金额_sum_cash',
stg_pln_avg_prc_amt_ftr_adv_cash DECIMAL(22,10) comment '已提前还款的未来应还分期计划金额_avg_cash',
stg_pln_avg_prc_amt_1m_ftr_adv_cash DECIMAL(22,10) comment '近1个月已提前还款的未来应还分期计划金额_avg_cash',
stg_pln_avg_prc_amt_2m_ftr_adv_cash DECIMAL(22,10) comment '近2个月已提前还款的未来应还分期计划金额_avg_cash',
stg_pln_avg_prc_amt_3m_ftr_adv_cash DECIMAL(22,10) comment '近3个月已提前还款的未来应还分期计划金额_avg_cash',
stg_pln_avg_prc_amt_6m_ftr_adv_cash DECIMAL(22,10) comment '近6个月已提前还款的未来应还分期计划金额_avg_cash',
stg_pln_avg_prc_amt_12m_ftr_adv_cash DECIMAL(22,10) comment '近12个月已提前还款的未来应还分期计划金额_avg_cash',
stg_pln_min_prc_amt_ftr_adv_cash DECIMAL(18,6) comment '已提前还款的未来应还分期计划金额_min_cash',
stg_pln_min_prc_amt_1m_ftr_adv_cash DECIMAL(18,6) comment '近1个月已提前还款的未来应还分期计划金额_min_cash',
stg_pln_min_prc_amt_2m_ftr_adv_cash DECIMAL(18,6) comment '近2个月已提前还款的未来应还分期计划金额_min_cash',
stg_pln_min_prc_amt_3m_ftr_adv_cash DECIMAL(18,6) comment '近3个月已提前还款的未来应还分期计划金额_min_cash',
stg_pln_min_prc_amt_6m_ftr_adv_cash DECIMAL(18,6) comment '近6个月已提前还款的未来应还分期计划金额_min_cash',
stg_pln_min_prc_amt_12m_ftr_adv_cash DECIMAL(18,6) comment '近12个月已提前还款的未来应还分期计划金额_min_cash',
stg_pln_max_prc_amt_ftr_adv_cash DECIMAL(18,6) comment '已提前还款的未来应还分期计划金额_max_cash',
stg_pln_max_prc_amt_1m_ftr_adv_cash DECIMAL(18,6) comment '近1个月已提前还款的未来应还分期计划金额_max_cash',
stg_pln_max_prc_amt_2m_ftr_adv_cash DECIMAL(18,6) comment '近2个月已提前还款的未来应还分期计划金额_max_cash',
stg_pln_max_prc_amt_3m_ftr_adv_cash DECIMAL(18,6) comment '近3个月已提前还款的未来应还分期计划金额_max_cash',
stg_pln_max_prc_amt_6m_ftr_adv_cash DECIMAL(18,6) comment '近6个月已提前还款的未来应还分期计划金额_max_cash',
stg_pln_max_prc_amt_12m_ftr_adv_cash DECIMAL(18,6) comment '近12个月已提前还款的未来应还分期计划金额_max_cash',
stg_pln_cnt_ftr_rep_cash BIGINT comment '未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_3d_ftr_rep_cash BIGINT comment '近3天未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_7d_ftr_rep_cash BIGINT comment '近7天未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_1m_ftr_rep_cash BIGINT comment '近1个月未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_2m_ftr_rep_cash BIGINT comment '近2个月未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_3m_ftr_rep_cash BIGINT comment '近3个月未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_6m_ftr_rep_cash BIGINT comment '近6个月未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_12m_ftr_rep_cash BIGINT comment '近12个月未来应还分期计划数(包含历史未还订单)_cash',
stg_pln_sum_prc_amt_ftr_rep_cash DECIMAL(28,6) comment '未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_3d_ftr_rep_cash DECIMAL(28,6) comment '近3天未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_7d_ftr_rep_cash DECIMAL(28,6) comment '近7天未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_1m_ftr_rep_cash DECIMAL(28,6) comment '近1个月未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_2m_ftr_rep_cash DECIMAL(28,6) comment '近2个月未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_3m_ftr_rep_cash DECIMAL(28,6) comment '近3个月未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_6m_ftr_rep_cash DECIMAL(28,6) comment '近6个月未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_12m_ftr_rep_cash DECIMAL(28,6) comment '近12个月未来应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_avg_prc_amt_ftr_rep_cash DECIMAL(22,10) comment '未来应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_1m_ftr_rep_cash DECIMAL(22,10) comment '近1个月未来应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_2m_ftr_rep_cash DECIMAL(22,10) comment '近2个月未来应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_3m_ftr_rep_cash DECIMAL(22,10) comment '近3个月未来应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_6m_ftr_rep_cash DECIMAL(22,10) comment '近6个月未来应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_12m_ftr_rep_cash DECIMAL(22,10) comment '近12个月未来应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_min_prc_amt_ftr_rep_cash DECIMAL(18,6) comment '未来应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_1m_ftr_rep_cash DECIMAL(18,6) comment '近1个月未来应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_2m_ftr_rep_cash DECIMAL(18,6) comment '近2个月未来应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_3m_ftr_rep_cash DECIMAL(18,6) comment '近3个月未来应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_6m_ftr_rep_cash DECIMAL(18,6) comment '近6个月未来应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_12m_ftr_rep_cash DECIMAL(18,6) comment '近12个月未来应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_max_prc_amt_ftr_rep_cash DECIMAL(18,6) comment '未来应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_1m_ftr_rep_cash DECIMAL(18,6) comment '近1个月未来应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_2m_ftr_rep_cash DECIMAL(18,6) comment '近2个月未来应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_3m_ftr_rep_cash DECIMAL(18,6) comment '近3个月未来应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_6m_ftr_rep_cash DECIMAL(18,6) comment '近6个月未来应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_12m_ftr_rep_cash DECIMAL(18,6) comment '近12个月未来应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_cnt_1m_3m_ftr_cash BIGINT comment '未来1m-3m应还分期计划数(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_1m_3m_ftr_cash DECIMAL(28,6) comment '未来1m-3m应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_avg_prc_amt_1m_3m_ftr_cash DECIMAL(22,10) comment '未来1m-3m应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_min_prc_amt_1m_3m_ftr_cash DECIMAL(18,6) comment '未来1m-3m应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_max_prc_amt_1m_3m_ftr_cash DECIMAL(18,6) comment '未来1m-3m应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_cnt_3m_6m_ftr_cash BIGINT comment '未来3m-6m应还分期计划数(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_3m_6m_ftr_cash DECIMAL(28,6) comment '未来3m-6m应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_avg_prc_amt_3m_6m_ftr_cash DECIMAL(22,10) comment '未来3m-6m应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_min_prc_amt_3m_6m_ftr_cash DECIMAL(18,6) comment '未来3m-6m应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_max_prc_amt_3m_6m_ftr_cash DECIMAL(18,6) comment '未来3m-6m应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_cnt_6m_12m_ftr_cash BIGINT comment '未来6m-12m应还分期计划数(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_6m_12m_ftr_cash DECIMAL(28,6) comment '未来6m-12m应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_avg_prc_amt_6m_12m_ftr_cash DECIMAL(22,10) comment '未来6m-12m应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_min_prc_amt_6m_12m_ftr_cash DECIMAL(18,6) comment '未来6m-12m应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_max_prc_amt_6m_12m_ftr_cash DECIMAL(18,6) comment '未来6m-12m应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_cnt_1m_3m_ftr_rto_cash DOUBLE comment '未来1m应还分期计划数/未来1m-3m应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_3m_6m_ftr_rto_cash DOUBLE comment '未来3m应还分期计划数/未来3m-6m应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_6m_12m_ftr_rto_cash DOUBLE comment '未来6m应还分期计划数/未来6m-12m应还分期计划数(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_1m_3m_ftr_rto_cash DECIMAL(38,18) comment '未来1m应还分期计划金额_sum/未来1m-3m应还分期计划金额_sum(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_3m_6m_ftr_rto_cash DECIMAL(38,18) comment '未来3m应还分期计划金额_sum/未来3m-6m应还分期计划金额_sum(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_6m_12m_ftr_rto_cash DECIMAL(38,18) comment '未来6m应还分期计划金额_sum/未来6m-12m应还分期计划金额_sum(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_1m_3m_ftr_rto_cash DECIMAL(38,18) comment '未来1m应还分期计划金额_avg/未来1m-3m应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_3m_6m_ftr_rto_cash DECIMAL(38,18) comment '未来3m应还分期计划金额_avg/未来3m-6m应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_6m_12m_ftr_rto_cash DECIMAL(38,18) comment '未来6m应还分期计划金额_avg/未来6m-12m应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_min_prc_amt_1m_3m_ftr_rto_cash DECIMAL(38,18) comment '未来1m应还分期计划金额_min/未来1m-3m应还分期计划金额_min(包含提前已还订单)_cash',
stg_pln_min_prc_amt_3m_6m_ftr_rto_cash DECIMAL(38,18) comment '未来3m应还分期计划金额_min/未来3m-6m应还分期计划金额_min(包含提前已还订单)_cash',
stg_pln_min_prc_amt_6m_12m_ftr_rto_cash DECIMAL(38,18) comment '未来6m应还分期计划金额_min/未来6m-12m应还分期计划金额_min(包含提前已还订单)_cash',
stg_pln_max_prc_amt_1m_3m_ftr_rto_cash DECIMAL(38,18) comment '未来1m应还分期计划金额_max/未来1m-3m应还分期计划金额_max(包含提前已还订单)_cash',
stg_pln_max_prc_amt_3m_6m_ftr_rto_cash DECIMAL(38,18) comment '未来3m应还分期计划金额_max/未来3m-6m应还分期计划金额_max(包含提前已还订单)_cash',
stg_pln_max_prc_amt_6m_12m_ftr_rto_cash DECIMAL(38,18) comment '未来6m应还分期计划金额_max/未来6m-12m应还分期计划金额_max(包含提前已还订单)_cash',
stg_pln_cnt_3d_ftr_his_rto_cash DOUBLE comment '近3天未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_7d_ftr_his_rto_cash DOUBLE comment '近7天未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_1m_ftr_his_rto_cash DOUBLE comment '近1个月未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_2m_ftr_his_rto_cash DOUBLE comment '近2个月未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_3m_ftr_his_rto_cash DOUBLE comment '近3个月未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_6m_ftr_his_rto_cash DOUBLE comment '近6个月未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_12m_ftr_his_rto_cash DOUBLE comment '近12个月未来/历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_sum_prc_amt_3d_ftr_his_rto_cash DECIMAL(38,18) comment '近3天未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_7d_ftr_his_rto_cash DECIMAL(38,18) comment '近7天未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_1m_ftr_his_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_2m_ftr_his_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_3m_ftr_his_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_6m_ftr_his_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_sum_prc_amt_12m_ftr_his_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含提前已还订单)_sum_cash',
stg_pln_avg_prc_amt_1m_ftr_his_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_2m_ftr_his_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_3m_ftr_his_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_6m_ftr_his_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_avg_prc_amt_12m_ftr_his_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含提前已还订单)_avg_cash',
stg_pln_min_prc_amt_1m_ftr_his_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_2m_ftr_his_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_3m_ftr_his_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_6m_ftr_his_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_min_prc_amt_12m_ftr_his_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含提前已还订单)_min_cash',
stg_pln_max_prc_amt_1m_ftr_his_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_2m_ftr_his_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_3m_ftr_his_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_6m_ftr_his_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_max_prc_amt_12m_ftr_his_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含提前已还订单)_max_cash',
stg_pln_cnt_1m_ftr_his_12m_rto_cash DOUBLE comment '近1个月未来/近12个月历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_2m_ftr_his_12m_rto_cash DOUBLE comment '近2个月未来/近12个月历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_3m_ftr_his_12m_rto_cash DOUBLE comment '近3个月未来/近12个月历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_cnt_6m_ftr_his_12m_rto_cash DOUBLE comment '近6个月未来/近12个月历史应还分期计划数(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_1m_ftr_his_12m_rto_cash DECIMAL(38,18) comment '近1个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_2m_ftr_his_12m_rto_cash DECIMAL(38,18) comment '近2个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_3m_ftr_his_12m_rto_cash DECIMAL(38,18) comment '近3个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_avg_prc_amt_6m_ftr_his_12m_rto_cash DECIMAL(38,18) comment '近6个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_cash',
stg_pln_cnt_1m_ftr_his_rep_rto_cash DOUBLE comment '近1个月未来/历史应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_2m_ftr_his_rep_rto_cash DOUBLE comment '近2个月未来/历史应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_3m_ftr_his_rep_rto_cash DOUBLE comment '近3个月未来/历史应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_6m_ftr_his_rep_rto_cash DOUBLE comment '近6个月未来/历史应还分期计划数(包含历史未还订单)_cash',
stg_pln_cnt_12m_ftr_his_rep_rto_cash DOUBLE comment '近12个月未来/历史应还分期计划数(包含历史未还订单)_cash',
stg_pln_sum_prc_amt_1m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_2m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_3m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_6m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_sum_prc_amt_12m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含历史未还订单)_sum_cash',
stg_pln_avg_prc_amt_1m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_2m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_3m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_6m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_avg_prc_amt_12m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含历史未还订单)_avg_cash',
stg_pln_min_prc_amt_1m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_2m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_3m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_6m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_min_prc_amt_12m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含历史未还订单)_min_cash',
stg_pln_max_prc_amt_1m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_2m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_3m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_6m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_max_prc_amt_12m_ftr_his_rep_rto_cash DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含历史未还订单)_max_cash',
stg_pln_cnt_ftr_adv_rto_cash DOUBLE comment '已提前还款的未来/历史分期计划数_cash',
stg_pln_cnt_1m_ftr_adv_rto_cash DOUBLE comment '近1个月已提前还款的未来/历史分期计划数_cash',
stg_pln_cnt_2m_ftr_adv_rto_cash DOUBLE comment '近2个月已提前还款的未来/历史分期计划数_cash',
stg_pln_cnt_3m_ftr_adv_rto_cash DOUBLE comment '近3个月已提前还款的未来/历史分期计划数_cash',
stg_pln_cnt_6m_ftr_adv_rto_cash DOUBLE comment '近6个月已提前还款的未来/历史分期计划数_cash',
stg_pln_cnt_12m_ftr_adv_rto_cash DOUBLE comment '近12个月已提前还款的未来/历史分期计划数_cash',
stg_pln_sum_prc_amt_ftr_adv_rto_cash DECIMAL(38,18) comment '已提前还款的未来/历史分期计划金额_sum_cash',
stg_pln_sum_prc_amt_1m_ftr_adv_rto_cash DECIMAL(38,18) comment '近1个月已提前还款的未来/历史分期计划金额_sum_cash',
stg_pln_sum_prc_amt_2m_ftr_adv_rto_cash DECIMAL(38,18) comment '近2个月已提前还款的未来/历史分期计划金额_sum_cash',
stg_pln_sum_prc_amt_3m_ftr_adv_rto_cash DECIMAL(38,18) comment '近3个月已提前还款的未来/历史分期计划金额_sum_cash',
stg_pln_sum_prc_amt_6m_ftr_adv_rto_cash DECIMAL(38,18) comment '近6个月已提前还款的未来/历史分期计划金额_sum_cash',
stg_pln_sum_prc_amt_12m_ftr_adv_rto_cash DECIMAL(38,18) comment '近12个月已提前还款的未来/历史分期计划金额_sum_cash',
stg_pln_bsy_typ_cnt_1m_ftr_all BIGINT comment '近1个月未来应还业务类型数(重资产/DCP/HUGELOAN/API_ASSET)_cash',
stg_pln_bsy_typ_cnt_2m_ftr_all BIGINT comment '近2个月未来应还业务类型数(重资产/DCP/HUGELOAN/API_ASSET)_cash',
stg_pln_bsy_typ_cnt_3m_ftr_all BIGINT comment '近3个月未来应还业务类型数(重资产/DCP/HUGELOAN/API_ASSET)_cash',
stg_pln_bsy_typ_cnt_6m_ftr_all BIGINT comment '近6个月未来应还业务类型数(重资产/DCP/HUGELOAN/API_ASSET)_cash',
stg_pln_bsy_typ_cnt_12m_ftr_all BIGINT comment '近12个月未来应还业务类型数(重资产/DCP/HUGELOAN/API_ASSET)_cash',
stg_pln_cnt_ftr_all BIGINT comment '未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_3d_ftr_all BIGINT comment '近3天未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_7d_ftr_all BIGINT comment '近7天未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_1m_ftr_all BIGINT comment '近1个月未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_2m_ftr_all BIGINT comment '近2个月未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_3m_ftr_all BIGINT comment '近3个月未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_6m_ftr_all BIGINT comment '近6个月未来应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_12m_ftr_all BIGINT comment '近12个月未来应还分期计划数(包含提前已还订单)_all',
stg_pln_sum_prc_amt_ftr_all DECIMAL(28,6) comment '未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_3d_ftr_all DECIMAL(28,6) comment '近3天未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_7d_ftr_all DECIMAL(28,6) comment '近7天未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_1m_ftr_all DECIMAL(28,6) comment '近1个月未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_2m_ftr_all DECIMAL(28,6) comment '近2个月未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_3m_ftr_all DECIMAL(28,6) comment '近3个月未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_6m_ftr_all DECIMAL(28,6) comment '近6个月未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_12m_ftr_all DECIMAL(28,6) comment '近12个月未来应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_avg_prc_amt_ftr_all DECIMAL(22,10) comment '未来应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_1m_ftr_all DECIMAL(22,10) comment '近1个月未来应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_2m_ftr_all DECIMAL(22,10) comment '近2个月未来应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_3m_ftr_all DECIMAL(22,10) comment '近3个月未来应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_6m_ftr_all DECIMAL(22,10) comment '近6个月未来应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_12m_ftr_all DECIMAL(22,10) comment '近12个月未来应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_cnt_ftr_adv_all BIGINT comment '已提前还款的未来分期计划数_all',
stg_pln_cnt_1m_ftr_adv_all BIGINT comment '近1个月已提前还款的未来分期计划数_all',
stg_pln_cnt_2m_ftr_adv_all BIGINT comment '近2个月已提前还款的未来分期计划数_all',
stg_pln_cnt_3m_ftr_adv_all BIGINT comment '近3个月已提前还款的未来分期计划数_all',
stg_pln_cnt_6m_ftr_adv_all BIGINT comment '近6个月已提前还款的未来分期计划数_all',
stg_pln_cnt_12m_ftr_adv_all BIGINT comment '近12个月已提前还款的未来分期计划数_all',
stg_pln_sum_prc_amt_ftr_adv_all DECIMAL(28,6) comment '已提前还款的未来分期计划金额_sum_all',
stg_pln_sum_prc_amt_1m_ftr_adv_all DECIMAL(28,6) comment '近1个月已提前还款的未来分期计划金额_sum_all',
stg_pln_sum_prc_amt_2m_ftr_adv_all DECIMAL(28,6) comment '近2个月已提前还款的未来分期计划金额_sum_all',
stg_pln_sum_prc_amt_3m_ftr_adv_all DECIMAL(28,6) comment '近3个月已提前还款的未来分期计划金额_sum_all',
stg_pln_sum_prc_amt_6m_ftr_adv_all DECIMAL(28,6) comment '近6个月已提前还款的未来分期计划金额_sum_all',
stg_pln_sum_prc_amt_12m_ftr_adv_all DECIMAL(28,6) comment '近12个月已提前还款的未来分期计划金额_sum_all',
stg_pln_avg_prc_amt_ftr_adv_all DECIMAL(22,10) comment '已提前还款的未来应还分期计划金额_avg_all',
stg_pln_avg_prc_amt_1m_ftr_adv_all DECIMAL(22,10) comment '近1个月已提前还款的未来应还分期计划金额_avg_all',
stg_pln_avg_prc_amt_2m_ftr_adv_all DECIMAL(22,10) comment '近2个月已提前还款的未来应还分期计划金额_avg_all',
stg_pln_avg_prc_amt_3m_ftr_adv_all DECIMAL(22,10) comment '近3个月已提前还款的未来应还分期计划金额_avg_all',
stg_pln_avg_prc_amt_6m_ftr_adv_all DECIMAL(22,10) comment '近6个月已提前还款的未来应还分期计划金额_avg_all',
stg_pln_avg_prc_amt_12m_ftr_adv_all DECIMAL(22,10) comment '近12个月已提前还款的未来应还分期计划金额_avg_all',
stg_pln_cnt_ftr_rep_all BIGINT comment '未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_3d_ftr_rep_all BIGINT comment '近3天未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_7d_ftr_rep_all BIGINT comment '近7天未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_1m_ftr_rep_all BIGINT comment '近1个月未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_2m_ftr_rep_all BIGINT comment '近2个月未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_3m_ftr_rep_all BIGINT comment '近3个月未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_6m_ftr_rep_all BIGINT comment '近6个月未来应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_12m_ftr_rep_all BIGINT comment '近12个月未来应还分期计划数(包含历史未还订单)_all',
stg_pln_sum_prc_amt_ftr_rep_all DECIMAL(28,6) comment '未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_3d_ftr_rep_all DECIMAL(28,6) comment '近3天未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_7d_ftr_rep_all DECIMAL(28,6) comment '近7天未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_1m_ftr_rep_all DECIMAL(28,6) comment '近1个月未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_2m_ftr_rep_all DECIMAL(28,6) comment '近2个月未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_3m_ftr_rep_all DECIMAL(28,6) comment '近3个月未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_6m_ftr_rep_all DECIMAL(28,6) comment '近6个月未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_12m_ftr_rep_all DECIMAL(28,6) comment '近12个月未来应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_avg_prc_amt_ftr_rep_all DECIMAL(22,10) comment '未来应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_1m_ftr_rep_all DECIMAL(22,10) comment '近1个月未来应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_2m_ftr_rep_all DECIMAL(22,10) comment '近2个月未来应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_3m_ftr_rep_all DECIMAL(22,10) comment '近3个月未来应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_6m_ftr_rep_all DECIMAL(22,10) comment '近6个月未来应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_12m_ftr_rep_all DECIMAL(22,10) comment '近12个月未来应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_cnt_1m_3m_ftr_all BIGINT comment '未来1m-3m应还分期计划数(包含提前已还订单)_all',
stg_pln_sum_prc_amt_1m_3m_ftr_all DECIMAL(28,6) comment '未来1m-3m应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_avg_prc_amt_1m_3m_ftr_all DECIMAL(22,10) comment '未来1m-3m应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_cnt_3m_6m_ftr_all BIGINT comment '未来3m-6m应还分期计划数(包含提前已还订单)_all',
stg_pln_sum_prc_amt_3m_6m_ftr_all DECIMAL(28,6) comment '未来3m-6m应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_avg_prc_amt_3m_6m_ftr_all DECIMAL(22,10) comment '未来3m-6m应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_cnt_6m_12m_ftr_all BIGINT comment '未来6m-12m应还分期计划数(包含提前已还订单)_all',
stg_pln_sum_prc_amt_6m_12m_ftr_all DECIMAL(28,6) comment '未来6m-12m应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_avg_prc_amt_6m_12m_ftr_all DECIMAL(22,10) comment '未来6m-12m应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_cnt_1m_3m_ftr_rto_all DOUBLE comment '未来1m应还分期计划数/未来1m-3m应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_3m_6m_ftr_rto_all DOUBLE comment '未来3m应还分期计划数/未来3m-6m应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_6m_12m_ftr_rto_all DOUBLE comment '未来6m应还分期计划数/未来6m-12m应还分期计划数(包含提前已还订单)_all',
stg_pln_sum_prc_amt_1m_3m_ftr_rto_all DECIMAL(38,18) comment '未来1m应还分期计划金额_sum/未来1m-3m应还分期计划金额_sum(包含提前已还订单)_all',
stg_pln_sum_prc_amt_3m_6m_ftr_rto_all DECIMAL(38,18) comment '未来3m应还分期计划金额_sum/未来3m-6m应还分期计划金额_sum(包含提前已还订单)_all',
stg_pln_sum_prc_amt_6m_12m_ftr_rto_all DECIMAL(38,18) comment '未来6m应还分期计划金额_sum/未来6m-12m应还分期计划金额_sum(包含提前已还订单)_all',
stg_pln_avg_prc_amt_1m_3m_ftr_rto_all DECIMAL(38,18) comment '未来1m应还分期计划金额_avg/未来1m-3m应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_avg_prc_amt_3m_6m_ftr_rto_all DECIMAL(38,18) comment '未来3m应还分期计划金额_avg/未来3m-6m应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_avg_prc_amt_6m_12m_ftr_rto_all DECIMAL(38,18) comment '未来6m应还分期计划金额_avg/未来6m-12m应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_cnt_3d_ftr_his_rto_all DOUBLE comment '近3天未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_7d_ftr_his_rto_all DOUBLE comment '近7天未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_1m_ftr_his_rto_all DOUBLE comment '近1个月未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_2m_ftr_his_rto_all DOUBLE comment '近2个月未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_3m_ftr_his_rto_all DOUBLE comment '近3个月未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_6m_ftr_his_rto_all DOUBLE comment '近6个月未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_12m_ftr_his_rto_all DOUBLE comment '近12个月未来/历史应还分期计划数(包含提前已还订单)_all',
stg_pln_sum_prc_amt_3d_ftr_his_rto_all DECIMAL(38,18) comment '近3天未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_7d_ftr_his_rto_all DECIMAL(38,18) comment '近7天未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_1m_ftr_his_rto_all DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_2m_ftr_his_rto_all DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_3m_ftr_his_rto_all DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_6m_ftr_his_rto_all DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_sum_prc_amt_12m_ftr_his_rto_all DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含提前已还订单)_sum_all',
stg_pln_avg_prc_amt_1m_ftr_his_rto_all DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_2m_ftr_his_rto_all DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_3m_ftr_his_rto_all DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_6m_ftr_his_rto_all DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_avg_prc_amt_12m_ftr_his_rto_all DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含提前已还订单)_avg_all',
stg_pln_cnt_1m_ftr_his_12m_rto_all DOUBLE comment '近1个月未来/近12个月历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_2m_ftr_his_12m_rto_all DOUBLE comment '近2个月未来/近12个月历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_3m_ftr_his_12m_rto_all DOUBLE comment '近3个月未来/近12个月历史应还分期计划数(包含提前已还订单)_all',
stg_pln_cnt_6m_ftr_his_12m_rto_all DOUBLE comment '近6个月未来/近12个月历史应还分期计划数(包含提前已还订单)_all',
stg_pln_avg_prc_amt_1m_ftr_his_12m_rto_all DECIMAL(38,18) comment '近1个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_avg_prc_amt_2m_ftr_his_12m_rto_all DECIMAL(38,18) comment '近2个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_avg_prc_amt_3m_ftr_his_12m_rto_all DECIMAL(38,18) comment '近3个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_avg_prc_amt_6m_ftr_his_12m_rto_all DECIMAL(38,18) comment '近6个月未来/近12个月历史应还分期计划金额_avg(包含提前已还订单)_all',
stg_pln_cnt_1m_ftr_his_rep_rto_all DOUBLE comment '近1个月未来/历史应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_2m_ftr_his_rep_rto_all DOUBLE comment '近2个月未来/历史应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_3m_ftr_his_rep_rto_all DOUBLE comment '近3个月未来/历史应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_6m_ftr_his_rep_rto_all DOUBLE comment '近6个月未来/历史应还分期计划数(包含历史未还订单)_all',
stg_pln_cnt_12m_ftr_his_rep_rto_all DOUBLE comment '近12个月未来/历史应还分期计划数(包含历史未还订单)_all',
stg_pln_sum_prc_amt_1m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_2m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_3m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_6m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_sum_prc_amt_12m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含历史未还订单)_sum_all',
stg_pln_avg_prc_amt_1m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近1个月未来/历史应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_2m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近2个月未来/历史应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_3m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近3个月未来/历史应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_6m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近6个月未来/历史应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_avg_prc_amt_12m_ftr_his_rep_rto_all DECIMAL(38,18) comment '近12个月未来/历史应还分期计划金额(包含历史未还订单)_avg_all',
stg_pln_cnt_ftr_adv_rto_all DOUBLE comment '已提前还款的未来/历史分期计划数_all',
stg_pln_cnt_1m_ftr_adv_rto_all DOUBLE comment '近1个月已提前还款的未来/历史分期计划数_all',
stg_pln_cnt_2m_ftr_adv_rto_all DOUBLE comment '近2个月已提前还款的未来/历史分期计划数_all',
stg_pln_cnt_3m_ftr_adv_rto_all DOUBLE comment '近3个月已提前还款的未来/历史分期计划数_all',
stg_pln_cnt_6m_ftr_adv_rto_all DOUBLE comment '近6个月已提前还款的未来/历史分期计划数_all',
stg_pln_cnt_12m_ftr_adv_rto_all DOUBLE comment '近12个月已提前还款的未来/历史分期计划数_all',
stg_pln_sum_prc_amt_ftr_adv_rto_all DECIMAL(38,18) comment '已提前还款的未来/历史分期计划金额_sum_all',
stg_pln_sum_prc_amt_1m_ftr_adv_rto_all DECIMAL(38,18) comment '近1个月已提前还款的未来/历史分期计划金额_sum_all',
stg_pln_sum_prc_amt_2m_ftr_adv_rto_all DECIMAL(38,18) comment '近2个月已提前还款的未来/历史分期计划金额_sum_all',
stg_pln_sum_prc_amt_3m_ftr_adv_rto_all DECIMAL(38,18) comment '近3个月已提前还款的未来/历史分期计划金额_sum_all',
stg_pln_sum_prc_amt_6m_ftr_adv_rto_all DECIMAL(38,18) comment '近6个月已提前还款的未来/历史分期计划金额_sum_all',
stg_pln_sum_prc_amt_12m_ftr_adv_rto_all DECIMAL(38,18) comment '近12个月已提前还款的未来/历史分期计划金额_sum_all'
)comment '贷中宽表_未来还款压力趋势'
partitioned by (ds string)
;


drop table if exists dwa_risk.dwa_risk_f_dz_model_final_14ftr_rep_pressure_trend_df_data_base_tmp;
create table dwa_risk.dwa_risk_f_dz_model_final_14ftr_rep_pressure_trend_df_data_base_tmp as
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


set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1 as 
select  
         main2.uid
        ,main2.mdl_dte
        ,main2.dtl_ord_no
        ,bsy_typ
        ,main2.dtl_stg_pln_no
        ,ord_crt_tim
        ,ord_crt_dte
        ,main2.dtl_rep_dte
        ,main2.rep_tim
        ,main2.prc_amt
        ,main2.stg_stt
        ,main2.stg_no

        --应还日和实还日之间的间隔（天）
        ,main2.ddf_rep_tim_dte --应还日和实还日的间隔--for逾期使用
        --实还日和评分日的间隔
        ,main2.ddf_mdl_rep_tim
        --应还日和评分日的间隔
        ,main2.ddf_mdl_rep_dte 
        -- 订单创建和评分日的间隔
        ,ddf_mdl_ord_crt_dte 

        -- 数据模块flag，对宽表模块对应的数据各自打标
        --/*12、历史还款信息*/12.1.1 历史应还分期计划或历史已还分期计划
        ,case when ddf_mdl_rep_dte>0 or ddf_mdl_rep_tim>0 then 1 else 0 end as is_his_rep_rpm_stg_pln
        --/*12、历史还款信息*/12.1.3 历史应还分期计划
        ,case when ddf_mdl_rep_dte>0 then 1 else 0 end as is_his_rep_stg_pln
        --/*14、未来压力信息*/14.1.1 评分日当天和之后未到期分期计划 
        ,case when ddf_mdl_rep_dte<=0 then 1 else 0 end as is_ftr_rep_stg_pln
        --/*14、未来压力信息*/14.2.1 截止到评分日之前已到期未还分期计划
        ,case when ddf_mdl_rep_dte>0 and ddf_mdl_rep_tim is null then 1 else 0 end as is_ovd_future_repay_stg_pln

        --还款状态--flag
        --是否提前还款flag
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then 1 else 0 end adv_rep_flg
        --历史是否逾期flag
        ,case when ddf_rep_tim_dte>0 then 1 else 0 end as ovd_rep_flg
        --是否还款日当天按时还款
        ,case when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then 1 else 0 end as d0_rep_flg

        --历史应还日和评分日的间隔（月）时间切片flag
        ,case when ddf_mdl_rep_dte between 1 and 3 then 1 else 0 end as his_rep_stg_pln_3d_flg
        ,case when ddf_mdl_rep_dte between 1 and 7 then 1 else 0 end as his_rep_stg_pln_7d_flg
        ,case when ddf_mdl_rep_dte between 1 and 31 then 1 else 0 end as his_rep_stg_pln_1m_flg
        ,case when ddf_mdl_rep_dte between 1 and 62 then 1 else 0 end as his_rep_stg_pln_2m_flg
        ,case when ddf_mdl_rep_dte between 1 and 92 then 1 else 0 end as his_rep_stg_pln_3m_flg
        ,case when ddf_mdl_rep_dte between 1 and 183 then 1 else 0 end as his_rep_stg_pln_6m_flg
        ,case when ddf_mdl_rep_dte between 1 and 366 then 1 else 0 end as his_rep_stg_pln_12m_flg

        --未来应还日和评分日的间隔（月）时间切片flag
        ,case when ddf_mdl_rep_dte between -3 and 0 then 1 else 0 end as ftr_rep_stg_pln_3d_flg
        ,case when ddf_mdl_rep_dte between -7 and 0 then 1 else 0 end as ftr_rep_stg_pln_7d_flg
        ,case when ddf_mdl_rep_dte between -31 and 0 then 1 else 0 end as ftr_rep_stg_pln_1m_flg
        ,case when ddf_mdl_rep_dte between -62 and 0 then 1 else 0 end as ftr_rep_stg_pln_2m_flg
        ,case when ddf_mdl_rep_dte between -92 and 0 then 1 else 0 end as ftr_rep_stg_pln_3m_flg
        ,case when ddf_mdl_rep_dte between -183 and 0 then 1 else 0 end as ftr_rep_stg_pln_6m_flg
        ,case when ddf_mdl_rep_dte between -366 and 0 then 1 else 0 end as ftr_rep_stg_pln_12m_flg
        
        --应还日和实还日的间隔（月）时间切片的flag--for计算逾期使用
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 1 and 3 then 1 else 0 end as ovd_1d_3d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>3 then 1 else 0 end as ovd_3d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>7 then 1 else 0 end as ovd_7d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>14 then 1 else 0 end as ovd_14d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>30 then 1 else 0 end as ovd_m2_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>60 then 1 else 0 end as ovd_m3_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>90 then 1 else 0 end as ovd_m4_pls_flg

        --应还日和实还日的间隔（月）时间切片的flag--for计算提前还款使用
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -3 and -1 then 1 else 0 end as adv_3d_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -7 and -1 then 1 else 0 end as adv_7d_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -14 and -1 then 1 else 0 end as adv_14d_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -31 and -1 then 1 else 0 end as adv_1m_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -62 and -1 then 1 else 0 end as adv_2m_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -92 and -1 then 1 else 0 end as adv_3m_flg
        
        --实还日和评分日的间隔（月）时间切片flag--for还清口径
        ,case when ddf_mdl_rep_tim>0 then 1 else 0 end as rep_flg
        ,case when ddf_mdl_rep_tim between 1 and 7 then 1 else 0 end as rep_7d_flg
        ,case when ddf_mdl_rep_tim between 1 and 14 then 1 else 0 end as rep_14d_flg
        ,case when ddf_mdl_rep_tim between 1 and 31 then 1 else 0 end as rep_1m_flg
        ,case when ddf_mdl_rep_tim between 1 and 92 then 1 else 0 end as rep_3m_flg
        ,case when ddf_mdl_rep_tim between 1 and 183 then 1 else 0 end as rep_6m_flg
        ,case when ddf_mdl_rep_tim between 1 and 366 then 1 else 0 end as rep_12m_flg

        --单日还请金额
        ,sum(case when ddf_mdl_rep_tim>0 then prc_amt else 0 end) over(partition by main2.uid,rep_tim) as prc_amt_pday
        --还清日-单月flag
        ,case when ddf_mdl_rep_tim between 1 and 31 then 1
             when ddf_mdl_rep_tim between 1 and 62 then 2
             when ddf_mdl_rep_tim between 1 and 92 then 3 end as per_rep_mth_flg

        -- ,order_info_tmp.fst_ord_flg --首借订单
        -- ,order_info_tmp.cur_ord_flg --当前订单

        -- 产品类型
        ,case when bsy_typ in  ('CASH','BALANCE_TRANSFER') then 'ZZC' else bsy_typ end as bsy_typ_flg
from
(
        select 
                 main1.uid
                ,main1.mdl_dte
                ,main1.dtl_ord_no
                ,bsy_typ
                ,main1.dtl_stg_pln_no
                ,main1.dtl_rep_dte
                ,main1.rep_tim
                ,main1.prc_amt
                ,main1.stg_stt
                ,main1.stg_no
                ,ord_crt_tim
                ,ord_crt_dte

                --应还日和实还日之间的间隔（天）
                ,case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte)
                        else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte --应还日和实还日的间隔--for逾期使用
                --实还日和评分日的间隔
                ,datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim
                --应还日和评分日的间隔
                ,datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte 
                -- 订单创建和评分日的间隔
                ,datediff(mdl_dte,ord_crt_dte) as ddf_mdl_ord_crt_dte 
                -- ,ds
        from
        (
                select 
                        model_data.uid
                        ,model_data.mdl_dte
                        -- ,model_data.ds
                        ,plan.dtl_ord_no
                        ,bsy_typ
                        ,plan.dtl_stg_pln_no
                        ,plan.dtl_rep_dte
                        ,case when date(plan.rep_tim)>=model_data.mdl_dte then null else date(plan.rep_tim) end as rep_tim
                        ,plan.prc_amt
                        ,plan.stg_stt
                        ,plan.stg_no
                        ,ord_crt_tim
                        ,ord_crt_dte
                from    (select uid
                                ,mdl_dte
                        from dwa_risk.dwa_risk_f_dz_model_final_14ftr_rep_pressure_trend_df_data_base_tmp
                        ) model_data

                        left join
                        (select uid
                                ,ord_no as dtl_ord_no
                                ,bsy_typ
                                ,stg_pln_no as dtl_stg_pln_no
                                ,rep_dte as dtl_rep_dte
                                ,rep_tim
                                ,prc_amt
                                ,stg_stt
                                ,stg_no
                                ,ctr_tim as ord_crt_tim
                                ,to_date(ctr_tim) as ord_crt_dte
                        from 
                        (
                            select  a.uid
                                    ,a.order_no as ord_no
                                    ,a.stage_plan_no stg_pln_no
                                    ,a.original_biz_type bsy_typ
                                    ,a.original_stage_plan_status stg_stt --放款成功取<>'R'
                                    ,coalesce(b.init_total_stage,b.apply_total_stage) as total_stage
                                    ,a.stage_no as stg_no
                                    ,a.schedule_pay_principal prc_amt
                                    ,a.due_date rep_dte
                                    ,a.settlement_time rep_tim 
                                    ,a.current_overdue_status ovd_stt
                                    ,a.original_repay_type ded_typ
                                    ,a.create_time as ctr_tim
                                    ,a.original_loan_principal as raw_prc_amt
                            from ${cdmx}.cdmx_fct_heavy_stage_plan_df a
                            left join ${dwt}.dwt_heavy_order_df b on a.order_no = b.order_no and b.ds=${bizdate}
                            where a.ds = '${bizdate}'
                            and a.original_biz_type in  ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN','API_ASSET')
                            and a.original_stage_plan_status <>'R'
                        ) as a
                        )plan on model_data.uid=plan.uid
        )main1
)main2
left join
(
        select uid
                ,crt_tim
                ,ord_no as dtl_ord_no
        from 
        (
            select  uid
                    ,order_no as ord_no
                    ,case when loan_success_flag = 1 then 'success'
                          when apply_status in ('LEND_FAIL', 'LOAN_DENIED')  then 'fail'
                          when order_status ='R'  then 'fail'
                     else 'else' 
                     end ord_stt_flg
                     ,crt_time as crt_tim
            from ${dwt}.dwt_heavy_order_df 
            where ds = '${bizdate}'
        ) as a
        where ord_stt_flg='success'
)order_info_tmp on main2.uid=order_info_tmp.uid and main2.dtl_ord_no=order_info_tmp.dtl_ord_no
where to_date(order_info_tmp.crt_tim)<=date_add(main2.mdl_dte,-1)
;

-----------------------------------------------------------
--------/*统计重资产（'CASH','BALANCE_TRANSFER'）*/
-----------------------------------------------------------

set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp2 as
select uid
       ,mdl_dte

       ----------------/*未来计划还款（包含提前已还订单）*/------------------
        -- /*未来应还分期数*/
        ,count(case when is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_cash
        ,count(case when ftr_rep_stg_pln_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_ftr_cash
        ,count(case when ftr_rep_stg_pln_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_ftr_cash
        ,count(case when ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_cash
        ,count(case when ftr_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_ftr_cash
        ,count(case when ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_cash
        ,count(case when ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_cash
        ,count(case when ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_cash
        
        -- /*未来应还金额*/
        ,sum(case when is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_cash
        ,sum(case when ftr_rep_stg_pln_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_ftr_cash
        ,sum(case when ftr_rep_stg_pln_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_ftr_cash
        ,sum(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_cash
        ,sum(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr_cash
        ,sum(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_cash
        ,sum(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_cash
        ,sum(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_cash
        
        -- /*未来单笔应还金额*/
        ,avg(case when is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_avg_prc_amt_ftr_cash
        ,avg(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_ftr_cash
        ,avg(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_2m_ftr_cash
        ,avg(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_ftr_cash
        ,avg(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_ftr_cash
        ,avg(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_12m_ftr_cash

        ,min(case when is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_min_prc_amt_ftr_cash
        ,min(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_1m_ftr_cash
        ,min(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_2m_ftr_cash
        ,min(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_3m_ftr_cash
        ,min(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_6m_ftr_cash
        ,min(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_12m_ftr_cash

        ,max(case when is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_max_prc_amt_ftr_cash
        ,max(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_1m_ftr_cash
        ,max(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_2m_ftr_cash
        ,max(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_3m_ftr_cash
        ,max(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_6m_ftr_cash
        ,max(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_12m_ftr_cash

        -- ----------------/*未来提前已还订单*/------------------
        -- /*未来应还分期数*/
        ,count(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_adv_cash
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_adv_cash
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_ftr_adv_cash
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_adv_cash
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_adv_cash
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_adv_cash
        
        -- /*未来应还金额*/
        ,sum(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_adv_cash
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_adv_cash
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr_adv_cash
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_adv_cash
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_adv_cash
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_adv_cash
        
        -- /*未来单笔应还金额*/
        ,avg(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_avg_prc_amt_ftr_adv_cash
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_ftr_adv_cash
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_2m_ftr_adv_cash
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_ftr_adv_cash
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_ftr_adv_cash
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_12m_ftr_adv_cash

        ,min(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_min_prc_amt_ftr_adv_cash
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_1m_ftr_adv_cash
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_2m_ftr_adv_cash
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_3m_ftr_adv_cash
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_6m_ftr_adv_cash
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_12m_ftr_adv_cash

        ,max(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_max_prc_amt_ftr_adv_cash
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_1m_ftr_adv_cash
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_2m_ftr_adv_cash
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_3m_ftr_adv_cash
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_6m_ftr_adv_cash
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_12m_ftr_adv_cash  

        --------------/*未来应还未还订单（包含历史未还订单）*/------------------
        -- /*未来应还分期数*/
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3d_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_7d_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_rep_cash
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_rep_cash
        
        -- /*未来应还金额*/
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3d_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_7d_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_rep_cash
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_rep_cash
        
        -- /*未来单笔应还金额*/
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then prc_amt else null end) as stg_pln_avg_prc_amt_ftr_rep_cash
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_1m_ftr_rep_cash
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_2m_ftr_rep_cash
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_3m_ftr_rep_cash
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_6m_ftr_rep_cash
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_12m_ftr_rep_cash

        ,min(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then prc_amt else null end) as stg_pln_min_prc_amt_ftr_rep_cash
        ,min(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then prc_amt else null end) as stg_pln_min_prc_amt_1m_ftr_rep_cash
        ,min(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then prc_amt else null end) as stg_pln_min_prc_amt_2m_ftr_rep_cash
        ,min(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then prc_amt else null end) as stg_pln_min_prc_amt_3m_ftr_rep_cash
        ,min(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then prc_amt else null end) as stg_pln_min_prc_amt_6m_ftr_rep_cash
        ,min(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then prc_amt else null end) as stg_pln_min_prc_amt_12m_ftr_rep_cash

        ,max(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then prc_amt else null end) as stg_pln_max_prc_amt_ftr_rep_cash
        ,max(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then prc_amt else null end) as stg_pln_max_prc_amt_1m_ftr_rep_cash
        ,max(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then prc_amt else null end) as stg_pln_max_prc_amt_2m_ftr_rep_cash
        ,max(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then prc_amt else null end) as stg_pln_max_prc_amt_3m_ftr_rep_cash
        ,max(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then prc_amt else null end) as stg_pln_max_prc_amt_6m_ftr_rep_cash
        ,max(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then prc_amt else null end) as stg_pln_max_prc_amt_12m_ftr_rep_cash

        ----------------/*未来阶段计划还款（包含提前已还订单）*/------------------
       -- /*未来1m-3m*/
       ,count(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_3m_ftr_cash
       ,sum(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_3m_ftr_cash
       ,avg(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_3m_ftr_cash
       ,min(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_1m_3m_ftr_cash
       ,max(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_1m_3m_ftr_cash
       -- /*未来3m-6m*/
       ,count(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_6m_ftr_cash
       ,sum(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_6m_ftr_cash
       ,avg(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_6m_ftr_cash
       ,min(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_3m_6m_ftr_cash
       ,max(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_3m_6m_ftr_cash
       -- /*未来6m-12m*/
       ,count(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_12m_ftr_cash
       ,sum(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_12m_ftr_cash
       ,avg(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_12m_ftr_cash
       ,min(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_6m_12m_ftr_cash
       ,max(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_6m_12m_ftr_cash

      
from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1
where bsy_typ in ('CASH','BALANCE_TRANSFER')
group by uid
        ,mdl_dte
;



set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp2 as
select uid
       ,mdl_dte

        ----------------/*历史计划还款（包含逾期未还订单）*/------------------
        -- /*历史应还分期数*/
        ,count(case when is_his_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_his_cash
        ,count(case when his_rep_stg_pln_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_his_cash
        ,count(case when his_rep_stg_pln_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_his_cash
        ,count(case when his_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_his_cash
        ,count(case when his_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_his_cash
        ,count(case when his_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_his_cash
        ,count(case when his_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_his_cash
        ,count(case when his_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_his_cash
        
        -- /*历史应还金额*/
        ,sum(case when is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_cash
        ,sum(case when his_rep_stg_pln_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_his_cash
        ,sum(case when his_rep_stg_pln_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_his_cash
        ,sum(case when his_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_his_cash
        ,sum(case when his_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_his_cash
        ,sum(case when his_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_his_cash
        ,sum(case when his_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_his_cash
        ,sum(case when his_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_his_cash
        
        -- /*历史单笔应还金额*/
        ,avg(case when is_his_rep_stg_pln=1 then prc_amt else null end) as stg_pln_avg_prc_amt_his_cash
        ,avg(case when his_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_his_cash
        ,avg(case when his_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_2m_his_cash
        ,avg(case when his_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_his_cash
        ,avg(case when his_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_his_cash
        ,avg(case when his_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_12m_his_cash

        ,min(case when is_his_rep_stg_pln=1 then prc_amt else null end) as stg_pln_min_prc_amt_his_cash
        ,min(case when his_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_1m_his_cash
        ,min(case when his_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_2m_his_cash
        ,min(case when his_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_3m_his_cash
        ,min(case when his_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_6m_his_cash
        ,min(case when his_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_min_prc_amt_12m_his_cash

        ,max(case when is_his_rep_stg_pln=1 then prc_amt else null end) as stg_pln_max_prc_amt_his_cash
        ,max(case when his_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_1m_his_cash
        ,max(case when his_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_2m_his_cash
        ,max(case when his_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_3m_his_cash
        ,max(case when his_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_6m_his_cash
        ,max(case when his_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_max_prc_amt_12m_his_cash

        -- ----------------/*历史应还已还订单*/------------------
        -- /*历史应还分期数*/
        ,count(case when is_his_rep_stg_pln=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_his_rep_cash
        ,count(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_his_rep_cash
        ,count(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_his_rep_cash
        ,count(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_his_rep_cash
        ,count(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_his_rep_cash
        ,count(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_his_rep_cash
        
        -- /*历史应还金额*/
        ,sum(case when is_his_rep_stg_pln=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_rep_cash
        ,sum(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_his_rep_cash
        ,sum(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_his_rep_cash
        ,sum(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_his_rep_cash
        ,sum(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_his_rep_cash
        ,sum(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_his_rep_cash
        
        -- /*历史单笔应还金额*/
        ,avg(case when is_his_rep_stg_pln=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_his_rep_cash
        ,avg(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_1m_his_rep_cash
        ,avg(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_2m_his_rep_cash
        ,avg(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_3m_his_rep_cash
        ,avg(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_6m_his_rep_cash
        ,avg(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_12m_his_rep_cash

        ,min(case when is_his_rep_stg_pln=1 and rep_tim is not null then prc_amt else null end) as stg_pln_min_prc_amt_his_rep_cash
        ,min(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_min_prc_amt_1m_his_rep_cash
        ,min(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_min_prc_amt_2m_his_rep_cash
        ,min(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_min_prc_amt_3m_his_rep_cash
        ,min(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_min_prc_amt_6m_his_rep_cash
        ,min(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_min_prc_amt_12m_his_rep_cash

        ,max(case when is_his_rep_stg_pln=1 and rep_tim is not null then prc_amt else null end) as stg_pln_max_prc_amt_his_rep_cash
        ,max(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_max_prc_amt_1m_his_rep_cash
        ,max(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_max_prc_amt_2m_his_rep_cash
        ,max(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_max_prc_amt_3m_his_rep_cash
        ,max(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_max_prc_amt_6m_his_rep_cash
        ,max(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_max_prc_amt_12m_his_rep_cash  

 

from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1
where bsy_typ in ('CASH','BALANCE_TRANSFER')
group by uid
        ,mdl_dte
;


set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp2 as
select t1.uid
       ,t1.mdl_dte
       ----------------/*基础变量*/------------------
        ,coalesce(stg_pln_cnt_ftr_cash,0) as stg_pln_cnt_ftr_cash
        ,coalesce(stg_pln_cnt_3d_ftr_cash,0) as stg_pln_cnt_3d_ftr_cash
        ,coalesce(stg_pln_cnt_7d_ftr_cash,0) as stg_pln_cnt_7d_ftr_cash
        ,coalesce(stg_pln_cnt_1m_ftr_cash,0) as stg_pln_cnt_1m_ftr_cash
        ,coalesce(stg_pln_cnt_2m_ftr_cash,0) as stg_pln_cnt_2m_ftr_cash
        ,coalesce(stg_pln_cnt_3m_ftr_cash,0) as stg_pln_cnt_3m_ftr_cash
        ,coalesce(stg_pln_cnt_6m_ftr_cash,0) as stg_pln_cnt_6m_ftr_cash
        ,coalesce(stg_pln_cnt_12m_ftr_cash,0) as stg_pln_cnt_12m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_ftr_cash,0) as stg_pln_sum_prc_amt_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_3d_ftr_cash,0) as stg_pln_sum_prc_amt_3d_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_7d_ftr_cash,0) as stg_pln_sum_prc_amt_7d_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_1m_ftr_cash,0) as stg_pln_sum_prc_amt_1m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_2m_ftr_cash,0) as stg_pln_sum_prc_amt_2m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_3m_ftr_cash,0) as stg_pln_sum_prc_amt_3m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_6m_ftr_cash,0) as stg_pln_sum_prc_amt_6m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_12m_ftr_cash,0) as stg_pln_sum_prc_amt_12m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_ftr_cash,0) as stg_pln_avg_prc_amt_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_1m_ftr_cash,0) as stg_pln_avg_prc_amt_1m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_2m_ftr_cash,0) as stg_pln_avg_prc_amt_2m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_3m_ftr_cash,0) as stg_pln_avg_prc_amt_3m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_6m_ftr_cash,0) as stg_pln_avg_prc_amt_6m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_12m_ftr_cash,0) as stg_pln_avg_prc_amt_12m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_ftr_cash,0) as stg_pln_min_prc_amt_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_1m_ftr_cash,0) as stg_pln_min_prc_amt_1m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_2m_ftr_cash,0) as stg_pln_min_prc_amt_2m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_3m_ftr_cash,0) as stg_pln_min_prc_amt_3m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_6m_ftr_cash,0) as stg_pln_min_prc_amt_6m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_12m_ftr_cash,0) as stg_pln_min_prc_amt_12m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_ftr_cash,0) as stg_pln_max_prc_amt_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_1m_ftr_cash,0) as stg_pln_max_prc_amt_1m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_2m_ftr_cash,0) as stg_pln_max_prc_amt_2m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_3m_ftr_cash,0) as stg_pln_max_prc_amt_3m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_6m_ftr_cash,0) as stg_pln_max_prc_amt_6m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_12m_ftr_cash,0) as stg_pln_max_prc_amt_12m_ftr_cash
        ,coalesce(stg_pln_cnt_ftr_adv_cash,0) as stg_pln_cnt_ftr_adv_cash
        ,coalesce(stg_pln_cnt_1m_ftr_adv_cash,0) as stg_pln_cnt_1m_ftr_adv_cash
        ,coalesce(stg_pln_cnt_2m_ftr_adv_cash,0) as stg_pln_cnt_2m_ftr_adv_cash
        ,coalesce(stg_pln_cnt_3m_ftr_adv_cash,0) as stg_pln_cnt_3m_ftr_adv_cash
        ,coalesce(stg_pln_cnt_6m_ftr_adv_cash,0) as stg_pln_cnt_6m_ftr_adv_cash
        ,coalesce(stg_pln_cnt_12m_ftr_adv_cash,0) as stg_pln_cnt_12m_ftr_adv_cash
        ,coalesce(stg_pln_sum_prc_amt_ftr_adv_cash,0) as stg_pln_sum_prc_amt_ftr_adv_cash
        ,coalesce(stg_pln_sum_prc_amt_1m_ftr_adv_cash,0) as stg_pln_sum_prc_amt_1m_ftr_adv_cash
        ,coalesce(stg_pln_sum_prc_amt_2m_ftr_adv_cash,0) as stg_pln_sum_prc_amt_2m_ftr_adv_cash
        ,coalesce(stg_pln_sum_prc_amt_3m_ftr_adv_cash,0) as stg_pln_sum_prc_amt_3m_ftr_adv_cash
        ,coalesce(stg_pln_sum_prc_amt_6m_ftr_adv_cash,0) as stg_pln_sum_prc_amt_6m_ftr_adv_cash
        ,coalesce(stg_pln_sum_prc_amt_12m_ftr_adv_cash,0) as stg_pln_sum_prc_amt_12m_ftr_adv_cash
        ,coalesce(stg_pln_avg_prc_amt_ftr_adv_cash,0) as stg_pln_avg_prc_amt_ftr_adv_cash
        ,coalesce(stg_pln_avg_prc_amt_1m_ftr_adv_cash,0) as stg_pln_avg_prc_amt_1m_ftr_adv_cash
        ,coalesce(stg_pln_avg_prc_amt_2m_ftr_adv_cash,0) as stg_pln_avg_prc_amt_2m_ftr_adv_cash
        ,coalesce(stg_pln_avg_prc_amt_3m_ftr_adv_cash,0) as stg_pln_avg_prc_amt_3m_ftr_adv_cash
        ,coalesce(stg_pln_avg_prc_amt_6m_ftr_adv_cash,0) as stg_pln_avg_prc_amt_6m_ftr_adv_cash
        ,coalesce(stg_pln_avg_prc_amt_12m_ftr_adv_cash,0) as stg_pln_avg_prc_amt_12m_ftr_adv_cash
        ,coalesce(stg_pln_min_prc_amt_ftr_adv_cash,0) as stg_pln_min_prc_amt_ftr_adv_cash
        ,coalesce(stg_pln_min_prc_amt_1m_ftr_adv_cash,0) as stg_pln_min_prc_amt_1m_ftr_adv_cash
        ,coalesce(stg_pln_min_prc_amt_2m_ftr_adv_cash,0) as stg_pln_min_prc_amt_2m_ftr_adv_cash
        ,coalesce(stg_pln_min_prc_amt_3m_ftr_adv_cash,0) as stg_pln_min_prc_amt_3m_ftr_adv_cash
        ,coalesce(stg_pln_min_prc_amt_6m_ftr_adv_cash,0) as stg_pln_min_prc_amt_6m_ftr_adv_cash
        ,coalesce(stg_pln_min_prc_amt_12m_ftr_adv_cash,0) as stg_pln_min_prc_amt_12m_ftr_adv_cash
        ,coalesce(stg_pln_max_prc_amt_ftr_adv_cash,0) as stg_pln_max_prc_amt_ftr_adv_cash
        ,coalesce(stg_pln_max_prc_amt_1m_ftr_adv_cash,0) as stg_pln_max_prc_amt_1m_ftr_adv_cash
        ,coalesce(stg_pln_max_prc_amt_2m_ftr_adv_cash,0) as stg_pln_max_prc_amt_2m_ftr_adv_cash
        ,coalesce(stg_pln_max_prc_amt_3m_ftr_adv_cash,0) as stg_pln_max_prc_amt_3m_ftr_adv_cash
        ,coalesce(stg_pln_max_prc_amt_6m_ftr_adv_cash,0) as stg_pln_max_prc_amt_6m_ftr_adv_cash
        ,coalesce(stg_pln_max_prc_amt_12m_ftr_adv_cash,0) as stg_pln_max_prc_amt_12m_ftr_adv_cash
        ,coalesce(stg_pln_cnt_ftr_rep_cash,0) as stg_pln_cnt_ftr_rep_cash
        ,coalesce(stg_pln_cnt_3d_ftr_rep_cash,0) as stg_pln_cnt_3d_ftr_rep_cash
        ,coalesce(stg_pln_cnt_7d_ftr_rep_cash,0) as stg_pln_cnt_7d_ftr_rep_cash
        ,coalesce(stg_pln_cnt_1m_ftr_rep_cash,0) as stg_pln_cnt_1m_ftr_rep_cash
        ,coalesce(stg_pln_cnt_2m_ftr_rep_cash,0) as stg_pln_cnt_2m_ftr_rep_cash
        ,coalesce(stg_pln_cnt_3m_ftr_rep_cash,0) as stg_pln_cnt_3m_ftr_rep_cash
        ,coalesce(stg_pln_cnt_6m_ftr_rep_cash,0) as stg_pln_cnt_6m_ftr_rep_cash
        ,coalesce(stg_pln_cnt_12m_ftr_rep_cash,0) as stg_pln_cnt_12m_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_ftr_rep_cash,0) as stg_pln_sum_prc_amt_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_3d_ftr_rep_cash,0) as stg_pln_sum_prc_amt_3d_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_7d_ftr_rep_cash,0) as stg_pln_sum_prc_amt_7d_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_1m_ftr_rep_cash,0) as stg_pln_sum_prc_amt_1m_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_2m_ftr_rep_cash,0) as stg_pln_sum_prc_amt_2m_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_3m_ftr_rep_cash,0) as stg_pln_sum_prc_amt_3m_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_6m_ftr_rep_cash,0) as stg_pln_sum_prc_amt_6m_ftr_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_12m_ftr_rep_cash,0) as stg_pln_sum_prc_amt_12m_ftr_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_ftr_rep_cash,0) as stg_pln_avg_prc_amt_ftr_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_1m_ftr_rep_cash,0) as stg_pln_avg_prc_amt_1m_ftr_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_2m_ftr_rep_cash,0) as stg_pln_avg_prc_amt_2m_ftr_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_3m_ftr_rep_cash,0) as stg_pln_avg_prc_amt_3m_ftr_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_6m_ftr_rep_cash,0) as stg_pln_avg_prc_amt_6m_ftr_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_12m_ftr_rep_cash,0) as stg_pln_avg_prc_amt_12m_ftr_rep_cash
        ,coalesce(stg_pln_min_prc_amt_ftr_rep_cash,0) as stg_pln_min_prc_amt_ftr_rep_cash
        ,coalesce(stg_pln_min_prc_amt_1m_ftr_rep_cash,0) as stg_pln_min_prc_amt_1m_ftr_rep_cash
        ,coalesce(stg_pln_min_prc_amt_2m_ftr_rep_cash,0) as stg_pln_min_prc_amt_2m_ftr_rep_cash
        ,coalesce(stg_pln_min_prc_amt_3m_ftr_rep_cash,0) as stg_pln_min_prc_amt_3m_ftr_rep_cash
        ,coalesce(stg_pln_min_prc_amt_6m_ftr_rep_cash,0) as stg_pln_min_prc_amt_6m_ftr_rep_cash
        ,coalesce(stg_pln_min_prc_amt_12m_ftr_rep_cash,0) as stg_pln_min_prc_amt_12m_ftr_rep_cash
        ,coalesce(stg_pln_max_prc_amt_ftr_rep_cash,0) as stg_pln_max_prc_amt_ftr_rep_cash
        ,coalesce(stg_pln_max_prc_amt_1m_ftr_rep_cash,0) as stg_pln_max_prc_amt_1m_ftr_rep_cash
        ,coalesce(stg_pln_max_prc_amt_2m_ftr_rep_cash,0) as stg_pln_max_prc_amt_2m_ftr_rep_cash
        ,coalesce(stg_pln_max_prc_amt_3m_ftr_rep_cash,0) as stg_pln_max_prc_amt_3m_ftr_rep_cash
        ,coalesce(stg_pln_max_prc_amt_6m_ftr_rep_cash,0) as stg_pln_max_prc_amt_6m_ftr_rep_cash
        ,coalesce(stg_pln_max_prc_amt_12m_ftr_rep_cash,0) as stg_pln_max_prc_amt_12m_ftr_rep_cash
        ,coalesce(stg_pln_cnt_1m_3m_ftr_cash,0) as stg_pln_cnt_1m_3m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_1m_3m_ftr_cash,0) as stg_pln_sum_prc_amt_1m_3m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_1m_3m_ftr_cash,0) as stg_pln_avg_prc_amt_1m_3m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_1m_3m_ftr_cash,0) as stg_pln_min_prc_amt_1m_3m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_1m_3m_ftr_cash,0) as stg_pln_max_prc_amt_1m_3m_ftr_cash
        ,coalesce(stg_pln_cnt_3m_6m_ftr_cash,0) as stg_pln_cnt_3m_6m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_3m_6m_ftr_cash,0) as stg_pln_sum_prc_amt_3m_6m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_3m_6m_ftr_cash,0) as stg_pln_avg_prc_amt_3m_6m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_3m_6m_ftr_cash,0) as stg_pln_min_prc_amt_3m_6m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_3m_6m_ftr_cash,0) as stg_pln_max_prc_amt_3m_6m_ftr_cash
        ,coalesce(stg_pln_cnt_6m_12m_ftr_cash,0) as stg_pln_cnt_6m_12m_ftr_cash
        ,coalesce(stg_pln_sum_prc_amt_6m_12m_ftr_cash,0) as stg_pln_sum_prc_amt_6m_12m_ftr_cash
        ,coalesce(stg_pln_avg_prc_amt_6m_12m_ftr_cash,0) as stg_pln_avg_prc_amt_6m_12m_ftr_cash
        ,coalesce(stg_pln_min_prc_amt_6m_12m_ftr_cash,0) as stg_pln_min_prc_amt_6m_12m_ftr_cash
        ,coalesce(stg_pln_max_prc_amt_6m_12m_ftr_cash,0) as stg_pln_max_prc_amt_6m_12m_ftr_cash
        ,coalesce(stg_pln_cnt_his_cash,0) as stg_pln_cnt_his_cash
        ,coalesce(stg_pln_cnt_3d_his_cash,0) as stg_pln_cnt_3d_his_cash
        ,coalesce(stg_pln_cnt_7d_his_cash,0) as stg_pln_cnt_7d_his_cash
        ,coalesce(stg_pln_cnt_1m_his_cash,0) as stg_pln_cnt_1m_his_cash
        ,coalesce(stg_pln_cnt_2m_his_cash,0) as stg_pln_cnt_2m_his_cash
        ,coalesce(stg_pln_cnt_3m_his_cash,0) as stg_pln_cnt_3m_his_cash
        ,coalesce(stg_pln_cnt_6m_his_cash,0) as stg_pln_cnt_6m_his_cash
        ,coalesce(stg_pln_cnt_12m_his_cash,0) as stg_pln_cnt_12m_his_cash
        ,coalesce(stg_pln_sum_prc_amt_his_cash,0) as stg_pln_sum_prc_amt_his_cash
        ,coalesce(stg_pln_sum_prc_amt_3d_his_cash,0) as stg_pln_sum_prc_amt_3d_his_cash
        ,coalesce(stg_pln_sum_prc_amt_7d_his_cash,0) as stg_pln_sum_prc_amt_7d_his_cash
        ,coalesce(stg_pln_sum_prc_amt_1m_his_cash,0) as stg_pln_sum_prc_amt_1m_his_cash
        ,coalesce(stg_pln_sum_prc_amt_2m_his_cash,0) as stg_pln_sum_prc_amt_2m_his_cash
        ,coalesce(stg_pln_sum_prc_amt_3m_his_cash,0) as stg_pln_sum_prc_amt_3m_his_cash
        ,coalesce(stg_pln_sum_prc_amt_6m_his_cash,0) as stg_pln_sum_prc_amt_6m_his_cash
        ,coalesce(stg_pln_sum_prc_amt_12m_his_cash,0) as stg_pln_sum_prc_amt_12m_his_cash
        ,coalesce(stg_pln_avg_prc_amt_his_cash,0) as stg_pln_avg_prc_amt_his_cash
        ,coalesce(stg_pln_avg_prc_amt_1m_his_cash,0) as stg_pln_avg_prc_amt_1m_his_cash
        ,coalesce(stg_pln_avg_prc_amt_2m_his_cash,0) as stg_pln_avg_prc_amt_2m_his_cash
        ,coalesce(stg_pln_avg_prc_amt_3m_his_cash,0) as stg_pln_avg_prc_amt_3m_his_cash
        ,coalesce(stg_pln_avg_prc_amt_6m_his_cash,0) as stg_pln_avg_prc_amt_6m_his_cash
        ,coalesce(stg_pln_avg_prc_amt_12m_his_cash,0) as stg_pln_avg_prc_amt_12m_his_cash
        ,coalesce(stg_pln_min_prc_amt_his_cash,0) as stg_pln_min_prc_amt_his_cash
        ,coalesce(stg_pln_min_prc_amt_1m_his_cash,0) as stg_pln_min_prc_amt_1m_his_cash
        ,coalesce(stg_pln_min_prc_amt_2m_his_cash,0) as stg_pln_min_prc_amt_2m_his_cash
        ,coalesce(stg_pln_min_prc_amt_3m_his_cash,0) as stg_pln_min_prc_amt_3m_his_cash
        ,coalesce(stg_pln_min_prc_amt_6m_his_cash,0) as stg_pln_min_prc_amt_6m_his_cash
        ,coalesce(stg_pln_min_prc_amt_12m_his_cash,0) as stg_pln_min_prc_amt_12m_his_cash
        ,coalesce(stg_pln_max_prc_amt_his_cash,0) as stg_pln_max_prc_amt_his_cash
        ,coalesce(stg_pln_max_prc_amt_1m_his_cash,0) as stg_pln_max_prc_amt_1m_his_cash
        ,coalesce(stg_pln_max_prc_amt_2m_his_cash,0) as stg_pln_max_prc_amt_2m_his_cash
        ,coalesce(stg_pln_max_prc_amt_3m_his_cash,0) as stg_pln_max_prc_amt_3m_his_cash
        ,coalesce(stg_pln_max_prc_amt_6m_his_cash,0) as stg_pln_max_prc_amt_6m_his_cash
        ,coalesce(stg_pln_max_prc_amt_12m_his_cash,0) as stg_pln_max_prc_amt_12m_his_cash
        ,coalesce(stg_pln_cnt_his_rep_cash,0) as stg_pln_cnt_his_rep_cash
        ,coalesce(stg_pln_cnt_1m_his_rep_cash,0) as stg_pln_cnt_1m_his_rep_cash
        ,coalesce(stg_pln_cnt_2m_his_rep_cash,0) as stg_pln_cnt_2m_his_rep_cash
        ,coalesce(stg_pln_cnt_3m_his_rep_cash,0) as stg_pln_cnt_3m_his_rep_cash
        ,coalesce(stg_pln_cnt_6m_his_rep_cash,0) as stg_pln_cnt_6m_his_rep_cash
        ,coalesce(stg_pln_cnt_12m_his_rep_cash,0) as stg_pln_cnt_12m_his_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_his_rep_cash,0) as stg_pln_sum_prc_amt_his_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_1m_his_rep_cash,0) as stg_pln_sum_prc_amt_1m_his_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_2m_his_rep_cash,0) as stg_pln_sum_prc_amt_2m_his_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_3m_his_rep_cash,0) as stg_pln_sum_prc_amt_3m_his_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_6m_his_rep_cash,0) as stg_pln_sum_prc_amt_6m_his_rep_cash
        ,coalesce(stg_pln_sum_prc_amt_12m_his_rep_cash,0) as stg_pln_sum_prc_amt_12m_his_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_his_rep_cash,0) as stg_pln_avg_prc_amt_his_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_1m_his_rep_cash,0) as stg_pln_avg_prc_amt_1m_his_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_2m_his_rep_cash,0) as stg_pln_avg_prc_amt_2m_his_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_3m_his_rep_cash,0) as stg_pln_avg_prc_amt_3m_his_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_6m_his_rep_cash,0) as stg_pln_avg_prc_amt_6m_his_rep_cash
        ,coalesce(stg_pln_avg_prc_amt_12m_his_rep_cash,0) as stg_pln_avg_prc_amt_12m_his_rep_cash
        ,coalesce(stg_pln_min_prc_amt_his_rep_cash,0) as stg_pln_min_prc_amt_his_rep_cash
        ,coalesce(stg_pln_min_prc_amt_1m_his_rep_cash,0) as stg_pln_min_prc_amt_1m_his_rep_cash
        ,coalesce(stg_pln_min_prc_amt_2m_his_rep_cash,0) as stg_pln_min_prc_amt_2m_his_rep_cash
        ,coalesce(stg_pln_min_prc_amt_3m_his_rep_cash,0) as stg_pln_min_prc_amt_3m_his_rep_cash
        ,coalesce(stg_pln_min_prc_amt_6m_his_rep_cash,0) as stg_pln_min_prc_amt_6m_his_rep_cash
        ,coalesce(stg_pln_min_prc_amt_12m_his_rep_cash,0) as stg_pln_min_prc_amt_12m_his_rep_cash
        ,coalesce(stg_pln_max_prc_amt_his_rep_cash,0) as stg_pln_max_prc_amt_his_rep_cash
        ,coalesce(stg_pln_max_prc_amt_1m_his_rep_cash,0) as stg_pln_max_prc_amt_1m_his_rep_cash
        ,coalesce(stg_pln_max_prc_amt_2m_his_rep_cash,0) as stg_pln_max_prc_amt_2m_his_rep_cash
        ,coalesce(stg_pln_max_prc_amt_3m_his_rep_cash,0) as stg_pln_max_prc_amt_3m_his_rep_cash
        ,coalesce(stg_pln_max_prc_amt_6m_his_rep_cash,0) as stg_pln_max_prc_amt_6m_his_rep_cash
        ,coalesce(stg_pln_max_prc_amt_12m_his_rep_cash,0) as stg_pln_max_prc_amt_12m_his_rep_cash
       ----------------/*未来计划还款趋势*/------------------
       -- /*未来/未来,未来计划还款（包含提前已还订单）*/
        ,stg_pln_cnt_1m_ftr_cash/stg_pln_cnt_1m_3m_ftr_cash as stg_pln_cnt_1m_3m_ftr_rto_cash
        ,stg_pln_cnt_3m_ftr_cash/stg_pln_cnt_3m_6m_ftr_cash as stg_pln_cnt_3m_6m_ftr_rto_cash
        ,stg_pln_cnt_6m_ftr_cash/stg_pln_cnt_6m_12m_ftr_cash as stg_pln_cnt_6m_12m_ftr_rto_cash
        ,stg_pln_sum_prc_amt_1m_ftr_cash/stg_pln_sum_prc_amt_1m_3m_ftr_cash as stg_pln_sum_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_cash/stg_pln_sum_prc_amt_3m_6m_ftr_cash as stg_pln_sum_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_cash/stg_pln_sum_prc_amt_6m_12m_ftr_cash as stg_pln_sum_prc_amt_6m_12m_ftr_rto_cash   
        ,stg_pln_avg_prc_amt_1m_ftr_cash/stg_pln_avg_prc_amt_1m_3m_ftr_cash as stg_pln_avg_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_cash/stg_pln_avg_prc_amt_3m_6m_ftr_cash as stg_pln_avg_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_cash/stg_pln_avg_prc_amt_6m_12m_ftr_cash as stg_pln_avg_prc_amt_6m_12m_ftr_rto_cash  
        ,stg_pln_min_prc_amt_1m_ftr_cash/stg_pln_min_prc_amt_1m_3m_ftr_cash as stg_pln_min_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_min_prc_amt_3m_ftr_cash/stg_pln_min_prc_amt_3m_6m_ftr_cash as stg_pln_min_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_min_prc_amt_6m_ftr_cash/stg_pln_min_prc_amt_6m_12m_ftr_cash as stg_pln_min_prc_amt_6m_12m_ftr_rto_cash
        ,stg_pln_max_prc_amt_1m_ftr_cash/stg_pln_max_prc_amt_1m_3m_ftr_cash as stg_pln_max_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_max_prc_amt_3m_ftr_cash/stg_pln_max_prc_amt_3m_6m_ftr_cash as stg_pln_max_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_max_prc_amt_6m_ftr_cash/stg_pln_max_prc_amt_6m_12m_ftr_cash as stg_pln_max_prc_amt_6m_12m_ftr_rto_cash  
        
        -- /*未来/历史,未来计划还款（包含提前已还订单）*/
        ,stg_pln_cnt_3d_ftr_cash/stg_pln_cnt_3d_his_cash as stg_pln_cnt_3d_ftr_his_rto_cash
        ,stg_pln_cnt_7d_ftr_cash/stg_pln_cnt_7d_his_cash as stg_pln_cnt_7d_ftr_his_rto_cash
        ,stg_pln_cnt_1m_ftr_cash/stg_pln_cnt_1m_his_cash as stg_pln_cnt_1m_ftr_his_rto_cash
        ,stg_pln_cnt_2m_ftr_cash/stg_pln_cnt_2m_his_cash as stg_pln_cnt_2m_ftr_his_rto_cash
        ,stg_pln_cnt_3m_ftr_cash/stg_pln_cnt_3m_his_cash as stg_pln_cnt_3m_ftr_his_rto_cash
        ,stg_pln_cnt_6m_ftr_cash/stg_pln_cnt_6m_his_cash as stg_pln_cnt_6m_ftr_his_rto_cash
        ,stg_pln_cnt_12m_ftr_cash/stg_pln_cnt_12m_his_cash as stg_pln_cnt_12m_ftr_his_rto_cash

        ,stg_pln_sum_prc_amt_3d_ftr_cash/stg_pln_sum_prc_amt_3d_his_cash as stg_pln_sum_prc_amt_3d_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_7d_ftr_cash/stg_pln_sum_prc_amt_7d_his_cash as stg_pln_sum_prc_amt_7d_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_1m_ftr_cash/stg_pln_sum_prc_amt_1m_his_cash as stg_pln_sum_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_2m_ftr_cash/stg_pln_sum_prc_amt_2m_his_cash as stg_pln_sum_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_cash/stg_pln_sum_prc_amt_3m_his_cash as stg_pln_sum_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_cash/stg_pln_sum_prc_amt_6m_his_cash as stg_pln_sum_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_12m_ftr_cash/stg_pln_sum_prc_amt_12m_his_cash as stg_pln_sum_prc_amt_12m_ftr_his_rto_cash

        ,stg_pln_avg_prc_amt_1m_ftr_cash/stg_pln_avg_prc_amt_1m_his_cash as stg_pln_avg_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_2m_ftr_cash/stg_pln_avg_prc_amt_2m_his_cash as stg_pln_avg_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_cash/stg_pln_avg_prc_amt_3m_his_cash as stg_pln_avg_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_cash/stg_pln_avg_prc_amt_6m_his_cash as stg_pln_avg_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_12m_ftr_cash/stg_pln_avg_prc_amt_12m_his_cash as stg_pln_avg_prc_amt_12m_ftr_his_rto_cash

        ,stg_pln_min_prc_amt_1m_ftr_cash/stg_pln_min_prc_amt_1m_his_cash as stg_pln_min_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_2m_ftr_cash/stg_pln_min_prc_amt_2m_his_cash as stg_pln_min_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_3m_ftr_cash/stg_pln_min_prc_amt_3m_his_cash as stg_pln_min_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_6m_ftr_cash/stg_pln_min_prc_amt_6m_his_cash as stg_pln_min_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_12m_ftr_cash/stg_pln_min_prc_amt_12m_his_cash as stg_pln_min_prc_amt_12m_ftr_his_rto_cash

        ,stg_pln_max_prc_amt_1m_ftr_cash/stg_pln_max_prc_amt_1m_his_cash as stg_pln_max_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_2m_ftr_cash/stg_pln_max_prc_amt_2m_his_cash as stg_pln_max_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_3m_ftr_cash/stg_pln_max_prc_amt_3m_his_cash as stg_pln_max_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_6m_ftr_cash/stg_pln_max_prc_amt_6m_his_cash as stg_pln_max_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_12m_ftr_cash/stg_pln_max_prc_amt_12m_his_cash as stg_pln_max_prc_amt_12m_ftr_his_rto_cash

        -- 和历史固定表现期作对比
        ,stg_pln_cnt_1m_ftr_cash/stg_pln_cnt_12m_his_cash as stg_pln_cnt_1m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_2m_ftr_cash/stg_pln_cnt_12m_his_cash as stg_pln_cnt_2m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_3m_ftr_cash/stg_pln_cnt_12m_his_cash as stg_pln_cnt_3m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_6m_ftr_cash/stg_pln_cnt_12m_his_cash as stg_pln_cnt_6m_ftr_his_12m_rto_cash

        ,stg_pln_avg_prc_amt_1m_ftr_cash/stg_pln_avg_prc_amt_12m_his_cash as stg_pln_avg_prc_amt_1m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_2m_ftr_cash/stg_pln_avg_prc_amt_12m_his_cash as stg_pln_avg_prc_amt_2m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_cash/stg_pln_avg_prc_amt_12m_his_cash as stg_pln_avg_prc_amt_3m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_cash/stg_pln_avg_prc_amt_12m_his_cash as stg_pln_avg_prc_amt_6m_ftr_his_12m_rto_cash

        ----------------/*未来实际还款趋势*/------------------
        -- /*未来/历史,未来应还未还订单（包含历史未还订单）*/
        ,stg_pln_cnt_1m_ftr_rep_cash/stg_pln_cnt_1m_his_rep_cash as stg_pln_cnt_1m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_2m_ftr_rep_cash/stg_pln_cnt_2m_his_rep_cash as stg_pln_cnt_2m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_3m_ftr_rep_cash/stg_pln_cnt_3m_his_rep_cash as stg_pln_cnt_3m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_6m_ftr_rep_cash/stg_pln_cnt_6m_his_rep_cash as stg_pln_cnt_6m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_12m_ftr_rep_cash/stg_pln_cnt_12m_his_rep_cash as stg_pln_cnt_12m_ftr_his_rep_rto_cash

        ,stg_pln_sum_prc_amt_1m_ftr_rep_cash/stg_pln_sum_prc_amt_1m_his_rep_cash as stg_pln_sum_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_2m_ftr_rep_cash/stg_pln_sum_prc_amt_2m_his_rep_cash as stg_pln_sum_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_rep_cash/stg_pln_sum_prc_amt_3m_his_rep_cash as stg_pln_sum_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_rep_cash/stg_pln_sum_prc_amt_6m_his_rep_cash as stg_pln_sum_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_12m_ftr_rep_cash/stg_pln_sum_prc_amt_12m_his_rep_cash as stg_pln_sum_prc_amt_12m_ftr_his_rep_rto_cash

        ,stg_pln_avg_prc_amt_1m_ftr_rep_cash/stg_pln_avg_prc_amt_1m_his_rep_cash as stg_pln_avg_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_2m_ftr_rep_cash/stg_pln_avg_prc_amt_2m_his_rep_cash as stg_pln_avg_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_rep_cash/stg_pln_avg_prc_amt_3m_his_rep_cash as stg_pln_avg_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_rep_cash/stg_pln_avg_prc_amt_6m_his_rep_cash as stg_pln_avg_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_12m_ftr_rep_cash/stg_pln_avg_prc_amt_12m_his_rep_cash as stg_pln_avg_prc_amt_12m_ftr_his_rep_rto_cash

        ,stg_pln_min_prc_amt_1m_ftr_rep_cash/stg_pln_min_prc_amt_1m_his_rep_cash as stg_pln_min_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_2m_ftr_rep_cash/stg_pln_min_prc_amt_2m_his_rep_cash as stg_pln_min_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_3m_ftr_rep_cash/stg_pln_min_prc_amt_3m_his_rep_cash as stg_pln_min_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_6m_ftr_rep_cash/stg_pln_min_prc_amt_6m_his_rep_cash as stg_pln_min_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_12m_ftr_rep_cash/stg_pln_min_prc_amt_12m_his_rep_cash as stg_pln_min_prc_amt_12m_ftr_his_rep_rto_cash

        ,stg_pln_max_prc_amt_1m_ftr_rep_cash/stg_pln_max_prc_amt_1m_his_rep_cash as stg_pln_max_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_2m_ftr_rep_cash/stg_pln_max_prc_amt_2m_his_rep_cash as stg_pln_max_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_3m_ftr_rep_cash/stg_pln_max_prc_amt_3m_his_rep_cash as stg_pln_max_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_6m_ftr_rep_cash/stg_pln_max_prc_amt_6m_his_rep_cash as stg_pln_max_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_12m_ftr_rep_cash/stg_pln_max_prc_amt_12m_his_rep_cash as stg_pln_max_prc_amt_12m_ftr_his_rep_rto_cash

        ----------------/*未来提前还款占比*/------------------
        ,stg_pln_cnt_ftr_adv_cash/stg_pln_cnt_ftr_cash as stg_pln_cnt_ftr_adv_rto_cash
        ,stg_pln_cnt_1m_ftr_adv_cash/stg_pln_cnt_1m_ftr_cash as stg_pln_cnt_1m_ftr_adv_rto_cash
        ,stg_pln_cnt_2m_ftr_adv_cash/stg_pln_cnt_2m_ftr_cash as stg_pln_cnt_2m_ftr_adv_rto_cash
        ,stg_pln_cnt_3m_ftr_adv_cash/stg_pln_cnt_3m_ftr_cash as stg_pln_cnt_3m_ftr_adv_rto_cash
        ,stg_pln_cnt_6m_ftr_adv_cash/stg_pln_cnt_6m_ftr_cash as stg_pln_cnt_6m_ftr_adv_rto_cash
        ,stg_pln_cnt_12m_ftr_adv_cash/stg_pln_cnt_12m_ftr_cash as stg_pln_cnt_12m_ftr_adv_rto_cash

        ,stg_pln_sum_prc_amt_ftr_adv_cash/stg_pln_sum_prc_amt_ftr_cash as stg_pln_sum_prc_amt_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_1m_ftr_adv_cash/stg_pln_sum_prc_amt_1m_ftr_cash as stg_pln_sum_prc_amt_1m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_2m_ftr_adv_cash/stg_pln_sum_prc_amt_2m_ftr_cash as stg_pln_sum_prc_amt_2m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_adv_cash/stg_pln_sum_prc_amt_3m_ftr_cash as stg_pln_sum_prc_amt_3m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_adv_cash/stg_pln_sum_prc_amt_6m_ftr_cash as stg_pln_sum_prc_amt_6m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_12m_ftr_adv_cash/stg_pln_sum_prc_amt_12m_ftr_cash as stg_pln_sum_prc_amt_12m_ftr_adv_rto_cash
from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp2 as t1
left join  ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp2 as t2
on t1.uid = t2.uid and t1.mdl_dte = t2.mdl_dte
;


-----------------------------------------------------------
--------/*统计重资产('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN','API_ASSET')*/
-----------------------------------------------------------
set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp3 as
select uid
       ,mdl_dte
       ----------------/*产品类型统计*/------------------
       ,count(distinct case when ftr_rep_stg_pln_1m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_1m_ftr_all
       ,count(distinct case when ftr_rep_stg_pln_2m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_2m_ftr_all
       ,count(distinct case when ftr_rep_stg_pln_3m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_3m_ftr_all
       ,count(distinct case when ftr_rep_stg_pln_6m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_6m_ftr_all
       ,count(distinct case when ftr_rep_stg_pln_12m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_12m_ftr_all

       ----------------/*未来计划还款（包含提前已还订单）*/------------------
        -- /*未来应还分期数*/
        ,count(case when is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_all
        ,count(case when ftr_rep_stg_pln_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_ftr_all
        ,count(case when ftr_rep_stg_pln_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_ftr_all
        ,count(case when ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_all
        ,count(case when ftr_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_ftr_all
        ,count(case when ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_all
        ,count(case when ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_all
        ,count(case when ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_all
        
        -- /*未来应还金额*/
        ,sum(case when is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_all
        ,sum(case when ftr_rep_stg_pln_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_ftr_all
        ,sum(case when ftr_rep_stg_pln_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_ftr_all
        ,sum(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_all
        ,sum(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr_all
        ,sum(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_all
        ,sum(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_all
        ,sum(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_all
        
        -- /*未来单笔应还金额*/
        ,avg(case when is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_avg_prc_amt_ftr_all
        ,avg(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_ftr_all
        ,avg(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_2m_ftr_all
        ,avg(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_ftr_all
        ,avg(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_ftr_all
        ,avg(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_12m_ftr_all

        -- ----------------/*未来提前已还订单*/------------------
        -- /*未来应还分期数*/
        ,count(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_adv_all
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_adv_all
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_ftr_adv_all
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_adv_all
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_adv_all
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_adv_all
        
        -- /*未来应还金额*/
        ,sum(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_adv_all
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_adv_all
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr_adv_all
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_adv_all
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_adv_all
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_adv_all
        
        -- /*未来单笔应还金额*/
        ,avg(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else null end) as stg_pln_avg_prc_amt_ftr_adv_all
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_ftr_adv_all
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_2m_ftr_adv_all
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_ftr_adv_all
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_ftr_adv_all
        ,avg(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_12m_ftr_adv_all 

        --------------/*未来应还未还订单（包含历史未还订单）*/------------------
        -- /*未来应还分期数*/
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3d_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_7d_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_rep_all
        ,count(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_rep_all
        
        -- /*未来应还金额*/
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3d_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_7d_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_rep_all
        ,sum(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_rep_all
        
        -- /*未来单笔应还金额*/
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and is_ftr_rep_stg_pln=1) then prc_amt else null end) as stg_pln_avg_prc_amt_ftr_rep_all
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_1m_ftr_rep_all
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_2m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_2m_ftr_rep_all
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_3m_ftr_rep_all
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_6m_ftr_rep_all
        ,avg(case when is_ovd_future_repay_stg_pln = 1 or (adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1) then prc_amt else null end) as stg_pln_avg_prc_amt_12m_ftr_rep_all

        ----------------/*未来阶段计划还款（包含提前已还订单）*/------------------
       -- /*未来1m-3m*/
       ,count(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_3m_ftr_all
       ,sum(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_3m_ftr_all
       ,avg(case when ftr_rep_stg_pln_1m_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_3m_ftr_all
       -- /*未来3m-6m*/
       ,count(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_6m_ftr_all
       ,sum(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_6m_ftr_all
       ,avg(case when ftr_rep_stg_pln_3m_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_6m_ftr_all
       -- /*未来6m-12m*/
       ,count(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_12m_ftr_all
       ,sum(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_12m_ftr_all
       ,avg(case when ftr_rep_stg_pln_6m_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_12m_ftr_all
from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1
where bsy_typ in ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN','API_ASSET')
group by uid
        ,mdl_dte
;



set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp3 as
select uid
       ,mdl_dte

       ----------------/*产品类型统计*/------------------
       ,count(distinct case when his_rep_stg_pln_1m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_1m_his_all
       ,count(distinct case when his_rep_stg_pln_2m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_2m_his_all
       ,count(distinct case when his_rep_stg_pln_3m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_3m_his_all
       ,count(distinct case when his_rep_stg_pln_6m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_6m_his_all
       ,count(distinct case when his_rep_stg_pln_12m_flg=1 then bsy_typ_flg else null end) as stg_pln_bsy_typ_cnt_12m_his_all

        ----------------/*历史计划还款（包含逾期未还订单）*/------------------
        -- /*历史应还分期数*/
        ,count(case when is_his_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_his_all
        ,count(case when his_rep_stg_pln_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_his_all
        ,count(case when his_rep_stg_pln_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_his_all
        ,count(case when his_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_his_all
        ,count(case when his_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_his_all
        ,count(case when his_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_his_all
        ,count(case when his_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_his_all
        ,count(case when his_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_his_all
        
        -- /*历史应还金额*/
        ,sum(case when is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_all
        ,sum(case when his_rep_stg_pln_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_his_all
        ,sum(case when his_rep_stg_pln_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_his_all
        ,sum(case when his_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_his_all
        ,sum(case when his_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_his_all
        ,sum(case when his_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_his_all
        ,sum(case when his_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_his_all
        ,sum(case when his_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_his_all
        
        -- /*历史单笔应还金额*/
        ,avg(case when is_his_rep_stg_pln=1 then prc_amt else null end) as stg_pln_avg_prc_amt_his_all
        ,avg(case when his_rep_stg_pln_1m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_1m_his_all
        ,avg(case when his_rep_stg_pln_2m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_2m_his_all
        ,avg(case when his_rep_stg_pln_3m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_3m_his_all
        ,avg(case when his_rep_stg_pln_6m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_6m_his_all
        ,avg(case when his_rep_stg_pln_12m_flg=1 then prc_amt else null end) as stg_pln_avg_prc_amt_12m_his_all

        -- ----------------/*历史应还已还订单*/------------------
        -- /*历史应还分期数*/
        ,count(case when is_his_rep_stg_pln=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_his_rep_all
        ,count(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_his_rep_all
        ,count(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_his_rep_all
        ,count(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_his_rep_all
        ,count(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_his_rep_all
        ,count(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_his_rep_all
        
        -- /*历史应还金额*/
        ,sum(case when is_his_rep_stg_pln=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_rep_all
        ,sum(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_his_rep_all
        ,sum(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_his_rep_all
        ,sum(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_his_rep_all
        ,sum(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_his_rep_all
        ,sum(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_his_rep_all
        
        -- /*历史单笔应还金额*/
        ,avg(case when is_his_rep_stg_pln=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_his_rep_all
        ,avg(case when his_rep_stg_pln_1m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_1m_his_rep_all
        ,avg(case when his_rep_stg_pln_2m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_2m_his_rep_all
        ,avg(case when his_rep_stg_pln_3m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_3m_his_rep_all
        ,avg(case when his_rep_stg_pln_6m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_6m_his_rep_all
        ,avg(case when his_rep_stg_pln_12m_flg=1 and rep_tim is not null then prc_amt else null end) as stg_pln_avg_prc_amt_12m_his_rep_all

from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp1
where bsy_typ in ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN','API_ASSET')
group by uid
        ,mdl_dte
;


set odps.stage.mapper.split.size=20; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp3 as
select t1.uid
       ,t1.mdl_dte
       ----------------/*基础变量*/------------------
        ,coalesce(stg_pln_bsy_typ_cnt_1m_ftr_all,0) as stg_pln_bsy_typ_cnt_1m_ftr_all
        ,coalesce(stg_pln_bsy_typ_cnt_2m_ftr_all,0) as stg_pln_bsy_typ_cnt_2m_ftr_all
        ,coalesce(stg_pln_bsy_typ_cnt_3m_ftr_all,0) as stg_pln_bsy_typ_cnt_3m_ftr_all
        ,coalesce(stg_pln_bsy_typ_cnt_6m_ftr_all,0) as stg_pln_bsy_typ_cnt_6m_ftr_all
        ,coalesce(stg_pln_bsy_typ_cnt_12m_ftr_all,0) as stg_pln_bsy_typ_cnt_12m_ftr_all
        ,coalesce(stg_pln_cnt_ftr_all,0) as stg_pln_cnt_ftr_all
        ,coalesce(stg_pln_cnt_3d_ftr_all,0) as stg_pln_cnt_3d_ftr_all
        ,coalesce(stg_pln_cnt_7d_ftr_all,0) as stg_pln_cnt_7d_ftr_all
        ,coalesce(stg_pln_cnt_1m_ftr_all,0) as stg_pln_cnt_1m_ftr_all
        ,coalesce(stg_pln_cnt_2m_ftr_all,0) as stg_pln_cnt_2m_ftr_all
        ,coalesce(stg_pln_cnt_3m_ftr_all,0) as stg_pln_cnt_3m_ftr_all
        ,coalesce(stg_pln_cnt_6m_ftr_all,0) as stg_pln_cnt_6m_ftr_all
        ,coalesce(stg_pln_cnt_12m_ftr_all,0) as stg_pln_cnt_12m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_ftr_all,0) as stg_pln_sum_prc_amt_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_3d_ftr_all,0) as stg_pln_sum_prc_amt_3d_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_7d_ftr_all,0) as stg_pln_sum_prc_amt_7d_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_1m_ftr_all,0) as stg_pln_sum_prc_amt_1m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_2m_ftr_all,0) as stg_pln_sum_prc_amt_2m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_3m_ftr_all,0) as stg_pln_sum_prc_amt_3m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_6m_ftr_all,0) as stg_pln_sum_prc_amt_6m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_12m_ftr_all,0) as stg_pln_sum_prc_amt_12m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_ftr_all,0) as stg_pln_avg_prc_amt_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_1m_ftr_all,0) as stg_pln_avg_prc_amt_1m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_2m_ftr_all,0) as stg_pln_avg_prc_amt_2m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_3m_ftr_all,0) as stg_pln_avg_prc_amt_3m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_6m_ftr_all,0) as stg_pln_avg_prc_amt_6m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_12m_ftr_all,0) as stg_pln_avg_prc_amt_12m_ftr_all
        ,coalesce(stg_pln_cnt_ftr_adv_all,0) as stg_pln_cnt_ftr_adv_all
        ,coalesce(stg_pln_cnt_1m_ftr_adv_all,0) as stg_pln_cnt_1m_ftr_adv_all
        ,coalesce(stg_pln_cnt_2m_ftr_adv_all,0) as stg_pln_cnt_2m_ftr_adv_all
        ,coalesce(stg_pln_cnt_3m_ftr_adv_all,0) as stg_pln_cnt_3m_ftr_adv_all
        ,coalesce(stg_pln_cnt_6m_ftr_adv_all,0) as stg_pln_cnt_6m_ftr_adv_all
        ,coalesce(stg_pln_cnt_12m_ftr_adv_all,0) as stg_pln_cnt_12m_ftr_adv_all
        ,coalesce(stg_pln_sum_prc_amt_ftr_adv_all,0) as stg_pln_sum_prc_amt_ftr_adv_all
        ,coalesce(stg_pln_sum_prc_amt_1m_ftr_adv_all,0) as stg_pln_sum_prc_amt_1m_ftr_adv_all
        ,coalesce(stg_pln_sum_prc_amt_2m_ftr_adv_all,0) as stg_pln_sum_prc_amt_2m_ftr_adv_all
        ,coalesce(stg_pln_sum_prc_amt_3m_ftr_adv_all,0) as stg_pln_sum_prc_amt_3m_ftr_adv_all
        ,coalesce(stg_pln_sum_prc_amt_6m_ftr_adv_all,0) as stg_pln_sum_prc_amt_6m_ftr_adv_all
        ,coalesce(stg_pln_sum_prc_amt_12m_ftr_adv_all,0) as stg_pln_sum_prc_amt_12m_ftr_adv_all
        ,coalesce(stg_pln_avg_prc_amt_ftr_adv_all,0) as stg_pln_avg_prc_amt_ftr_adv_all
        ,coalesce(stg_pln_avg_prc_amt_1m_ftr_adv_all,0) as stg_pln_avg_prc_amt_1m_ftr_adv_all
        ,coalesce(stg_pln_avg_prc_amt_2m_ftr_adv_all,0) as stg_pln_avg_prc_amt_2m_ftr_adv_all
        ,coalesce(stg_pln_avg_prc_amt_3m_ftr_adv_all,0) as stg_pln_avg_prc_amt_3m_ftr_adv_all
        ,coalesce(stg_pln_avg_prc_amt_6m_ftr_adv_all,0) as stg_pln_avg_prc_amt_6m_ftr_adv_all
        ,coalesce(stg_pln_avg_prc_amt_12m_ftr_adv_all,0) as stg_pln_avg_prc_amt_12m_ftr_adv_all
        ,coalesce(stg_pln_cnt_ftr_rep_all,0) as stg_pln_cnt_ftr_rep_all
        ,coalesce(stg_pln_cnt_3d_ftr_rep_all,0) as stg_pln_cnt_3d_ftr_rep_all
        ,coalesce(stg_pln_cnt_7d_ftr_rep_all,0) as stg_pln_cnt_7d_ftr_rep_all
        ,coalesce(stg_pln_cnt_1m_ftr_rep_all,0) as stg_pln_cnt_1m_ftr_rep_all
        ,coalesce(stg_pln_cnt_2m_ftr_rep_all,0) as stg_pln_cnt_2m_ftr_rep_all
        ,coalesce(stg_pln_cnt_3m_ftr_rep_all,0) as stg_pln_cnt_3m_ftr_rep_all
        ,coalesce(stg_pln_cnt_6m_ftr_rep_all,0) as stg_pln_cnt_6m_ftr_rep_all
        ,coalesce(stg_pln_cnt_12m_ftr_rep_all,0) as stg_pln_cnt_12m_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_ftr_rep_all,0) as stg_pln_sum_prc_amt_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_3d_ftr_rep_all,0) as stg_pln_sum_prc_amt_3d_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_7d_ftr_rep_all,0) as stg_pln_sum_prc_amt_7d_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_1m_ftr_rep_all,0) as stg_pln_sum_prc_amt_1m_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_2m_ftr_rep_all,0) as stg_pln_sum_prc_amt_2m_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_3m_ftr_rep_all,0) as stg_pln_sum_prc_amt_3m_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_6m_ftr_rep_all,0) as stg_pln_sum_prc_amt_6m_ftr_rep_all
        ,coalesce(stg_pln_sum_prc_amt_12m_ftr_rep_all,0) as stg_pln_sum_prc_amt_12m_ftr_rep_all
        ,coalesce(stg_pln_avg_prc_amt_ftr_rep_all,0) as stg_pln_avg_prc_amt_ftr_rep_all
        ,coalesce(stg_pln_avg_prc_amt_1m_ftr_rep_all,0) as stg_pln_avg_prc_amt_1m_ftr_rep_all
        ,coalesce(stg_pln_avg_prc_amt_2m_ftr_rep_all,0) as stg_pln_avg_prc_amt_2m_ftr_rep_all
        ,coalesce(stg_pln_avg_prc_amt_3m_ftr_rep_all,0) as stg_pln_avg_prc_amt_3m_ftr_rep_all
        ,coalesce(stg_pln_avg_prc_amt_6m_ftr_rep_all,0) as stg_pln_avg_prc_amt_6m_ftr_rep_all
        ,coalesce(stg_pln_avg_prc_amt_12m_ftr_rep_all,0) as stg_pln_avg_prc_amt_12m_ftr_rep_all
        ,coalesce(stg_pln_cnt_1m_3m_ftr_all,0) as stg_pln_cnt_1m_3m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_1m_3m_ftr_all,0) as stg_pln_sum_prc_amt_1m_3m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_1m_3m_ftr_all,0) as stg_pln_avg_prc_amt_1m_3m_ftr_all
        ,coalesce(stg_pln_cnt_3m_6m_ftr_all,0) as stg_pln_cnt_3m_6m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_3m_6m_ftr_all,0) as stg_pln_sum_prc_amt_3m_6m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_3m_6m_ftr_all,0) as stg_pln_avg_prc_amt_3m_6m_ftr_all
        ,coalesce(stg_pln_cnt_6m_12m_ftr_all,0) as stg_pln_cnt_6m_12m_ftr_all
        ,coalesce(stg_pln_sum_prc_amt_6m_12m_ftr_all,0) as stg_pln_sum_prc_amt_6m_12m_ftr_all
        ,coalesce(stg_pln_avg_prc_amt_6m_12m_ftr_all,0) as stg_pln_avg_prc_amt_6m_12m_ftr_all
        ,coalesce(stg_pln_bsy_typ_cnt_1m_his_all,0) as stg_pln_bsy_typ_cnt_1m_his_all
        ,coalesce(stg_pln_bsy_typ_cnt_2m_his_all,0) as stg_pln_bsy_typ_cnt_2m_his_all
        ,coalesce(stg_pln_bsy_typ_cnt_3m_his_all,0) as stg_pln_bsy_typ_cnt_3m_his_all
        ,coalesce(stg_pln_bsy_typ_cnt_6m_his_all,0) as stg_pln_bsy_typ_cnt_6m_his_all
        ,coalesce(stg_pln_bsy_typ_cnt_12m_his_all,0) as stg_pln_bsy_typ_cnt_12m_his_all
        ,coalesce(stg_pln_cnt_his_all,0) as stg_pln_cnt_his_all
        ,coalesce(stg_pln_cnt_3d_his_all,0) as stg_pln_cnt_3d_his_all
        ,coalesce(stg_pln_cnt_7d_his_all,0) as stg_pln_cnt_7d_his_all
        ,coalesce(stg_pln_cnt_1m_his_all,0) as stg_pln_cnt_1m_his_all
        ,coalesce(stg_pln_cnt_2m_his_all,0) as stg_pln_cnt_2m_his_all
        ,coalesce(stg_pln_cnt_3m_his_all,0) as stg_pln_cnt_3m_his_all
        ,coalesce(stg_pln_cnt_6m_his_all,0) as stg_pln_cnt_6m_his_all
        ,coalesce(stg_pln_cnt_12m_his_all,0) as stg_pln_cnt_12m_his_all
        ,coalesce(stg_pln_sum_prc_amt_his_all,0) as stg_pln_sum_prc_amt_his_all
        ,coalesce(stg_pln_sum_prc_amt_3d_his_all,0) as stg_pln_sum_prc_amt_3d_his_all
        ,coalesce(stg_pln_sum_prc_amt_7d_his_all,0) as stg_pln_sum_prc_amt_7d_his_all
        ,coalesce(stg_pln_sum_prc_amt_1m_his_all,0) as stg_pln_sum_prc_amt_1m_his_all
        ,coalesce(stg_pln_sum_prc_amt_2m_his_all,0) as stg_pln_sum_prc_amt_2m_his_all
        ,coalesce(stg_pln_sum_prc_amt_3m_his_all,0) as stg_pln_sum_prc_amt_3m_his_all
        ,coalesce(stg_pln_sum_prc_amt_6m_his_all,0) as stg_pln_sum_prc_amt_6m_his_all
        ,coalesce(stg_pln_sum_prc_amt_12m_his_all,0) as stg_pln_sum_prc_amt_12m_his_all
        ,coalesce(stg_pln_avg_prc_amt_his_all,0) as stg_pln_avg_prc_amt_his_all
        ,coalesce(stg_pln_avg_prc_amt_1m_his_all,0) as stg_pln_avg_prc_amt_1m_his_all
        ,coalesce(stg_pln_avg_prc_amt_2m_his_all,0) as stg_pln_avg_prc_amt_2m_his_all
        ,coalesce(stg_pln_avg_prc_amt_3m_his_all,0) as stg_pln_avg_prc_amt_3m_his_all
        ,coalesce(stg_pln_avg_prc_amt_6m_his_all,0) as stg_pln_avg_prc_amt_6m_his_all
        ,coalesce(stg_pln_avg_prc_amt_12m_his_all,0) as stg_pln_avg_prc_amt_12m_his_all
        ,coalesce(stg_pln_cnt_his_rep_all,0) as stg_pln_cnt_his_rep_all
        ,coalesce(stg_pln_cnt_1m_his_rep_all,0) as stg_pln_cnt_1m_his_rep_all
        ,coalesce(stg_pln_cnt_2m_his_rep_all,0) as stg_pln_cnt_2m_his_rep_all
        ,coalesce(stg_pln_cnt_3m_his_rep_all,0) as stg_pln_cnt_3m_his_rep_all
        ,coalesce(stg_pln_cnt_6m_his_rep_all,0) as stg_pln_cnt_6m_his_rep_all
        ,coalesce(stg_pln_cnt_12m_his_rep_all,0) as stg_pln_cnt_12m_his_rep_all
        ,coalesce(stg_pln_sum_prc_amt_his_rep_all,0) as stg_pln_sum_prc_amt_his_rep_all
        ,coalesce(stg_pln_sum_prc_amt_1m_his_rep_all,0) as stg_pln_sum_prc_amt_1m_his_rep_all
        ,coalesce(stg_pln_sum_prc_amt_2m_his_rep_all,0) as stg_pln_sum_prc_amt_2m_his_rep_all
        ,coalesce(stg_pln_sum_prc_amt_3m_his_rep_all,0) as stg_pln_sum_prc_amt_3m_his_rep_all
        ,coalesce(stg_pln_sum_prc_amt_6m_his_rep_all,0) as stg_pln_sum_prc_amt_6m_his_rep_all
        ,coalesce(stg_pln_sum_prc_amt_12m_his_rep_all,0) as stg_pln_sum_prc_amt_12m_his_rep_all
        ,coalesce(stg_pln_avg_prc_amt_his_rep_all,0) as stg_pln_avg_prc_amt_his_rep_all
        ,coalesce(stg_pln_avg_prc_amt_1m_his_rep_all,0) as stg_pln_avg_prc_amt_1m_his_rep_all
        ,coalesce(stg_pln_avg_prc_amt_2m_his_rep_all,0) as stg_pln_avg_prc_amt_2m_his_rep_all
        ,coalesce(stg_pln_avg_prc_amt_3m_his_rep_all,0) as stg_pln_avg_prc_amt_3m_his_rep_all
        ,coalesce(stg_pln_avg_prc_amt_6m_his_rep_all,0) as stg_pln_avg_prc_amt_6m_his_rep_all
        ,coalesce(stg_pln_avg_prc_amt_12m_his_rep_all,0) as stg_pln_avg_prc_amt_12m_his_rep_all

       ----------------/*未来计划还款趋势*/------------------
       -- /*未来/未来,未来计划还款（包含提前已还订单）*/
        ,stg_pln_cnt_1m_ftr_all/stg_pln_cnt_1m_3m_ftr_all as stg_pln_cnt_1m_3m_ftr_rto_all
        ,stg_pln_cnt_3m_ftr_all/stg_pln_cnt_3m_6m_ftr_all as stg_pln_cnt_3m_6m_ftr_rto_all
        ,stg_pln_cnt_6m_ftr_all/stg_pln_cnt_6m_12m_ftr_all as stg_pln_cnt_6m_12m_ftr_rto_all
        ,stg_pln_sum_prc_amt_1m_ftr_all/stg_pln_sum_prc_amt_1m_3m_ftr_all as stg_pln_sum_prc_amt_1m_3m_ftr_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_all/stg_pln_sum_prc_amt_3m_6m_ftr_all as stg_pln_sum_prc_amt_3m_6m_ftr_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_all/stg_pln_sum_prc_amt_6m_12m_ftr_all as stg_pln_sum_prc_amt_6m_12m_ftr_rto_all   
        ,stg_pln_avg_prc_amt_1m_ftr_all/stg_pln_avg_prc_amt_1m_3m_ftr_all as stg_pln_avg_prc_amt_1m_3m_ftr_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_all/stg_pln_avg_prc_amt_3m_6m_ftr_all as stg_pln_avg_prc_amt_3m_6m_ftr_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_all/stg_pln_avg_prc_amt_6m_12m_ftr_all as stg_pln_avg_prc_amt_6m_12m_ftr_rto_all  
        
        -- /*未来/历史,未来计划还款（包含提前已还订单）*/
        ,stg_pln_cnt_3d_ftr_all/stg_pln_cnt_3d_his_all as stg_pln_cnt_3d_ftr_his_rto_all
        ,stg_pln_cnt_7d_ftr_all/stg_pln_cnt_7d_his_all as stg_pln_cnt_7d_ftr_his_rto_all
        ,stg_pln_cnt_1m_ftr_all/stg_pln_cnt_1m_his_all as stg_pln_cnt_1m_ftr_his_rto_all
        ,stg_pln_cnt_2m_ftr_all/stg_pln_cnt_2m_his_all as stg_pln_cnt_2m_ftr_his_rto_all
        ,stg_pln_cnt_3m_ftr_all/stg_pln_cnt_3m_his_all as stg_pln_cnt_3m_ftr_his_rto_all
        ,stg_pln_cnt_6m_ftr_all/stg_pln_cnt_6m_his_all as stg_pln_cnt_6m_ftr_his_rto_all
        ,stg_pln_cnt_12m_ftr_all/stg_pln_cnt_12m_his_all as stg_pln_cnt_12m_ftr_his_rto_all

        ,stg_pln_sum_prc_amt_3d_ftr_all/stg_pln_sum_prc_amt_3d_his_all as stg_pln_sum_prc_amt_3d_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_7d_ftr_all/stg_pln_sum_prc_amt_7d_his_all as stg_pln_sum_prc_amt_7d_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_1m_ftr_all/stg_pln_sum_prc_amt_1m_his_all as stg_pln_sum_prc_amt_1m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_2m_ftr_all/stg_pln_sum_prc_amt_2m_his_all as stg_pln_sum_prc_amt_2m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_all/stg_pln_sum_prc_amt_3m_his_all as stg_pln_sum_prc_amt_3m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_all/stg_pln_sum_prc_amt_6m_his_all as stg_pln_sum_prc_amt_6m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_12m_ftr_all/stg_pln_sum_prc_amt_12m_his_all as stg_pln_sum_prc_amt_12m_ftr_his_rto_all

        ,stg_pln_avg_prc_amt_1m_ftr_all/stg_pln_avg_prc_amt_1m_his_all as stg_pln_avg_prc_amt_1m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_2m_ftr_all/stg_pln_avg_prc_amt_2m_his_all as stg_pln_avg_prc_amt_2m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_all/stg_pln_avg_prc_amt_3m_his_all as stg_pln_avg_prc_amt_3m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_all/stg_pln_avg_prc_amt_6m_his_all as stg_pln_avg_prc_amt_6m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_12m_ftr_all/stg_pln_avg_prc_amt_12m_his_all as stg_pln_avg_prc_amt_12m_ftr_his_rto_all

        -- 和历史固定表现期作对比
        ,stg_pln_cnt_1m_ftr_all/stg_pln_cnt_12m_his_all as stg_pln_cnt_1m_ftr_his_12m_rto_all
        ,stg_pln_cnt_2m_ftr_all/stg_pln_cnt_12m_his_all as stg_pln_cnt_2m_ftr_his_12m_rto_all
        ,stg_pln_cnt_3m_ftr_all/stg_pln_cnt_12m_his_all as stg_pln_cnt_3m_ftr_his_12m_rto_all
        ,stg_pln_cnt_6m_ftr_all/stg_pln_cnt_12m_his_all as stg_pln_cnt_6m_ftr_his_12m_rto_all

        ,stg_pln_avg_prc_amt_1m_ftr_all/stg_pln_avg_prc_amt_12m_his_all as stg_pln_avg_prc_amt_1m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_2m_ftr_all/stg_pln_avg_prc_amt_12m_his_all as stg_pln_avg_prc_amt_2m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_all/stg_pln_avg_prc_amt_12m_his_all as stg_pln_avg_prc_amt_3m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_all/stg_pln_avg_prc_amt_12m_his_all as stg_pln_avg_prc_amt_6m_ftr_his_12m_rto_all

        ----------------/*未来实际还款趋势*/------------------
        -- /*未来/历史,未来应还未还订单（包含历史未还订单）*/
        ,stg_pln_cnt_1m_ftr_rep_all/stg_pln_cnt_1m_his_rep_all as stg_pln_cnt_1m_ftr_his_rep_rto_all
        ,stg_pln_cnt_2m_ftr_rep_all/stg_pln_cnt_2m_his_rep_all as stg_pln_cnt_2m_ftr_his_rep_rto_all
        ,stg_pln_cnt_3m_ftr_rep_all/stg_pln_cnt_3m_his_rep_all as stg_pln_cnt_3m_ftr_his_rep_rto_all
        ,stg_pln_cnt_6m_ftr_rep_all/stg_pln_cnt_6m_his_rep_all as stg_pln_cnt_6m_ftr_his_rep_rto_all
        ,stg_pln_cnt_12m_ftr_rep_all/stg_pln_cnt_12m_his_rep_all as stg_pln_cnt_12m_ftr_his_rep_rto_all

        ,stg_pln_sum_prc_amt_1m_ftr_rep_all/stg_pln_sum_prc_amt_1m_his_rep_all as stg_pln_sum_prc_amt_1m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_2m_ftr_rep_all/stg_pln_sum_prc_amt_2m_his_rep_all as stg_pln_sum_prc_amt_2m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_rep_all/stg_pln_sum_prc_amt_3m_his_rep_all as stg_pln_sum_prc_amt_3m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_rep_all/stg_pln_sum_prc_amt_6m_his_rep_all as stg_pln_sum_prc_amt_6m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_12m_ftr_rep_all/stg_pln_sum_prc_amt_12m_his_rep_all as stg_pln_sum_prc_amt_12m_ftr_his_rep_rto_all

        ,stg_pln_avg_prc_amt_1m_ftr_rep_all/stg_pln_avg_prc_amt_1m_his_rep_all as stg_pln_avg_prc_amt_1m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_2m_ftr_rep_all/stg_pln_avg_prc_amt_2m_his_rep_all as stg_pln_avg_prc_amt_2m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_rep_all/stg_pln_avg_prc_amt_3m_his_rep_all as stg_pln_avg_prc_amt_3m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_rep_all/stg_pln_avg_prc_amt_6m_his_rep_all as stg_pln_avg_prc_amt_6m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_12m_ftr_rep_all/stg_pln_avg_prc_amt_12m_his_rep_all as stg_pln_avg_prc_amt_12m_ftr_his_rep_rto_all

        ----------------/*未来提前还款占比*/------------------
        ,stg_pln_cnt_ftr_adv_all/stg_pln_cnt_ftr_all as stg_pln_cnt_ftr_adv_rto_all
        ,stg_pln_cnt_1m_ftr_adv_all/stg_pln_cnt_1m_ftr_all as stg_pln_cnt_1m_ftr_adv_rto_all
        ,stg_pln_cnt_2m_ftr_adv_all/stg_pln_cnt_2m_ftr_all as stg_pln_cnt_2m_ftr_adv_rto_all
        ,stg_pln_cnt_3m_ftr_adv_all/stg_pln_cnt_3m_ftr_all as stg_pln_cnt_3m_ftr_adv_rto_all
        ,stg_pln_cnt_6m_ftr_adv_all/stg_pln_cnt_6m_ftr_all as stg_pln_cnt_6m_ftr_adv_rto_all
        ,stg_pln_cnt_12m_ftr_adv_all/stg_pln_cnt_12m_ftr_all as stg_pln_cnt_12m_ftr_adv_rto_all

        ,stg_pln_sum_prc_amt_ftr_adv_all/stg_pln_sum_prc_amt_ftr_all as stg_pln_sum_prc_amt_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_1m_ftr_adv_all/stg_pln_sum_prc_amt_1m_ftr_all as stg_pln_sum_prc_amt_1m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_2m_ftr_adv_all/stg_pln_sum_prc_amt_2m_ftr_all as stg_pln_sum_prc_amt_2m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_adv_all/stg_pln_sum_prc_amt_3m_ftr_all as stg_pln_sum_prc_amt_3m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_adv_all/stg_pln_sum_prc_amt_6m_ftr_all as stg_pln_sum_prc_amt_6m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_12m_ftr_adv_all/stg_pln_sum_prc_amt_12m_ftr_all as stg_pln_sum_prc_amt_12m_ftr_adv_rto_all
from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_ftr_tmp3 as t1
left join  ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_his_tmp3 as t2
on t1.uid = t2.uid and t1.mdl_dte = t2.mdl_dte
;


set odps.stage.mapper.split.size=20; 
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df partition(ds='${bizdate}') 
select model_data.uid
        ,model_data.mdl_dte
        
        ,stg_pln_cnt_ftr_cash
        ,stg_pln_cnt_3d_ftr_cash
        ,stg_pln_cnt_7d_ftr_cash
        ,stg_pln_cnt_1m_ftr_cash
        ,stg_pln_cnt_2m_ftr_cash
        ,stg_pln_cnt_3m_ftr_cash
        ,stg_pln_cnt_6m_ftr_cash
        ,stg_pln_cnt_12m_ftr_cash
        ,stg_pln_sum_prc_amt_ftr_cash
        ,stg_pln_sum_prc_amt_3d_ftr_cash
        ,stg_pln_sum_prc_amt_7d_ftr_cash
        ,stg_pln_sum_prc_amt_1m_ftr_cash
        ,stg_pln_sum_prc_amt_2m_ftr_cash
        ,stg_pln_sum_prc_amt_3m_ftr_cash
        ,stg_pln_sum_prc_amt_6m_ftr_cash
        ,stg_pln_sum_prc_amt_12m_ftr_cash
        ,stg_pln_avg_prc_amt_ftr_cash
        ,stg_pln_avg_prc_amt_1m_ftr_cash
        ,stg_pln_avg_prc_amt_2m_ftr_cash
        ,stg_pln_avg_prc_amt_3m_ftr_cash
        ,stg_pln_avg_prc_amt_6m_ftr_cash
        ,stg_pln_avg_prc_amt_12m_ftr_cash
        ,stg_pln_min_prc_amt_ftr_cash
        ,stg_pln_min_prc_amt_1m_ftr_cash
        ,stg_pln_min_prc_amt_2m_ftr_cash
        ,stg_pln_min_prc_amt_3m_ftr_cash
        ,stg_pln_min_prc_amt_6m_ftr_cash
        ,stg_pln_min_prc_amt_12m_ftr_cash
        ,stg_pln_max_prc_amt_ftr_cash
        ,stg_pln_max_prc_amt_1m_ftr_cash
        ,stg_pln_max_prc_amt_2m_ftr_cash
        ,stg_pln_max_prc_amt_3m_ftr_cash
        ,stg_pln_max_prc_amt_6m_ftr_cash
        ,stg_pln_max_prc_amt_12m_ftr_cash
        ,stg_pln_cnt_ftr_adv_cash
        ,stg_pln_cnt_1m_ftr_adv_cash
        ,stg_pln_cnt_2m_ftr_adv_cash
        ,stg_pln_cnt_3m_ftr_adv_cash
        ,stg_pln_cnt_6m_ftr_adv_cash
        ,stg_pln_cnt_12m_ftr_adv_cash
        ,stg_pln_sum_prc_amt_ftr_adv_cash
        ,stg_pln_sum_prc_amt_1m_ftr_adv_cash
        ,stg_pln_sum_prc_amt_2m_ftr_adv_cash
        ,stg_pln_sum_prc_amt_3m_ftr_adv_cash
        ,stg_pln_sum_prc_amt_6m_ftr_adv_cash
        ,stg_pln_sum_prc_amt_12m_ftr_adv_cash
        ,stg_pln_avg_prc_amt_ftr_adv_cash
        ,stg_pln_avg_prc_amt_1m_ftr_adv_cash
        ,stg_pln_avg_prc_amt_2m_ftr_adv_cash
        ,stg_pln_avg_prc_amt_3m_ftr_adv_cash
        ,stg_pln_avg_prc_amt_6m_ftr_adv_cash
        ,stg_pln_avg_prc_amt_12m_ftr_adv_cash
        ,stg_pln_min_prc_amt_ftr_adv_cash
        ,stg_pln_min_prc_amt_1m_ftr_adv_cash
        ,stg_pln_min_prc_amt_2m_ftr_adv_cash
        ,stg_pln_min_prc_amt_3m_ftr_adv_cash
        ,stg_pln_min_prc_amt_6m_ftr_adv_cash
        ,stg_pln_min_prc_amt_12m_ftr_adv_cash
        ,stg_pln_max_prc_amt_ftr_adv_cash
        ,stg_pln_max_prc_amt_1m_ftr_adv_cash
        ,stg_pln_max_prc_amt_2m_ftr_adv_cash
        ,stg_pln_max_prc_amt_3m_ftr_adv_cash
        ,stg_pln_max_prc_amt_6m_ftr_adv_cash
        ,stg_pln_max_prc_amt_12m_ftr_adv_cash
        ,stg_pln_cnt_ftr_rep_cash
        ,stg_pln_cnt_3d_ftr_rep_cash
        ,stg_pln_cnt_7d_ftr_rep_cash
        ,stg_pln_cnt_1m_ftr_rep_cash
        ,stg_pln_cnt_2m_ftr_rep_cash
        ,stg_pln_cnt_3m_ftr_rep_cash
        ,stg_pln_cnt_6m_ftr_rep_cash
        ,stg_pln_cnt_12m_ftr_rep_cash
        ,stg_pln_sum_prc_amt_ftr_rep_cash
        ,stg_pln_sum_prc_amt_3d_ftr_rep_cash
        ,stg_pln_sum_prc_amt_7d_ftr_rep_cash
        ,stg_pln_sum_prc_amt_1m_ftr_rep_cash
        ,stg_pln_sum_prc_amt_2m_ftr_rep_cash
        ,stg_pln_sum_prc_amt_3m_ftr_rep_cash
        ,stg_pln_sum_prc_amt_6m_ftr_rep_cash
        ,stg_pln_sum_prc_amt_12m_ftr_rep_cash
        ,stg_pln_avg_prc_amt_ftr_rep_cash
        ,stg_pln_avg_prc_amt_1m_ftr_rep_cash
        ,stg_pln_avg_prc_amt_2m_ftr_rep_cash
        ,stg_pln_avg_prc_amt_3m_ftr_rep_cash
        ,stg_pln_avg_prc_amt_6m_ftr_rep_cash
        ,stg_pln_avg_prc_amt_12m_ftr_rep_cash
        ,stg_pln_min_prc_amt_ftr_rep_cash
        ,stg_pln_min_prc_amt_1m_ftr_rep_cash
        ,stg_pln_min_prc_amt_2m_ftr_rep_cash
        ,stg_pln_min_prc_amt_3m_ftr_rep_cash
        ,stg_pln_min_prc_amt_6m_ftr_rep_cash
        ,stg_pln_min_prc_amt_12m_ftr_rep_cash
        ,stg_pln_max_prc_amt_ftr_rep_cash
        ,stg_pln_max_prc_amt_1m_ftr_rep_cash
        ,stg_pln_max_prc_amt_2m_ftr_rep_cash
        ,stg_pln_max_prc_amt_3m_ftr_rep_cash
        ,stg_pln_max_prc_amt_6m_ftr_rep_cash
        ,stg_pln_max_prc_amt_12m_ftr_rep_cash
        ,stg_pln_cnt_1m_3m_ftr_cash
        ,stg_pln_sum_prc_amt_1m_3m_ftr_cash
        ,stg_pln_avg_prc_amt_1m_3m_ftr_cash
        ,stg_pln_min_prc_amt_1m_3m_ftr_cash
        ,stg_pln_max_prc_amt_1m_3m_ftr_cash
        ,stg_pln_cnt_3m_6m_ftr_cash
        ,stg_pln_sum_prc_amt_3m_6m_ftr_cash
        ,stg_pln_avg_prc_amt_3m_6m_ftr_cash
        ,stg_pln_min_prc_amt_3m_6m_ftr_cash
        ,stg_pln_max_prc_amt_3m_6m_ftr_cash
        ,stg_pln_cnt_6m_12m_ftr_cash
        ,stg_pln_sum_prc_amt_6m_12m_ftr_cash
        ,stg_pln_avg_prc_amt_6m_12m_ftr_cash
        ,stg_pln_min_prc_amt_6m_12m_ftr_cash
        ,stg_pln_max_prc_amt_6m_12m_ftr_cash
        -- ,stg_pln_cnt_his_cash
        -- ,stg_pln_cnt_3d_his_cash
        -- ,stg_pln_cnt_7d_his_cash
        -- ,stg_pln_cnt_1m_his_cash
        -- ,stg_pln_cnt_2m_his_cash
        -- ,stg_pln_cnt_3m_his_cash
        -- ,stg_pln_cnt_6m_his_cash
        -- ,stg_pln_cnt_12m_his_cash
        -- ,stg_pln_sum_prc_amt_his_cash
        -- ,stg_pln_sum_prc_amt_3d_his_cash
        -- ,stg_pln_sum_prc_amt_7d_his_cash
        -- ,stg_pln_sum_prc_amt_1m_his_cash
        -- ,stg_pln_sum_prc_amt_2m_his_cash
        -- ,stg_pln_sum_prc_amt_3m_his_cash
        -- ,stg_pln_sum_prc_amt_6m_his_cash
        -- ,stg_pln_sum_prc_amt_12m_his_cash
        -- ,stg_pln_avg_prc_amt_his_cash
        -- ,stg_pln_avg_prc_amt_1m_his_cash
        -- ,stg_pln_avg_prc_amt_2m_his_cash
        -- ,stg_pln_avg_prc_amt_3m_his_cash
        -- ,stg_pln_avg_prc_amt_6m_his_cash
        -- ,stg_pln_avg_prc_amt_12m_his_cash
        -- ,stg_pln_min_prc_amt_his_cash
        -- ,stg_pln_min_prc_amt_1m_his_cash
        -- ,stg_pln_min_prc_amt_2m_his_cash
        -- ,stg_pln_min_prc_amt_3m_his_cash
        -- ,stg_pln_min_prc_amt_6m_his_cash
        -- ,stg_pln_min_prc_amt_12m_his_cash
        -- ,stg_pln_max_prc_amt_his_cash
        -- ,stg_pln_max_prc_amt_1m_his_cash
        -- ,stg_pln_max_prc_amt_2m_his_cash
        -- ,stg_pln_max_prc_amt_3m_his_cash
        -- ,stg_pln_max_prc_amt_6m_his_cash
        -- ,stg_pln_max_prc_amt_12m_his_cash
        -- ,stg_pln_cnt_his_rep_cash
        -- ,stg_pln_cnt_1m_his_rep_cash
        -- ,stg_pln_cnt_2m_his_rep_cash
        -- ,stg_pln_cnt_3m_his_rep_cash
        -- ,stg_pln_cnt_6m_his_rep_cash
        -- ,stg_pln_cnt_12m_his_rep_cash
        -- ,stg_pln_sum_prc_amt_his_rep_cash
        -- ,stg_pln_sum_prc_amt_1m_his_rep_cash
        -- ,stg_pln_sum_prc_amt_2m_his_rep_cash
        -- ,stg_pln_sum_prc_amt_3m_his_rep_cash
        -- ,stg_pln_sum_prc_amt_6m_his_rep_cash
        -- ,stg_pln_sum_prc_amt_12m_his_rep_cash
        -- ,stg_pln_avg_prc_amt_his_rep_cash
        -- ,stg_pln_avg_prc_amt_1m_his_rep_cash
        -- ,stg_pln_avg_prc_amt_2m_his_rep_cash
        -- ,stg_pln_avg_prc_amt_3m_his_rep_cash
        -- ,stg_pln_avg_prc_amt_6m_his_rep_cash
        -- ,stg_pln_avg_prc_amt_12m_his_rep_cash
        -- ,stg_pln_min_prc_amt_his_rep_cash
        -- ,stg_pln_min_prc_amt_1m_his_rep_cash
        -- ,stg_pln_min_prc_amt_2m_his_rep_cash
        -- ,stg_pln_min_prc_amt_3m_his_rep_cash
        -- ,stg_pln_min_prc_amt_6m_his_rep_cash
        -- ,stg_pln_min_prc_amt_12m_his_rep_cash
        -- ,stg_pln_max_prc_amt_his_rep_cash
        -- ,stg_pln_max_prc_amt_1m_his_rep_cash
        -- ,stg_pln_max_prc_amt_2m_his_rep_cash
        -- ,stg_pln_max_prc_amt_3m_his_rep_cash
        -- ,stg_pln_max_prc_amt_6m_his_rep_cash
        -- ,stg_pln_max_prc_amt_12m_his_rep_cash
        ,stg_pln_cnt_1m_3m_ftr_rto_cash
        ,stg_pln_cnt_3m_6m_ftr_rto_cash
        ,stg_pln_cnt_6m_12m_ftr_rto_cash
        ,stg_pln_sum_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_sum_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_sum_prc_amt_6m_12m_ftr_rto_cash
        ,stg_pln_avg_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_avg_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_avg_prc_amt_6m_12m_ftr_rto_cash
        ,stg_pln_min_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_min_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_min_prc_amt_6m_12m_ftr_rto_cash
        ,stg_pln_max_prc_amt_1m_3m_ftr_rto_cash
        ,stg_pln_max_prc_amt_3m_6m_ftr_rto_cash
        ,stg_pln_max_prc_amt_6m_12m_ftr_rto_cash
        ,stg_pln_cnt_3d_ftr_his_rto_cash
        ,stg_pln_cnt_7d_ftr_his_rto_cash
        ,stg_pln_cnt_1m_ftr_his_rto_cash
        ,stg_pln_cnt_2m_ftr_his_rto_cash
        ,stg_pln_cnt_3m_ftr_his_rto_cash
        ,stg_pln_cnt_6m_ftr_his_rto_cash
        ,stg_pln_cnt_12m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_3d_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_7d_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_sum_prc_amt_12m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_avg_prc_amt_12m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_min_prc_amt_12m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_1m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_2m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_3m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_6m_ftr_his_rto_cash
        ,stg_pln_max_prc_amt_12m_ftr_his_rto_cash
        ,stg_pln_cnt_1m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_2m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_3m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_6m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_1m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_2m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_his_12m_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_his_12m_rto_cash
        ,stg_pln_cnt_1m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_2m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_3m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_6m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_12m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_sum_prc_amt_12m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_avg_prc_amt_12m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_min_prc_amt_12m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_1m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_2m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_3m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_6m_ftr_his_rep_rto_cash
        ,stg_pln_max_prc_amt_12m_ftr_his_rep_rto_cash
        ,stg_pln_cnt_ftr_adv_rto_cash
        ,stg_pln_cnt_1m_ftr_adv_rto_cash
        ,stg_pln_cnt_2m_ftr_adv_rto_cash
        ,stg_pln_cnt_3m_ftr_adv_rto_cash
        ,stg_pln_cnt_6m_ftr_adv_rto_cash
        ,stg_pln_cnt_12m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_1m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_2m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_3m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_6m_ftr_adv_rto_cash
        ,stg_pln_sum_prc_amt_12m_ftr_adv_rto_cash


        ,stg_pln_bsy_typ_cnt_1m_ftr_all
        ,stg_pln_bsy_typ_cnt_2m_ftr_all
        ,stg_pln_bsy_typ_cnt_3m_ftr_all
        ,stg_pln_bsy_typ_cnt_6m_ftr_all
        ,stg_pln_bsy_typ_cnt_12m_ftr_all
        ,stg_pln_cnt_ftr_all
        ,stg_pln_cnt_3d_ftr_all
        ,stg_pln_cnt_7d_ftr_all
        ,stg_pln_cnt_1m_ftr_all
        ,stg_pln_cnt_2m_ftr_all
        ,stg_pln_cnt_3m_ftr_all
        ,stg_pln_cnt_6m_ftr_all
        ,stg_pln_cnt_12m_ftr_all
        ,stg_pln_sum_prc_amt_ftr_all
        ,stg_pln_sum_prc_amt_3d_ftr_all
        ,stg_pln_sum_prc_amt_7d_ftr_all
        ,stg_pln_sum_prc_amt_1m_ftr_all
        ,stg_pln_sum_prc_amt_2m_ftr_all
        ,stg_pln_sum_prc_amt_3m_ftr_all
        ,stg_pln_sum_prc_amt_6m_ftr_all
        ,stg_pln_sum_prc_amt_12m_ftr_all
        ,stg_pln_avg_prc_amt_ftr_all
        ,stg_pln_avg_prc_amt_1m_ftr_all
        ,stg_pln_avg_prc_amt_2m_ftr_all
        ,stg_pln_avg_prc_amt_3m_ftr_all
        ,stg_pln_avg_prc_amt_6m_ftr_all
        ,stg_pln_avg_prc_amt_12m_ftr_all
        ,stg_pln_cnt_ftr_adv_all
        ,stg_pln_cnt_1m_ftr_adv_all
        ,stg_pln_cnt_2m_ftr_adv_all
        ,stg_pln_cnt_3m_ftr_adv_all
        ,stg_pln_cnt_6m_ftr_adv_all
        ,stg_pln_cnt_12m_ftr_adv_all
        ,stg_pln_sum_prc_amt_ftr_adv_all
        ,stg_pln_sum_prc_amt_1m_ftr_adv_all
        ,stg_pln_sum_prc_amt_2m_ftr_adv_all
        ,stg_pln_sum_prc_amt_3m_ftr_adv_all
        ,stg_pln_sum_prc_amt_6m_ftr_adv_all
        ,stg_pln_sum_prc_amt_12m_ftr_adv_all
        ,stg_pln_avg_prc_amt_ftr_adv_all
        ,stg_pln_avg_prc_amt_1m_ftr_adv_all
        ,stg_pln_avg_prc_amt_2m_ftr_adv_all
        ,stg_pln_avg_prc_amt_3m_ftr_adv_all
        ,stg_pln_avg_prc_amt_6m_ftr_adv_all
        ,stg_pln_avg_prc_amt_12m_ftr_adv_all
        ,stg_pln_cnt_ftr_rep_all
        ,stg_pln_cnt_3d_ftr_rep_all
        ,stg_pln_cnt_7d_ftr_rep_all
        ,stg_pln_cnt_1m_ftr_rep_all
        ,stg_pln_cnt_2m_ftr_rep_all
        ,stg_pln_cnt_3m_ftr_rep_all
        ,stg_pln_cnt_6m_ftr_rep_all
        ,stg_pln_cnt_12m_ftr_rep_all
        ,stg_pln_sum_prc_amt_ftr_rep_all
        ,stg_pln_sum_prc_amt_3d_ftr_rep_all
        ,stg_pln_sum_prc_amt_7d_ftr_rep_all
        ,stg_pln_sum_prc_amt_1m_ftr_rep_all
        ,stg_pln_sum_prc_amt_2m_ftr_rep_all
        ,stg_pln_sum_prc_amt_3m_ftr_rep_all
        ,stg_pln_sum_prc_amt_6m_ftr_rep_all
        ,stg_pln_sum_prc_amt_12m_ftr_rep_all
        ,stg_pln_avg_prc_amt_ftr_rep_all
        ,stg_pln_avg_prc_amt_1m_ftr_rep_all
        ,stg_pln_avg_prc_amt_2m_ftr_rep_all
        ,stg_pln_avg_prc_amt_3m_ftr_rep_all
        ,stg_pln_avg_prc_amt_6m_ftr_rep_all
        ,stg_pln_avg_prc_amt_12m_ftr_rep_all
        ,stg_pln_cnt_1m_3m_ftr_all
        ,stg_pln_sum_prc_amt_1m_3m_ftr_all
        ,stg_pln_avg_prc_amt_1m_3m_ftr_all
        ,stg_pln_cnt_3m_6m_ftr_all
        ,stg_pln_sum_prc_amt_3m_6m_ftr_all
        ,stg_pln_avg_prc_amt_3m_6m_ftr_all
        ,stg_pln_cnt_6m_12m_ftr_all
        ,stg_pln_sum_prc_amt_6m_12m_ftr_all
        ,stg_pln_avg_prc_amt_6m_12m_ftr_all
        -- ,stg_pln_bsy_typ_cnt_1m_his_all
        -- ,stg_pln_bsy_typ_cnt_2m_his_all
        -- ,stg_pln_bsy_typ_cnt_3m_his_all
        -- ,stg_pln_bsy_typ_cnt_6m_his_all
        -- ,stg_pln_bsy_typ_cnt_12m_his_all
        -- ,stg_pln_cnt_his_all
        -- ,stg_pln_cnt_3d_his_all
        -- ,stg_pln_cnt_7d_his_all
        -- ,stg_pln_cnt_1m_his_all
        -- ,stg_pln_cnt_2m_his_all
        -- ,stg_pln_cnt_3m_his_all
        -- ,stg_pln_cnt_6m_his_all
        -- ,stg_pln_cnt_12m_his_all
        -- ,stg_pln_sum_prc_amt_his_all
        -- ,stg_pln_sum_prc_amt_3d_his_all
        -- ,stg_pln_sum_prc_amt_7d_his_all
        -- ,stg_pln_sum_prc_amt_1m_his_all
        -- ,stg_pln_sum_prc_amt_2m_his_all
        -- ,stg_pln_sum_prc_amt_3m_his_all
        -- ,stg_pln_sum_prc_amt_6m_his_all
        -- ,stg_pln_sum_prc_amt_12m_his_all
        -- ,stg_pln_avg_prc_amt_his_all
        -- ,stg_pln_avg_prc_amt_1m_his_all
        -- ,stg_pln_avg_prc_amt_2m_his_all
        -- ,stg_pln_avg_prc_amt_3m_his_all
        -- ,stg_pln_avg_prc_amt_6m_his_all
        -- ,stg_pln_avg_prc_amt_12m_his_all
        -- ,stg_pln_cnt_his_rep_all
        -- ,stg_pln_cnt_1m_his_rep_all
        -- ,stg_pln_cnt_2m_his_rep_all
        -- ,stg_pln_cnt_3m_his_rep_all
        -- ,stg_pln_cnt_6m_his_rep_all
        -- ,stg_pln_cnt_12m_his_rep_all
        -- ,stg_pln_sum_prc_amt_his_rep_all
        -- ,stg_pln_sum_prc_amt_1m_his_rep_all
        -- ,stg_pln_sum_prc_amt_2m_his_rep_all
        -- ,stg_pln_sum_prc_amt_3m_his_rep_all
        -- ,stg_pln_sum_prc_amt_6m_his_rep_all
        -- ,stg_pln_sum_prc_amt_12m_his_rep_all
        -- ,stg_pln_avg_prc_amt_his_rep_all
        -- ,stg_pln_avg_prc_amt_1m_his_rep_all
        -- ,stg_pln_avg_prc_amt_2m_his_rep_all
        -- ,stg_pln_avg_prc_amt_3m_his_rep_all
        -- ,stg_pln_avg_prc_amt_6m_his_rep_all
        -- ,stg_pln_avg_prc_amt_12m_his_rep_all
        ,stg_pln_cnt_1m_3m_ftr_rto_all
        ,stg_pln_cnt_3m_6m_ftr_rto_all
        ,stg_pln_cnt_6m_12m_ftr_rto_all
        ,stg_pln_sum_prc_amt_1m_3m_ftr_rto_all
        ,stg_pln_sum_prc_amt_3m_6m_ftr_rto_all
        ,stg_pln_sum_prc_amt_6m_12m_ftr_rto_all
        ,stg_pln_avg_prc_amt_1m_3m_ftr_rto_all
        ,stg_pln_avg_prc_amt_3m_6m_ftr_rto_all
        ,stg_pln_avg_prc_amt_6m_12m_ftr_rto_all
        ,stg_pln_cnt_3d_ftr_his_rto_all
        ,stg_pln_cnt_7d_ftr_his_rto_all
        ,stg_pln_cnt_1m_ftr_his_rto_all
        ,stg_pln_cnt_2m_ftr_his_rto_all
        ,stg_pln_cnt_3m_ftr_his_rto_all
        ,stg_pln_cnt_6m_ftr_his_rto_all
        ,stg_pln_cnt_12m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_3d_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_7d_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_1m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_2m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_his_rto_all
        ,stg_pln_sum_prc_amt_12m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_1m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_2m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_his_rto_all
        ,stg_pln_avg_prc_amt_12m_ftr_his_rto_all
        ,stg_pln_cnt_1m_ftr_his_12m_rto_all
        ,stg_pln_cnt_2m_ftr_his_12m_rto_all
        ,stg_pln_cnt_3m_ftr_his_12m_rto_all
        ,stg_pln_cnt_6m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_1m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_2m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_his_12m_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_his_12m_rto_all
        ,stg_pln_cnt_1m_ftr_his_rep_rto_all
        ,stg_pln_cnt_2m_ftr_his_rep_rto_all
        ,stg_pln_cnt_3m_ftr_his_rep_rto_all
        ,stg_pln_cnt_6m_ftr_his_rep_rto_all
        ,stg_pln_cnt_12m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_1m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_2m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_his_rep_rto_all
        ,stg_pln_sum_prc_amt_12m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_1m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_2m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_3m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_6m_ftr_his_rep_rto_all
        ,stg_pln_avg_prc_amt_12m_ftr_his_rep_rto_all
        ,stg_pln_cnt_ftr_adv_rto_all
        ,stg_pln_cnt_1m_ftr_adv_rto_all
        ,stg_pln_cnt_2m_ftr_adv_rto_all
        ,stg_pln_cnt_3m_ftr_adv_rto_all
        ,stg_pln_cnt_6m_ftr_adv_rto_all
        ,stg_pln_cnt_12m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_1m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_2m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_3m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_6m_ftr_adv_rto_all
        ,stg_pln_sum_prc_amt_12m_ftr_adv_rto_all
from 
(
        select uid
                ,mdl_dte
        from dwa_risk.dwa_risk_f_dz_model_final_14ftr_rep_pressure_trend_df_data_base_tmp
        group by uid
                ,mdl_dte
) model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp2 as t1
on model_data.uid = t1.uid and model_data.mdl_dte = t1.mdl_dte
left join ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_trend_df_tmp3 as t2
on model_data.uid = t2.uid and model_data.mdl_dte = t2.mdl_dte
;
-- feature-copilot:node-end ordinal=0
