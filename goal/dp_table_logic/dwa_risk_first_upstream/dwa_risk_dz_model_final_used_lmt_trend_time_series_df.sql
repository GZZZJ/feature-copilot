-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_used_lmt_trend_time_series_df
-- node_id: n_6185031357581361152
-- task_name: dwa_risk_dz_model_final_used_lmt_trend_time_series_df
-- owner_name: 黄皓俞
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_used_lmt_trend_time_series_df.json
-- source_json_sha256: 83c22f6edacc6d08b2840ed01ab241675768f1be073378af0bd41ec76fb04759
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_customer_credit_limit_basic_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_bizdate
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_bizdate

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 黄皓俞
--创建日期: 2024-09-11 10:37:53
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df(
uid  string  comment '客户号'
,mdl_dte  string  comment '模型评分日'
,3m_used_lmt_first_der_max string comment '近3个月额度使用率一阶导数的最大值'
,6m_used_lmt_first_der_max string comment '近6个月额度使用率一阶导数的最大值'
,12m_used_lmt_first_der_max string comment '近12个月额度使用率一阶导数的最大值'
,18m_used_lmt_first_der_max string comment '近18个月额度使用率一阶导数的最大值'
,3m_used_lmt_first_der_min string comment '近3个月额度使用率一阶导数的最小值'
,6m_used_lmt_first_der_min string comment '近6个月额度使用率一阶导数的最小值'
,12m_used_lmt_first_der_min string comment '近12个月额度使用率一阶导数的最小值'
,18m_used_lmt_first_der_min string comment '近18个月额度使用率一阶导数的最小值'
,3m_used_lmt_first_der_avg string comment '近3个月额度使用率一阶导数的平均值'
,6m_used_lmt_first_der_avg string comment '近6个月额度使用率一阶导数的平均值'
,12m_used_lmt_first_der_avg string comment '近12个月额度使用率一阶导数的平均值'
,18m_used_lmt_first_der_avg string comment '近18个月额度使用率一阶导数的平均值'
,3m_used_lmt_first_der_median string comment '近3个月额度使用率一阶导数的中位数'
,6m_used_lmt_first_der_median string comment '近6个月额度使用率一阶导数的中位数'
,12m_used_lmt_first_der_median string comment '近12个月额度使用率一阶导数的中位数'
,18m_used_lmt_first_der_median string comment '近18个月额度使用率一阶导数的中位数'
,3m_used_lmt_first_der_stddev string comment '近3个月额度使用率一阶导数的标准差'
,6m_used_lmt_first_der_stddev string comment '近6个月额度使用率一阶导数的标准差'
,12m_used_lmt_first_der_stddev string comment '近12个月额度使用率一阶导数的标准差'
,18m_used_lmt_first_der_stddev string comment '近18个月额度使用率一阶导数的标准差'
,3m_used_lmt_first_der_sum string comment '近3个月额度使用率一阶导数的和'
,6m_used_lmt_first_der_sum string comment '近6个月额度使用率一阶导数的和'
,12m_used_lmt_first_der_sum string comment '近12个月额度使用率一阶导数的和'
,18m_used_lmt_first_der_sum string comment '近18个月额度使用率一阶导数的和'
,3m_used_lmt_first_der_great_0_count string comment '近3个月额度使用率一阶导数大于0的次数'
,6m_used_lmt_first_der_great_0_count string comment '近6个月额度使用率一阶导数大于0的次数'
,12m_used_lmt_first_der_great_0_count string comment '近12个月额度使用率一阶导数大于0的次数'
,18m_used_lmt_first_der_great_0_count string comment '近18个月额度使用率一阶导数大于0的次数'
,3m_used_lmt_first_der_great_0_sum string comment '近3个月额度使用率一阶导数大于0的和'
,6m_used_lmt_first_der_great_0_sum string comment '近6个月额度使用率一阶导数大于0的和'
,12m_used_lmt_first_der_great_0_sum string comment '近12个月额度使用率一阶导数大于0的和'
,18m_used_lmt_first_der_great_0_sum string comment '近18个月额度使用率一阶导数大于0的和'
,3m_used_lmt_first_der_small_0_count string comment '近3个月额度使用率一阶导数小于0的次数'
,6m_used_lmt_first_der_small_0_count string comment '近6个月额度使用率一阶导数小于0的次数'
,12m_used_lmt_first_der_small_0_count string comment '近12个月额度使用率一阶导数小于0的次数'
,18m_used_lmt_first_der_small_0_count string comment '近18个月额度使用率一阶导数小于0的次数'
,3m_used_lmt_first_der_small_0_sum string comment '近3个月额度使用率一阶导数小于0的和'
,6m_used_lmt_first_der_small_0_sum string comment '近6个月额度使用率一阶导数小于0的和'
,12m_used_lmt_first_der_small_0_sum string comment '近12个月额度使用率一阶导数小于0的和'
,18m_used_lmt_first_der_small_0_sum string comment '近18个月额度使用率一阶导数小于0的和'
,3m_used_lmt_first_der_mean_diff string comment '近3个月额度使用率一阶导数前一半和后一半均值的差'
,6m_used_lmt_first_der_mean_diff string comment '近6个月额度使用率一阶导数前一半和后一半均值的差'
,12m_used_lmt_first_der_mean_diff string comment '近12个月额度使用率一阶导数前一半和后一半均值的差'
,18m_used_lmt_first_der_mean_diff string comment '近18个月额度使用率一阶导数前一半和后一半均值的差'
,3m_used_lmt_first_der_mean_rto string comment '近3个月额度使用率一阶导数前一半和后一半均值的比值'
,6m_used_lmt_first_der_mean_rto string comment '近6个月额度使用率一阶导数前一半和后一半均值的比值'
,12m_used_lmt_first_der_mean_rto string comment '近12个月额度使用率一阶导数前一半和后一半均值的比值'
,18m_used_lmt_first_der_mean_rto string comment '近18个月额度使用率一阶导数前一半和后一半均值的比值'

,3m_used_lmt_second_der_max string comment '近3个月额度使用率二阶导数的最大值'
,6m_used_lmt_second_der_max string comment '近6个月额度使用率二阶导数的最大值'
,12m_used_lmt_second_der_max string comment '近12个月额度使用率二阶导数的最大值'
,18m_used_lmt_second_der_max string comment '近18个月额度使用率二阶导数的最大值'
,3m_used_lmt_second_der_min string comment '近3个月额度使用率二阶导数的最小值'
,6m_used_lmt_second_der_min string comment '近6个月额度使用率二阶导数的最小值'
,12m_used_lmt_second_der_min string comment '近12个月额度使用率二阶导数的最小值'
,18m_used_lmt_second_der_min string comment '近18个月额度使用率二阶导数的最小值'
,3m_used_lmt_second_der_avg string comment '近3个月额度使用率二阶导数的平均值'
,6m_used_lmt_second_der_avg string comment '近6个月额度使用率二阶导数的平均值'
,12m_used_lmt_second_der_avg string comment '近12个月额度使用率二阶导数的平均值'
,18m_used_lmt_second_der_avg string comment '近18个月额度使用率二阶导数的平均值'
,3m_used_lmt_second_der_median string comment '近3个月额度使用率二阶导数的中位数'
,6m_used_lmt_second_der_median string comment '近6个月额度使用率二阶导数的中位数'
,12m_used_lmt_second_der_median string comment '近12个月额度使用率二阶导数的中位数'
,18m_used_lmt_second_der_median string comment '近18个月额度使用率二阶导数的中位数'
,3m_used_lmt_second_der_stddev string comment '近3个月额度使用率二阶导数的标准差'
,6m_used_lmt_second_der_stddev string comment '近6个月额度使用率二阶导数的标准差'
,12m_used_lmt_second_der_stddev string comment '近12个月额度使用率二阶导数的标准差'
,18m_used_lmt_second_der_stddev string comment '近18个月额度使用率二阶导数的标准差'
,3m_used_lmt_second_der_sum string comment '近3个月额度使用率二阶导数的和'
,6m_used_lmt_second_der_sum string comment '近6个月额度使用率二阶导数的和'
,12m_used_lmt_second_der_sum string comment '近12个月额度使用率二阶导数的和'
,18m_used_lmt_second_der_sum string comment '近18个月额度使用率二阶导数的和'
,3m_used_lmt_second_der_great_0_count string comment '近3个月额度使用率二阶导数大于0的次数'
,6m_used_lmt_second_der_great_0_count string comment '近6个月额度使用率二阶导数大于0的次数'
,12m_used_lmt_second_der_great_0_count string comment '近12个月额度使用率二阶导数大于0的次数'
,18m_used_lmt_second_der_great_0_count string comment '近18个月额度使用率二阶导数大于0的次数'
,3m_used_lmt_second_der_great_0_sum string comment '近3个月额度使用率二阶导数大于0的和'
,6m_used_lmt_second_der_great_0_sum string comment '近6个月额度使用率二阶导数大于0的和'
,12m_used_lmt_second_der_great_0_sum string comment '近12个月额度使用率二阶导数大于0的和'
,18m_used_lmt_second_der_great_0_sum string comment '近18个月额度使用率二阶导数大于0的和'
,3m_used_lmt_second_der_small_0_count string comment '近3个月额度使用率二阶导数小于0的次数'
,6m_used_lmt_second_der_small_0_count string comment '近6个月额度使用率二阶导数小于0的次数'
,12m_used_lmt_second_der_small_0_count string comment '近12个月额度使用率二阶导数小于0的次数'
,18m_used_lmt_second_der_small_0_count string comment '近18个月额度使用率二阶导数小于0的次数'
,3m_used_lmt_second_der_small_0_sum string comment '近3个月额度使用率二阶导数小于0的和'
,6m_used_lmt_second_der_small_0_sum string comment '近6个月额度使用率二阶导数小于0的和'
,12m_used_lmt_second_der_small_0_sum string comment '近12个月额度使用率二阶导数小于0的和'
,18m_used_lmt_second_der_small_0_sum string comment '近18个月额度使用率二阶导数小于0的和'
,3m_used_lmt_second_der_mean_diff string comment '近3个月额度使用率二阶导数前一半和后一半均值的差'
,6m_used_lmt_second_der_mean_diff string comment '近6个月额度使用率二阶导数前一半和后一半均值的差'
,12m_used_lmt_second_der_mean_diff string comment '近12个月额度使用率二阶导数前一半和后一半均值的差'
,18m_used_lmt_second_der_mean_diff string comment '近18个月额度使用率二阶导数前一半和后一半均值的差'
,3m_used_lmt_second_der_mean_rto string comment '近3个月额度使用率二阶导数前一半和后一半均值的比值'
,6m_used_lmt_second_der_mean_rto string comment '近6个月额度使用率二阶导数前一半和后一半均值的比值'
,12m_used_lmt_second_der_mean_rto string comment '近12个月额度使用率二阶导数前一半和后一半均值的比值'
,18m_used_lmt_second_der_mean_rto string comment '近18个月额度使用率二阶导数前一半和后一半均值的比值'
  
) comment '贷中额度使用率时间序列变量' partitioned by (ds string comment '业务日期分区，格式yyyymmdd');

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate} as


        select 
                        uid
                        ,rn1
                        ,avg(rto) as lmt_used_rto
                
                        from
                        (
                            select 
                                            t1.uid
                                            ,rto
                                            ,(case when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-1) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),0) then 1
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-2) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-1) then 2
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-3) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-2) then 3
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-4) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-3) then 4
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-5) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-4) then 5
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-6) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-5) then 6
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-7) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-6) then 7
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-8) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-7) then 8
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-9) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-8) then 9
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-10) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-9) then 10
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-11) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-10) then 11
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-12) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-11) then 12
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-13) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-12) then 13
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-14) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-13) then 14
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-15) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-14) then 15
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-16) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-15) then 16
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-17) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-16) then 17
                                                    when date(t2.lmt_mdl_dte) > add_months(to_date(mdl_dte),-18) and date(t2.lmt_mdl_dte) <=  add_months(to_date(mdl_dte),-17) then 18
                                                    else null end ) as rn1
                                                
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
                                                            ,mdl_dte as lmt_mdl_dte
                                                            ,(rsk_adt_lmt_cash - rsk_avl_lmt_cash) / rsk_adt_lmt_cash as rto
                                                    from dwa_risk.dwa_risk_f_customer_credit_limit_basic_df 
                                                    where ds between add_months(to_date('${bizdate}' ,'yyyymmdd'),-18) and '${bizdate}' 
                                                            and rsk_adt_lmt_cash is not null
                                            ) t2   
                                            on t1.uid = t2.uid and t1.mdl_dte > t2.lmt_mdl_dte 
                        ) where rn1 is not null
                        group by uid, rn1;



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate} as
select 
        uid
        ,rn1
        ,first_derivative
        ,first_derivative - previous_first_derivative as second_derivative
        from  
        (
                select 
                                uid
                                ,rn1
                                ,first_derivative
                                ,lead(first_derivative,1,null) over (partition by uid order by rn1 asc) as previous_first_derivative
                        from 
                        (
                                select 
                                        uid
                                        ,rn1
                                        ,lmt_used_rto -  previous_lmt_used_rto as first_derivative
                                        from
                                        (
                                                select 
                                                    uid
                                                    ,rn1
                                                    ,lmt_used_rto
                                                    ,lead(lmt_used_rto,1,null) over (partition by uid order by rn1 asc) as previous_lmt_used_rto
                                                
                                                    from ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate}
                                        )
                        )
        )
;


drop table if EXISTS ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate} as
select   
        uid
        ,max( case when rn1 <= 3 then first_derivative else null end) as 3m_used_lmt_first_der_max
        ,max( case when rn1 <= 6 then first_derivative else null end) as 6m_used_lmt_first_der_max
        ,max( case when rn1 <= 12 then first_derivative else null end) as 12m_used_lmt_first_der_max
        ,max( case when rn1 <= 18 then first_derivative else null end) as 18m_used_lmt_first_der_max

        ,min( case when rn1 <= 3 then first_derivative else null end) as 3m_used_lmt_first_der_min
        ,min( case when rn1 <= 6 then first_derivative else null end) as 6m_used_lmt_first_der_min
        ,min( case when rn1 <= 12 then first_derivative else null end) as 12m_used_lmt_first_der_min
        ,min( case when rn1 <= 18 then first_derivative else null end) as 18m_used_lmt_first_der_min

        ,avg( case when rn1 <= 3 then first_derivative else null end) as 3m_used_lmt_first_der_avg
        ,avg( case when rn1 <= 6 then first_derivative else null end) as 6m_used_lmt_first_der_avg
        ,avg( case when rn1 <= 12 then first_derivative else null end) as 12m_used_lmt_first_der_avg
        ,avg( case when rn1 <= 18 then first_derivative else null end) as 18m_used_lmt_first_der_avg

        ,median( case when rn1 <= 3 then first_derivative else null end) as 3m_used_lmt_first_der_median
        ,median( case when rn1 <= 6 then first_derivative else null end) as 6m_used_lmt_first_der_median
        ,median( case when rn1 <= 12 then first_derivative else null end) as 12m_used_lmt_first_der_median
        ,median( case when rn1 <= 18 then first_derivative else null end) as 18m_used_lmt_first_der_median

        ,stddev( case when rn1 <= 3 then first_derivative else null end) as 3m_used_lmt_first_der_stddev
        ,stddev( case when rn1 <= 6 then first_derivative else null end) as 6m_used_lmt_first_der_stddev
        ,stddev( case when rn1 <= 12 then first_derivative else null end) as 12m_used_lmt_first_der_stddev
        ,stddev( case when rn1 <= 18 then first_derivative else null end) as 18m_used_lmt_first_der_stddev

        ,sum( case when rn1 <= 3 then first_derivative else null end) as 3m_used_lmt_first_der_sum
        ,sum( case when rn1 <= 6 then first_derivative else null end) as 6m_used_lmt_first_der_sum
        ,sum( case when rn1 <= 12 then first_derivative else null end) as 12m_used_lmt_first_der_sum
        ,sum( case when rn1 <= 18 then first_derivative else null end) as 18m_used_lmt_first_der_sum

        ,count( case when rn1 <= 3 and first_derivative > 0 then 1 else null end) as 3m_used_lmt_first_der_great_0_count
        ,count( case when rn1 <= 6 and first_derivative > 0 then 1 else null end) as 6m_used_lmt_first_der_great_0_count
        ,count( case when rn1 <= 12 and first_derivative > 0 then 1 else null end) as 12m_used_lmt_first_der_great_0_count
        ,count( case when rn1 <= 18 and first_derivative > 0 then 1 else null end) as 18m_used_lmt_first_der_great_0_count

        ,sum( case when rn1 <= 3 and first_derivative > 0 then first_derivative else null end) as 3m_used_lmt_first_der_great_0_sum
        ,sum( case when rn1 <= 6 and first_derivative > 0 then first_derivative else null end) as 6m_used_lmt_first_der_great_0_sum
        ,sum( case when rn1 <= 12 and first_derivative > 0 then first_derivative else null end) as 12m_used_lmt_first_der_great_0_sum
        ,sum( case when rn1 <= 18 and first_derivative > 0 then first_derivative else null end) as 18m_used_lmt_first_der_great_0_sum

        ,count( case when rn1 <= 3 and first_derivative < 0 then 1 else null end) as 3m_used_lmt_first_der_small_0_count
        ,count( case when rn1 <= 6 and first_derivative < 0 then 1 else null end) as 6m_used_lmt_first_der_small_0_count
        ,count( case when rn1 <= 12 and first_derivative < 0 then 1 else null end) as 12m_used_lmt_first_der_small_0_count
        ,count( case when rn1 <= 18 and first_derivative < 0 then 1 else null end) as 18m_used_lmt_first_der_small_0_count

        ,sum( case when rn1 <= 3 and first_derivative < 0 then first_derivative else null end) as 3m_used_lmt_first_der_small_0_sum
        ,sum( case when rn1 <= 6 and first_derivative < 0 then first_derivative else null end) as 6m_used_lmt_first_der_small_0_sum
        ,sum( case when rn1 <= 12 and first_derivative < 0 then first_derivative else null end) as 12m_used_lmt_first_der_small_0_sum
        ,sum( case when rn1 <= 18 and first_derivative < 0 then first_derivative else null end) as 18m_used_lmt_first_der_small_0_sum

        ,avg(case when rn1 <= 1 then first_derivative else 0 end) - avg(case when rn1 <= 3 and rn1 > 1 then first_derivative else 0 end) 
            as 3m_used_lmt_first_der_mean_diff
        ,avg(case when rn1 <= 3 then first_derivative else 0 end) - avg(case when rn1 <= 6 and rn1 > 3 then first_derivative else 0 end) 
            as 6m_used_lmt_first_der_mean_diff
        ,avg(case when rn1 <= 6 then first_derivative else 0 end) - avg(case when rn1 <= 12 and rn1 > 6 then first_derivative else 0 end) 
            as 12m_used_lmt_first_der_mean_diff
        ,avg(case when rn1 <= 9 then first_derivative else 0 end) - avg(case when rn1 <= 18 and rn1 > 9 then first_derivative else 0 end) 
            as 18m_used_lmt_first_der_mean_diff

        ,avg(case when rn1 <= 1 then first_derivative else 0 end) / avg(case when rn1 <= 3 and rn1 > 1 then first_derivative else null end) 
            as 3m_used_lmt_first_der_mean_rto
        ,avg(case when rn1 <= 3 then first_derivative else 0 end) / avg(case when rn1 <= 6 and rn1 > 3 then first_derivative else null end) 
            as 6m_used_lmt_first_der_mean_rto
        ,avg(case when rn1 <= 6 then first_derivative else 0 end) / avg(case when rn1 <= 12 and rn1 > 6 then first_derivative else null end) 
            as 12m_used_lmt_first_der_mean_rto
        ,avg(case when rn1 <= 9 then first_derivative else 0 end) / avg(case when rn1 <= 18 and rn1 > 9 then first_derivative else null end) 
            as 18m_used_lmt_first_der_mean_rto

        -- second derivative 
        ,max( case when rn1 <= 3 then second_derivative else null end) as 3m_used_lmt_second_der_max
        ,max( case when rn1 <= 6 then second_derivative else null end) as 6m_used_lmt_second_der_max
        ,max( case when rn1 <= 12 then second_derivative else null end) as 12m_used_lmt_second_der_max
        ,max( case when rn1 <= 18 then second_derivative else null end) as 18m_used_lmt_second_der_max

        ,min( case when rn1 <= 3 then second_derivative else null end) as 3m_used_lmt_second_der_min
        ,min( case when rn1 <= 6 then second_derivative else null end) as 6m_used_lmt_second_der_min
        ,min( case when rn1 <= 12 then second_derivative else null end) as 12m_used_lmt_second_der_min
        ,min( case when rn1 <= 18 then second_derivative else null end) as 18m_used_lmt_second_der_min

        ,avg( case when rn1 <= 3 then second_derivative else null end) as 3m_used_lmt_second_der_avg
        ,avg( case when rn1 <= 6 then second_derivative else null end) as 6m_used_lmt_second_der_avg
        ,avg( case when rn1 <= 12 then second_derivative else null end) as 12m_used_lmt_second_der_avg
        ,avg( case when rn1 <= 18 then second_derivative else null end) as 18m_used_lmt_second_der_avg

        ,median( case when rn1 <= 3 then second_derivative else null end) as 3m_used_lmt_second_der_median
        ,median( case when rn1 <= 6 then second_derivative else null end) as 6m_used_lmt_second_der_median
        ,median( case when rn1 <= 12 then second_derivative else null end) as 12m_used_lmt_second_der_median
        ,median( case when rn1 <= 18 then second_derivative else null end) as 18m_used_lmt_second_der_median

        ,stddev( case when rn1 <= 3 then second_derivative else null end) as 3m_used_lmt_second_der_stddev
        ,stddev( case when rn1 <= 6 then second_derivative else null end) as 6m_used_lmt_second_der_stddev
        ,stddev( case when rn1 <= 12 then second_derivative else null end) as 12m_used_lmt_second_der_stddev
        ,stddev( case when rn1 <= 18 then second_derivative else null end) as 18m_used_lmt_second_der_stddev

        ,sum( case when rn1 <= 3 then second_derivative else null end) as 3m_used_lmt_second_der_sum
        ,sum( case when rn1 <= 6 then second_derivative else null end) as 6m_used_lmt_second_der_sum
        ,sum( case when rn1 <= 12 then second_derivative else null end) as 12m_used_lmt_second_der_sum
        ,sum( case when rn1 <= 18 then second_derivative else null end) as 18m_used_lmt_second_der_sum

        ,count( case when rn1 <= 3 and second_derivative > 0 then 1 else null end) as 3m_used_lmt_second_der_great_0_count
        ,count( case when rn1 <= 6 and second_derivative > 0 then 1 else null end) as 6m_used_lmt_second_der_great_0_count
        ,count( case when rn1 <= 12 and second_derivative > 0 then 1 else null end) as 12m_used_lmt_second_der_great_0_count
        ,count( case when rn1 <= 18 and second_derivative > 0 then 1 else null end) as 18m_used_lmt_second_der_great_0_count

        ,sum( case when rn1 <= 3 and second_derivative > 0 then second_derivative else null end) as 3m_used_lmt_second_der_great_0_sum
        ,sum( case when rn1 <= 6 and second_derivative > 0 then second_derivative else null end) as 6m_used_lmt_second_der_great_0_sum
        ,sum( case when rn1 <= 12 and second_derivative > 0 then second_derivative else null end) as 12m_used_lmt_second_der_great_0_sum
        ,sum( case when rn1 <= 18 and second_derivative > 0 then second_derivative else null end) as 18m_used_lmt_second_der_great_0_sum

        ,count( case when rn1 <= 3 and second_derivative < 0 then 1 else null end) as 3m_used_lmt_second_der_small_0_count
        ,count( case when rn1 <= 6 and second_derivative < 0 then 1 else null end) as 6m_used_lmt_second_der_small_0_count
        ,count( case when rn1 <= 12 and second_derivative < 0 then 1 else null end) as 12m_used_lmt_second_der_small_0_count
        ,count( case when rn1 <= 18 and second_derivative < 0 then 1 else null end) as 18m_used_lmt_second_der_small_0_count

        ,sum( case when rn1 <= 3 and second_derivative < 0 then second_derivative else null end) as 3m_used_lmt_second_der_small_0_sum
        ,sum( case when rn1 <= 6 and second_derivative < 0 then second_derivative else null end) as 6m_used_lmt_second_der_small_0_sum
        ,sum( case when rn1 <= 12 and second_derivative < 0 then second_derivative else null end) as 12m_used_lmt_second_der_small_0_sum
        ,sum( case when rn1 <= 18 and second_derivative < 0 then second_derivative else null end) as 18m_used_lmt_second_der_small_0_sum

        ,avg(case when rn1 <= 1 then second_derivative else 0 end) - avg(case when rn1 <= 3 and rn1 > 1 then second_derivative else 0 end) 
            as 3m_used_lmt_second_der_mean_diff
        ,avg(case when rn1 <= 3 then second_derivative else 0 end) - avg(case when rn1 <= 6 and rn1 > 3 then second_derivative else 0 end) 
            as 6m_used_lmt_second_der_mean_diff
        ,avg(case when rn1 <= 6 then second_derivative else 0 end) - avg(case when rn1 <= 12 and rn1 > 6 then second_derivative else 0 end) 
            as 12m_used_lmt_second_der_mean_diff
        ,avg(case when rn1 <= 9 then second_derivative else 0 end) - avg(case when rn1 <= 18 and rn1 > 9 then second_derivative else 0 end) 
            as 18m_used_lmt_second_der_mean_diff

        ,avg(case when rn1 <= 1 then second_derivative else 0 end) / avg(case when rn1 <= 3 and rn1 > 1 then second_derivative else null end) 
            as 3m_used_lmt_second_der_mean_rto
        ,avg(case when rn1 <= 3 then second_derivative else 0 end) / avg(case when rn1 <= 6 and rn1 > 3 then second_derivative else null end) 
            as 6m_used_lmt_second_der_mean_rto
        ,avg(case when rn1 <= 6 then second_derivative else 0 end) / avg(case when rn1 <= 12 and rn1 > 6 then second_derivative else null end) 
            as 12m_used_lmt_second_der_mean_rto
        ,avg(case when rn1 <= 9 then second_derivative else 0 end) / avg(case when rn1 <= 18 and rn1 > 9 then second_derivative else null end) 
            as 18m_used_lmt_second_der_mean_rto



from ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate}
group by uid;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df partition(ds = '${bizdate}')
select  a.uid,
        a.mdl_dte,
        3m_used_lmt_first_der_max,
         6m_used_lmt_first_der_max,
         12m_used_lmt_first_der_max,
         18m_used_lmt_first_der_max,
         3m_used_lmt_first_der_min,
         6m_used_lmt_first_der_min,
         12m_used_lmt_first_der_min,
         18m_used_lmt_first_der_min,
         3m_used_lmt_first_der_avg,
         6m_used_lmt_first_der_avg,
         12m_used_lmt_first_der_avg,
         18m_used_lmt_first_der_avg,
         3m_used_lmt_first_der_median,
         6m_used_lmt_first_der_median,
         12m_used_lmt_first_der_median,
         18m_used_lmt_first_der_median,
         3m_used_lmt_first_der_stddev,
         6m_used_lmt_first_der_stddev,
         12m_used_lmt_first_der_stddev,
         18m_used_lmt_first_der_stddev,
         3m_used_lmt_first_der_sum,
         6m_used_lmt_first_der_sum,
         12m_used_lmt_first_der_sum,
         18m_used_lmt_first_der_sum,
         3m_used_lmt_first_der_great_0_count,
         6m_used_lmt_first_der_great_0_count,
         12m_used_lmt_first_der_great_0_count,
         18m_used_lmt_first_der_great_0_count,
         3m_used_lmt_first_der_great_0_sum,
         6m_used_lmt_first_der_great_0_sum,
         12m_used_lmt_first_der_great_0_sum,
         18m_used_lmt_first_der_great_0_sum,
         3m_used_lmt_first_der_small_0_count,
         6m_used_lmt_first_der_small_0_count,
         12m_used_lmt_first_der_small_0_count,
         18m_used_lmt_first_der_small_0_count,
         3m_used_lmt_first_der_small_0_sum,
         6m_used_lmt_first_der_small_0_sum,
         12m_used_lmt_first_der_small_0_sum,
         18m_used_lmt_first_der_small_0_sum,
         3m_used_lmt_first_der_mean_diff,
         6m_used_lmt_first_der_mean_diff,
         12m_used_lmt_first_der_mean_diff,
         18m_used_lmt_first_der_mean_diff,
         3m_used_lmt_first_der_mean_rto,
         6m_used_lmt_first_der_mean_rto,
         12m_used_lmt_first_der_mean_rto,
         18m_used_lmt_first_der_mean_rto,
         3m_used_lmt_second_der_max,
         6m_used_lmt_second_der_max,
         12m_used_lmt_second_der_max,
         18m_used_lmt_second_der_max,
         3m_used_lmt_second_der_min,
         6m_used_lmt_second_der_min,
         12m_used_lmt_second_der_min,
         18m_used_lmt_second_der_min,
         3m_used_lmt_second_der_avg,
         6m_used_lmt_second_der_avg,
         12m_used_lmt_second_der_avg,
         18m_used_lmt_second_der_avg,
         3m_used_lmt_second_der_median,
         6m_used_lmt_second_der_median,
         12m_used_lmt_second_der_median,
         18m_used_lmt_second_der_median,
         3m_used_lmt_second_der_stddev,
         6m_used_lmt_second_der_stddev,
         12m_used_lmt_second_der_stddev,
         18m_used_lmt_second_der_stddev,
         3m_used_lmt_second_der_sum,
         6m_used_lmt_second_der_sum,
         12m_used_lmt_second_der_sum,
         18m_used_lmt_second_der_sum,
         3m_used_lmt_second_der_great_0_count,
         6m_used_lmt_second_der_great_0_count,
         12m_used_lmt_second_der_great_0_count,
         18m_used_lmt_second_der_great_0_count,
         3m_used_lmt_second_der_great_0_sum,
         6m_used_lmt_second_der_great_0_sum,
         12m_used_lmt_second_der_great_0_sum,
         18m_used_lmt_second_der_great_0_sum,
         3m_used_lmt_second_der_small_0_count,
         6m_used_lmt_second_der_small_0_count,
         12m_used_lmt_second_der_small_0_count,
         18m_used_lmt_second_der_small_0_count,
         3m_used_lmt_second_der_small_0_sum,
         6m_used_lmt_second_der_small_0_sum,
         12m_used_lmt_second_der_small_0_sum,
         18m_used_lmt_second_der_small_0_sum,
         3m_used_lmt_second_der_mean_diff,
         6m_used_lmt_second_der_mean_diff,
         12m_used_lmt_second_der_mean_diff,
         18m_used_lmt_second_der_mean_diff,
         3m_used_lmt_second_der_mean_rto,
         6m_used_lmt_second_der_mean_rto,
         12m_used_lmt_second_der_mean_rto,
         18m_used_lmt_second_der_mean_rto
         from
(
    select  uid,
            date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base
) a  
left join ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate} as b
on a.uid = b.uid 
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate};
-- feature-copilot:node-end ordinal=0
