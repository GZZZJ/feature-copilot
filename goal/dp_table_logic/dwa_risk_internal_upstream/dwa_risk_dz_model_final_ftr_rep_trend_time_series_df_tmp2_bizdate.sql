-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_bizdate
-- node_id: n_6185014349510606850
-- task_name: dwa_risk_dz_model_final_ftr_rep_trend_time_series_df
-- owner_name: 黄皓俞
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_bizdate.json
-- source_json_sha256: 93f3aedc6cc6abf5d012c9b01d79e61c4a499be6d8b4b92d6b98d4f12b3cbcd7
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_bizdate
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part2_bizdate

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 黄皓俞
--创建日期: 2024-09-11 11:34:41
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df(
uid  string  comment '客户号'
,mdl_dte  string  comment '模型评分日'
,3m_repay_ftr_amt_first_der_max string comment '未来3个月应还金额一阶导数的最大值'
,6m_repay_ftr_amt_first_der_max string comment '未来6个月应还金额一阶导数的最大值'
,12m_repay_ftr_amt_first_der_max string comment '未来12个月应还金额一阶导数的最大值'
,18m_repay_ftr_amt_first_der_max string comment '未来18个月应还金额一阶导数的最大值'
,3m_repay_ftr_amt_first_der_min string comment '未来3个月应还金额一阶导数的最小值'
,6m_repay_ftr_amt_first_der_min string comment '未来6个月应还金额一阶导数的最小值'
,12m_repay_ftr_amt_first_der_min string comment '未来12个月应还金额一阶导数的最小值'
,18m_repay_ftr_amt_first_der_min string comment '未来18个月应还金额一阶导数的最小值'
,3m_repay_ftr_amt_first_der_avg string comment '未来3个月应还金额一阶导数的平均值'
,6m_repay_ftr_amt_first_der_avg string comment '未来6个月应还金额一阶导数的平均值'
,12m_repay_ftr_amt_first_der_avg string comment '未来12个月应还金额一阶导数的平均值'
,18m_repay_ftr_amt_first_der_avg string comment '未来18个月应还金额一阶导数的平均值'
,3m_repay_ftr_amt_first_der_median string comment '未来3个月应还金额一阶导数的中位数'
,6m_repay_ftr_amt_first_der_median string comment '未来6个月应还金额一阶导数的中位数'
,12m_repay_ftr_amt_first_der_median string comment '未来12个月应还金额一阶导数的中位数'
,18m_repay_ftr_amt_first_der_median string comment '未来18个月应还金额一阶导数的中位数'
,3m_repay_ftr_amt_first_der_stddev string comment '未来3个月应还金额一阶导数的标准差'
,6m_repay_ftr_amt_first_der_stddev string comment '未来6个月应还金额一阶导数的标准差'
,12m_repay_ftr_amt_first_der_stddev string comment '未来12个月应还金额一阶导数的标准差'
,18m_repay_ftr_amt_first_der_stddev string comment '未来18个月应还金额一阶导数的标准差'
,3m_repay_ftr_amt_first_der_sum string comment '未来3个月应还金额一阶导数的和'
,6m_repay_ftr_amt_first_der_sum string comment '未来6个月应还金额一阶导数的和'
,12m_repay_ftr_amt_first_der_sum string comment '未来12个月应还金额一阶导数的和'
,18m_repay_ftr_amt_first_der_sum string comment '未来18个月应还金额一阶导数的和'
,3m_repay_ftr_amt_first_der_great_0_count string comment '未来3个月应还金额一阶导数大于0的次数'
,6m_repay_ftr_amt_first_der_great_0_count string comment '未来6个月应还金额一阶导数大于0的次数'
,12m_repay_ftr_amt_first_der_great_0_count string comment '未来12个月应还金额一阶导数大于0的次数'
,18m_repay_ftr_amt_first_der_great_0_count string comment '未来18个月应还金额一阶导数大于0的次数'
,3m_repay_ftr_amt_first_der_great_0_sum string comment '未来3个月应还金额一阶导数大于0的和'
,6m_repay_ftr_amt_first_der_great_0_sum string comment '未来6个月应还金额一阶导数大于0的和'
,12m_repay_ftr_amt_first_der_great_0_sum string comment '未来12个月应还金额一阶导数大于0的和'
,18m_repay_ftr_amt_first_der_great_0_sum string comment '未来18个月应还金额一阶导数大于0的和'
,3m_repay_ftr_amt_first_der_small_0_count string comment '未来3个月应还金额一阶导数小于0的次数'
,6m_repay_ftr_amt_first_der_small_0_count string comment '未来6个月应还金额一阶导数小于0的次数'
,12m_repay_ftr_amt_first_der_small_0_count string comment '未来12个月应还金额一阶导数小于0的次数'
,18m_repay_ftr_amt_first_der_small_0_count string comment '未来18个月应还金额一阶导数小于0的次数'
,3m_repay_ftr_amt_first_der_small_0_sum string comment '未来3个月应还金额一阶导数小于0的和'
,6m_repay_ftr_amt_first_der_small_0_sum string comment '未来6个月应还金额一阶导数小于0的和'
,12m_repay_ftr_amt_first_der_small_0_sum string comment '未来12个月应还金额一阶导数小于0的和'
,18m_repay_ftr_amt_first_der_small_0_sum string comment '未来18个月应还金额一阶导数小于0的和'
,3m_repay_ftr_amt_first_der_mean_diff string comment '未来3个月应还金额一阶导数前一半和后一半均值的差'
,6m_repay_ftr_amt_first_der_mean_diff string comment '未来6个月应还金额一阶导数前一半和后一半均值的差'
,12m_repay_ftr_amt_first_der_mean_diff string comment '未来12个月应还金额一阶导数前一半和后一半均值的差'
,18m_repay_ftr_amt_first_der_mean_diff string comment '未来18个月应还金额一阶导数前一半和后一半均值的差'
,3m_repay_ftr_amt_first_der_mean_rto string comment '未来3个月应还金额一阶导数前一半和后一半均值的比值'
,6m_repay_ftr_amt_first_der_mean_rto string comment '未来6个月应还金额一阶导数前一半和后一半均值的比值'
,12m_repay_ftr_amt_first_der_mean_rto string comment '未来12个月应还金额一阶导数前一半和后一半均值的比值'
,18m_repay_ftr_amt_first_der_mean_rto string comment '未来18个月应还金额一阶导数前一半和后一半均值的比值'

,3m_repay_ftr_amt_second_der_max string comment '未来3个月应还金额二阶导数的最大值'
,6m_repay_ftr_amt_second_der_max string comment '未来6个月应还金额二阶导数的最大值'
,12m_repay_ftr_amt_second_der_max string comment '未来12个月应还金额二阶导数的最大值'
,18m_repay_ftr_amt_second_der_max string comment '未来18个月应还金额二阶导数的最大值'
,3m_repay_ftr_amt_second_der_min string comment '未来3个月应还金额二阶导数的最小值'
,6m_repay_ftr_amt_second_der_min string comment '未来6个月应还金额二阶导数的最小值'
,12m_repay_ftr_amt_second_der_min string comment '未来12个月应还金额二阶导数的最小值'
,18m_repay_ftr_amt_second_der_min string comment '未来18个月应还金额二阶导数的最小值'
,3m_repay_ftr_amt_second_der_avg string comment '未来3个月应还金额二阶导数的平均值'
,6m_repay_ftr_amt_second_der_avg string comment '未来6个月应还金额二阶导数的平均值'
,12m_repay_ftr_amt_second_der_avg string comment '未来12个月应还金额二阶导数的平均值'
,18m_repay_ftr_amt_second_der_avg string comment '未来18个月应还金额二阶导数的平均值'
,3m_repay_ftr_amt_second_der_median string comment '未来3个月应还金额二阶导数的中位数'
,6m_repay_ftr_amt_second_der_median string comment '未来6个月应还金额二阶导数的中位数'
,12m_repay_ftr_amt_second_der_median string comment '未来12个月应还金额二阶导数的中位数'
,18m_repay_ftr_amt_second_der_median string comment '未来18个月应还金额二阶导数的中位数'
,3m_repay_ftr_amt_second_der_stddev string comment '未来3个月应还金额二阶导数的标准差'
,6m_repay_ftr_amt_second_der_stddev string comment '未来6个月应还金额二阶导数的标准差'
,12m_repay_ftr_amt_second_der_stddev string comment '未来12个月应还金额二阶导数的标准差'
,18m_repay_ftr_amt_second_der_stddev string comment '未来18个月应还金额二阶导数的标准差'
,3m_repay_ftr_amt_second_der_sum string comment '未来3个月应还金额二阶导数的和'
,6m_repay_ftr_amt_second_der_sum string comment '未来6个月应还金额二阶导数的和'
,12m_repay_ftr_amt_second_der_sum string comment '未来12个月应还金额二阶导数的和'
,18m_repay_ftr_amt_second_der_sum string comment '未来18个月应还金额二阶导数的和'
,3m_repay_ftr_amt_second_der_great_0_count string comment '未来3个月应还金额二阶导数大于0的次数'
,6m_repay_ftr_amt_second_der_great_0_count string comment '未来6个月应还金额二阶导数大于0的次数'
,12m_repay_ftr_amt_second_der_great_0_count string comment '未来12个月应还金额二阶导数大于0的次数'
,18m_repay_ftr_amt_second_der_great_0_count string comment '未来18个月应还金额二阶导数大于0的次数'
,3m_repay_ftr_amt_second_der_great_0_sum string comment '未来3个月应还金额二阶导数大于0的和'
,6m_repay_ftr_amt_second_der_great_0_sum string comment '未来6个月应还金额二阶导数大于0的和'
,12m_repay_ftr_amt_second_der_great_0_sum string comment '未来12个月应还金额二阶导数大于0的和'
,18m_repay_ftr_amt_second_der_great_0_sum string comment '未来18个月应还金额二阶导数大于0的和'
,3m_repay_ftr_amt_second_der_small_0_count string comment '未来3个月应还金额二阶导数小于0的次数'
,6m_repay_ftr_amt_second_der_small_0_count string comment '未来6个月应还金额二阶导数小于0的次数'
,12m_repay_ftr_amt_second_der_small_0_count string comment '未来12个月应还金额二阶导数小于0的次数'
,18m_repay_ftr_amt_second_der_small_0_count string comment '未来18个月应还金额二阶导数小于0的次数'
,3m_repay_ftr_amt_second_der_small_0_sum string comment '未来3个月应还金额二阶导数小于0的和'
,6m_repay_ftr_amt_second_der_small_0_sum string comment '未来6个月应还金额二阶导数小于0的和'
,12m_repay_ftr_amt_second_der_small_0_sum string comment '未来12个月应还金额二阶导数小于0的和'
,18m_repay_ftr_amt_second_der_small_0_sum string comment '未来18个月应还金额二阶导数小于0的和'
,3m_repay_ftr_amt_second_der_mean_diff string comment '未来3个月应还金额二阶导数前一半和后一半均值的差'
,6m_repay_ftr_amt_second_der_mean_diff string comment '未来6个月应还金额二阶导数前一半和后一半均值的差'
,12m_repay_ftr_amt_second_der_mean_diff string comment '未来12个月应还金额二阶导数前一半和后一半均值的差'
,18m_repay_ftr_amt_second_der_mean_diff string comment '未来18个月应还金额二阶导数前一半和后一半均值的差'
,3m_repay_ftr_amt_second_der_mean_rto string comment '未来3个月应还金额二阶导数前一半和后一半均值的比值'
,6m_repay_ftr_amt_second_der_mean_rto string comment '未来6个月应还金额二阶导数前一半和后一半均值的比值'
,12m_repay_ftr_amt_second_der_mean_rto string comment '未来12个月应还金额二阶导数前一半和后一半均值的比值'
,18m_repay_ftr_amt_second_der_mean_rto string comment '未来18个月应还金额二阶导数前一半和后一半均值的比值'

,6m_ftr_con_asc_repay_amt_max string comment '未来6个月应还金额连续上升次数的最大次数'
,6m_ftr_con_dsc_repay_amt_max string comment '未来6个月应还金额连续下降次数的最大次数'
,6m_ftr_con_keep_repay_amt_max string comment '未来6个月应还金额连续持平次数的最大次数'
,9m_ftr_con_asc_repay_amt_max string comment '未来9个月应还金额连续上升次数的最大次数'
,9m_ftr_con_dsc_repay_amt_max string comment '未来9个月应还金额连续下降次数的最大次数'
,9m_ftr_con_keep_repay_amt_max string comment '未来9个月应还金额连续持平次数的最大次数'
,12m_ftr_con_asc_repay_amt_max string comment '未来12个月应还金额连续上升次数的最大次数'
,12m_ftr_con_dsc_repay_amt_max string comment '未来12个月应还金额连续下降次数的最大次数'
,12m_ftr_con_keep_repay_amt_max string comment '未来12个月应还金额连续持平次数的最大次数'
,18m_ftr_con_asc_repay_amt_max string comment '未来18个月应还金额连续上升次数的最大次数'
,18m_ftr_con_dsc_repay_amt_max string comment '未来18个月应还金额连续下降次数的最大次数'
,18m_ftr_con_keep_repay_amt_max string comment '未来18个月应还金额连续持平次数的最大次数'
  
) comment '贷中未来应还金额时间序列变量' partitioned by (ds string comment '业务日期分区，格式yyyymmdd');

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp1_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp1_${bizdate} as

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
                    ,loan_date
                    ,loan_original_principal
                    ,(case when date(t2.due_date) > add_months(to_date(mdl_dte),0) and date(t2.due_date) <=  add_months(to_date(mdl_dte),1) then 1
                            when date(t2.due_date) > add_months(to_date(mdl_dte),1) and date(t2.due_date) <=  add_months(to_date(mdl_dte),2) then 2
                            when date(t2.due_date) > add_months(to_date(mdl_dte),2) and date(t2.due_date) <=  add_months(to_date(mdl_dte),3) then 3
                            when date(t2.due_date) > add_months(to_date(mdl_dte),3) and date(t2.due_date) <=  add_months(to_date(mdl_dte),4) then 4
                            when date(t2.due_date) > add_months(to_date(mdl_dte),4) and date(t2.due_date) <=  add_months(to_date(mdl_dte),5) then 5
                            when date(t2.due_date) > add_months(to_date(mdl_dte),5) and date(t2.due_date) <=  add_months(to_date(mdl_dte),6) then 6
                            when date(t2.due_date) > add_months(to_date(mdl_dte),6) and date(t2.due_date) <=  add_months(to_date(mdl_dte),7) then 7
                            when date(t2.due_date) > add_months(to_date(mdl_dte),7) and date(t2.due_date) <=  add_months(to_date(mdl_dte),8) then 8
                            when date(t2.due_date) > add_months(to_date(mdl_dte),8) and date(t2.due_date) <=  add_months(to_date(mdl_dte),9) then 9
                            when date(t2.due_date) > add_months(to_date(mdl_dte),9) and date(t2.due_date) <=  add_months(to_date(mdl_dte),10) then 10
                            when date(t2.due_date) > add_months(to_date(mdl_dte),10) and date(t2.due_date) <=  add_months(to_date(mdl_dte),11) then 11
                            when date(t2.due_date) > add_months(to_date(mdl_dte),11) and date(t2.due_date) <=  add_months(to_date(mdl_dte),12) then 12
                            when date(t2.due_date) > add_months(to_date(mdl_dte),12) and date(t2.due_date) <=  add_months(to_date(mdl_dte),13) then 13
                            when date(t2.due_date) > add_months(to_date(mdl_dte),13) and date(t2.due_date) <=  add_months(to_date(mdl_dte),14) then 14
                            when date(t2.due_date) > add_months(to_date(mdl_dte),14) and date(t2.due_date) <=  add_months(to_date(mdl_dte),15) then 15
                            when date(t2.due_date) > add_months(to_date(mdl_dte),15) and date(t2.due_date) <=  add_months(to_date(mdl_dte),16) then 16
                            when date(t2.due_date) > add_months(to_date(mdl_dte),16) and date(t2.due_date) <=  add_months(to_date(mdl_dte),17) then 17
                            when date(t2.due_date) > add_months(to_date(mdl_dte),17) and date(t2.due_date) <=  add_months(to_date(mdl_dte),18) then 18
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
                        ,loan_date
                        ,original_loan_principal as loan_original_principal
                        from cdmx.cdmx_fct_heavy_stage_plan_df
                        where   ds='${bizdate}'
                                and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                and  due_date is not null
                                and  substr(order_no,1,2) in ('BT','CH','BL','HE')
                ) t2
                on t1.uid = t2.uid and date(t2.due_date) <=  add_months(to_date(mdl_dte),18) and date(t2.due_date) >= date(t1.mdl_dte) and  date(t2.loan_date) < date(t1.mdl_dte)
        ) where rn is not null 
        group by uid, rn
;




drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate} as
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
                                                
                                                    from ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp1_${bizdate}
                                        )
                        )
        )
;

drop table if EXISTS ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part1_${bizdate} as
select   
        uid
        ,max( case when rn <= 3 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_max
        ,max( case when rn <= 6 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_max
        ,max( case when rn <= 12 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_max
        ,max( case when rn <= 18 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_max

        ,min( case when rn <= 3 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_min
        ,min( case when rn <= 6 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_min
        ,min( case when rn <= 12 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_min
        ,min( case when rn <= 18 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_min

        ,avg( case when rn <= 3 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_avg
        ,avg( case when rn <= 6 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_avg
        ,avg( case when rn <= 12 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_avg
        ,avg( case when rn <= 18 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_avg

        ,median( case when rn <= 3 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_median
        ,median( case when rn <= 6 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_median
        ,median( case when rn <= 12 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_median
        ,median( case when rn <= 18 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_median

        ,stddev( case when rn <= 3 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_stddev
        ,stddev( case when rn <= 6 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_stddev
        ,stddev( case when rn <= 12 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_stddev
        ,stddev( case when rn <= 18 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_stddev

        ,sum( case when rn <= 3 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_sum
        ,sum( case when rn <= 6 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_sum
        ,sum( case when rn <= 12 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_sum
        ,sum( case when rn <= 18 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_sum

        ,count( case when rn <= 3 and first_derivative > 0 then 1 else null end) as 3m_repay_ftr_amt_first_der_great_0_count
        ,count( case when rn <= 6 and first_derivative > 0 then 1 else null end) as 6m_repay_ftr_amt_first_der_great_0_count
        ,count( case when rn <= 12 and first_derivative > 0 then 1 else null end) as 12m_repay_ftr_amt_first_der_great_0_count
        ,count( case when rn <= 18 and first_derivative > 0 then 1 else null end) as 18m_repay_ftr_amt_first_der_great_0_count

        ,sum( case when rn <= 3 and first_derivative > 0 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_great_0_sum
        ,sum( case when rn <= 6 and first_derivative > 0 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_great_0_sum
        ,sum( case when rn <= 12 and first_derivative > 0 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_great_0_sum
        ,sum( case when rn <= 18 and first_derivative > 0 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_great_0_sum

        ,count( case when rn <= 3 and first_derivative < 0 then 1 else null end) as 3m_repay_ftr_amt_first_der_small_0_count
        ,count( case when rn <= 6 and first_derivative < 0 then 1 else null end) as 6m_repay_ftr_amt_first_der_small_0_count
        ,count( case when rn <= 12 and first_derivative < 0 then 1 else null end) as 12m_repay_ftr_amt_first_der_small_0_count
        ,count( case when rn <= 18 and first_derivative < 0 then 1 else null end) as 18m_repay_ftr_amt_first_der_small_0_count

        ,sum( case when rn <= 3 and first_derivative < 0 then first_derivative else null end) as 3m_repay_ftr_amt_first_der_small_0_sum
        ,sum( case when rn <= 6 and first_derivative < 0 then first_derivative else null end) as 6m_repay_ftr_amt_first_der_small_0_sum
        ,sum( case when rn <= 12 and first_derivative < 0 then first_derivative else null end) as 12m_repay_ftr_amt_first_der_small_0_sum
        ,sum( case when rn <= 18 and first_derivative < 0 then first_derivative else null end) as 18m_repay_ftr_amt_first_der_small_0_sum

        ,avg(case when rn <= 1 then first_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then first_derivative else 0 end) 
            as 3m_repay_ftr_amt_first_der_mean_diff
        ,avg(case when rn <= 3 then first_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then first_derivative else 0 end) 
            as 6m_repay_ftr_amt_first_der_mean_diff
        ,avg(case when rn <= 6 then first_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then first_derivative else 0 end) 
            as 12m_repay_ftr_amt_first_der_mean_diff
        ,avg(case when rn <= 9 then first_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then first_derivative else 0 end) 
            as 18m_repay_ftr_amt_first_der_mean_diff

        ,avg(case when rn <= 1 then first_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then first_derivative else null end) 
            as 3m_repay_ftr_amt_first_der_mean_rto
        ,avg(case when rn <= 3 then first_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then first_derivative else null end) 
            as 6m_repay_ftr_amt_first_der_mean_rto
        ,avg(case when rn <= 6 then first_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then first_derivative else null end) 
            as 12m_repay_ftr_amt_first_der_mean_rto
        ,avg(case when rn <= 9 then first_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then first_derivative else null end) 
            as 18m_repay_ftr_amt_first_der_mean_rto

        -- second derivative 
        ,max( case when rn <= 3 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_max
        ,max( case when rn <= 6 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_max
        ,max( case when rn <= 12 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_max
        ,max( case when rn <= 18 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_max

        ,min( case when rn <= 3 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_min
        ,min( case when rn <= 6 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_min
        ,min( case when rn <= 12 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_min
        ,min( case when rn <= 18 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_min

        ,avg( case when rn <= 3 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_avg
        ,avg( case when rn <= 6 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_avg
        ,avg( case when rn <= 12 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_avg
        ,avg( case when rn <= 18 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_avg

        ,median( case when rn <= 3 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_median
        ,median( case when rn <= 6 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_median
        ,median( case when rn <= 12 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_median
        ,median( case when rn <= 18 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_median

        ,stddev( case when rn <= 3 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_stddev
        ,stddev( case when rn <= 6 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_stddev
        ,stddev( case when rn <= 12 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_stddev
        ,stddev( case when rn <= 18 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_stddev

        ,sum( case when rn <= 3 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_sum
        ,sum( case when rn <= 6 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_sum
        ,sum( case when rn <= 12 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_sum
        ,sum( case when rn <= 18 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_sum

        ,count( case when rn <= 3 and second_derivative > 0 then 1 else null end) as 3m_repay_ftr_amt_second_der_great_0_count
        ,count( case when rn <= 6 and second_derivative > 0 then 1 else null end) as 6m_repay_ftr_amt_second_der_great_0_count
        ,count( case when rn <= 12 and second_derivative > 0 then 1 else null end) as 12m_repay_ftr_amt_second_der_great_0_count
        ,count( case when rn <= 18 and second_derivative > 0 then 1 else null end) as 18m_repay_ftr_amt_second_der_great_0_count

        ,sum( case when rn <= 3 and second_derivative > 0 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_great_0_sum
        ,sum( case when rn <= 6 and second_derivative > 0 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_great_0_sum
        ,sum( case when rn <= 12 and second_derivative > 0 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_great_0_sum
        ,sum( case when rn <= 18 and second_derivative > 0 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_great_0_sum

        ,count( case when rn <= 3 and second_derivative < 0 then 1 else null end) as 3m_repay_ftr_amt_second_der_small_0_count
        ,count( case when rn <= 6 and second_derivative < 0 then 1 else null end) as 6m_repay_ftr_amt_second_der_small_0_count
        ,count( case when rn <= 12 and second_derivative < 0 then 1 else null end) as 12m_repay_ftr_amt_second_der_small_0_count
        ,count( case when rn <= 18 and second_derivative < 0 then 1 else null end) as 18m_repay_ftr_amt_second_der_small_0_count

        ,sum( case when rn <= 3 and second_derivative < 0 then second_derivative else null end) as 3m_repay_ftr_amt_second_der_small_0_sum
        ,sum( case when rn <= 6 and second_derivative < 0 then second_derivative else null end) as 6m_repay_ftr_amt_second_der_small_0_sum
        ,sum( case when rn <= 12 and second_derivative < 0 then second_derivative else null end) as 12m_repay_ftr_amt_second_der_small_0_sum
        ,sum( case when rn <= 18 and second_derivative < 0 then second_derivative else null end) as 18m_repay_ftr_amt_second_der_small_0_sum

        ,avg(case when rn <= 1 then second_derivative else 0 end) - avg(case when rn <= 3 and rn > 1 then second_derivative else 0 end) 
            as 3m_repay_ftr_amt_second_der_mean_diff
        ,avg(case when rn <= 3 then second_derivative else 0 end) - avg(case when rn <= 6 and rn > 3 then second_derivative else 0 end) 
            as 6m_repay_ftr_amt_second_der_mean_diff
        ,avg(case when rn <= 6 then second_derivative else 0 end) - avg(case when rn <= 12 and rn > 6 then second_derivative else 0 end) 
            as 12m_repay_ftr_amt_second_der_mean_diff
        ,avg(case when rn <= 9 then second_derivative else 0 end) - avg(case when rn <= 18 and rn > 9 then second_derivative else 0 end) 
            as 18m_repay_ftr_amt_second_der_mean_diff

        ,avg(case when rn <= 1 then second_derivative else 0 end) / avg(case when rn <= 3 and rn > 1 then second_derivative else null end) 
            as 3m_repay_ftr_amt_second_der_mean_rto
        ,avg(case when rn <= 3 then second_derivative else 0 end) / avg(case when rn <= 6 and rn > 3 then second_derivative else null end) 
            as 6m_repay_ftr_amt_second_der_mean_rto
        ,avg(case when rn <= 6 then second_derivative else 0 end) / avg(case when rn <= 12 and rn > 6 then second_derivative else null end) 
            as 12m_repay_ftr_amt_second_der_mean_rto
        ,avg(case when rn <= 9 then second_derivative else 0 end) / avg(case when rn <= 18 and rn > 9 then second_derivative else null end) 
            as 18m_repay_ftr_amt_second_der_mean_rto



from ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate}
group by uid
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part2_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part2_${bizdate} as
select
        t1.uid
        ,6m_ftr_con_asc_repay_amt_max
        ,6m_ftr_con_dsc_repay_amt_max
        ,6m_ftr_con_keep_repay_amt_max
        ,9m_ftr_con_asc_repay_amt_max
        ,9m_ftr_con_dsc_repay_amt_max
        ,9m_ftr_con_keep_repay_amt_max
        ,12m_ftr_con_asc_repay_amt_max
        ,12m_ftr_con_dsc_repay_amt_max
        ,12m_ftr_con_keep_repay_amt_max
        ,18m_ftr_con_asc_repay_amt_max
        ,18m_ftr_con_dsc_repay_amt_max
        ,18m_ftr_con_keep_repay_amt_max   
from
        (    
        
        select 
                uid
                ,max(case when repay_status = 1 then times else 0 end) as 6m_ftr_con_asc_repay_amt_max
                ,max(case when repay_status = 0 then times else 0 end) as 6m_ftr_con_dsc_repay_amt_max
                ,max(case when repay_status = 3 then times else 0 end) as 6m_ftr_con_keep_repay_amt_max
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
                                                from ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate}
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
                ,max(case when repay_status = 1 then times else 0 end) as 9m_ftr_con_asc_repay_amt_max
                ,max(case when repay_status = 0 then times else 0 end) as 9m_ftr_con_dsc_repay_amt_max
                ,max(case when repay_status = 3 then times else 0 end) as 9m_ftr_con_keep_repay_amt_max
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
                                                from ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate}
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
        ,max(case when repay_status = 1 then times else 0 end) as 12m_ftr_con_asc_repay_amt_max
        ,max(case when repay_status = 0 then times else 0 end) as 12m_ftr_con_dsc_repay_amt_max
        ,max(case when repay_status = 3 then times else 0 end) as 12m_ftr_con_keep_repay_amt_max
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
                                        from ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate}
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
            ,max(case when repay_status = 1 then times else 0 end) as 18m_ftr_con_asc_repay_amt_max
            ,max(case when repay_status = 0 then times else 0 end) as 18m_ftr_con_dsc_repay_amt_max
            ,max(case when repay_status = 3 then times else 0 end) as 18m_ftr_con_keep_repay_amt_max
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
                                            from ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate}
                                            where rn <= 18
                                    )
            
                        ) group by uid, row2-row1, repay_status
            )
            group by uid

) t4
on t1.uid = t4.uid;

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df partition(ds = '${bizdate}')
select  a.uid,
        a.mdl_dte,
        3m_repay_ftr_amt_first_der_max,
         6m_repay_ftr_amt_first_der_max,
         12m_repay_ftr_amt_first_der_max,
         18m_repay_ftr_amt_first_der_max,
         3m_repay_ftr_amt_first_der_min,
         6m_repay_ftr_amt_first_der_min,
         12m_repay_ftr_amt_first_der_min,
         18m_repay_ftr_amt_first_der_min,
         3m_repay_ftr_amt_first_der_avg,
         6m_repay_ftr_amt_first_der_avg,
         12m_repay_ftr_amt_first_der_avg,
         18m_repay_ftr_amt_first_der_avg,
         3m_repay_ftr_amt_first_der_median,
         6m_repay_ftr_amt_first_der_median,
         12m_repay_ftr_amt_first_der_median,
         18m_repay_ftr_amt_first_der_median,
         3m_repay_ftr_amt_first_der_stddev,
         6m_repay_ftr_amt_first_der_stddev,
         12m_repay_ftr_amt_first_der_stddev,
         18m_repay_ftr_amt_first_der_stddev,
         3m_repay_ftr_amt_first_der_sum,
         6m_repay_ftr_amt_first_der_sum,
         12m_repay_ftr_amt_first_der_sum,
         18m_repay_ftr_amt_first_der_sum,
         3m_repay_ftr_amt_first_der_great_0_count,
         6m_repay_ftr_amt_first_der_great_0_count,
         12m_repay_ftr_amt_first_der_great_0_count,
         18m_repay_ftr_amt_first_der_great_0_count,
         3m_repay_ftr_amt_first_der_great_0_sum,
         6m_repay_ftr_amt_first_der_great_0_sum,
         12m_repay_ftr_amt_first_der_great_0_sum,
         18m_repay_ftr_amt_first_der_great_0_sum,
         3m_repay_ftr_amt_first_der_small_0_count,
         6m_repay_ftr_amt_first_der_small_0_count,
         12m_repay_ftr_amt_first_der_small_0_count,
         18m_repay_ftr_amt_first_der_small_0_count,
         3m_repay_ftr_amt_first_der_small_0_sum,
         6m_repay_ftr_amt_first_der_small_0_sum,
         12m_repay_ftr_amt_first_der_small_0_sum,
         18m_repay_ftr_amt_first_der_small_0_sum,
         3m_repay_ftr_amt_first_der_mean_diff,
         6m_repay_ftr_amt_first_der_mean_diff,
         12m_repay_ftr_amt_first_der_mean_diff,
         18m_repay_ftr_amt_first_der_mean_diff,
         3m_repay_ftr_amt_first_der_mean_rto,
         6m_repay_ftr_amt_first_der_mean_rto,
         12m_repay_ftr_amt_first_der_mean_rto,
         18m_repay_ftr_amt_first_der_mean_rto,
         3m_repay_ftr_amt_second_der_max,
         6m_repay_ftr_amt_second_der_max,
         12m_repay_ftr_amt_second_der_max,
         18m_repay_ftr_amt_second_der_max,
         3m_repay_ftr_amt_second_der_min,
         6m_repay_ftr_amt_second_der_min,
         12m_repay_ftr_amt_second_der_min,
         18m_repay_ftr_amt_second_der_min,
         3m_repay_ftr_amt_second_der_avg,
         6m_repay_ftr_amt_second_der_avg,
         12m_repay_ftr_amt_second_der_avg,
         18m_repay_ftr_amt_second_der_avg,
         3m_repay_ftr_amt_second_der_median,
         6m_repay_ftr_amt_second_der_median,
         12m_repay_ftr_amt_second_der_median,
         18m_repay_ftr_amt_second_der_median,
         3m_repay_ftr_amt_second_der_stddev,
         6m_repay_ftr_amt_second_der_stddev,
         12m_repay_ftr_amt_second_der_stddev,
         18m_repay_ftr_amt_second_der_stddev,
         3m_repay_ftr_amt_second_der_sum,
         6m_repay_ftr_amt_second_der_sum,
         12m_repay_ftr_amt_second_der_sum,
         18m_repay_ftr_amt_second_der_sum,
         3m_repay_ftr_amt_second_der_great_0_count,
         6m_repay_ftr_amt_second_der_great_0_count,
         12m_repay_ftr_amt_second_der_great_0_count,
         18m_repay_ftr_amt_second_der_great_0_count,
         3m_repay_ftr_amt_second_der_great_0_sum,
         6m_repay_ftr_amt_second_der_great_0_sum,
         12m_repay_ftr_amt_second_der_great_0_sum,
         18m_repay_ftr_amt_second_der_great_0_sum,
         3m_repay_ftr_amt_second_der_small_0_count,
         6m_repay_ftr_amt_second_der_small_0_count,
         12m_repay_ftr_amt_second_der_small_0_count,
         18m_repay_ftr_amt_second_der_small_0_count,
         3m_repay_ftr_amt_second_der_small_0_sum,
         6m_repay_ftr_amt_second_der_small_0_sum,
         12m_repay_ftr_amt_second_der_small_0_sum,
         18m_repay_ftr_amt_second_der_small_0_sum,
         3m_repay_ftr_amt_second_der_mean_diff,
         6m_repay_ftr_amt_second_der_mean_diff,
         12m_repay_ftr_amt_second_der_mean_diff,
         18m_repay_ftr_amt_second_der_mean_diff,
         3m_repay_ftr_amt_second_der_mean_rto,
         6m_repay_ftr_amt_second_der_mean_rto,
         12m_repay_ftr_amt_second_der_mean_rto,
         18m_repay_ftr_amt_second_der_mean_rto,
         6m_ftr_con_asc_repay_amt_max,
         6m_ftr_con_dsc_repay_amt_max,
         6m_ftr_con_keep_repay_amt_max,
         9m_ftr_con_asc_repay_amt_max,
         9m_ftr_con_dsc_repay_amt_max,
         9m_ftr_con_keep_repay_amt_max,
         12m_ftr_con_asc_repay_amt_max,
         12m_ftr_con_dsc_repay_amt_max,
         12m_ftr_con_keep_repay_amt_max,
         18m_ftr_con_asc_repay_amt_max,
         18m_ftr_con_dsc_repay_amt_max,
         18m_ftr_con_keep_repay_amt_max
         from
(
    select  uid,
            date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base
) a  
left join ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part1_${bizdate} as b
on a.uid = b.uid 
left join ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part2_${bizdate} as c
on a.uid = c.uid 
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_ftr_rep_trend_time_series_df_part2_${bizdate};
-- feature-copilot:node-end ordinal=0
