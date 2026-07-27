-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_22pip_heavy_cross_info_df
-- node_id: n_5347940685402079233
-- task_name: dwa_risk_dz_model_final_22pip_heavy_cross_info_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_22pip_heavy_cross_info_df.json
-- source_json_sha256: 1ec66fe3f24ed1b993aabbbcd9a42d09dd08631a1ffca72b377f52267097a8db
-- upstream_table: dwa_risk.dwa_risk_light_and_heavy_credit_and_loan_feature_batch_3_df
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_light_and_heavy_credit_and_loan_feature_batch_1_df
-- upstream_table: dwa_risk.dwa_risk_light_and_heavy_credit_and_loan_feature_batch_2_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 裴阳
--创建日期: 2023-12-06 18:33:02
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

-- drop table if exists dwa_risk_dev.dwa_risk_dz_model_final_22pip_heavy_cross_info_df;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_22pip_heavy_cross_info_df (
    uid                                                   string
   ,mdl_dte                                               date
   ,amt_n_unique_all                                      decimal ( 26 , 10 )
   ,avg_amt_channel_hb                                    decimal ( 26 , 10 )
   ,avg_amt_event_result_0                                decimal ( 26 , 10 )
   ,avg_amt_event_type_limit_all                          decimal ( 26 , 10 )
   ,avg_amt_event_type_limit_recent_60                    decimal ( 26 , 10 )
   ,avg_amt_event_type_loan_all                           decimal ( 26 , 10 )
   ,avg_amt_event_type_loan_event_result_1                decimal ( 26 , 10 )
   ,avg_amt_event_type_loan_event_result_1_recent_180     decimal ( 26 , 10 )
   ,avg_amt_event_type_loan_event_result_1_recent_60      decimal ( 26 , 10 )
   ,avg_amt_event_type_loan_recent_180                    decimal ( 26 , 10 )
   ,avg_amt_event_type_repay_all                          decimal ( 26 , 10 )
   ,avg_amt_event_type_repay_event_result_1_recent_180    decimal ( 26 , 10 )
   ,avg_amt_event_type_repay_event_result_1_recent_60     decimal ( 26 , 10 )
   ,avg_amt_event_type_repay_recent_60                    decimal ( 26 , 10 )
   ,avg_amt_other_info_cash                               decimal ( 26 , 10 )
   ,avg_amt_recent_days_120                               decimal ( 26 , 10 )
   ,avg_amt_recent_days_180                               decimal ( 26 , 10 )
   ,avg_amt_recent_days_540                               decimal ( 26 , 10 )
   ,avg_day_diff_event_result_0_event_type_loan           decimal ( 26 , 10 )
   ,avg_day_diff_event_result_1_event_type_loan           decimal ( 26 , 10 )
   ,avg_day_diff_shift1_event_type_repay_all              decimal ( 26 , 10 )
   ,avg_day_diff_type_light_all                           decimal ( 26 , 10 )
   ,cnt_channel_hb_all                                    decimal ( 26 , 10 )
   ,cnt_channel_hb_uid_recent_days_180                    decimal ( 26 , 10 )
   ,cnt_channel_hb_uid_recent_days_540                    decimal ( 26 , 10 )
   ,cnt_event_result_0_uid_recent_days_540                decimal ( 26 , 10 )
   ,cnt_event_result_1_type_heavy_all                     decimal ( 26 , 10 )
   ,cnt_event_result_1_uid_recent_days_120                decimal ( 26 , 10 )
   ,cnt_event_result_1_uid_recent_days_360                decimal ( 26 , 10 )
   ,cnt_event_type_credit_event_result_1_all              decimal ( 26 , 10 )
   ,cnt_event_type_limit_type_heavy_all                   decimal ( 26 , 10 )
   ,cnt_event_type_loan_all                               decimal ( 26 , 10 )
   ,cnt_event_type_loan_event_result_1_all                decimal ( 26 , 10 )
   ,cnt_event_type_loan_type_heavy_all                    decimal ( 26 , 10 )
   ,cnt_event_type_loan_uid_recent_days_30                decimal ( 26 , 10 )
   ,cnt_event_type_repay_all                              decimal ( 26 , 10 )
   ,cnt_event_type_repay_event_result_1_all               decimal ( 26 , 10 )
   ,cnt_event_type_repay_other_info_manual_repay          decimal ( 26 , 10 )
   ,cnt_event_type_repay_type_heavy_all                   decimal ( 26 , 10 )
   ,cnt_event_type_repay_uid_recent_days_180              decimal ( 26 , 10 )
   ,cnt_event_type_repay_uid_recent_days_360              decimal ( 26 , 10 )
   ,cnt_event_type_repay_uid_recent_days_540              decimal ( 26 , 10 )
   ,cnt_other_info_auto_deduct_uid_recent_days_120        decimal ( 26 , 10 )
   ,cnt_other_info_auto_deduct_uid_recent_days_540        decimal ( 26 , 10 )
   ,cnt_other_info_cash_uid_recent_days_14                decimal ( 26 , 10 )
   ,cnt_other_info_cash_uid_recent_days_30                decimal ( 26 , 10 )
   ,cnt_other_info_cash_uid_recent_days_360               decimal ( 26 , 10 )
   ,cnt_other_info_cash_uid_recent_days_540               decimal ( 26 , 10 )
   ,cnt_other_info_light_uid_recent_days_360              decimal ( 26 , 10 )
   ,cnt_other_info_manual_repay_all                       decimal ( 26 , 10 )
   ,cnt_other_info_manual_repay_uid_recent_days_90        decimal ( 26 , 10 )
   ,cnt_type_heavy_uid_recent_days_180                    decimal ( 26 , 10 )
   ,cnt_type_heavy_uid_recent_days_540                    decimal ( 26 , 10 )
   ,cnt_type_light_uid_recent_days_30                     decimal ( 26 , 10 )
   ,cnt_type_light_uid_recent_days_90                     decimal ( 26 , 10 )
   ,day_diff_shift1_n_unique_all                          decimal ( 26 , 10 )
   ,div_amt_event_type_repay_loan                         decimal ( 26 , 10 )
   ,max_amt_event_result_1_event_type_loan                decimal ( 26 , 10 )
   ,max_amt_event_type_limit_recent_30                    decimal ( 26 , 10 )
   ,max_amt_event_type_loan                               decimal ( 26 , 10 )
   ,max_amt_event_type_loan_event_result_1_recent_180     decimal ( 26 , 10 )
   ,max_amt_event_type_loan_event_result_1_recent_30      decimal ( 26 , 10 )
   ,max_amt_event_type_loan_recent_180                    decimal ( 26 , 10 )
   ,max_amt_event_type_loan_recent_60                     decimal ( 26 , 10 )
   ,max_amt_event_type_repay_event_result_1               decimal ( 26 , 10 )
   ,max_amt_event_type_repay_event_result_1_recent_180    decimal ( 26 , 10 )
   ,max_amt_event_type_repay_event_result_1_recent_30     decimal ( 26 , 10 )
   ,max_amt_event_type_repay_event_result_1_recent_60     decimal ( 26 , 10 )
   ,max_amt_event_type_repay_recent_180                   decimal ( 26 , 10 )
   ,max_amt_event_type_repay_recent_60                    decimal ( 26 , 10 )
   ,max_amt_other_info_auto_deduct                        decimal ( 26 , 10 )
   ,max_amt_other_info_manual_repay                       decimal ( 26 , 10 )
   ,max_amt_recent_days_30                                decimal ( 26 , 10 )
   ,max_amt_recent_days_60                                decimal ( 26 , 10 )
   ,max_amt_recent_days_90                                decimal ( 26 , 10 )
   ,max_amt_type_light                                    decimal ( 26 , 10 )
   ,mean_amt_event_result_1_event_type_loan               decimal ( 26 , 10 )
   ,mean_amt_recent_days_360                              decimal ( 26 , 10 )
   ,mean_day_diff_event_result_0_event_type_loan_all      decimal ( 26 , 10 )
   ,min_amt_channel_hb                                    decimal ( 26 , 10 )
   ,min_amt_event_type_credit_all                         decimal ( 26 , 10 )
   ,min_amt_event_type_credit_event_result_1              decimal ( 26 , 10 )
   ,min_amt_event_type_limit_recent_60                    decimal ( 26 , 10 )
   ,min_amt_event_type_repay_event_result_1               decimal ( 26 , 10 )
   ,min_amt_event_type_repay_recent_180                   decimal ( 26 , 10 )
   ,n_unique_channel_event_result_1                       decimal ( 26 , 10 )
   ,n_unique_channel_event_type_repay                     decimal ( 26 , 10 )
   ,n_unique_day_diff_event_result_1                      decimal ( 26 , 10 )
   ,n_unique_day_diff_event_type_repay                    decimal ( 26 , 10 )
   ,n_unique_day_diff_shift1_event_type_loan              decimal ( 26 , 10 )
   ,n_unique_event_type_day_diff_shift1_event_type_loan   decimal ( 26 , 10 )
   ,n_unique_other_info_event_type_credit                 decimal ( 26 , 10 )
   ,per_event_type_limit_all                              decimal ( 26 , 10 )
   ,per_uid_recent_days_120                               decimal ( 26 , 10 )
   ,redu_amt_event_type_repay_loan                        decimal ( 26 , 10 )
   ,std_amt_channel_hb                                    decimal ( 26 , 10 )
   ,stddev_amt_event_type_limit_recent_30                 decimal ( 26 , 10 )
   ,stddev_amt_event_type_repay_all                       decimal ( 26 , 10 )
   ,stddev_amt_event_type_repay_event_result_1_recent_180 decimal ( 26 , 10 )
   ,stddev_amt_event_type_repay_recent_180                decimal ( 26 , 10 )
   ,stddev_amt_recent_days_90                             decimal ( 26 , 10 )
   ,stddev_day_diff                                       decimal ( 26 , 10 )
   ,stddev_day_diff_event_type_repay_all                  decimal ( 26 , 10 )
   ,stddev_day_diff_shift1_event_type_repay_all           decimal ( 26 , 10 )
   ,sum_day_diff_event_type_repay_all                     decimal ( 26 , 10 )
   ,sum_day_diff_shift1_event_type_loan_all               decimal ( 26 , 10 )
   ,sum_day_diff_type_heavy_all                           decimal ( 26 , 10 )
   ,sum_event_result_day_diff_shift1_event_result_0_all   decimal ( 26 , 10 )
   ,day_diff_first_event_result_10                        decimal ( 26 , 10 )
   ,day_diff_first_limit_repay                            decimal ( 26 , 10 )
   ,day_diff_last_repay_loan                              decimal ( 26 , 10 )
   ,first_amt_channel_hb_microcredit_lv1_all              decimal ( 26 , 10 )
   ,first_amt_event_result_0_all                          decimal ( 26 , 10 )
   ,first_amt_event_type_credit_all                       decimal ( 26 , 10 )
   ,first_amt_event_type_limit_recent_30                  decimal ( 26 , 10 )
   ,first_day_diff_event_result_0_event_type_loan_all     decimal ( 26 , 10 )
   ,first_day_diff_event_result_1_all                     decimal ( 26 , 10 )
   ,first_day_diff_event_result_1_event_type_repay_all    decimal ( 26 , 10 )
   ,first_day_diff_event_type_repay_all                   decimal ( 26 , 10 )
   ,last_amt_channel_hb_microcredit_lv1_all               decimal ( 26 , 10 )
   ,last_amt_type_light_all                               decimal ( 26 , 10 )
   ,last_day_diff_event_result_0_event_type_loan_all      decimal ( 26 , 10 )
   ,last_day_diff_event_result_1_all                      decimal ( 26 , 10 )
   ,last_event_type_day_diff_shift1_event_type_repay_all  decimal ( 26 , 10 )
   ,median_amt_channel_hb_microcredit_lv1_all             decimal ( 26 , 10 )
   ,median_amt_event_result_0_all                         decimal ( 26 , 10 )
   ,median_amt_event_result_0_event_type_limit            decimal ( 26 , 10 )
   ,median_amt_event_result_1_all                         decimal ( 26 , 10 )
   ,median_amt_event_result_1_event_type_repay            decimal ( 26 , 10 )
   ,median_amt_event_result_1_event_type_repay_recent_180 decimal ( 26 , 10 )
   ,median_amt_event_result_1_event_type_repay_recent_30  decimal ( 26 , 10 )
   ,median_amt_event_result_1_event_type_repay_recent_60  decimal ( 26 , 10 )
   ,median_amt_event_type_limit_all                       decimal ( 26 , 10 )
   ,median_amt_event_type_limit_recent_180                decimal ( 26 , 10 )
   ,median_amt_event_type_limit_recent_60                 decimal ( 26 , 10 )
   ,median_amt_event_type_loan_recent_180                 decimal ( 26 , 10 )
   ,median_amt_event_type_repay_recent_180                decimal ( 26 , 10 )
   ,median_amt_event_type_repay_recent_30                 decimal ( 26 , 10 )
   ,median_amt_event_type_repay_recent_60                 decimal ( 26 , 10 )
   ,median_amt_other_info_auto_deduct_all                 decimal ( 26 , 10 )
   ,median_amt_other_info_cash_all                        decimal ( 26 , 10 )
   ,median_amt_recent_days_120                            decimal ( 26 , 10 )
   ,median_amt_recent_days_180                            decimal ( 26 , 10 )
   ,median_amt_recent_days_30                             decimal ( 26 , 10 )
   ,median_amt_recent_days_60                             decimal ( 26 , 10 )
   ,median_amt_recent_days_90                             decimal ( 26 , 10 )
   ,succloan_stage_num_mean_all                           decimal ( 26 , 10 )
   ,succloan_day_diff_reud_stage_num_sum_all              decimal ( 26 , 10 )
   ,succloan_day_diff_reud_stage_num_min_all              decimal ( 26 , 10 )
   ,succloan_day_diff_reud_stage_num_first_all            decimal ( 26 , 10 )
)
partitioned by (
    ds string
);

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_22pip_heavy_cross_info_df partition (ds = '${bizdate}')
select 
        model_data.uid
        ,model_data.mdl_dte
        ,amt_n_unique_all
        ,avg_amt_channel_hb
        ,avg_amt_event_result_0
        ,avg_amt_event_type_limit_all
        ,avg_amt_event_type_limit_recent_60
        ,avg_amt_event_type_loan_all
        ,avg_amt_event_type_loan_event_result_1
        ,avg_amt_event_type_loan_event_result_1_recent_180
        ,avg_amt_event_type_loan_event_result_1_recent_60
        ,avg_amt_event_type_loan_recent_180
        ,avg_amt_event_type_repay_all
        ,avg_amt_event_type_repay_event_result_1_recent_180
        ,avg_amt_event_type_repay_event_result_1_recent_60
        ,avg_amt_event_type_repay_recent_60
        ,avg_amt_other_info_cash
        ,avg_amt_recent_days_120
        ,avg_amt_recent_days_180
        ,avg_amt_recent_days_540
        ,avg_day_diff_event_result_0_event_type_loan
        ,avg_day_diff_event_result_1_event_type_loan
        ,avg_day_diff_shift1_event_type_repay_all
        ,avg_day_diff_type_light_all
        ,cnt_channel_hb_all
        ,cnt_channel_hb_uid_recent_days_180
        ,cnt_channel_hb_uid_recent_days_540
        ,cnt_event_result_0_uid_recent_days_540
        ,cnt_event_result_1_type_heavy_all
        ,cnt_event_result_1_uid_recent_days_120
        ,cnt_event_result_1_uid_recent_days_360
        ,cnt_event_type_credit_event_result_1_all
        ,cnt_event_type_limit_type_heavy_all
        ,cnt_event_type_loan_all
        ,cnt_event_type_loan_event_result_1_all
        ,cnt_event_type_loan_type_heavy_all
        ,cnt_event_type_loan_uid_recent_days_30
        ,cnt_event_type_repay_all
        ,cnt_event_type_repay_event_result_1_all
        ,cnt_event_type_repay_other_info_manual_repay
        ,cnt_event_type_repay_type_heavy_all
        ,cnt_event_type_repay_uid_recent_days_180
        ,cnt_event_type_repay_uid_recent_days_360
        ,cnt_event_type_repay_uid_recent_days_540
        ,cnt_other_info_auto_deduct_uid_recent_days_120
        ,cnt_other_info_auto_deduct_uid_recent_days_540
        ,cnt_other_info_cash_uid_recent_days_14
        ,cnt_other_info_cash_uid_recent_days_30
        ,cnt_other_info_cash_uid_recent_days_360
        ,cnt_other_info_cash_uid_recent_days_540
        ,cnt_other_info_light_uid_recent_days_360
        ,cnt_other_info_manual_repay_all
        ,cnt_other_info_manual_repay_uid_recent_days_90
        ,cnt_type_heavy_uid_recent_days_180
        ,cnt_type_heavy_uid_recent_days_540
        ,cnt_type_light_uid_recent_days_30
        ,cnt_type_light_uid_recent_days_90
        ,day_diff_shift1_n_unique_all
        ,div_amt_event_type_repay_loan
        ,max_amt_event_result_1_event_type_loan
        ,max_amt_event_type_limit_recent_30
        ,max_amt_event_type_loan
        ,max_amt_event_type_loan_event_result_1_recent_180
        ,max_amt_event_type_loan_event_result_1_recent_30
        ,max_amt_event_type_loan_recent_180
        ,max_amt_event_type_loan_recent_60
        ,max_amt_event_type_repay_event_result_1
        ,max_amt_event_type_repay_event_result_1_recent_180
        ,max_amt_event_type_repay_event_result_1_recent_30
        ,max_amt_event_type_repay_event_result_1_recent_60
        ,max_amt_event_type_repay_recent_180
        ,max_amt_event_type_repay_recent_60
        ,max_amt_other_info_auto_deduct
        ,max_amt_other_info_manual_repay
        ,max_amt_recent_days_30
        ,max_amt_recent_days_60
        ,max_amt_recent_days_90
        ,max_amt_type_light
        ,mean_amt_event_result_1_event_type_loan
        ,mean_amt_recent_days_360
        ,mean_day_diff_event_result_0_event_type_loan_all
        ,min_amt_channel_hb
        ,min_amt_event_type_credit_all
        ,min_amt_event_type_credit_event_result_1
        ,min_amt_event_type_limit_recent_60
        ,min_amt_event_type_repay_event_result_1
        ,min_amt_event_type_repay_recent_180
        ,n_unique_channel_event_result_1
        ,n_unique_channel_event_type_repay
        ,n_unique_day_diff_event_result_1
        ,n_unique_day_diff_event_type_repay
        ,n_unique_day_diff_shift1_event_type_loan
        ,n_unique_event_type_day_diff_shift1_event_type_loan
        ,n_unique_other_info_event_type_credit
        ,per_event_type_limit_all
        ,per_uid_recent_days_120
        ,redu_amt_event_type_repay_loan
        ,std_amt_channel_hb
        ,stddev_amt_event_type_limit_recent_30
        ,stddev_amt_event_type_repay_all
        ,stddev_amt_event_type_repay_event_result_1_recent_180
        ,stddev_amt_event_type_repay_recent_180
        ,stddev_amt_recent_days_90
        ,stddev_day_diff
        ,stddev_day_diff_event_type_repay_all
        ,stddev_day_diff_shift1_event_type_repay_all
        ,sum_day_diff_event_type_repay_all
        ,sum_day_diff_shift1_event_type_loan_all
        ,sum_day_diff_type_heavy_all
        ,sum_event_result_day_diff_shift1_event_result_0_all
        ,day_diff_first_event_result_10
        ,day_diff_first_limit_repay
        ,day_diff_last_repay_loan
        ,first_amt_channel_hb_microcredit_lv1_all
        ,first_amt_event_result_0_all
        ,first_amt_event_type_credit_all
        ,first_amt_event_type_limit_recent_30
        ,first_day_diff_event_result_0_event_type_loan_all
        ,first_day_diff_event_result_1_all
        ,first_day_diff_event_result_1_event_type_repay_all
        ,first_day_diff_event_type_repay_all
        ,last_amt_channel_hb_microcredit_lv1_all
        ,last_amt_type_light_all
        ,last_day_diff_event_result_0_event_type_loan_all
        ,last_day_diff_event_result_1_all
        ,last_event_type_day_diff_shift1_event_type_repay_all
        ,median_amt_channel_hb_microcredit_lv1_all
        ,median_amt_event_result_0_all
        ,median_amt_event_result_0_event_type_limit
        ,median_amt_event_result_1_all
        ,median_amt_event_result_1_event_type_repay
        ,median_amt_event_result_1_event_type_repay_recent_180
        ,median_amt_event_result_1_event_type_repay_recent_30
        ,median_amt_event_result_1_event_type_repay_recent_60
        ,median_amt_event_type_limit_all
        ,median_amt_event_type_limit_recent_180
        ,median_amt_event_type_limit_recent_60
        ,median_amt_event_type_loan_recent_180
        ,median_amt_event_type_repay_recent_180
        ,median_amt_event_type_repay_recent_30
        ,median_amt_event_type_repay_recent_60
        ,median_amt_other_info_auto_deduct_all
        ,median_amt_other_info_cash_all
        ,median_amt_recent_days_120
        ,median_amt_recent_days_180
        ,median_amt_recent_days_30
        ,median_amt_recent_days_60
        ,median_amt_recent_days_90
        ,succloan_stage_num_mean_all
        ,succloan_day_diff_reud_stage_num_sum_all
        ,succloan_day_diff_reud_stage_num_min_all
        ,succloan_day_diff_reud_stage_num_first_all
from 
 ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
LEFT OUTER JOIN dwa_risk.dwa_risk_light_and_heavy_credit_and_loan_feature_batch_1_df t1 on model_data.uid = t1.uid
LEFT OUTER JOIN dwa_risk.dwa_risk_light_and_heavy_credit_and_loan_feature_batch_2_df t2 on model_data.uid = t2.uid
LEFT OUTER JOIN dwa_risk.dwa_risk_light_and_heavy_credit_and_loan_feature_batch_3_df t3 on model_data.uid = t3.uid
;
-- feature-copilot:node-end ordinal=0
