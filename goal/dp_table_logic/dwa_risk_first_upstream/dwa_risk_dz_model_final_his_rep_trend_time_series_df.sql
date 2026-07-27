-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_his_rep_trend_time_series_df
-- node_id: n_6185039638278307840
-- task_name: dwa_risk_dz_model_final_his_rep_trend_time_series_df
-- owner_name: 黄皓俞
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_his_rep_trend_time_series_df.json
-- source_json_sha256: d302b63dece685e1dbf88b7c42c46305be99a0ad5da2cbb274627475b5fb8b7d
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_bizdate
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp1_bizdate
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part2_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part3_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part4_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part5_bizdate

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 黄皓俞
--创建日期: 2024-08-28 10:45:40
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df(
uid  string  comment '客户号'
,mdl_dte  string  comment '模型评分日'
,3m_repay_amt_first_der_max string comment '近3个月应还金额一阶导数的最大值'
,6m_repay_amt_first_der_max string comment '近6个月应还金额一阶导数的最大值'
,12m_repay_amt_first_der_max string comment '近12个月应还金额一阶导数的最大值'
,18m_repay_amt_first_der_max string comment '近18个月应还金额一阶导数的最大值'
,3m_repay_amt_first_der_min string comment '近3个月应还金额一阶导数的最小值'
,6m_repay_amt_first_der_min string comment '近6个月应还金额一阶导数的最小值'
,12m_repay_amt_first_der_min string comment '近12个月应还金额一阶导数的最小值'
,18m_repay_amt_first_der_min string comment '近18个月应还金额一阶导数的最小值'
,3m_repay_amt_first_der_avg string comment '近3个月应还金额一阶导数的平均值'
,6m_repay_amt_first_der_avg string comment '近6个月应还金额一阶导数的平均值'
,12m_repay_amt_first_der_avg string comment '近12个月应还金额一阶导数的平均值'
,18m_repay_amt_first_der_avg string comment '近18个月应还金额一阶导数的平均值'
,3m_repay_amt_first_der_median string comment '近3个月应还金额一阶导数的中位数'
,6m_repay_amt_first_der_median string comment '近6个月应还金额一阶导数的中位数'
,12m_repay_amt_first_der_median string comment '近12个月应还金额一阶导数的中位数'
,18m_repay_amt_first_der_median string comment '近18个月应还金额一阶导数的中位数'
,3m_repay_amt_first_der_stddev string comment '近3个月应还金额一阶导数的标准差'
,6m_repay_amt_first_der_stddev string comment '近6个月应还金额一阶导数的标准差'
,12m_repay_amt_first_der_stddev string comment '近12个月应还金额一阶导数的标准差'
,18m_repay_amt_first_der_stddev string comment '近18个月应还金额一阶导数的标准差'
,3m_repay_amt_first_der_sum string comment '近3个月应还金额一阶导数的和'
,6m_repay_amt_first_der_sum string comment '近6个月应还金额一阶导数的和'
,12m_repay_amt_first_der_sum string comment '近12个月应还金额一阶导数的和'
,18m_repay_amt_first_der_sum string comment '近18个月应还金额一阶导数的和'
,3m_repay_amt_first_der_great_0_count string comment '近3个月应还金额一阶导数大于0的次数'
,6m_repay_amt_first_der_great_0_count string comment '近6个月应还金额一阶导数大于0的次数'
,12m_repay_amt_first_der_great_0_count string comment '近12个月应还金额一阶导数大于0的次数'
,18m_repay_amt_first_der_great_0_count string comment '近18个月应还金额一阶导数大于0的次数'
,3m_repay_amt_first_der_great_0_sum string comment '近3个月应还金额一阶导数大于0的和'
,6m_repay_amt_first_der_great_0_sum string comment '近6个月应还金额一阶导数大于0的和'
,12m_repay_amt_first_der_great_0_sum string comment '近12个月应还金额一阶导数大于0的和'
,18m_repay_amt_first_der_great_0_sum string comment '近18个月应还金额一阶导数大于0的和'
,3m_repay_amt_first_der_small_0_count string comment '近3个月应还金额一阶导数小于0的次数'
,6m_repay_amt_first_der_small_0_count string comment '近6个月应还金额一阶导数小于0的次数'
,12m_repay_amt_first_der_small_0_count string comment '近12个月应还金额一阶导数小于0的次数'
,18m_repay_amt_first_der_small_0_count string comment '近18个月应还金额一阶导数小于0的次数'
,3m_repay_amt_first_der_small_0_sum string comment '近3个月应还金额一阶导数小于0的和'
,6m_repay_amt_first_der_small_0_sum string comment '近6个月应还金额一阶导数小于0的和'
,12m_repay_amt_first_der_small_0_sum string comment '近12个月应还金额一阶导数小于0的和'
,18m_repay_amt_first_der_small_0_sum string comment '近18个月应还金额一阶导数小于0的和'
,3m_repay_amt_first_der_mean_diff string comment '近3个月应还金额一阶导数前一半和后一半均值的差'
,6m_repay_amt_first_der_mean_diff string comment '近6个月应还金额一阶导数前一半和后一半均值的差'
,12m_repay_amt_first_der_mean_diff string comment '近12个月应还金额一阶导数前一半和后一半均值的差'
,18m_repay_amt_first_der_mean_diff string comment '近18个月应还金额一阶导数前一半和后一半均值的差'
,3m_repay_amt_first_der_mean_rto string comment '近3个月应还金额一阶导数前一半和后一半均值的比值'
,6m_repay_amt_first_der_mean_rto string comment '近6个月应还金额一阶导数前一半和后一半均值的比值'
,12m_repay_amt_first_der_mean_rto string comment '近12个月应还金额一阶导数前一半和后一半均值的比值'
,18m_repay_amt_first_der_mean_rto string comment '近18个月应还金额一阶导数前一半和后一半均值的比值'

,3m_repay_amt_second_der_max string comment '近3个月应还金额二阶导数的最大值'
,6m_repay_amt_second_der_max string comment '近6个月应还金额二阶导数的最大值'
,12m_repay_amt_second_der_max string comment '近12个月应还金额二阶导数的最大值'
,18m_repay_amt_second_der_max string comment '近18个月应还金额二阶导数的最大值'
,3m_repay_amt_second_der_min string comment '近3个月应还金额二阶导数的最小值'
,6m_repay_amt_second_der_min string comment '近6个月应还金额二阶导数的最小值'
,12m_repay_amt_second_der_min string comment '近12个月应还金额二阶导数的最小值'
,18m_repay_amt_second_der_min string comment '近18个月应还金额二阶导数的最小值'
,3m_repay_amt_second_der_avg string comment '近3个月应还金额二阶导数的平均值'
,6m_repay_amt_second_der_avg string comment '近6个月应还金额二阶导数的平均值'
,12m_repay_amt_second_der_avg string comment '近12个月应还金额二阶导数的平均值'
,18m_repay_amt_second_der_avg string comment '近18个月应还金额二阶导数的平均值'
,3m_repay_amt_second_der_median string comment '近3个月应还金额二阶导数的中位数'
,6m_repay_amt_second_der_median string comment '近6个月应还金额二阶导数的中位数'
,12m_repay_amt_second_der_median string comment '近12个月应还金额二阶导数的中位数'
,18m_repay_amt_second_der_median string comment '近18个月应还金额二阶导数的中位数'
,3m_repay_amt_second_der_stddev string comment '近3个月应还金额二阶导数的标准差'
,6m_repay_amt_second_der_stddev string comment '近6个月应还金额二阶导数的标准差'
,12m_repay_amt_second_der_stddev string comment '近12个月应还金额二阶导数的标准差'
,18m_repay_amt_second_der_stddev string comment '近18个月应还金额二阶导数的标准差'
,3m_repay_amt_second_der_sum string comment '近3个月应还金额二阶导数的和'
,6m_repay_amt_second_der_sum string comment '近6个月应还金额二阶导数的和'
,12m_repay_amt_second_der_sum string comment '近12个月应还金额二阶导数的和'
,18m_repay_amt_second_der_sum string comment '近18个月应还金额二阶导数的和'
,3m_repay_amt_second_der_great_0_count string comment '近3个月应还金额二阶导数大于0的次数'
,6m_repay_amt_second_der_great_0_count string comment '近6个月应还金额二阶导数大于0的次数'
,12m_repay_amt_second_der_great_0_count string comment '近12个月应还金额二阶导数大于0的次数'
,18m_repay_amt_second_der_great_0_count string comment '近18个月应还金额二阶导数大于0的次数'
,3m_repay_amt_second_der_great_0_sum string comment '近3个月应还金额二阶导数大于0的和'
,6m_repay_amt_second_der_great_0_sum string comment '近6个月应还金额二阶导数大于0的和'
,12m_repay_amt_second_der_great_0_sum string comment '近12个月应还金额二阶导数大于0的和'
,18m_repay_amt_second_der_great_0_sum string comment '近18个月应还金额二阶导数大于0的和'
,3m_repay_amt_second_der_small_0_count string comment '近3个月应还金额二阶导数小于0的次数'
,6m_repay_amt_second_der_small_0_count string comment '近6个月应还金额二阶导数小于0的次数'
,12m_repay_amt_second_der_small_0_count string comment '近12个月应还金额二阶导数小于0的次数'
,18m_repay_amt_second_der_small_0_count string comment '近18个月应还金额二阶导数小于0的次数'
,3m_repay_amt_second_der_small_0_sum string comment '近3个月应还金额二阶导数小于0的和'
,6m_repay_amt_second_der_small_0_sum string comment '近6个月应还金额二阶导数小于0的和'
,12m_repay_amt_second_der_small_0_sum string comment '近12个月应还金额二阶导数小于0的和'
,18m_repay_amt_second_der_small_0_sum string comment '近18个月应还金额二阶导数小于0的和'
,3m_repay_amt_second_der_mean_diff string comment '近3个月应还金额二阶导数前一半和后一半均值的差'
,6m_repay_amt_second_der_mean_diff string comment '近6个月应还金额二阶导数前一半和后一半均值的差'
,12m_repay_amt_second_der_mean_diff string comment '近12个月应还金额二阶导数前一半和后一半均值的差'
,18m_repay_amt_second_der_mean_diff string comment '近18个月应还金额二阶导数前一半和后一半均值的差'
,3m_repay_amt_second_der_mean_rto string comment '近3个月应还金额二阶导数前一半和后一半均值的比值'
,6m_repay_amt_second_der_mean_rto string comment '近6个月应还金额二阶导数前一半和后一半均值的比值'
,12m_repay_amt_second_der_mean_rto string comment '近12个月应还金额二阶导数前一半和后一半均值的比值'
,18m_repay_amt_second_der_mean_rto string comment '近18个月应还金额二阶导数前一半和后一半均值的比值'

,6m_con_asc_repay_max string comment '近6个月应还金额连续上升次数的最大次数'
,6m_con_dsc_repay_max string comment '近6个月应还金额连续下降次数的最大次数'
,6m_con_keep_repay_max string comment '近6个月应还金额连续持平次数的最大次数'
,9m_con_asc_repay_max string comment '近9个月应还金额连续上升次数的最大次数'
,9m_con_dsc_repay_max string comment '近9个月应还金额连续下降次数的最大次数'
,9m_con_keep_repay_max string comment '近9个月应还金额连续持平次数的最大次数'
,12m_con_asc_repay_max string comment '近12个月应还金额连续上升次数的最大次数'
,12m_con_dsc_repay_max string comment '近12个月应还金额连续下降次数的最大次数'
,12m_con_keep_repay_max string comment '近12个月应还金额连续持平次数的最大次数'
,18m_con_asc_repay_max string comment '近18个月应还金额连续上升次数的最大次数'
,18m_con_dsc_repay_max string comment '近18个月应还金额连续下降次数的最大次数'
,18m_con_keep_repay_max string comment '近18个月应还金额连续持平次数的最大次数'

,3stg_pln_repay_amt_first_der_max string comment '近3笔分期订单应还金额一阶导数的最大值'
,6stg_pln_repay_amt_first_der_max string comment '近6笔分期订单应还金额一阶导数的最大值'
,12stg_pln_repay_amt_first_der_max string comment '近12笔分期订单应还金额一阶导数的最大值'
,18stg_pln_repay_amt_first_der_max string comment '近18笔分期订单应还金额一阶导数的最大值'
,24stg_pln_repay_amt_first_der_max string comment '近24笔分期订单应还金额一阶导数的最大值'
,30stg_pln_repay_amt_first_der_max string comment '近30笔分期订单应还金额一阶导数的最大值'
,36stg_pln_repay_amt_first_der_max string comment '近36笔分期订单应还金额一阶导数的最大值'
,3stg_pln_repay_amt_first_der_min string comment '近3笔分期订单应还金额一阶导数的最小值'
,6stg_pln_repay_amt_first_der_min string comment '近6笔分期订单应还金额一阶导数的最小值'
,12stg_pln_repay_amt_first_der_min string comment '近12笔分期订单应还金额一阶导数的最小值'
,18stg_pln_repay_amt_first_der_min string comment '近18笔分期订单应还金额一阶导数的最小值'
,24stg_pln_repay_amt_first_der_min string comment '近24笔分期订单应还金额一阶导数的最小值'
,30stg_pln_repay_amt_first_der_min string comment '近30笔分期订单应还金额一阶导数的最小值'
,36stg_pln_repay_amt_first_der_min string comment '近36笔分期订单应还金额一阶导数的最小值'
,3stg_pln_repay_amt_first_der_avg string comment '近3笔分期订单应还金额一阶导数的平均值'
,6stg_pln_repay_amt_first_der_avg string comment '近6笔分期订单应还金额一阶导数的平均值'
,12stg_pln_repay_amt_first_der_avg string comment '近12笔分期订单应还金额一阶导数的平均值'
,18stg_pln_repay_amt_first_der_avg string comment '近18笔分期订单应还金额一阶导数的平均值'
,24stg_pln_repay_amt_first_der_avg string comment '近24笔分期订单应还金额一阶导数的平均值'
,30stg_pln_repay_amt_first_der_avg string comment '近30笔分期订单应还金额一阶导数的平均值'
,36stg_pln_repay_amt_first_der_avg string comment '近36笔分期订单应还金额一阶导数的平均值'
,3stg_pln_repay_amt_first_der_median string comment '近3笔分期订单应还金额一阶导数的中位数'
,6stg_pln_repay_amt_first_der_median string comment '近6笔分期订单应还金额一阶导数的中位数'
,12stg_pln_repay_amt_first_der_median string comment '近12笔分期订单应还金额一阶导数的中位数'
,18stg_pln_repay_amt_first_der_median string comment '近18笔分期订单应还金额一阶导数的中位数'
,24stg_pln_repay_amt_first_der_median string comment '近24笔分期订单应还金额一阶导数的中位数'
,30stg_pln_repay_amt_first_der_median string comment '近30笔分期订单应还金额一阶导数的中位数'
,36stg_pln_repay_amt_first_der_median string comment '近36笔分期订单应还金额一阶导数的中位数'
,3stg_pln_repay_amt_first_der_stddev string comment '近3笔分期订单应还金额一阶导数的标准差'
,6stg_pln_repay_amt_first_der_stddev string comment '近6笔分期订单应还金额一阶导数的标准差'
,12stg_pln_repay_amt_first_der_stddev string comment '近12笔分期订单应还金额一阶导数的标准差'
,18stg_pln_repay_amt_first_der_stddev string comment '近18笔分期订单应还金额一阶导数的标准差'
,24stg_pln_repay_amt_first_der_stddev string comment '近6笔分期订单应还金额一阶导数的标准差'
,30stg_pln_repay_amt_first_der_stddev string comment '近12笔分期订单应还金额一阶导数的标准差'
,36stg_pln_repay_amt_first_der_stddev string comment '近18笔分期订单应还金额一阶导数的标准差'
,3stg_pln_repay_amt_first_der_sum string comment '近3笔分期订单应还金额一阶导数的和'
,6stg_pln_repay_amt_first_der_sum string comment '近6笔分期订单应还金额一阶导数的和'
,12stg_pln_repay_amt_first_der_sum string comment '近12笔分期订单应还金额一阶导数的和'
,18stg_pln_repay_amt_first_der_sum string comment '近18笔分期订单应还金额一阶导数的和'
,24stg_pln_repay_amt_first_der_sum string comment '近24笔分期订单应还金额一阶导数的和'
,30stg_pln_repay_amt_first_der_sum string comment '近30笔分期订单应还金额一阶导数的和'
,36stg_pln_repay_amt_first_der_sum string comment '近46笔分期订单应还金额一阶导数的和'
,3stg_pln_repay_amt_first_der_great_0_count string comment '近3笔分期订单应还金额一阶导数大于0的次数'
,6stg_pln_repay_amt_first_der_great_0_count string comment '近6笔分期订单应还金额一阶导数大于0的次数'
,12stg_pln_repay_amt_first_der_great_0_count string comment '近12笔分期订单应还金额一阶导数大于0的次数'
,18stg_pln_repay_amt_first_der_great_0_count string comment '近18笔分期订单应还金额一阶导数大于0的次数'
,24stg_pln_repay_amt_first_der_great_0_count string comment '近24笔分期订单应还金额一阶导数大于0的次数'
,30stg_pln_repay_amt_first_der_great_0_count string comment '近30笔分期订单应还金额一阶导数大于0的次数'
,36stg_pln_repay_amt_first_der_great_0_count string comment '近36笔分期订单应还金额一阶导数大于0的次数'
,3stg_pln_repay_amt_first_der_great_0_sum string comment '近3笔分期订单应还金额一阶导数大于0的和'
,6stg_pln_repay_amt_first_der_great_0_sum string comment '近6笔分期订单应还金额一阶导数大于0的和'
,12stg_pln_repay_amt_first_der_great_0_sum string comment '近12笔分期订单应还金额一阶导数大于0的和'
,18stg_pln_repay_amt_first_der_great_0_sum string comment '近18笔分期订单应还金额一阶导数大于0的和'
,24stg_pln_repay_amt_first_der_great_0_sum string comment '近24笔分期订单应还金额一阶导数大于0的和'
,30stg_pln_repay_amt_first_der_great_0_sum string comment '近30笔分期订单应还金额一阶导数大于0的和'
,36stg_pln_repay_amt_first_der_great_0_sum string comment '近36笔分期订单应还金额一阶导数大于0的和'
,3stg_pln_repay_amt_first_der_small_0_count string comment '近3笔分期订单应还金额一阶导数小于0的次数'
,6stg_pln_repay_amt_first_der_small_0_count string comment '近6笔分期订单应还金额一阶导数小于0的次数'
,12stg_pln_repay_amt_first_der_small_0_count string comment '近12笔分期订单应还金额一阶导数小于0的次数'
,18stg_pln_repay_amt_first_der_small_0_count string comment '近18笔分期订单应还金额一阶导数小于0的次数'
,24stg_pln_repay_amt_first_der_small_0_count string comment '近24笔分期订单应还金额一阶导数小于0的次数'
,30stg_pln_repay_amt_first_der_small_0_count string comment '近30笔分期订单应还金额一阶导数小于0的次数'
,36stg_pln_repay_amt_first_der_small_0_count string comment '近36笔分期订单应还金额一阶导数小于0的次数'
,3stg_pln_repay_amt_first_der_small_0_sum string comment '近3笔分期订单应还金额一阶导数小于0的和'
,6stg_pln_repay_amt_first_der_small_0_sum string comment '近6笔分期订单应还金额一阶导数小于0的和'
,12stg_pln_repay_amt_first_der_small_0_sum string comment '近12笔分期订单应还金额一阶导数小于0的和'
,18stg_pln_repay_amt_first_der_small_0_sum string comment '近18笔分期订单应还金额一阶导数小于0的和'
,24stg_pln_repay_amt_first_der_small_0_sum string comment '近24笔分期订单应还金额一阶导数小于0的和'
,30stg_pln_repay_amt_first_der_small_0_sum string comment '近30笔分期订单应还金额一阶导数小于0的和'
,36stg_pln_repay_amt_first_der_small_0_sum string comment '近36笔分期订单应还金额一阶导数小于0的和'
,3stg_pln_repay_amt_first_der_mean_diff string comment '近3笔分期订单应还金额一阶导数前一半和后一半均值的差'
,6stg_pln_repay_amt_first_der_mean_diff string comment '近6笔分期订单应还金额一阶导数前一半和后一半均值的差'
,12stg_pln_repay_amt_first_der_mean_diff string comment '近12笔分期订单应还金额一阶导数前一半和后一半均值的差'
,18stg_pln_repay_amt_first_der_mean_diff string comment '近18笔分期订单应还金额一阶导数前一半和后一半均值的差'
,24stg_pln_repay_amt_first_der_mean_diff string comment '近24笔分期订单应还金额一阶导数前一半和后一半均值的差'
,30stg_pln_repay_amt_first_der_mean_diff string comment '近30笔分期订单应还金额一阶导数前一半和后一半均值的差'
,36stg_pln_repay_amt_first_der_mean_diff string comment '近36笔分期订单应还金额一阶导数前一半和后一半均值的差'
,3stg_pln_repay_amt_first_der_mean_rto string comment '近3笔分期订单应还金额一阶导数前一半和后一半均值的比值'
,6stg_pln_repay_amt_first_der_mean_rto string comment '近6笔分期订单应还金额一阶导数前一半和后一半均值的比值'
,12stg_pln_repay_amt_first_der_mean_rto string comment '近12笔分期订单应还金额一阶导数前一半和后一半均值的比值'
,18stg_pln_repay_amt_first_der_mean_rto string comment '近18笔分期订单应还金额一阶导数前一半和后一半均值的比值'
,24stg_pln_repay_amt_first_der_mean_rto string comment '近24笔分期订单应还金额一阶导数前一半和后一半均值的比值'
,30stg_pln_repay_amt_first_der_mean_rto string comment '近30笔分期订单应还金额一阶导数前一半和后一半均值的比值'
,36stg_pln_repay_amt_first_der_mean_rto string comment '近36笔分期订单应还金额一阶导数前一半和后一半均值的比值'

,3stg_pln_repay_amt_second_der_max string comment '近3笔分期订单应还金额二阶导数的最大值'
,6stg_pln_repay_amt_second_der_max string comment '近6笔分期订单应还金额二阶导数的最大值'
,12stg_pln_repay_amt_second_der_max string comment '近12笔分期订单应还金额二阶导数的最大值'
,18stg_pln_repay_amt_second_der_max string comment '近18笔分期订单应还金额二阶导数的最大值'
,24stg_pln_repay_amt_second_der_max string comment '近24笔分期订单应还金额二阶导数的最大值'
,30stg_pln_repay_amt_second_der_max string comment '近30笔分期订单应还金额二阶导数的最大值'
,36stg_pln_repay_amt_second_der_max string comment '近36笔分期订单应还金额二阶导数的最大值'
,3stg_pln_repay_amt_second_der_min string comment '近3笔分期订单应还金额二阶导数的最小值'
,6stg_pln_repay_amt_second_der_min string comment '近6笔分期订单应还金额二阶导数的最小值'
,12stg_pln_repay_amt_second_der_min string comment '近12笔分期订单应还金额二阶导数的最小值'
,18stg_pln_repay_amt_second_der_min string comment '近18笔分期订单应还金额二阶导数的最小值'
,24stg_pln_repay_amt_second_der_min string comment '近24笔分期订单应还金额二阶导数的最小值'
,30stg_pln_repay_amt_second_der_min string comment '近30笔分期订单应还金额二阶导数的最小值'
,36stg_pln_repay_amt_second_der_min string comment '近36笔分期订单应还金额二阶导数的最小值'
,3stg_pln_repay_amt_second_der_avg string comment '近3笔分期订单应还金额二阶导数的平均值'
,6stg_pln_repay_amt_second_der_avg string comment '近6笔分期订单应还金额二阶导数的平均值'
,12stg_pln_repay_amt_second_der_avg string comment '近12笔分期订单应还金额二阶导数的平均值'
,18stg_pln_repay_amt_second_der_avg string comment '近18笔分期订单应还金额二阶导数的平均值'
,24stg_pln_repay_amt_second_der_avg string comment '近24笔分期订单应还金额二阶导数的平均值'
,30stg_pln_repay_amt_second_der_avg string comment '近30笔分期订单应还金额二阶导数的平均值'
,36stg_pln_repay_amt_second_der_avg string comment '近36笔分期订单应还金额二阶导数的平均值'
,3stg_pln_repay_amt_second_der_median string comment '近3笔分期订单应还金额二阶导数的中位数'
,6stg_pln_repay_amt_second_der_median string comment '近6笔分期订单应还金额二阶导数的中位数'
,12stg_pln_repay_amt_second_der_median string comment '近12笔分期订单应还金额二阶导数的中位数'
,18stg_pln_repay_amt_second_der_median string comment '近18笔分期订单应还金额二阶导数的中位数'
,24stg_pln_repay_amt_second_der_median string comment '近24笔分期订单应还金额二阶导数的中位数'
,30stg_pln_repay_amt_second_der_median string comment '近30笔分期订单应还金额二阶导数的中位数'
,36stg_pln_repay_amt_second_der_median string comment '近36笔分期订单应还金额二阶导数的中位数'
,3stg_pln_repay_amt_second_der_stddev string comment '近3笔分期订单应还金额二阶导数的标准差'
,6stg_pln_repay_amt_second_der_stddev string comment '近6笔分期订单应还金额二阶导数的标准差'
,12stg_pln_repay_amt_second_der_stddev string comment '近12笔分期订单应还金额二阶导数的标准差'
,18stg_pln_repay_amt_second_der_stddev string comment '近18笔分期订单应还金额二阶导数的标准差'
,24stg_pln_repay_amt_second_der_stddev string comment '近6笔分期订单应还金额二阶导数的标准差'
,30stg_pln_repay_amt_second_der_stddev string comment '近12笔分期订单应还金额二阶导数的标准差'
,36stg_pln_repay_amt_second_der_stddev string comment '近18笔分期订单应还金额二阶导数的标准差'
,3stg_pln_repay_amt_second_der_sum string comment '近3笔分期订单应还金额二阶导数的和'
,6stg_pln_repay_amt_second_der_sum string comment '近6笔分期订单应还金额二阶导数的和'
,12stg_pln_repay_amt_second_der_sum string comment '近12笔分期订单应还金额二阶导数的和'
,18stg_pln_repay_amt_second_der_sum string comment '近18笔分期订单应还金额二阶导数的和'
,24stg_pln_repay_amt_second_der_sum string comment '近24笔分期订单应还金额二阶导数的和'
,30stg_pln_repay_amt_second_der_sum string comment '近30笔分期订单应还金额二阶导数的和'
,36stg_pln_repay_amt_second_der_sum string comment '近46笔分期订单应还金额二阶导数的和'
,3stg_pln_repay_amt_second_der_great_0_count string comment '近3笔分期订单应还金额二阶导数大于0的次数'
,6stg_pln_repay_amt_second_der_great_0_count string comment '近6笔分期订单应还金额二阶导数大于0的次数'
,12stg_pln_repay_amt_second_der_great_0_count string comment '近12笔分期订单应还金额二阶导数大于0的次数'
,18stg_pln_repay_amt_second_der_great_0_count string comment '近18笔分期订单应还金额二阶导数大于0的次数'
,24stg_pln_repay_amt_second_der_great_0_count string comment '近24笔分期订单应还金额二阶导数大于0的次数'
,30stg_pln_repay_amt_second_der_great_0_count string comment '近30笔分期订单应还金额二阶导数大于0的次数'
,36stg_pln_repay_amt_second_der_great_0_count string comment '近36笔分期订单应还金额二阶导数大于0的次数'
,3stg_pln_repay_amt_second_der_great_0_sum string comment '近3笔分期订单应还金额二阶导数大于0的和'
,6stg_pln_repay_amt_second_der_great_0_sum string comment '近6笔分期订单应还金额二阶导数大于0的和'
,12stg_pln_repay_amt_second_der_great_0_sum string comment '近12笔分期订单应还金额二阶导数大于0的和'
,18stg_pln_repay_amt_second_der_great_0_sum string comment '近18笔分期订单应还金额二阶导数大于0的和'
,24stg_pln_repay_amt_second_der_great_0_sum string comment '近24笔分期订单应还金额二阶导数大于0的和'
,30stg_pln_repay_amt_second_der_great_0_sum string comment '近30笔分期订单应还金额二阶导数大于0的和'
,36stg_pln_repay_amt_second_der_great_0_sum string comment '近36笔分期订单应还金额二阶导数大于0的和'
,3stg_pln_repay_amt_second_der_small_0_count string comment '近3笔分期订单应还金额二阶导数小于0的次数'
,6stg_pln_repay_amt_second_der_small_0_count string comment '近6笔分期订单应还金额二阶导数小于0的次数'
,12stg_pln_repay_amt_second_der_small_0_count string comment '近12笔分期订单应还金额二阶导数小于0的次数'
,18stg_pln_repay_amt_second_der_small_0_count string comment '近18笔分期订单应还金额二阶导数小于0的次数'
,24stg_pln_repay_amt_second_der_small_0_count string comment '近24笔分期订单应还金额二阶导数小于0的次数'
,30stg_pln_repay_amt_second_der_small_0_count string comment '近30笔分期订单应还金额二阶导数小于0的次数'
,36stg_pln_repay_amt_second_der_small_0_count string comment '近36笔分期订单应还金额二阶导数小于0的次数'
,3stg_pln_repay_amt_second_der_small_0_sum string comment '近3笔分期订单应还金额二阶导数小于0的和'
,6stg_pln_repay_amt_second_der_small_0_sum string comment '近6笔分期订单应还金额二阶导数小于0的和'
,12stg_pln_repay_amt_second_der_small_0_sum string comment '近12笔分期订单应还金额二阶导数小于0的和'
,18stg_pln_repay_amt_second_der_small_0_sum string comment '近18笔分期订单应还金额二阶导数小于0的和'
,24stg_pln_repay_amt_second_der_small_0_sum string comment '近24笔分期订单应还金额二阶导数小于0的和'
,30stg_pln_repay_amt_second_der_small_0_sum string comment '近30笔分期订单应还金额二阶导数小于0的和'
,36stg_pln_repay_amt_second_der_small_0_sum string comment '近36笔分期订单应还金额二阶导数小于0的和'
,3stg_pln_repay_amt_second_der_mean_diff string comment '近3笔分期订单应还金额二阶导数前一半和后一半均值的差'
,6stg_pln_repay_amt_second_der_mean_diff string comment '近6笔分期订单应还金额二阶导数前一半和后一半均值的差'
,12stg_pln_repay_amt_second_der_mean_diff string comment '近12笔分期订单应还金额二阶导数前一半和后一半均值的差'
,18stg_pln_repay_amt_second_der_mean_diff string comment '近18笔分期订单应还金额二阶导数前一半和后一半均值的差'
,24stg_pln_repay_amt_second_der_mean_diff string comment '近24笔分期订单应还金额二阶导数前一半和后一半均值的差'
,30stg_pln_repay_amt_second_der_mean_diff string comment '近30笔分期订单应还金额二阶导数前一半和后一半均值的差'
,36stg_pln_repay_amt_second_der_mean_diff string comment '近36笔分期订单应还金额二阶导数前一半和后一半均值的差'
,3stg_pln_repay_amt_second_der_mean_rto string comment '近3笔分期订单应还金额二阶导数前一半和后一半均值的比值'
,6stg_pln_repay_amt_second_der_mean_rto string comment '近6笔分期订单应还金额二阶导数前一半和后一半均值的比值'
,12stg_pln_repay_amt_second_der_mean_rto string comment '近12笔分期订单应还金额二阶导数前一半和后一半均值的比值'
,18stg_pln_repay_amt_second_der_mean_rto string comment '近18笔分期订单应还金额二阶导数前一半和后一半均值的比值'
,24stg_pln_repay_amt_second_der_mean_rto string comment '近24笔分期订单应还金额二阶导数前一半和后一半均值的比值'
,30stg_pln_repay_amt_second_der_mean_rto string comment '近30笔分期订单应还金额二阶导数前一半和后一半均值的比值'
,36stg_pln_repay_amt_second_der_mean_rto string comment '近36笔分期订单应还金额二阶导数前一半和后一半均值的比值'

,6thord_con_asc_repay_amt_max string comment '近6笔分期订单应还金额连续上升次数的最大次数'
,6thord_con_dsc_repay_amt_max string comment '近6笔分期订单应还金额连续下降次数的最大次数'
,6thord_con_keep_repay_amt_max string comment '近6笔分期订单应还金额连续持平次数的最大次数'
,12thord_con_asc_repay_amt_max string comment '近12笔分期订单应还金额连续上升次数的最大次数'
,12thord_con_dsc_repay_amt_max string comment '近12笔分期订单应还金额连续下降次数的最大次数'
,12thord_con_keep_repay_amt_max string comment '近12笔分期订单应还金额连续持平次数的最大次数'
,18thord_con_asc_repay_amt_max string comment '近18笔分期订单应还金额连续上升次数的最大次数'
,18thord_con_dsc_repay_amt_max string comment '近18笔分期订单应还金额连续下降次数的最大次数'
,18thord_con_keep_repay_amt_max string comment '近18笔分期订单应还金额连续持平次数的最大次数'
,24thord_con_asc_repay_amt_max string comment '近24笔分期订单应还金额连续上升次数的最大次数'
,24thord_con_dsc_repay_amt_max string comment '近24笔分期订单应还金额连续下降次数的最大次数'
,24thord_con_keep_repay_amt_max string comment '近24笔分期订单应还金额连续持平次数的最大次数'
,30thord_con_asc_repay_amt_max string comment '近30笔分期订单应还金额连续上升次数的最大次数'
,30thord_con_dsc_repay_amt_max string comment '近30笔分期订单应还金额连续下降次数的最大次数'
,30thord_con_keep_repay_amt_max string comment '近30笔分期订单应还金额连续持平次数的最大次数'
,36thord_con_asc_repay_amt_max string comment '近36笔分期订单应还金额连续上升次数的最大次数'
,36thord_con_dsc_repay_amt_max string comment '近36笔分期订单应还金额连续下降次数的最大次数'
,36thord_con_keep_repay_amt_max string comment '近36笔分期订单应还金额连续持平次数的最大次数'

,6thord_con_ontime_repay_max string comment '近6笔订单连续及时还款的最大次数'
,6thord_con_adv_repay_max string comment '近6笔订单连续提前还款的最大次数'
,6thord_con_late_repay_max string comment '近6笔订单连续逾期还款的最大次数'
,12thord_con_ontime_repay_max string comment '近12笔订单连续及时还款的最大次数'
,12thord_con_adv_repay_max string comment '近12笔订单连续提前还款的最大次数'
,12thord_con_late_repay_max string comment '近12笔订单连续逾期还款的最大次数'
,18thord_con_ontime_repay_max string comment '近18笔订单连续及时还款的最大次数'
,18thord_con_adv_repay_max string comment '近18笔订单连续提前还款的最大次数'
,18thord_con_late_repay_max string comment '近18笔订单连续逾期还款的最大次数'
,24thord_con_ontime_repay_max string comment '近24笔订单连续及时还款的最大次数'
,24thord_con_adv_repay_max string comment '近24笔订单连续提前还款的最大次数'
,24thord_con_late_repay_max string comment '近24笔订单连续逾期还款的最大次数'
) comment '贷中应还金额时间序列变量' partitioned by (ds string comment '业务日期分区，格式yyyymmdd');


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp1_${bizdate} as
select 
        uid
        ,rn
        ,sum(loan_original_principal) as loan_original_principal
from

(
    
    select 
            t1.uid
            ,crt_time
            ,due_date
            ,loan_original_principal
            ,(case when date(t2.due_date) > add_months(to_date(mdl_dte),-1) and date(t2.due_date) <=  add_months(to_date(mdl_dte),0) then 1
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-2) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-1) then 2
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-3) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-2) then 3
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-4) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-3) then 4
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-5) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-4) then 5
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-6) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-5) then 6
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-7) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-6) then 7
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-8) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-7) then 8
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-9) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-8) then 9
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-10) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-9) then 10
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-11) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-10) then 11
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-12) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-11) then 12
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-13) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-12) then 13
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-14) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-13) then 14
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-15) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-14) then 15
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-16) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-15) then 16
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-17) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-16) then 17
                    when date(t2.due_date) > add_months(to_date(mdl_dte),-18) and date(t2.due_date) <=  add_months(to_date(mdl_dte),-17) then 18
                    else null end ) as rn
        from 
        (
            select  uid,
                    date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
            from ${dwa_risk}.dwa_risk_f_dz_model_data_base

        ) t1
        left join 
        (
            select 
                uid
                ,order_no
                ,create_time as crt_time
                ,due_date 
                ,original_loan_principal as loan_original_principal
                from cdmx.cdmx_fct_heavy_stage_plan_df
                where   ds='${bizdate}'
                        and  original_stage_plan_status in ('S','A','U','X','O','E') 
                        and  due_date is not null
                        and  substr(order_no,1,2) in ('BT','CH','BL','HE')
                        and  date(due_date) <= date_add(to_date(ds, 'yyyymmdd'),0)
        ) t2
        on t1.uid = t2.uid and date(t2.due_date) >=  add_months(to_date(mdl_dte),-18) and date(t2.due_date) < date(t1.mdl_dte) 
) where rn is not null 
group by uid, rn
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate}  as
select 
        uid
        ,rn
        ,first_derivative
        ,first_derivative - previous_first_derivative as second_derivative
        from  
        (
                select 
                                uid
                                ,rn
                                ,first_derivative
                                ,lead(first_derivative,1,null) over (partition by uid order by rn asc) as previous_first_derivative
                        from 
                        (
                                select 
                                        uid
                                        ,rn
                                        ,loan_original_principal -  previous_loan_original_principal as first_derivative
                                        from
                                        (
                                                select 
                                                    uid
                                                    ,rn
                                                    ,loan_original_principal
                                                    ,lead(loan_original_principal,1,null) over (partition by uid order by rn asc) as previous_loan_original_principal
                                                
                                                    from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp1_${bizdate}

                                        )
                        )
        )
;
drop table if EXISTS ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part1_${bizdate}  as
select   
        uid
        ,max( case when rn <= 3 then first_derivative else null end) as 3m_repay_amt_first_der_max
        ,max( case when rn <= 6 then first_derivative else null end) as 6m_repay_amt_first_der_max
        ,max( case when rn <= 12 then first_derivative else null end) as 12m_repay_amt_first_der_max
        ,max( case when rn <= 18 then first_derivative else null end) as 18m_repay_amt_first_der_max

        ,min( case when rn <= 3 then first_derivative else null end) as 3m_repay_amt_first_der_min
        ,min( case when rn <= 6 then first_derivative else null end) as 6m_repay_amt_first_der_min
        ,min( case when rn <= 12 then first_derivative else null end) as 12m_repay_amt_first_der_min
        ,min( case when rn <= 18 then first_derivative else null end) as 18m_repay_amt_first_der_min

        ,avg( case when rn <= 3 then first_derivative else null end) as 3m_repay_amt_first_der_avg
        ,avg( case when rn <= 6 then first_derivative else null end) as 6m_repay_amt_first_der_avg
        ,avg( case when rn <= 12 then first_derivative else null end) as 12m_repay_amt_first_der_avg
        ,avg( case when rn <= 18 then first_derivative else null end) as 18m_repay_amt_first_der_avg

        ,median( case when rn <= 3 then first_derivative else null end) as 3m_repay_amt_first_der_median
        ,median( case when rn <= 6 then first_derivative else null end) as 6m_repay_amt_first_der_median
        ,median( case when rn <= 12 then first_derivative else null end) as 12m_repay_amt_first_der_median
        ,median( case when rn <= 18 then first_derivative else null end) as 18m_repay_amt_first_der_median

        ,stddev( case when rn <= 3 then first_derivative else null end) as 3m_repay_amt_first_der_stddev
        ,stddev( case when rn <= 6 then first_derivative else null end) as 6m_repay_amt_first_der_stddev
        ,stddev( case when rn <= 12 then first_derivative else null end) as 12m_repay_amt_first_der_stddev
        ,stddev( case when rn <= 18 then first_derivative else null end) as 18m_repay_amt_first_der_stddev

        ,sum( case when rn <= 3 then first_derivative else null end) as 3m_repay_amt_first_der_sum
        ,sum( case when rn <= 6 then first_derivative else null end) as 6m_repay_amt_first_der_sum
        ,sum( case when rn <= 12 then first_derivative else null end) as 12m_repay_amt_first_der_sum
        ,sum( case when rn <= 18 then first_derivative else null end) as 18m_repay_amt_first_der_sum

        ,count( case when rn <= 3 and first_derivative > 0 then 1 else null end) as 3m_repay_amt_first_der_great_0_count
        ,count( case when rn <= 6 and first_derivative > 0 then 1 else null end) as 6m_repay_amt_first_der_great_0_count
        ,count( case when rn <= 12 and first_derivative > 0 then 1 else null end) as 12m_repay_amt_first_der_great_0_count
        ,count( case when rn <= 18 and first_derivative > 0 then 1 else null end) as 18m_repay_amt_first_der_great_0_count

        ,sum( case when rn <= 3 and first_derivative > 0 then first_derivative else null end) as 3m_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 6 and first_derivative > 0 then first_derivative else null end) as 6m_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 12 and first_derivative > 0 then first_derivative else null end) as 12m_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 18 and first_derivative > 0 then first_derivative else null end) as 18m_repay_amt_first_der_great_0_sum

        ,count( case when rn <= 3 and first_derivative < 0 then 1 else null end) as 3m_repay_amt_first_der_small_0_count
        ,count( case when rn <= 6 and first_derivative < 0 then 1 else null end) as 6m_repay_amt_first_der_small_0_count
        ,count( case when rn <= 12 and first_derivative < 0 then 1 else null end) as 12m_repay_amt_first_der_small_0_count
        ,count( case when rn <= 18 and first_derivative < 0 then 1 else null end) as 18m_repay_amt_first_der_small_0_count

        ,sum( case when rn <= 3 and first_derivative < 0 then first_derivative else null end) as 3m_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 6 and first_derivative < 0 then first_derivative else null end) as 6m_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 12 and first_derivative < 0 then first_derivative else null end) as 12m_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 18 and first_derivative < 0 then first_derivative else null end) as 18m_repay_amt_first_der_small_0_sum

        ,avg(case when rn <= 1 then first_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then first_derivative else 0 end) 
            as 3m_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 3 then first_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then first_derivative else 0 end) 
            as 6m_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 6 then first_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then first_derivative else 0 end) 
            as 12m_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 9 then first_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then first_derivative else 0 end) 
            as 18m_repay_amt_first_der_mean_diff

        ,avg(case when rn <= 1 then first_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then first_derivative else null end) 
            as 3m_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 3 then first_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then first_derivative else null end) 
            as 6m_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 6 then first_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then first_derivative else null end) 
            as 12m_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 9 then first_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then first_derivative else null end) 
            as 18m_repay_amt_first_der_mean_rto

        -- second derivative 
        ,max( case when rn <= 3 then second_derivative else null end) as 3m_repay_amt_second_der_max
        ,max( case when rn <= 6 then second_derivative else null end) as 6m_repay_amt_second_der_max
        ,max( case when rn <= 12 then second_derivative else null end) as 12m_repay_amt_second_der_max
        ,max( case when rn <= 18 then second_derivative else null end) as 18m_repay_amt_second_der_max

        ,min( case when rn <= 3 then second_derivative else null end) as 3m_repay_amt_second_der_min
        ,min( case when rn <= 6 then second_derivative else null end) as 6m_repay_amt_second_der_min
        ,min( case when rn <= 12 then second_derivative else null end) as 12m_repay_amt_second_der_min
        ,min( case when rn <= 18 then second_derivative else null end) as 18m_repay_amt_second_der_min

        ,avg( case when rn <= 3 then second_derivative else null end) as 3m_repay_amt_second_der_avg
        ,avg( case when rn <= 6 then second_derivative else null end) as 6m_repay_amt_second_der_avg
        ,avg( case when rn <= 12 then second_derivative else null end) as 12m_repay_amt_second_der_avg
        ,avg( case when rn <= 18 then second_derivative else null end) as 18m_repay_amt_second_der_avg

        ,median( case when rn <= 3 then second_derivative else null end) as 3m_repay_amt_second_der_median
        ,median( case when rn <= 6 then second_derivative else null end) as 6m_repay_amt_second_der_median
        ,median( case when rn <= 12 then second_derivative else null end) as 12m_repay_amt_second_der_median
        ,median( case when rn <= 18 then second_derivative else null end) as 18m_repay_amt_second_der_median

        ,stddev( case when rn <= 3 then second_derivative else null end) as 3m_repay_amt_second_der_stddev
        ,stddev( case when rn <= 6 then second_derivative else null end) as 6m_repay_amt_second_der_stddev
        ,stddev( case when rn <= 12 then second_derivative else null end) as 12m_repay_amt_second_der_stddev
        ,stddev( case when rn <= 18 then second_derivative else null end) as 18m_repay_amt_second_der_stddev

        ,sum( case when rn <= 3 then second_derivative else null end) as 3m_repay_amt_second_der_sum
        ,sum( case when rn <= 6 then second_derivative else null end) as 6m_repay_amt_second_der_sum
        ,sum( case when rn <= 12 then second_derivative else null end) as 12m_repay_amt_second_der_sum
        ,sum( case when rn <= 18 then second_derivative else null end) as 18m_repay_amt_second_der_sum

        ,count( case when rn <= 3 and second_derivative > 0 then 1 else null end) as 3m_repay_amt_second_der_great_0_count
        ,count( case when rn <= 6 and second_derivative > 0 then 1 else null end) as 6m_repay_amt_second_der_great_0_count
        ,count( case when rn <= 12 and second_derivative > 0 then 1 else null end) as 12m_repay_amt_second_der_great_0_count
        ,count( case when rn <= 18 and second_derivative > 0 then 1 else null end) as 18m_repay_amt_second_der_great_0_count

        ,sum( case when rn <= 3 and second_derivative > 0 then second_derivative else null end) as 3m_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 6 and second_derivative > 0 then second_derivative else null end) as 6m_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 12 and second_derivative > 0 then second_derivative else null end) as 12m_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 18 and second_derivative > 0 then second_derivative else null end) as 18m_repay_amt_second_der_great_0_sum

        ,count( case when rn <= 3 and second_derivative < 0 then 1 else null end) as 3m_repay_amt_second_der_small_0_count
        ,count( case when rn <= 6 and second_derivative < 0 then 1 else null end) as 6m_repay_amt_second_der_small_0_count
        ,count( case when rn <= 12 and second_derivative < 0 then 1 else null end) as 12m_repay_amt_second_der_small_0_count
        ,count( case when rn <= 18 and second_derivative < 0 then 1 else null end) as 18m_repay_amt_second_der_small_0_count

        ,sum( case when rn <= 3 and second_derivative < 0 then second_derivative else null end) as 3m_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 6 and second_derivative < 0 then second_derivative else null end) as 6m_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 12 and second_derivative < 0 then second_derivative else null end) as 12m_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 18 and second_derivative < 0 then second_derivative else null end) as 18m_repay_amt_second_der_small_0_sum

        ,avg(case when rn <= 1 then second_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then second_derivative else 0 end) 
            as 3m_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 3 then second_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then second_derivative else 0 end) 
            as 6m_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 6 then second_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then second_derivative else 0 end) 
            as 12m_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 9 then second_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then second_derivative else 0 end) 
            as 18m_repay_amt_second_der_mean_diff

        ,avg(case when rn <= 1 then second_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then second_derivative else null end) 
            as 3m_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 3 then second_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then second_derivative else null end) 
            as 6m_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 6 then second_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then second_derivative else null end) 
            as 12m_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 9 then second_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then second_derivative else null end) 
            as 18m_repay_amt_second_der_mean_rto



from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate}
group by uid;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part2_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part2_${bizdate} as
        select 
                t1.uid
                ,6m_con_asc_repay_max
                ,6m_con_dsc_repay_max
                ,6m_con_keep_repay_max
                ,9m_con_asc_repay_max
                ,9m_con_dsc_repay_max
                ,9m_con_keep_repay_max     
                ,12m_con_asc_repay_max
                ,12m_con_dsc_repay_max
                ,12m_con_keep_repay_max
                ,18m_con_asc_repay_max
                ,18m_con_dsc_repay_max
                ,18m_con_keep_repay_max      
        from
        (    
                select uid
                        ,max(case when repay_status = 1 then times else 0 end) as 6m_con_asc_repay_max
                        ,max(case when repay_status = 0 then times else 0 end) as 6m_con_dsc_repay_max
                        ,max(case when repay_status = 3 then times else 0 end) as 6m_con_keep_repay_max
                 from 
                (
                        select count(uid) as times, repay_status, uid
                        from 
                            (
                                select repay_status,
                                        uid,
                                        rn,
                                        row_number() over (partition by uid, repay_status order by rn) as row1,
                                        row_number() over (partition by uid order by rn) as row2
                                        from 
                                        (
                                                select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate}
                                                where rn <= 6
                                        )
                
                            ) group by uid, row2-row1, repay_status
                )
                group by uid
        ) t1 
        left join  
        (
                select uid
                        ,max(case when repay_status = 1 then times else 0 end) as 9m_con_asc_repay_max
                        ,max(case when repay_status = 0 then times else 0 end) as 9m_con_dsc_repay_max
                        ,max(case when repay_status = 3 then times else 0 end) as 9m_con_keep_repay_max
                 from 
                (
                        select count(uid) as times, repay_status, uid
                        from 
                            (
                                select repay_status,
                                        uid,
                                        rn,
                                        row_number() over (partition by uid, repay_status order by rn) as row1,
                                        row_number() over (partition by uid order by rn) as row2
                                        from 
                                        (
                                                select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate}
                                                where rn <= 9
                                        )
                
                            ) group by uid, row2-row1, repay_status
                )
                group by uid
        ) t2
        on t1.uid = t2.uid

        left JOIN 

        (
                select uid
                        ,max(case when repay_status = 1 then times else 0 end) as 12m_con_asc_repay_max
                        ,max(case when repay_status = 0 then times else 0 end) as 12m_con_dsc_repay_max
                        ,max(case when repay_status = 3 then times else 0 end) as 12m_con_keep_repay_max
                 from 
                (
                        select count(uid) as times, repay_status, uid
                        from 
                            (
                                select repay_status,
                                        uid,
                                        rn,
                                        row_number() over (partition by uid, repay_status order by rn) as row1,
                                        row_number() over (partition by uid order by rn) as row2
                                        from 
                                        (
                                                select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate}
                                                where rn <= 12
                                        )
                
                            ) group by uid, row2-row1, repay_status
                )
                group by uid
        ) t3
        on t1.uid = t3.uid

        left JOIN 

        (
            select uid
                    ,max(case when repay_status = 1 then times else 0 end) as 18m_con_asc_repay_max
                    ,max(case when repay_status = 0 then times else 0 end) as 18m_con_dsc_repay_max
                    ,max(case when repay_status = 3 then times else 0 end) as 18m_con_keep_repay_max
             from 
            (
                    select count(uid) as times, repay_status, uid
                    from 
                        (
                            select repay_status,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from 
                                    (
                                            select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                            from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate}
                                            where rn <= 18
                                    )
            
                        ) group by uid, row2-row1, repay_status
            )
            group by uid
        ) t4
        on t1.uid = t4.uid
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp1_${bizdate} as

select 
        uid
        ,rn
        ,due_date
        ,loan_original_principal
from 
(
    select uid, mdl_dte, due_date, coalesce(sum(loan_original_principal),0) as loan_original_principal,
            row_number() over (partition by uid, mdl_dte order by due_date desc) as rn   
        from 
        (
                select 
                    t1.mdl_dte
                    ,t1.uid
                    ,t3.loan_original_principal
                    ,crt_time
                    ,due_date
                    
                from  
                (
                    select  uid,
                            date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                    from ${dwa_risk}.dwa_risk_f_dz_model_data_base
    
                ) t1  -- 样本
                left join 
                (
                        select 
                                uid
                                ,order_no
                                ,create_time as crt_time
                                ,due_date
                                ,original_loan_principal as loan_original_principal
                                ,stage_plan_no
                        from    cdmx.cdmx_fct_heavy_stage_plan_df
                        where   ds='${bizdate}'
                                and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                and  due_date is not null
                                and  substr(order_no,1,2) in ('BT','CH','BL','HE')
                                and  date(due_date) <= date_add(to_date(ds, 'yyyymmdd'),0)
    
        
                ) t3  -- stage_plan
                on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-18) and date(t3.due_date) < date(t1.mdl_dte) 
        ) group by uid, mdl_dte, due_date
) where rn <= 36;


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate} as
select 
        uid
        ,rn
        ,first_derivative
        ,(first_derivative - previous_first_derivative) / DATEDIFF(due_date,previous_due_date) as second_derivative
        from  
        (
                select 
                                uid
                                ,rn
                                ,first_derivative
                                ,due_date
                                ,lead(first_derivative,1,null) over (partition by uid order by rn asc) as previous_first_derivative
                                ,lead(due_date,1,null) over (partition by uid order by rn asc) as previous_due_date
                        from 
                        (
                                select 
                                        uid
                                        ,rn
                                        ,(loan_original_principal -  previous_loan_original_principal) / DATEDIFF(due_date,previous_due_date) as first_derivative
                                        ,due_date
                                        from
                                        (
                                                select 
                                                        uid
                                                        ,rn
                                                        ,loan_original_principal
                                                        ,due_date
                                                        ,lead(loan_original_principal,1,null) over (partition by uid order by rn asc) as previous_loan_original_principal
                                                        ,lead(due_date,1,null) over (partition by uid order by rn asc) as previous_due_date               
                                                        from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp1_${bizdate}
                                        )
                        )
        )
;
drop table if EXISTS ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part3_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part3_${bizdate} as
select   
        uid
        ,max( case when rn <= 3 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_max
        ,max( case when rn <= 6 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_max
        ,max( case when rn <= 12 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_max
        ,max( case when rn <= 18 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_max
        ,max( case when rn <= 24 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_max
        ,max( case when rn <= 30 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_max
        ,max( case when rn <= 36 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_max

        ,min( case when rn <= 3 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_min
        ,min( case when rn <= 6 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_min
        ,min( case when rn <= 12 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_min
        ,min( case when rn <= 18 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_min
        ,min( case when rn <= 24 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_min
        ,min( case when rn <= 30 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_min
        ,min( case when rn <= 36 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_min

        ,avg( case when rn <= 3 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_avg
        ,avg( case when rn <= 6 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_avg
        ,avg( case when rn <= 12 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_avg
        ,avg( case when rn <= 18 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_avg
        ,avg( case when rn <= 24 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_avg
        ,avg( case when rn <= 30 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_avg
        ,avg( case when rn <= 36 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_avg

        ,median( case when rn <= 3 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_median
        ,median( case when rn <= 6 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_median
        ,median( case when rn <= 12 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_median
        ,median( case when rn <= 18 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_median
        ,median( case when rn <= 24 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_median
        ,median( case when rn <= 30 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_median
        ,median( case when rn <= 36 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_median

        ,stddev( case when rn <= 3 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_stddev
        ,stddev( case when rn <= 6 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_stddev
        ,stddev( case when rn <= 12 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_stddev
        ,stddev( case when rn <= 18 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_stddev
        ,stddev( case when rn <= 24 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_stddev
        ,stddev( case when rn <= 30 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_stddev
        ,stddev( case when rn <= 36 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_stddev

        ,sum( case when rn <= 3 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_sum
        ,sum( case when rn <= 6 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_sum
        ,sum( case when rn <= 12 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_sum
        ,sum( case when rn <= 18 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_sum
        ,sum( case when rn <= 24 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_sum
        ,sum( case when rn <= 30 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_sum
        ,sum( case when rn <= 36 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_sum


        ,count( case when rn <= 3 and first_derivative > 0 then 1 else null end) as 3stg_pln_repay_amt_first_der_great_0_count
        ,count( case when rn <= 6 and first_derivative > 0 then 1 else null end) as 6stg_pln_repay_amt_first_der_great_0_count
        ,count( case when rn <= 12 and first_derivative > 0 then 1 else null end) as 12stg_pln_repay_amt_first_der_great_0_count
        ,count( case when rn <= 18 and first_derivative > 0 then 1 else null end) as 18stg_pln_repay_amt_first_der_great_0_count
        ,count( case when rn <= 24 and first_derivative > 0 then 1 else null end) as 24stg_pln_repay_amt_first_der_great_0_count
        ,count( case when rn <= 30 and first_derivative > 0 then 1 else null end) as 30stg_pln_repay_amt_first_der_great_0_count
        ,count( case when rn <= 36 and first_derivative > 0 then 1 else null end) as 36stg_pln_repay_amt_first_der_great_0_count

        ,sum( case when rn <= 3 and first_derivative > 0 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 6 and first_derivative > 0 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 12 and first_derivative > 0 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 18 and first_derivative > 0 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 24 and first_derivative > 0 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 30 and first_derivative > 0 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_great_0_sum
        ,sum( case when rn <= 36 and first_derivative > 0 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_great_0_sum

        ,count( case when rn <= 3 and first_derivative < 0 then 1 else null end) as 3stg_pln_repay_amt_first_der_small_0_count
        ,count( case when rn <= 6 and first_derivative < 0 then 1 else null end) as 6stg_pln_repay_amt_first_der_small_0_count
        ,count( case when rn <= 12 and first_derivative < 0 then 1 else null end) as 12stg_pln_repay_amt_first_der_small_0_count
        ,count( case when rn <= 18 and first_derivative < 0 then 1 else null end) as 18stg_pln_repay_amt_first_der_small_0_count
        ,count( case when rn <= 24 and first_derivative < 0 then 1 else null end) as 24stg_pln_repay_amt_first_der_small_0_count
        ,count( case when rn <= 30 and first_derivative < 0 then 1 else null end) as 30stg_pln_repay_amt_first_der_small_0_count
        ,count( case when rn <= 36 and first_derivative < 0 then 1 else null end) as 36stg_pln_repay_amt_first_der_small_0_count

        ,sum( case when rn <= 3 and first_derivative < 0 then first_derivative else null end) as 3stg_pln_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 6 and first_derivative < 0 then first_derivative else null end) as 6stg_pln_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 12 and first_derivative < 0 then first_derivative else null end) as 12stg_pln_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 18 and first_derivative < 0 then first_derivative else null end) as 18stg_pln_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 24 and first_derivative < 0 then first_derivative else null end) as 24stg_pln_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 30 and first_derivative < 0 then first_derivative else null end) as 30stg_pln_repay_amt_first_der_small_0_sum
        ,sum( case when rn <= 36 and first_derivative < 0 then first_derivative else null end) as 36stg_pln_repay_amt_first_der_small_0_sum

        ,avg(case when rn <= 1 then first_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then first_derivative else 0 end) 
            as 3stg_pln_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 3 then first_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then first_derivative else 0 end) 
            as 6stg_pln_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 6 then first_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then first_derivative else 0 end) 
            as 12stg_pln_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 9 then first_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then first_derivative else 0 end) 
            as 18stg_pln_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 12 then first_derivative else 0 end) - avg(case when rn <= 24 and rn > 12 then first_derivative else 0 end) 
            as 24stg_pln_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 15 then first_derivative else 0 end) - avg(case when rn <= 30 and rn > 15 then first_derivative else 0 end) 
            as 30stg_pln_repay_amt_first_der_mean_diff
        ,avg(case when rn <= 18 then first_derivative else 0 end) - avg(case when rn <= 36 and rn > 18 then first_derivative else 0 end) 
            as 36stg_pln_repay_amt_first_der_mean_diff

        ,avg(case when rn <= 1 then first_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then first_derivative else null end) 
            as 3stg_pln_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 3 then first_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then first_derivative else null end) 
            as 6stg_pln_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 6 then first_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then first_derivative else null end) 
            as 12stg_pln_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 9 then first_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then first_derivative else null end) 
            as 18stg_pln_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 12 then first_derivative else 0 end) / avg(case when rn <= 24 and rn > 12 then first_derivative else null end) 
            as 24stg_pln_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 15 then first_derivative else 0 end) / avg(case when rn <= 30 and rn > 15 then first_derivative else null end) 
            as 30stg_pln_repay_amt_first_der_mean_rto
        ,avg(case when rn <= 18 then first_derivative else 0 end) / avg(case when rn <= 36 and rn > 18 then first_derivative else null end) 
            as 36stg_pln_repay_amt_first_der_mean_rto

        -- second derivative 
        ,max( case when rn <= 3 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_max
        ,max( case when rn <= 6 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_max
        ,max( case when rn <= 12 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_max
        ,max( case when rn <= 18 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_max
        ,max( case when rn <= 24 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_max
        ,max( case when rn <= 30 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_max
        ,max( case when rn <= 36 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_max

        ,min( case when rn <= 3 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_min
        ,min( case when rn <= 6 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_min
        ,min( case when rn <= 12 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_min
        ,min( case when rn <= 18 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_min
        ,min( case when rn <= 24 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_min
        ,min( case when rn <= 30 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_min
        ,min( case when rn <= 36 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_min

        ,avg( case when rn <= 3 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_avg
        ,avg( case when rn <= 6 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_avg
        ,avg( case when rn <= 12 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_avg
        ,avg( case when rn <= 18 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_avg
        ,avg( case when rn <= 24 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_avg
        ,avg( case when rn <= 30 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_avg
        ,avg( case when rn <= 36 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_avg

        ,median( case when rn <= 3 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_median
        ,median( case when rn <= 6 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_median
        ,median( case when rn <= 12 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_median
        ,median( case when rn <= 18 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_median
        ,median( case when rn <= 24 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_median
        ,median( case when rn <= 30 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_median
        ,median( case when rn <= 36 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_median

        ,stddev( case when rn <= 3 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_stddev
        ,stddev( case when rn <= 6 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_stddev
        ,stddev( case when rn <= 12 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_stddev
        ,stddev( case when rn <= 18 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_stddev
        ,stddev( case when rn <= 24 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_stddev
        ,stddev( case when rn <= 30 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_stddev
        ,stddev( case when rn <= 36 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_stddev

        ,sum( case when rn <= 3 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_sum
        ,sum( case when rn <= 6 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_sum
        ,sum( case when rn <= 12 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_sum
        ,sum( case when rn <= 18 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_sum
        ,sum( case when rn <= 24 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_sum
        ,sum( case when rn <= 30 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_sum
        ,sum( case when rn <= 36 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_sum


        ,count( case when rn <= 3 and second_derivative > 0 then 1 else null end) as 3stg_pln_repay_amt_second_der_great_0_count
        ,count( case when rn <= 6 and second_derivative > 0 then 1 else null end) as 6stg_pln_repay_amt_second_der_great_0_count
        ,count( case when rn <= 12 and second_derivative > 0 then 1 else null end) as 12stg_pln_repay_amt_second_der_great_0_count
        ,count( case when rn <= 18 and second_derivative > 0 then 1 else null end) as 18stg_pln_repay_amt_second_der_great_0_count
        ,count( case when rn <= 24 and second_derivative > 0 then 1 else null end) as 24stg_pln_repay_amt_second_der_great_0_count
        ,count( case when rn <= 30 and second_derivative > 0 then 1 else null end) as 30stg_pln_repay_amt_second_der_great_0_count
        ,count( case when rn <= 36 and second_derivative > 0 then 1 else null end) as 36stg_pln_repay_amt_second_der_great_0_count

        ,sum( case when rn <= 3 and second_derivative > 0 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 6 and second_derivative > 0 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 12 and second_derivative > 0 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 18 and second_derivative > 0 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 24 and second_derivative > 0 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 30 and second_derivative > 0 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_great_0_sum
        ,sum( case when rn <= 36 and second_derivative > 0 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_great_0_sum

        ,count( case when rn <= 3 and second_derivative < 0 then 1 else null end) as 3stg_pln_repay_amt_second_der_small_0_count
        ,count( case when rn <= 6 and second_derivative < 0 then 1 else null end) as 6stg_pln_repay_amt_second_der_small_0_count
        ,count( case when rn <= 12 and second_derivative < 0 then 1 else null end) as 12stg_pln_repay_amt_second_der_small_0_count
        ,count( case when rn <= 18 and second_derivative < 0 then 1 else null end) as 18stg_pln_repay_amt_second_der_small_0_count
        ,count( case when rn <= 24 and second_derivative < 0 then 1 else null end) as 24stg_pln_repay_amt_second_der_small_0_count
        ,count( case when rn <= 30 and second_derivative < 0 then 1 else null end) as 30stg_pln_repay_amt_second_der_small_0_count
        ,count( case when rn <= 36 and second_derivative < 0 then 1 else null end) as 36stg_pln_repay_amt_second_der_small_0_count

        ,sum( case when rn <= 3 and second_derivative < 0 then second_derivative else null end) as 3stg_pln_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 6 and second_derivative < 0 then second_derivative else null end) as 6stg_pln_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 12 and second_derivative < 0 then second_derivative else null end) as 12stg_pln_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 18 and second_derivative < 0 then second_derivative else null end) as 18stg_pln_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 24 and second_derivative < 0 then second_derivative else null end) as 24stg_pln_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 30 and second_derivative < 0 then second_derivative else null end) as 30stg_pln_repay_amt_second_der_small_0_sum
        ,sum( case when rn <= 36 and second_derivative < 0 then second_derivative else null end) as 36stg_pln_repay_amt_second_der_small_0_sum

        ,avg(case when rn <= 1 then second_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then second_derivative else 0 end) 
            as 3stg_pln_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 3 then second_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then second_derivative else 0 end) 
            as 6stg_pln_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 6 then second_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then second_derivative else 0 end) 
            as 12stg_pln_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 9 then second_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then second_derivative else 0 end) 
            as 18stg_pln_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 12 then second_derivative else 0 end) - avg(case when rn <= 24 and rn > 12 then second_derivative else 0 end) 
            as 24stg_pln_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 15 then second_derivative else 0 end) - avg(case when rn <= 30 and rn > 15 then second_derivative else 0 end) 
            as 30stg_pln_repay_amt_second_der_mean_diff
        ,avg(case when rn <= 18 then second_derivative else 0 end) - avg(case when rn <= 36 and rn > 18 then second_derivative else 0 end) 
            as 36stg_pln_repay_amt_second_der_mean_diff

        ,avg(case when rn <= 1 then second_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then second_derivative else null end) 
            as 3stg_pln_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 3 then second_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then second_derivative else null end) 
            as 6stg_pln_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 6 then second_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then second_derivative else null end) 
            as 12stg_pln_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 9 then second_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then second_derivative else null end) 
            as 18stg_pln_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 12 then second_derivative else 0 end) / avg(case when rn <= 24 and rn > 12 then second_derivative else null end) 
            as 24stg_pln_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 15 then second_derivative else 0 end) / avg(case when rn <= 30 and rn > 15 then second_derivative else null end) 
            as 30stg_pln_repay_amt_second_der_mean_rto
        ,avg(case when rn <= 18 then second_derivative else 0 end) / avg(case when rn <= 36 and rn > 18 then second_derivative else null end) 
            as 36stg_pln_repay_amt_second_der_mean_rto



from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
group by uid
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part4_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part4_${bizdate} as

select
        t1.uid
        ,6thord_con_asc_repay_amt_max
        ,6thord_con_dsc_repay_amt_max
        ,6thord_con_keep_repay_amt_max
        ,12thord_con_asc_repay_amt_max
        ,12thord_con_dsc_repay_amt_max
        ,12thord_con_keep_repay_amt_max
        ,18thord_con_asc_repay_amt_max
        ,18thord_con_dsc_repay_amt_max
        ,18thord_con_keep_repay_amt_max   
        ,24thord_con_asc_repay_amt_max
        ,24thord_con_dsc_repay_amt_max
        ,24thord_con_keep_repay_amt_max   
        ,30thord_con_asc_repay_amt_max
        ,30thord_con_dsc_repay_amt_max
        ,30thord_con_keep_repay_amt_max   
        ,36thord_con_asc_repay_amt_max
        ,36thord_con_dsc_repay_amt_max
        ,36thord_con_keep_repay_amt_max   
from
        (    
        
        select 
                uid
                ,max(case when repay_status = 1 then times else 0 end) as 6thord_con_asc_repay_amt_max
                ,max(case when repay_status = 0 then times else 0 end) as 6thord_con_dsc_repay_amt_max
                ,max(case when repay_status = 3 then times else 0 end) as 6thord_con_keep_repay_amt_max
                from 
                (
                        select count(uid) as times, repay_status, uid
                        from 
                            (
                                select repay_status,
                                        uid,
                                        rn,
                                        row_number() over (partition by uid, repay_status order by rn) as row1,
                                        row_number() over (partition by uid order by rn) as row2
                                        from 
                                        (
                                                select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
                                                where rn <= 6
                                        )
                
                            ) group by uid, row2-row1, repay_status
                )
                group by uid
        ) t1
left join 
        (
        select 
                uid
                ,max(case when repay_status = 1 then times else 0 end) as 12thord_con_asc_repay_amt_max
                ,max(case when repay_status = 0 then times else 0 end) as 12thord_con_dsc_repay_amt_max
                ,max(case when repay_status = 3 then times else 0 end) as 12thord_con_keep_repay_amt_max
                from 
                (
                        select count(uid) as times, repay_status, uid
                        from 
                            (
                                select repay_status,
                                        uid,
                                        rn,
                                        row_number() over (partition by uid, repay_status order by rn) as row1,
                                        row_number() over (partition by uid order by rn) as row2
                                        from 
                                        (
                                                select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
                                                where rn <= 12
                                        )
                
                            ) group by uid, row2-row1, repay_status
                )
                group by uid
        ) t2
on t1.uid = t2.uid

left join

(
    select 
        uid
        ,max(case when repay_status = 1 then times else 0 end) as 18thord_con_asc_repay_amt_max
        ,max(case when repay_status = 0 then times else 0 end) as 18thord_con_dsc_repay_amt_max
        ,max(case when repay_status = 3 then times else 0 end) as 18thord_con_keep_repay_amt_max
        from 
        (
                select count(uid) as times, repay_status, uid
                from 
                    (
                        select repay_status,
                                uid,
                                rn,
                                row_number() over (partition by uid, repay_status order by rn) as row1,
                                row_number() over (partition by uid order by rn) as row2
                                from 
                                (
                                        select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                        from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
                                        where rn <= 18
                                )
        
                    ) group by uid, row2-row1, repay_status
        )
        group by uid
) t3 
on t1.uid = t3.uid
left join

(
    select 
            uid
            ,max(case when repay_status = 1 then times else 0 end) as 24thord_con_asc_repay_amt_max
            ,max(case when repay_status = 0 then times else 0 end) as 24thord_con_dsc_repay_amt_max
            ,max(case when repay_status = 3 then times else 0 end) as 24thord_con_keep_repay_amt_max
            from 
            (
                    select count(uid) as times, repay_status, uid
                    from 
                        (
                            select repay_status,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from 
                                    (
                                            select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                            from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
                                            where rn <= 24
                                    )
            
                        ) group by uid, row2-row1, repay_status
            )
            group by uid

) t4
on t1.uid = t4.uid

left join

(
    select 
        uid
        ,max(case when repay_status = 1 then times else 0 end) as 30thord_con_asc_repay_amt_max
        ,max(case when repay_status = 0 then times else 0 end) as 30thord_con_dsc_repay_amt_max
        ,max(case when repay_status = 3 then times else 0 end) as 30thord_con_keep_repay_amt_max
        from 
        (
                select count(uid) as times, repay_status, uid
                from 
                    (
                        select repay_status,
                                uid,
                                rn,
                                row_number() over (partition by uid, repay_status order by rn) as row1,
                                row_number() over (partition by uid order by rn) as row2
                                from 
                                (
                                        select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                        from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
                                        where rn <= 30
                                )
        
                    ) group by uid, row2-row1, repay_status
        )
        group by uid
) t5 
on t1.uid = t5.uid
left join

(
    select 
            uid
            ,max(case when repay_status = 1 then times else 0 end) as 36thord_con_asc_repay_amt_max
            ,max(case when repay_status = 0 then times else 0 end) as 36thord_con_dsc_repay_amt_max
            ,max(case when repay_status = 3 then times else 0 end) as 36thord_con_keep_repay_amt_max
            from 
            (
                    select count(uid) as times, repay_status, uid
                    from 
                        (
                            select repay_status,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from 
                                    (
                                            select *, case when first_derivative > 0 then 1 when  first_derivative < 0 then 0 else 3 end as  repay_status
                                            from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate}
                                            where rn <= 36
                                    )
            
                        ) group by uid, row2-row1, repay_status
            )
            group by uid

) t6
on t1.uid = t6.uid
;


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp1_${bizdate} as
select  
         main2.uid
        ,main2.mdl_dte
        ,main2.dtl_uid -- 还款记录表所在订单号
        ,main2.dtl_stg_pln_no -- 还款记录表的分期号码
        ,main2.dtl_rep_dte -- 应还款日
        ,main2.rep_tim -- 实际还款日
        ,main2.prc_amt -- 应还本金
        ,main2.stg_no -- 期号

        --还款状态--flag
        --是否提前还款flag
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then '提前还款' -- 这样写的好处是即使评分日后的应还分期，如果在评分日前提前还了，也能计入
         when ddf_rep_tim_dte>0 then '逾期还款'
         when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then '按时还款'
         when ddf_mdl_rep_dte<=0 then '未来应还（评分日T日及往后）'
         else '其他分期状态'
         end repay_status_main -- 还款状态主字段

from
        (select 
                main1.uid
                ,main1.mdl_dte
                ,main1.dtl_uid
                ,main1.dtl_stg_pln_no
                ,main1.dtl_rep_dte
                ,main1.rep_tim
                ,main1.prc_amt
                ,main1.stg_stt
                ,main1.stg_no


                --应还日和实还日之间的间隔（天），for判断逾期、提前、按时还款
                ,case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte)
                        else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte
                --实还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim
                --应还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte 
        from
                (select model_data.uid
                        ,model_data.mdl_dte
                        ,plan.dtl_uid
                        ,plan.dtl_stg_pln_no
                        ,plan.dtl_rep_dte
                        ,case when date(plan.rep_tim)>=model_data.mdl_dte then null else date(plan.rep_tim) end as rep_tim
                        ,plan.prc_amt
                        ,plan.stg_stt
                        ,plan.stg_no
                from    (
                        select  uid
                               ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                        from    dwa_risk.dwa_risk_f_dz_model_data_base
                        ) model_data

                        left join
                        (select uid
                                ,uid as dtl_uid -- 分期所在订单编号
                                ,stg_pln_no as dtl_stg_pln_no -- 分期计划编号
                                ,rep_dte as dtl_rep_dte -- 分期应还款日
                                ,rep_tim -- 分期结清时间
                                ,prc_amt -- 分期应还本金
                                ,stg_stt
                                ,stg_no -- 分期所在期数
                        from dwa_risk.dwa_risk_f_heavy_stage_plan_basic
                        where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
                        and stg_stt <> 'R' --分期计划状态，放款成功取<>'R'
                        ) plan on model_data.uid=plan.uid
                ) main1

        )main2
;

    drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate};
    create table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate} as
        select 
                        t1.uid
                        ,repay_status_main
                        ,row_number() over (partition by t1.uid, mdl_dte order by dtl_rep_dte desc) as rn   
                                
                        from   
                        (
                            select  uid,
                                    date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                            from ${dwa_risk}.dwa_risk_f_dz_model_data_base
                        ) t1
                        left join
                        (
                                select 
                                        uid
                                        ,dtl_rep_dte 
                                        ,repay_status_main
                                from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp1_${bizdate}
                                
                        ) t2   
                        on t1.uid = t2.uid and t1.mdl_dte > t2.dtl_rep_dte 

;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part5_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part5_${bizdate} as

select 
    t1.uid 
    ,6thord_con_ontime_repay_max
    ,6thord_con_adv_repay_max
    ,6thord_con_late_repay_max
    ,12thord_con_ontime_repay_max
    ,12thord_con_adv_repay_max
    ,12thord_con_late_repay_max
    ,18thord_con_ontime_repay_max
    ,18thord_con_adv_repay_max
    ,18thord_con_late_repay_max
    ,24thord_con_ontime_repay_max
    ,24thord_con_adv_repay_max
    ,24thord_con_late_repay_max
    from 
    (
            select uid
                    ,max(case when repay_status_main = '按时还款' then times else 0 end) as 6thord_con_ontime_repay_max
                    ,max(case when repay_status_main = '提前还款' then times else 0 end) as 6thord_con_adv_repay_max
                    ,max(case when repay_status_main = '逾期还款' then times else 0 end) as 6thord_con_late_repay_max
                    from 
            (
                    select count(uid) as times, repay_status_main, uid
                    from 
                        (
                            select repay_status_main,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status_main order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate}
                                    where rn <= 6 
                        ) group by uid, row2-row1, repay_status_main
            )
            
            group by uid
    ) t1
    
    left join 

    (
            select uid
                    ,max(case when repay_status_main = '按时还款' then times else 0 end) as 12thord_con_ontime_repay_max
                    ,max(case when repay_status_main = '提前还款' then times else 0 end) as 12thord_con_adv_repay_max
                    ,max(case when repay_status_main = '逾期还款' then times else 0 end) as 12thord_con_late_repay_max
                    from 
            (
                    select count(uid) as times, repay_status_main, uid
                    from 
                    (
                            select repay_status_main,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status_main order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate}
                                    where rn <= 12
                    ) group by uid, row2-row1, repay_status_main
            )
            
            group by uid
    ) t2
    on t1.uid = t2.uid

    left join 

    (
            select uid
                    ,max(case when repay_status_main = '按时还款' then times else 0 end) as 18thord_con_ontime_repay_max
                    ,max(case when repay_status_main = '提前还款' then times else 0 end) as 18thord_con_adv_repay_max
                    ,max(case when repay_status_main = '逾期还款' then times else 0 end) as 18thord_con_late_repay_max
                    from 
            (
                    select count(uid) as times, repay_status_main, uid
                    from 
                    (
                            select repay_status_main,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status_main order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate}
                                    where rn <= 18 
                    ) group by uid, row2-row1, repay_status_main
            )
            
            group by uid
    ) t3
    on t1.uid = t3.uid

    left join 

    (
            select uid
                    ,max(case when repay_status_main = '按时还款' then times else 0 end) as 24thord_con_ontime_repay_max
                    ,max(case when repay_status_main = '提前还款' then times else 0 end) as 24thord_con_adv_repay_max
                    ,max(case when repay_status_main = '逾期还款' then times else 0 end) as 24thord_con_late_repay_max
                    from 
            (
                    select count(uid) as times, repay_status_main, uid
                    from 
                    (
                            select repay_status_main,
                                    uid,
                                    rn,
                                    row_number() over (partition by uid, repay_status_main order by rn) as row1,
                                    row_number() over (partition by uid order by rn) as row2
                                    from ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate}
                                    where rn <= 24 
                    ) group by uid, row2-row1, repay_status_main
            )
            
            group by uid
    ) t4
    on t1.uid = t4.uid;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df partition(ds = '${bizdate}')
select  a.uid,
        a.mdl_dte,
         3m_repay_amt_first_der_max,
         6m_repay_amt_first_der_max,
         12m_repay_amt_first_der_max,
         18m_repay_amt_first_der_max,
         3m_repay_amt_first_der_min,
         6m_repay_amt_first_der_min,
         12m_repay_amt_first_der_min,
         18m_repay_amt_first_der_min,
         3m_repay_amt_first_der_avg,
         6m_repay_amt_first_der_avg,
         12m_repay_amt_first_der_avg,
         18m_repay_amt_first_der_avg,
         3m_repay_amt_first_der_median,
         6m_repay_amt_first_der_median,
         12m_repay_amt_first_der_median,
         18m_repay_amt_first_der_median,
         3m_repay_amt_first_der_stddev,
         6m_repay_amt_first_der_stddev,
         12m_repay_amt_first_der_stddev,
         18m_repay_amt_first_der_stddev,
         3m_repay_amt_first_der_sum,
         6m_repay_amt_first_der_sum,
         12m_repay_amt_first_der_sum,
         18m_repay_amt_first_der_sum,
         3m_repay_amt_first_der_great_0_count,
         6m_repay_amt_first_der_great_0_count,
         12m_repay_amt_first_der_great_0_count,
         18m_repay_amt_first_der_great_0_count,
         3m_repay_amt_first_der_great_0_sum,
         6m_repay_amt_first_der_great_0_sum,
         12m_repay_amt_first_der_great_0_sum,
         18m_repay_amt_first_der_great_0_sum,
         3m_repay_amt_first_der_small_0_count,
         6m_repay_amt_first_der_small_0_count,
         12m_repay_amt_first_der_small_0_count,
         18m_repay_amt_first_der_small_0_count,
         3m_repay_amt_first_der_small_0_sum,
         6m_repay_amt_first_der_small_0_sum,
         12m_repay_amt_first_der_small_0_sum,
         18m_repay_amt_first_der_small_0_sum,
         3m_repay_amt_first_der_mean_diff,
         6m_repay_amt_first_der_mean_diff,
         12m_repay_amt_first_der_mean_diff,
         18m_repay_amt_first_der_mean_diff,
         3m_repay_amt_first_der_mean_rto,
         6m_repay_amt_first_der_mean_rto,
         12m_repay_amt_first_der_mean_rto,
         18m_repay_amt_first_der_mean_rto,
         3m_repay_amt_second_der_max,
         6m_repay_amt_second_der_max,
         12m_repay_amt_second_der_max,
         18m_repay_amt_second_der_max,
         3m_repay_amt_second_der_min,
         6m_repay_amt_second_der_min,
         12m_repay_amt_second_der_min,
         18m_repay_amt_second_der_min,
         3m_repay_amt_second_der_avg,
         6m_repay_amt_second_der_avg,
         12m_repay_amt_second_der_avg,
         18m_repay_amt_second_der_avg,
         3m_repay_amt_second_der_median,
         6m_repay_amt_second_der_median,
         12m_repay_amt_second_der_median,
         18m_repay_amt_second_der_median,
         3m_repay_amt_second_der_stddev,
         6m_repay_amt_second_der_stddev,
         12m_repay_amt_second_der_stddev,
         18m_repay_amt_second_der_stddev,
         3m_repay_amt_second_der_sum,
         6m_repay_amt_second_der_sum,
         12m_repay_amt_second_der_sum,
         18m_repay_amt_second_der_sum,
         3m_repay_amt_second_der_great_0_count,
         6m_repay_amt_second_der_great_0_count,
         12m_repay_amt_second_der_great_0_count,
         18m_repay_amt_second_der_great_0_count,
         3m_repay_amt_second_der_great_0_sum,
         6m_repay_amt_second_der_great_0_sum,
         12m_repay_amt_second_der_great_0_sum,
         18m_repay_amt_second_der_great_0_sum,
         3m_repay_amt_second_der_small_0_count,
         6m_repay_amt_second_der_small_0_count,
         12m_repay_amt_second_der_small_0_count,
         18m_repay_amt_second_der_small_0_count,
         3m_repay_amt_second_der_small_0_sum,
         6m_repay_amt_second_der_small_0_sum,
         12m_repay_amt_second_der_small_0_sum,
         18m_repay_amt_second_der_small_0_sum,
         3m_repay_amt_second_der_mean_diff,
         6m_repay_amt_second_der_mean_diff,
         12m_repay_amt_second_der_mean_diff,
         18m_repay_amt_second_der_mean_diff,
         3m_repay_amt_second_der_mean_rto,
         6m_repay_amt_second_der_mean_rto,
         12m_repay_amt_second_der_mean_rto,
         18m_repay_amt_second_der_mean_rto,
         6m_con_asc_repay_max,
         6m_con_dsc_repay_max,
         6m_con_keep_repay_max,
         9m_con_asc_repay_max,
         9m_con_dsc_repay_max,
         9m_con_keep_repay_max,
         12m_con_asc_repay_max,
         12m_con_dsc_repay_max,
         12m_con_keep_repay_max,
         18m_con_asc_repay_max,
         18m_con_dsc_repay_max,
         18m_con_keep_repay_max,
         3stg_pln_repay_amt_first_der_max,
         6stg_pln_repay_amt_first_der_max,
         12stg_pln_repay_amt_first_der_max,
         18stg_pln_repay_amt_first_der_max,
         24stg_pln_repay_amt_first_der_max,
         30stg_pln_repay_amt_first_der_max,
         36stg_pln_repay_amt_first_der_max,
         3stg_pln_repay_amt_first_der_min,
         6stg_pln_repay_amt_first_der_min,
         12stg_pln_repay_amt_first_der_min,
         18stg_pln_repay_amt_first_der_min,
         24stg_pln_repay_amt_first_der_min,
         30stg_pln_repay_amt_first_der_min,
         36stg_pln_repay_amt_first_der_min,
         3stg_pln_repay_amt_first_der_avg,
         6stg_pln_repay_amt_first_der_avg,
         12stg_pln_repay_amt_first_der_avg,
         18stg_pln_repay_amt_first_der_avg,
         24stg_pln_repay_amt_first_der_avg,
         30stg_pln_repay_amt_first_der_avg,
         36stg_pln_repay_amt_first_der_avg,
         3stg_pln_repay_amt_first_der_median,
         6stg_pln_repay_amt_first_der_median,
         12stg_pln_repay_amt_first_der_median,
         18stg_pln_repay_amt_first_der_median,
         24stg_pln_repay_amt_first_der_median,
         30stg_pln_repay_amt_first_der_median,
         36stg_pln_repay_amt_first_der_median,
         3stg_pln_repay_amt_first_der_stddev,
         6stg_pln_repay_amt_first_der_stddev,
         12stg_pln_repay_amt_first_der_stddev,
         18stg_pln_repay_amt_first_der_stddev,
         24stg_pln_repay_amt_first_der_stddev,
         30stg_pln_repay_amt_first_der_stddev,
         36stg_pln_repay_amt_first_der_stddev,
         3stg_pln_repay_amt_first_der_sum,
         6stg_pln_repay_amt_first_der_sum,
         12stg_pln_repay_amt_first_der_sum,
         18stg_pln_repay_amt_first_der_sum,
         24stg_pln_repay_amt_first_der_sum,
         30stg_pln_repay_amt_first_der_sum,
         36stg_pln_repay_amt_first_der_sum,
         3stg_pln_repay_amt_first_der_great_0_count,
         6stg_pln_repay_amt_first_der_great_0_count,
         12stg_pln_repay_amt_first_der_great_0_count,
         18stg_pln_repay_amt_first_der_great_0_count,
         24stg_pln_repay_amt_first_der_great_0_count,
         30stg_pln_repay_amt_first_der_great_0_count,
         36stg_pln_repay_amt_first_der_great_0_count,
         3stg_pln_repay_amt_first_der_great_0_sum,
         6stg_pln_repay_amt_first_der_great_0_sum,
         12stg_pln_repay_amt_first_der_great_0_sum,
         18stg_pln_repay_amt_first_der_great_0_sum,
         24stg_pln_repay_amt_first_der_great_0_sum,
         30stg_pln_repay_amt_first_der_great_0_sum,
         36stg_pln_repay_amt_first_der_great_0_sum,
         3stg_pln_repay_amt_first_der_small_0_count,
         6stg_pln_repay_amt_first_der_small_0_count,
         12stg_pln_repay_amt_first_der_small_0_count,
         18stg_pln_repay_amt_first_der_small_0_count,
         24stg_pln_repay_amt_first_der_small_0_count,
         30stg_pln_repay_amt_first_der_small_0_count,
         36stg_pln_repay_amt_first_der_small_0_count,
         3stg_pln_repay_amt_first_der_small_0_sum,
         6stg_pln_repay_amt_first_der_small_0_sum,
         12stg_pln_repay_amt_first_der_small_0_sum,
         18stg_pln_repay_amt_first_der_small_0_sum,
         24stg_pln_repay_amt_first_der_small_0_sum,
         30stg_pln_repay_amt_first_der_small_0_sum,
         36stg_pln_repay_amt_first_der_small_0_sum,
         3stg_pln_repay_amt_first_der_mean_diff,
         6stg_pln_repay_amt_first_der_mean_diff,
         12stg_pln_repay_amt_first_der_mean_diff,
         18stg_pln_repay_amt_first_der_mean_diff,
         24stg_pln_repay_amt_first_der_mean_diff,
         30stg_pln_repay_amt_first_der_mean_diff,
         36stg_pln_repay_amt_first_der_mean_diff,
         3stg_pln_repay_amt_first_der_mean_rto,
         6stg_pln_repay_amt_first_der_mean_rto,
         12stg_pln_repay_amt_first_der_mean_rto,
         18stg_pln_repay_amt_first_der_mean_rto,
         24stg_pln_repay_amt_first_der_mean_rto,
         30stg_pln_repay_amt_first_der_mean_rto,
         36stg_pln_repay_amt_first_der_mean_rto,
         3stg_pln_repay_amt_second_der_max,
         6stg_pln_repay_amt_second_der_max,
         12stg_pln_repay_amt_second_der_max,
         18stg_pln_repay_amt_second_der_max,
         24stg_pln_repay_amt_second_der_max,
         30stg_pln_repay_amt_second_der_max,
         36stg_pln_repay_amt_second_der_max,
         3stg_pln_repay_amt_second_der_min,
         6stg_pln_repay_amt_second_der_min,
         12stg_pln_repay_amt_second_der_min,
         18stg_pln_repay_amt_second_der_min,
         24stg_pln_repay_amt_second_der_min,
         30stg_pln_repay_amt_second_der_min,
         36stg_pln_repay_amt_second_der_min,
         3stg_pln_repay_amt_second_der_avg,
         6stg_pln_repay_amt_second_der_avg,
         12stg_pln_repay_amt_second_der_avg,
         18stg_pln_repay_amt_second_der_avg,
         24stg_pln_repay_amt_second_der_avg,
         30stg_pln_repay_amt_second_der_avg,
         36stg_pln_repay_amt_second_der_avg,
         3stg_pln_repay_amt_second_der_median,
         6stg_pln_repay_amt_second_der_median,
         12stg_pln_repay_amt_second_der_median,
         18stg_pln_repay_amt_second_der_median,
         24stg_pln_repay_amt_second_der_median,
         30stg_pln_repay_amt_second_der_median,
         36stg_pln_repay_amt_second_der_median,
         3stg_pln_repay_amt_second_der_stddev,
         6stg_pln_repay_amt_second_der_stddev,
         12stg_pln_repay_amt_second_der_stddev,
         18stg_pln_repay_amt_second_der_stddev,
         24stg_pln_repay_amt_second_der_stddev,
         30stg_pln_repay_amt_second_der_stddev,
         36stg_pln_repay_amt_second_der_stddev,
         3stg_pln_repay_amt_second_der_sum,
         6stg_pln_repay_amt_second_der_sum,
         12stg_pln_repay_amt_second_der_sum,
         18stg_pln_repay_amt_second_der_sum,
         24stg_pln_repay_amt_second_der_sum,
         30stg_pln_repay_amt_second_der_sum,
         36stg_pln_repay_amt_second_der_sum,
         3stg_pln_repay_amt_second_der_great_0_count,
         6stg_pln_repay_amt_second_der_great_0_count,
         12stg_pln_repay_amt_second_der_great_0_count,
         18stg_pln_repay_amt_second_der_great_0_count,
         24stg_pln_repay_amt_second_der_great_0_count,
         30stg_pln_repay_amt_second_der_great_0_count,
         36stg_pln_repay_amt_second_der_great_0_count,
         3stg_pln_repay_amt_second_der_great_0_sum,
         6stg_pln_repay_amt_second_der_great_0_sum,
         12stg_pln_repay_amt_second_der_great_0_sum,
         18stg_pln_repay_amt_second_der_great_0_sum,
         24stg_pln_repay_amt_second_der_great_0_sum,
         30stg_pln_repay_amt_second_der_great_0_sum,
         36stg_pln_repay_amt_second_der_great_0_sum,
         3stg_pln_repay_amt_second_der_small_0_count,
         6stg_pln_repay_amt_second_der_small_0_count,
         12stg_pln_repay_amt_second_der_small_0_count,
         18stg_pln_repay_amt_second_der_small_0_count,
         24stg_pln_repay_amt_second_der_small_0_count,
         30stg_pln_repay_amt_second_der_small_0_count,
         36stg_pln_repay_amt_second_der_small_0_count,
         3stg_pln_repay_amt_second_der_small_0_sum,
         6stg_pln_repay_amt_second_der_small_0_sum,
         12stg_pln_repay_amt_second_der_small_0_sum,
         18stg_pln_repay_amt_second_der_small_0_sum,
         24stg_pln_repay_amt_second_der_small_0_sum,
         30stg_pln_repay_amt_second_der_small_0_sum,
         36stg_pln_repay_amt_second_der_small_0_sum,
         3stg_pln_repay_amt_second_der_mean_diff,
         6stg_pln_repay_amt_second_der_mean_diff,
         12stg_pln_repay_amt_second_der_mean_diff,
         18stg_pln_repay_amt_second_der_mean_diff,
         24stg_pln_repay_amt_second_der_mean_diff,
         30stg_pln_repay_amt_second_der_mean_diff,
         36stg_pln_repay_amt_second_der_mean_diff,
         3stg_pln_repay_amt_second_der_mean_rto,
         6stg_pln_repay_amt_second_der_mean_rto,
         12stg_pln_repay_amt_second_der_mean_rto,
         18stg_pln_repay_amt_second_der_mean_rto,
         24stg_pln_repay_amt_second_der_mean_rto,
         30stg_pln_repay_amt_second_der_mean_rto,
         36stg_pln_repay_amt_second_der_mean_rto,
         6thord_con_asc_repay_amt_max,
         6thord_con_dsc_repay_amt_max,
         6thord_con_keep_repay_amt_max,
         12thord_con_asc_repay_amt_max,
         12thord_con_dsc_repay_amt_max,
         12thord_con_keep_repay_amt_max,
         18thord_con_asc_repay_amt_max,
         18thord_con_dsc_repay_amt_max,
         18thord_con_keep_repay_amt_max,
         24thord_con_asc_repay_amt_max,
         24thord_con_dsc_repay_amt_max,
         24thord_con_keep_repay_amt_max,
         30thord_con_asc_repay_amt_max,
         30thord_con_dsc_repay_amt_max,
         30thord_con_keep_repay_amt_max,
         36thord_con_asc_repay_amt_max,
         36thord_con_dsc_repay_amt_max,
         36thord_con_keep_repay_amt_max,
         6thord_con_ontime_repay_max,
         6thord_con_adv_repay_max,
         6thord_con_late_repay_max,
         12thord_con_ontime_repay_max,
         12thord_con_adv_repay_max,
         12thord_con_late_repay_max,
         18thord_con_ontime_repay_max,
         18thord_con_adv_repay_max,
         18thord_con_late_repay_max,
         24thord_con_ontime_repay_max,
         24thord_con_adv_repay_max,
         24thord_con_late_repay_max
from
(
        select  uid,
                date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
        from ${dwa_risk}.dwa_risk_f_dz_model_data_base
) a  
left join ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part1_${bizdate} as b
on a.uid = b.uid 
left join ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part2_${bizdate} as c
on a.uid = c.uid 
left join ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part3_${bizdate} as d
on a.uid = d.uid 
left join ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part4_${bizdate} as e
on a.uid = e.uid 
left join ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part5_${bizdate} as f
on a.uid = f.uid 
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_behavior_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part3_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_stg_pln_trend_time_series_df_part4_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_rep_trend_time_series_df_part5_${bizdate};
-- feature-copilot:node-end ordinal=0
