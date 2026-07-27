-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_bizdate
-- node_id: n_6185036683340546048
-- task_name: dwa_risk_dz_model_final_his_apply_trend_time_series_df
-- owner_name: 黄皓俞
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_bizdate.json
-- source_json_sha256: dc87d7af12bbece25247a6cdbe73c4d2fff8d5ff1c06b08e245e700c584ca92c
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part2_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp1_bizdate

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 黄皓俞
--创建日期: 2024-09-10 14:42:53
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df(
uid  string  comment '客户号'
,mdl_dte  string  comment '模型评分日'
,3ord_apply_amt_first_der_max string comment '近3笔订单申请金额一阶导数的最大值'
,6ord_apply_amt_first_der_max string comment '近6笔订单申请金额一阶导数的最大值'
,12ord_apply_amt_first_der_max string comment '近12笔订单申请金额一阶导数的最大值'
,18ord_apply_amt_first_der_max string comment '近18笔订单申请金额一阶导数的最大值'
,3ord_apply_amt_first_der_min string comment '近3笔订单申请金额一阶导数的最小值'
,6ord_apply_amt_first_der_min string comment '近6笔订单申请金额一阶导数的最小值'
,12ord_apply_amt_first_der_min string comment '近12笔订单申请金额一阶导数的最小值'
,18ord_apply_amt_first_der_min string comment '近18笔订单申请金额一阶导数的最小值'
,3ord_apply_amt_first_der_avg string comment '近3笔订单申请金额一阶导数的平均值'
,6ord_apply_amt_first_der_avg string comment '近6笔订单申请金额一阶导数的平均值'
,12ord_apply_amt_first_der_avg string comment '近12笔订单申请金额一阶导数的平均值'
,18ord_apply_amt_first_der_avg string comment '近18笔订单申请金额一阶导数的平均值'
,3ord_apply_amt_first_der_median string comment '近3笔订单申请金额一阶导数的中位数'
,6ord_apply_amt_first_der_median string comment '近6笔订单申请金额一阶导数的中位数'
,12ord_apply_amt_first_der_median string comment '近12笔订单申请金额一阶导数的中位数'
,18ord_apply_amt_first_der_median string comment '近18笔订单申请金额一阶导数的中位数'
,3ord_apply_amt_first_der_stddev string comment '近3笔订单申请金额一阶导数的标准差'
,6ord_apply_amt_first_der_stddev string comment '近6笔订单申请金额一阶导数的标准差'
,12ord_apply_amt_first_der_stddev string comment '近12笔订单申请金额一阶导数的标准差'
,18ord_apply_amt_first_der_stddev string comment '近18笔订单申请金额一阶导数的标准差'
,3ord_apply_amt_first_der_sum string comment '近3笔订单申请金额一阶导数的和'
,6ord_apply_amt_first_der_sum string comment '近6笔订单申请金额一阶导数的和'
,12ord_apply_amt_first_der_sum string comment '近12笔订单申请金额一阶导数的和'
,18ord_apply_amt_first_der_sum string comment '近18笔订单申请金额一阶导数的和'
,3ord_apply_amt_first_der_great_0_count string comment '近3笔订单申请金额一阶导数大于0的次数'
,6ord_apply_amt_first_der_great_0_count string comment '近6笔订单申请金额一阶导数大于0的次数'
,12ord_apply_amt_first_der_great_0_count string comment '近12笔订单申请金额一阶导数大于0的次数'
,18ord_apply_amt_first_der_great_0_count string comment '近18笔订单申请金额一阶导数大于0的次数'
,3ord_apply_amt_first_der_great_0_sum string comment '近3笔订单申请金额一阶导数大于0的和'
,6ord_apply_amt_first_der_great_0_sum string comment '近6笔订单申请金额一阶导数大于0的和'
,12ord_apply_amt_first_der_great_0_sum string comment '近12笔订单申请金额一阶导数大于0的和'
,18ord_apply_amt_first_der_great_0_sum string comment '近18笔订单申请金额一阶导数大于0的和'
,3ord_apply_amt_first_der_small_0_count string comment '近3笔订单申请金额一阶导数小于0的次数'
,6ord_apply_amt_first_der_small_0_count string comment '近6笔订单申请金额一阶导数小于0的次数'
,12ord_apply_amt_first_der_small_0_count string comment '近12笔订单申请金额一阶导数小于0的次数'
,18ord_apply_amt_first_der_small_0_count string comment '近18笔订单申请金额一阶导数小于0的次数'
,3ord_apply_amt_first_der_small_0_sum string comment '近3笔订单申请金额一阶导数小于0的和'
,6ord_apply_amt_first_der_small_0_sum string comment '近6笔订单申请金额一阶导数小于0的和'
,12ord_apply_amt_first_der_small_0_sum string comment '近12笔订单申请金额一阶导数小于0的和'
,18ord_apply_amt_first_der_small_0_sum string comment '近18笔订单申请金额一阶导数小于0的和'
,3ord_apply_amt_first_der_mean_diff string comment '近3笔订单申请金额一阶导数前一半和后一半均值的差'
,6ord_apply_amt_first_der_mean_diff string comment '近6笔订单申请金额一阶导数前一半和后一半均值的差'
,12ord_apply_amt_first_der_mean_diff string comment '近12笔订单申请金额一阶导数前一半和后一半均值的差'
,18ord_apply_amt_first_der_mean_diff string comment '近18笔订单申请金额一阶导数前一半和后一半均值的差'
,3ord_apply_amt_first_der_mean_rto string comment '近3笔订单申请金额一阶导数前一半和后一半均值的比值'
,6ord_apply_amt_first_der_mean_rto string comment '近6笔订单申请金额一阶导数前一半和后一半均值的比值'
,12ord_apply_amt_first_der_mean_rto string comment '近12笔订单申请金额一阶导数前一半和后一半均值的比值'
,18ord_apply_amt_first_der_mean_rto string comment '近18笔订单申请金额一阶导数前一半和后一半均值的比值'

,3ord_apply_amt_second_der_max string comment '近3笔订单申请金额二阶导数的最大值'
,6ord_apply_amt_second_der_max string comment '近6笔订单申请金额二阶导数的最大值'
,12ord_apply_amt_second_der_max string comment '近12笔订单申请金额二阶导数的最大值'
,18ord_apply_amt_second_der_max string comment '近18笔订单申请金额二阶导数的最大值'
,3ord_apply_amt_second_der_min string comment '近3笔订单申请金额二阶导数的最小值'
,6ord_apply_amt_second_der_min string comment '近6笔订单申请金额二阶导数的最小值'
,12ord_apply_amt_second_der_min string comment '近12笔订单申请金额二阶导数的最小值'
,18ord_apply_amt_second_der_min string comment '近18笔订单申请金额二阶导数的最小值'
,3ord_apply_amt_second_der_avg string comment '近3笔订单申请金额二阶导数的平均值'
,6ord_apply_amt_second_der_avg string comment '近6笔订单申请金额二阶导数的平均值'
,12ord_apply_amt_second_der_avg string comment '近12笔订单申请金额二阶导数的平均值'
,18ord_apply_amt_second_der_avg string comment '近18笔订单申请金额二阶导数的平均值'
,3ord_apply_amt_second_der_median string comment '近3笔订单申请金额二阶导数的中位数'
,6ord_apply_amt_second_der_median string comment '近6笔订单申请金额二阶导数的中位数'
,12ord_apply_amt_second_der_median string comment '近12笔订单申请金额二阶导数的中位数'
,18ord_apply_amt_second_der_median string comment '近18笔订单申请金额二阶导数的中位数'
,3ord_apply_amt_second_der_stddev string comment '近3笔订单申请金额二阶导数的标准差'
,6ord_apply_amt_second_der_stddev string comment '近6笔订单申请金额二阶导数的标准差'
,12ord_apply_amt_second_der_stddev string comment '近12笔订单申请金额二阶导数的标准差'
,18ord_apply_amt_second_der_stddev string comment '近18笔订单申请金额二阶导数的标准差'
,3ord_apply_amt_second_der_sum string comment '近3笔订单申请金额二阶导数的和'
,6ord_apply_amt_second_der_sum string comment '近6笔订单申请金额二阶导数的和'
,12ord_apply_amt_second_der_sum string comment '近12笔订单申请金额二阶导数的和'
,18ord_apply_amt_second_der_sum string comment '近18笔订单申请金额二阶导数的和'
,3ord_apply_amt_second_der_great_0_count string comment '近3笔订单申请金额二阶导数大于0的次数'
,6ord_apply_amt_second_der_great_0_count string comment '近6笔订单申请金额二阶导数大于0的次数'
,12ord_apply_amt_second_der_great_0_count string comment '近12笔订单申请金额二阶导数大于0的次数'
,18ord_apply_amt_second_der_great_0_count string comment '近18笔订单申请金额二阶导数大于0的次数'
,3ord_apply_amt_second_der_great_0_sum string comment '近3笔订单申请金额二阶导数大于0的和'
,6ord_apply_amt_second_der_great_0_sum string comment '近6笔订单申请金额二阶导数大于0的和'
,12ord_apply_amt_second_der_great_0_sum string comment '近12笔订单申请金额二阶导数大于0的和'
,18ord_apply_amt_second_der_great_0_sum string comment '近18笔订单申请金额二阶导数大于0的和'
,3ord_apply_amt_second_der_small_0_count string comment '近3笔订单申请金额二阶导数小于0的次数'
,6ord_apply_amt_second_der_small_0_count string comment '近6笔订单申请金额二阶导数小于0的次数'
,12ord_apply_amt_second_der_small_0_count string comment '近12笔订单申请金额二阶导数小于0的次数'
,18ord_apply_amt_second_der_small_0_count string comment '近18笔订单申请金额二阶导数小于0的次数'
,3ord_apply_amt_second_der_small_0_sum string comment '近3笔订单申请金额二阶导数小于0的和'
,6ord_apply_amt_second_der_small_0_sum string comment '近6笔订单申请金额二阶导数小于0的和'
,12ord_apply_amt_second_der_small_0_sum string comment '近12笔订单申请金额二阶导数小于0的和'
,18ord_apply_amt_second_der_small_0_sum string comment '近18笔订单申请金额二阶导数小于0的和'
,3ord_apply_amt_second_der_mean_diff string comment '近3笔订单申请金额二阶导数前一半和后一半均值的差'
,6ord_apply_amt_second_der_mean_diff string comment '近6笔订单申请金额二阶导数前一半和后一半均值的差'
,12ord_apply_amt_second_der_mean_diff string comment '近12笔订单申请金额二阶导数前一半和后一半均值的差'
,18ord_apply_amt_second_der_mean_diff string comment '近18笔订单申请金额二阶导数前一半和后一半均值的差'
,3ord_apply_amt_second_der_mean_rto string comment '近3笔订单申请金额二阶导数前一半和后一半均值的比值'
,6ord_apply_amt_second_der_mean_rto string comment '近6笔订单申请金额二阶导数前一半和后一半均值的比值'
,12ord_apply_amt_second_der_mean_rto string comment '近12笔订单申请金额二阶导数前一半和后一半均值的比值'
,18ord_apply_amt_second_der_mean_rto string comment '近18笔订单申请金额二阶导数前一半和后一半均值的比值'

,6thord_con_asc_apply_amt_max string comment '近6笔订单申请金额连续上升次数的最大次数'
,6thord_con_dsc_apply_amt_max string comment '近6笔订单申请金额连续下降次数的最大次数'
,6thord_con_keep_apply_amt_max string comment '近6笔订单申请金额连续持平次数的最大次数'
,9thord_con_asc_apply_amt_max string comment '近9笔订单申请金额连续上升次数的最大次数'
,9thord_con_dsc_apply_amt_max string comment '近9笔订单申请金额连续下降次数的最大次数'
,9thord_con_keep_apply_amt_max string comment '近9笔订单申请金额连续持平次数的最大次数'
,12thord_con_asc_apply_amt_max string comment '近12笔订单申请金额连续上升次数的最大次数'
,12thord_con_dsc_apply_amt_max string comment '近12笔订单申请金额连续下降次数的最大次数'
,12thord_con_keep_apply_amt_max string comment '近12笔订单申请金额连续持平次数的最大次数'
,18thord_con_asc_apply_amt_max string comment '近18笔订单申请金额连续上升次数的最大次数'
,18thord_con_dsc_apply_amt_max string comment '近18笔订单申请金额连续下降次数的最大次数'
,18thord_con_keep_apply_amt_max string comment '近18笔订单申请金额连续持平次数的最大次数'
  
) comment '贷中申请金额时间序列变量' partitioned by (ds string comment '业务日期分区，格式yyyymmdd');


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp1_${bizdate} as

 select  
         uid
        ,rn
        ,crt_tim
        ,prc_amt
 from (         


                select 
                        uid
                        ,mdl_dte
                        ,crt_tim
                        ,sum(prc_amt) as prc_amt
                        
                        ,row_number() over (partition by uid, mdl_dte order by crt_tim desc) as rn   
                from 
                (
                            select 
                                    t1.*
                                    ,prc_amt
                                    ,crt_tim
                                    ,stg_num
                            from  
                            (
                                select  uid,
                                        date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                                from ${dwa_risk}.dwa_risk_f_dz_model_data_base
                            ) t1  -- 样本
                            left join 
                            (
                                    select uid
                                            ,order_no
                                            ,crt_time
                                            ,coalesce(loan_principal_amount,apply_amount) as prc_amt 
                                            ,coalesce(init_total_stage,apply_total_stage) stg_num
                                            ,apply_record_crt_time crt_tim
                                            ,coalesce(loan_date,date(apply_record_crt_time)) as loan_date
                                    from    dwt.dwt_heavy_order_df
                                    where   ds='${bizdate}'
                                            and  loan_success_flag = 1
                                            and  substr(order_no,1,2) in ('BT','CH','BL','HE')   
                    
                            ) t3  -- order
                            on t1.uid=t3.uid and date(t3.loan_date) > add_months(to_date(mdl_dte),-18) and date(t3.crt_tim) < date(t1.mdl_dte)
                    ) group by uid, mdl_dte, crt_tim
        ) where rn <= 20;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate} as
select 
        uid
        ,rn
        ,first_derivative
        ,(first_derivative - previous_first_derivative) / (DATEDIFF(crt_tim,previous_crt_tim,'mi')/(60*24)) as second_derivative
        from  
        (
                select 
                                uid
                                ,rn
                                ,first_derivative
                                ,crt_tim
                                ,lead(first_derivative,1,null) over (partition by uid order by rn asc) as previous_first_derivative
                                ,lead(crt_tim,1,null) over (partition by uid order by rn asc) as previous_crt_tim
                        from 
                        (
                                select 
                                        uid
                                        ,rn
                                        ,(prc_amt -  previous_prc_amt) / (DATEDIFF(crt_tim,previous_crt_tim,'mi')/(60*24))  as first_derivative
                                        ,crt_tim
                                        from
                                        (
                                                select 
                                                        uid
                                                        ,rn
                                                        ,prc_amt
                                                        ,crt_tim
                                                        ,lead(prc_amt,1,null) over (partition by uid order by rn asc) as previous_prc_amt
                                                        ,lead(crt_tim,1,null) over (partition by uid order by rn asc) as previous_crt_tim             
                                                        from ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp1_${bizdate}
                                        )
                        )
        )
;





drop table if EXISTS ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part1_${bizdate} as
select   
        uid
        ,max( case when rn <= 3 then first_derivative else null end) as 3ord_apply_amt_first_der_max
        ,max( case when rn <= 6 then first_derivative else null end) as 6ord_apply_amt_first_der_max
        ,max( case when rn <= 12 then first_derivative else null end) as 12ord_apply_amt_first_der_max
        ,max( case when rn <= 18 then first_derivative else null end) as 18ord_apply_amt_first_der_max

        ,min( case when rn <= 3 then first_derivative else null end) as 3ord_apply_amt_first_der_min
        ,min( case when rn <= 6 then first_derivative else null end) as 6ord_apply_amt_first_der_min
        ,min( case when rn <= 12 then first_derivative else null end) as 12ord_apply_amt_first_der_min
        ,min( case when rn <= 18 then first_derivative else null end) as 18ord_apply_amt_first_der_min

        ,avg( case when rn <= 3 then first_derivative else null end) as 3ord_apply_amt_first_der_avg
        ,avg( case when rn <= 6 then first_derivative else null end) as 6ord_apply_amt_first_der_avg
        ,avg( case when rn <= 12 then first_derivative else null end) as 12ord_apply_amt_first_der_avg
        ,avg( case when rn <= 18 then first_derivative else null end) as 18ord_apply_amt_first_der_avg

        ,median( case when rn <= 3 then first_derivative else null end) as 3ord_apply_amt_first_der_median
        ,median( case when rn <= 6 then first_derivative else null end) as 6ord_apply_amt_first_der_median
        ,median( case when rn <= 12 then first_derivative else null end) as 12ord_apply_amt_first_der_median
        ,median( case when rn <= 18 then first_derivative else null end) as 18ord_apply_amt_first_der_median

        ,stddev( case when rn <= 3 then first_derivative else null end) as 3ord_apply_amt_first_der_stddev
        ,stddev( case when rn <= 6 then first_derivative else null end) as 6ord_apply_amt_first_der_stddev
        ,stddev( case when rn <= 12 then first_derivative else null end) as 12ord_apply_amt_first_der_stddev
        ,stddev( case when rn <= 18 then first_derivative else null end) as 18ord_apply_amt_first_der_stddev

        ,sum( case when rn <= 3 then first_derivative else null end) as 3ord_apply_amt_first_der_sum
        ,sum( case when rn <= 6 then first_derivative else null end) as 6ord_apply_amt_first_der_sum
        ,sum( case when rn <= 12 then first_derivative else null end) as 12ord_apply_amt_first_der_sum
        ,sum( case when rn <= 18 then first_derivative else null end) as 18ord_apply_amt_first_der_sum

        ,count( case when rn <= 3 and first_derivative > 0 then 1 else null end) as 3ord_apply_amt_first_der_great_0_count
        ,count( case when rn <= 6 and first_derivative > 0 then 1 else null end) as 6ord_apply_amt_first_der_great_0_count
        ,count( case when rn <= 12 and first_derivative > 0 then 1 else null end) as 12ord_apply_amt_first_der_great_0_count
        ,count( case when rn <= 18 and first_derivative > 0 then 1 else null end) as 18ord_apply_amt_first_der_great_0_count

        ,sum( case when rn <= 3 and first_derivative > 0 then first_derivative else null end) as 3ord_apply_amt_first_der_great_0_sum
        ,sum( case when rn <= 6 and first_derivative > 0 then first_derivative else null end) as 6ord_apply_amt_first_der_great_0_sum
        ,sum( case when rn <= 12 and first_derivative > 0 then first_derivative else null end) as 12ord_apply_amt_first_der_great_0_sum
        ,sum( case when rn <= 18 and first_derivative > 0 then first_derivative else null end) as 18ord_apply_amt_first_der_great_0_sum

        ,count( case when rn <= 3 and first_derivative < 0 then 1 else null end) as 3ord_apply_amt_first_der_small_0_count
        ,count( case when rn <= 6 and first_derivative < 0 then 1 else null end) as 6ord_apply_amt_first_der_small_0_count
        ,count( case when rn <= 12 and first_derivative < 0 then 1 else null end) as 12ord_apply_amt_first_der_small_0_count
        ,count( case when rn <= 18 and first_derivative < 0 then 1 else null end) as 18ord_apply_amt_first_der_small_0_count

        ,sum( case when rn <= 3 and first_derivative < 0 then first_derivative else null end) as 3ord_apply_amt_first_der_small_0_sum
        ,sum( case when rn <= 6 and first_derivative < 0 then first_derivative else null end) as 6ord_apply_amt_first_der_small_0_sum
        ,sum( case when rn <= 12 and first_derivative < 0 then first_derivative else null end) as 12ord_apply_amt_first_der_small_0_sum
        ,sum( case when rn <= 18 and first_derivative < 0 then first_derivative else null end) as 18ord_apply_amt_first_der_small_0_sum

        ,avg(case when rn <= 1 then first_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then first_derivative else 0 end) 
            as 3ord_apply_amt_first_der_mean_diff
        ,avg(case when rn <= 3 then first_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then first_derivative else 0 end) 
            as 6ord_apply_amt_first_der_mean_diff
        ,avg(case when rn <= 6 then first_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then first_derivative else 0 end) 
            as 12ord_apply_amt_first_der_mean_diff
        ,avg(case when rn <= 9 then first_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then first_derivative else 0 end) 
            as 18ord_apply_amt_first_der_mean_diff

        ,avg(case when rn <= 1 then first_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then first_derivative else null end) 
            as 3ord_apply_amt_first_der_mean_rto
        ,avg(case when rn <= 3 then first_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then first_derivative else null end) 
            as 6ord_apply_amt_first_der_mean_rto
        ,avg(case when rn <= 6 then first_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then first_derivative else null end) 
            as 12ord_apply_amt_first_der_mean_rto
        ,avg(case when rn <= 9 then first_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then first_derivative else null end) 
            as 18ord_apply_amt_first_der_mean_rto

        -- second derivative 
        ,max( case when rn <= 3 then second_derivative else null end) as 3ord_apply_amt_second_der_max
        ,max( case when rn <= 6 then second_derivative else null end) as 6ord_apply_amt_second_der_max
        ,max( case when rn <= 12 then second_derivative else null end) as 12ord_apply_amt_second_der_max
        ,max( case when rn <= 18 then second_derivative else null end) as 18ord_apply_amt_second_der_max

        ,min( case when rn <= 3 then second_derivative else null end) as 3ord_apply_amt_second_der_min
        ,min( case when rn <= 6 then second_derivative else null end) as 6ord_apply_amt_second_der_min
        ,min( case when rn <= 12 then second_derivative else null end) as 12ord_apply_amt_second_der_min
        ,min( case when rn <= 18 then second_derivative else null end) as 18ord_apply_amt_second_der_min

        ,avg( case when rn <= 3 then second_derivative else null end) as 3ord_apply_amt_second_der_avg
        ,avg( case when rn <= 6 then second_derivative else null end) as 6ord_apply_amt_second_der_avg
        ,avg( case when rn <= 12 then second_derivative else null end) as 12ord_apply_amt_second_der_avg
        ,avg( case when rn <= 18 then second_derivative else null end) as 18ord_apply_amt_second_der_avg

        ,median( case when rn <= 3 then second_derivative else null end) as 3ord_apply_amt_second_der_median
        ,median( case when rn <= 6 then second_derivative else null end) as 6ord_apply_amt_second_der_median
        ,median( case when rn <= 12 then second_derivative else null end) as 12ord_apply_amt_second_der_median
        ,median( case when rn <= 18 then second_derivative else null end) as 18ord_apply_amt_second_der_median

        ,stddev( case when rn <= 3 then second_derivative else null end) as 3ord_apply_amt_second_der_stddev
        ,stddev( case when rn <= 6 then second_derivative else null end) as 6ord_apply_amt_second_der_stddev
        ,stddev( case when rn <= 12 then second_derivative else null end) as 12ord_apply_amt_second_der_stddev
        ,stddev( case when rn <= 18 then second_derivative else null end) as 18ord_apply_amt_second_der_stddev

        ,sum( case when rn <= 3 then second_derivative else null end) as 3ord_apply_amt_second_der_sum
        ,sum( case when rn <= 6 then second_derivative else null end) as 6ord_apply_amt_second_der_sum
        ,sum( case when rn <= 12 then second_derivative else null end) as 12ord_apply_amt_second_der_sum
        ,sum( case when rn <= 18 then second_derivative else null end) as 18ord_apply_amt_second_der_sum

        ,count( case when rn <= 3 and second_derivative > 0 then 1 else null end) as 3ord_apply_amt_second_der_great_0_count
        ,count( case when rn <= 6 and second_derivative > 0 then 1 else null end) as 6ord_apply_amt_second_der_great_0_count
        ,count( case when rn <= 12 and second_derivative > 0 then 1 else null end) as 12ord_apply_amt_second_der_great_0_count
        ,count( case when rn <= 18 and second_derivative > 0 then 1 else null end) as 18ord_apply_amt_second_der_great_0_count

        ,sum( case when rn <= 3 and second_derivative > 0 then second_derivative else null end) as 3ord_apply_amt_second_der_great_0_sum
        ,sum( case when rn <= 6 and second_derivative > 0 then second_derivative else null end) as 6ord_apply_amt_second_der_great_0_sum
        ,sum( case when rn <= 12 and second_derivative > 0 then second_derivative else null end) as 12ord_apply_amt_second_der_great_0_sum
        ,sum( case when rn <= 18 and second_derivative > 0 then second_derivative else null end) as 18ord_apply_amt_second_der_great_0_sum

        ,count( case when rn <= 3 and second_derivative < 0 then 1 else null end) as 3ord_apply_amt_second_der_small_0_count
        ,count( case when rn <= 6 and second_derivative < 0 then 1 else null end) as 6ord_apply_amt_second_der_small_0_count
        ,count( case when rn <= 12 and second_derivative < 0 then 1 else null end) as 12ord_apply_amt_second_der_small_0_count
        ,count( case when rn <= 18 and second_derivative < 0 then 1 else null end) as 18ord_apply_amt_second_der_small_0_count

        ,sum( case when rn <= 3 and second_derivative < 0 then second_derivative else null end) as 3ord_apply_amt_second_der_small_0_sum
        ,sum( case when rn <= 6 and second_derivative < 0 then second_derivative else null end) as 6ord_apply_amt_second_der_small_0_sum
        ,sum( case when rn <= 12 and second_derivative < 0 then second_derivative else null end) as 12ord_apply_amt_second_der_small_0_sum
        ,sum( case when rn <= 18 and second_derivative < 0 then second_derivative else null end) as 18ord_apply_amt_second_der_small_0_sum

        ,avg(case when rn <= 1 then second_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then second_derivative else 0 end) 
            as 3ord_apply_amt_second_der_mean_diff
        ,avg(case when rn <= 3 then second_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then second_derivative else 0 end) 
            as 6ord_apply_amt_second_der_mean_diff
        ,avg(case when rn <= 6 then second_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then second_derivative else 0 end) 
            as 12ord_apply_amt_second_der_mean_diff
        ,avg(case when rn <= 9 then second_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then second_derivative else 0 end) 
            as 18ord_apply_amt_second_der_mean_diff

        ,avg(case when rn <= 1 then second_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then second_derivative else null end) 
            as 3ord_apply_amt_second_der_mean_rto
        ,avg(case when rn <= 3 then second_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then second_derivative else null end) 
            as 6ord_apply_amt_second_der_mean_rto
        ,avg(case when rn <= 6 then second_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then second_derivative else null end) 
            as 12ord_apply_amt_second_der_mean_rto
        ,avg(case when rn <= 9 then second_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then second_derivative else null end) 
            as 18ord_apply_amt_second_der_mean_rto



from ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate}
group by uid
;


drop table if EXISTS ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part2_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part2_${bizdate} as
select
        t1.uid
        ,6thord_con_asc_apply_amt_max
        ,6thord_con_dsc_apply_amt_max
        ,6thord_con_keep_apply_amt_max
        ,9thord_con_asc_apply_amt_max
        ,9thord_con_dsc_apply_amt_max
        ,9thord_con_keep_apply_amt_max
        ,12thord_con_asc_apply_amt_max
        ,12thord_con_dsc_apply_amt_max
        ,12thord_con_keep_apply_amt_max
        ,18thord_con_asc_apply_amt_max
        ,18thord_con_dsc_apply_amt_max
        ,18thord_con_keep_apply_amt_max   
from
        (    
        
        select 
                uid
                ,max(case when repay_status = 1 then times else 0 end) as 6thord_con_asc_apply_amt_max
                ,max(case when repay_status = 0 then times else 0 end) as 6thord_con_dsc_apply_amt_max
                ,max(case when repay_status = 3 then times else 0 end) as 6thord_con_keep_apply_amt_max
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
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate}
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
                ,max(case when repay_status = 1 then times else 0 end) as 9thord_con_asc_apply_amt_max
                ,max(case when repay_status = 0 then times else 0 end) as 9thord_con_dsc_apply_amt_max
                ,max(case when repay_status = 3 then times else 0 end) as 9thord_con_keep_apply_amt_max
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
                                                from ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate}
                                                where rn <= 9
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
        ,max(case when repay_status = 1 then times else 0 end) as 12thord_con_asc_apply_amt_max
        ,max(case when repay_status = 0 then times else 0 end) as 12thord_con_dsc_apply_amt_max
        ,max(case when repay_status = 3 then times else 0 end) as 12thord_con_keep_apply_amt_max
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
                                        from ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate}
                                        where rn <= 12
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
            ,max(case when repay_status = 1 then times else 0 end) as 18thord_con_asc_apply_amt_max
            ,max(case when repay_status = 0 then times else 0 end) as 18thord_con_dsc_apply_amt_max
            ,max(case when repay_status = 3 then times else 0 end) as 18thord_con_keep_apply_amt_max
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
                                            from ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate}
                                            where rn <= 18
                                    )
            
                        ) group by uid, row2-row1, repay_status
            )
            group by uid

) t4
on t1.uid = t4.uid
;

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df partition(ds = '${bizdate}')
select  a.uid,
        a.mdl_dte,
        3ord_apply_amt_first_der_max,
         6ord_apply_amt_first_der_max,
         12ord_apply_amt_first_der_max,
         18ord_apply_amt_first_der_max,
         3ord_apply_amt_first_der_min,
         6ord_apply_amt_first_der_min,
         12ord_apply_amt_first_der_min,
         18ord_apply_amt_first_der_min,
         3ord_apply_amt_first_der_avg,
         6ord_apply_amt_first_der_avg,
         12ord_apply_amt_first_der_avg,
         18ord_apply_amt_first_der_avg,
         3ord_apply_amt_first_der_median,
         6ord_apply_amt_first_der_median,
         12ord_apply_amt_first_der_median,
         18ord_apply_amt_first_der_median,
         3ord_apply_amt_first_der_stddev,
         6ord_apply_amt_first_der_stddev,
         12ord_apply_amt_first_der_stddev,
         18ord_apply_amt_first_der_stddev,
         3ord_apply_amt_first_der_sum,
         6ord_apply_amt_first_der_sum,
         12ord_apply_amt_first_der_sum,
         18ord_apply_amt_first_der_sum,
         3ord_apply_amt_first_der_great_0_count,
         6ord_apply_amt_first_der_great_0_count,
         12ord_apply_amt_first_der_great_0_count,
         18ord_apply_amt_first_der_great_0_count,
         3ord_apply_amt_first_der_great_0_sum,
         6ord_apply_amt_first_der_great_0_sum,
         12ord_apply_amt_first_der_great_0_sum,
         18ord_apply_amt_first_der_great_0_sum,
         3ord_apply_amt_first_der_small_0_count,
         6ord_apply_amt_first_der_small_0_count,
         12ord_apply_amt_first_der_small_0_count,
         18ord_apply_amt_first_der_small_0_count,
         3ord_apply_amt_first_der_small_0_sum,
         6ord_apply_amt_first_der_small_0_sum,
         12ord_apply_amt_first_der_small_0_sum,
         18ord_apply_amt_first_der_small_0_sum,
         3ord_apply_amt_first_der_mean_diff,
         6ord_apply_amt_first_der_mean_diff,
         12ord_apply_amt_first_der_mean_diff,
         18ord_apply_amt_first_der_mean_diff,
         3ord_apply_amt_first_der_mean_rto,
         6ord_apply_amt_first_der_mean_rto,
         12ord_apply_amt_first_der_mean_rto,
         18ord_apply_amt_first_der_mean_rto,
         3ord_apply_amt_second_der_max,
         6ord_apply_amt_second_der_max,
         12ord_apply_amt_second_der_max,
         18ord_apply_amt_second_der_max,
         3ord_apply_amt_second_der_min,
         6ord_apply_amt_second_der_min,
         12ord_apply_amt_second_der_min,
         18ord_apply_amt_second_der_min,
         3ord_apply_amt_second_der_avg,
         6ord_apply_amt_second_der_avg,
         12ord_apply_amt_second_der_avg,
         18ord_apply_amt_second_der_avg,
         3ord_apply_amt_second_der_median,
         6ord_apply_amt_second_der_median,
         12ord_apply_amt_second_der_median,
         18ord_apply_amt_second_der_median,
         3ord_apply_amt_second_der_stddev,
         6ord_apply_amt_second_der_stddev,
         12ord_apply_amt_second_der_stddev,
         18ord_apply_amt_second_der_stddev,
         3ord_apply_amt_second_der_sum,
         6ord_apply_amt_second_der_sum,
         12ord_apply_amt_second_der_sum,
         18ord_apply_amt_second_der_sum,
         3ord_apply_amt_second_der_great_0_count,
         6ord_apply_amt_second_der_great_0_count,
         12ord_apply_amt_second_der_great_0_count,
         18ord_apply_amt_second_der_great_0_count,
         3ord_apply_amt_second_der_great_0_sum,
         6ord_apply_amt_second_der_great_0_sum,
         12ord_apply_amt_second_der_great_0_sum,
         18ord_apply_amt_second_der_great_0_sum,
         3ord_apply_amt_second_der_small_0_count,
         6ord_apply_amt_second_der_small_0_count,
         12ord_apply_amt_second_der_small_0_count,
         18ord_apply_amt_second_der_small_0_count,
         3ord_apply_amt_second_der_small_0_sum,
         6ord_apply_amt_second_der_small_0_sum,
         12ord_apply_amt_second_der_small_0_sum,
         18ord_apply_amt_second_der_small_0_sum,
         3ord_apply_amt_second_der_mean_diff,
         6ord_apply_amt_second_der_mean_diff,
         12ord_apply_amt_second_der_mean_diff,
         18ord_apply_amt_second_der_mean_diff,
         3ord_apply_amt_second_der_mean_rto,
         6ord_apply_amt_second_der_mean_rto,
         12ord_apply_amt_second_der_mean_rto,
         18ord_apply_amt_second_der_mean_rto,
         6thord_con_asc_apply_amt_max,
         6thord_con_dsc_apply_amt_max,
         6thord_con_keep_apply_amt_max,
         9thord_con_asc_apply_amt_max,
         9thord_con_dsc_apply_amt_max,
         9thord_con_keep_apply_amt_max,
         12thord_con_asc_apply_amt_max,
         12thord_con_dsc_apply_amt_max,
         12thord_con_keep_apply_amt_max,
         18thord_con_asc_apply_amt_max,
         18thord_con_dsc_apply_amt_max,
         18thord_con_keep_apply_amt_max

from
(
        select  uid,
                date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
        from ${dwa_risk}.dwa_risk_f_dz_model_data_base
) a  
left join ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part1_${bizdate} as b
on a.uid = b.uid 
left join ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part2_${bizdate} as c
on a.uid = c.uid 
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_his_apply_trend_time_series_df_part2_${bizdate};
-- feature-copilot:node-end ordinal=0
