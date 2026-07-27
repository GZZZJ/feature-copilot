-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_23changzhai_trend_df
-- node_id: n_5365749097280045056
-- task_name: dwa_risk_dz_model_final_23changzhai_trend_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_23changzhai_trend_df.json
-- source_json_sha256: 17dc6816604e2a8b4786dfa9febaf6fb6125574cfd22142c9b120e0f09e144e6
-- upstream_table: dbus.dbus_f_yu_cus_grp_day_list_new_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp02
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp01
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp03
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp04

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 牛莲泽
--创建日期: 2023-12-12 22:47:31
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_23changzhai_trend_df
-- (
--     uid string comment '用户ID',
--     mdl_dte date comment '模型评分日',
--     bf_1m_trend float comment '上月/上上月应还本金',
--     af_1m_trend float comment '下下月/下月应还本金',
--     bf_q4_q3_trend float comment '上季度/上上季度应还本金',
--     bf_q3_q2_trend float comment '上上季度/上三季度应还本金',
--     bf_q2_q1_trend float comment '上三季度/上四季度应还本金',
--     af_q2_q1_trend float comment '下下季度/下季度应还本金',
--     af_q3_q2_trend float comment '下三季度/下下季度应还本金',
--     af_q4_q3_trend float comment '下四季度/下三季度应还本金',
--     bf_6m_trend float comment '上半年/上上半年应还本金',
--     af_6m_trend float comment '下下半年/下半年应还本金',
--     bf_1y_inter_1m_sum_up float comment '近一年(间隔1个月)每月应还金额上涨总金额',
--     bf_1y_inter_1m_sum_down float comment '近一年(间隔1个月)每月应还金额下降总金额',
--     bf_1y_inter_1m_count_up int comment '近一年(间隔1个月)每月应还金额上涨总次数',
--     bf_1y_inter_1m_count_down int comment '近一年(间隔1个月)每月应还金额下降总次数',
--     af_1y_inter_1m_sum_up float comment '未来一年(间隔1个月)每月应还金额上涨总金额',
--     af_1y_inter_1m_sum_down float comment '未来一年(间隔1个月)每月应还金额下降总金额',
--     af_1y_inter_1m_count_up int comment '未来一年(间隔1个月)每月应还金额上涨总次数',
--     af_1y_inter_1m_count_down int comment '未来一年(间隔1个月)每月应还金额下降总次数',
--     bf_9m_inter_1m_sum_up float comment '近9个月(间隔1个月)每月应还金额上涨总金额',
--     bf_9m_inter_1m_sum_down float comment '近9个月(间隔1个月)每月应还金额下降总金额',
--     bf_9m_inter_1m_count_up int comment '近9个月(间隔1个月)每月应还金额上涨总次数',
--     bf_9m_inter_1m_count_down int comment '近9个月(间隔1个月)每月应还金额下降总次数',
--     af_9m_inter_1m_sum_up float comment '未来9个月(间隔1个月)每月应还金额上涨总金额',
--     af_9m_inter_1m_sum_down float comment '未来9个月(间隔1个月)每月应还金额下降总金额',
--     af_9m_inter_1m_count_up int comment '未来9个月(间隔1个月)每月应还金额上涨总次数',
--     af_9m_inter_1m_count_down int comment '未来9个月(间隔1个月)每月应还金额下降总次数',
--     bf_6m_inter_1m_sum_up float comment '近6个月(间隔1个月)每月应还金额上涨总金额',
--     bf_6m_inter_1m_sum_down float comment '近6个月(间隔1个月)每月应还金额下降总金额',
--     bf_6m_inter_1m_count_up int comment '近6个月(间隔1个月)每月应还金额上涨总次数',
--     bf_6m_inter_1m_count_down int comment '近6个月(间隔1个月)每月应还金额下降总次数',
--     af_6m_inter_1m_sum_up float comment '未来6个月(间隔1个月)每月应还金额上涨总金额',
--     af_6m_inter_1m_sum_down float comment '未来6个月(间隔1个月)每月应还金额下降总金额',
--     af_6m_inter_1m_count_up float comment '未来6个月(间隔1个月)每月应还金额上涨总次数',
--     af_6m_inter_1m_count_down float comment '未来6个月(间隔1个月)每月应还金额下降总次数',
--     bf_3m_inter_1m_sum_up float comment '近3个月(间隔1个月)每月应还金额上涨总金额',
--     bf_3m_inter_1m_sum_down float comment '近3个月(间隔1个月)每月应还金额下降总金额',
--     bf_3m_inter_1m_count_up int comment '近3个月(间隔1个月)每月应还金额上涨总次数',
--     bf_3m_inter_1m_count_down int comment '近3个月(间隔1个月)每月应还金额下降总次数',
--     af_3m_inter_1m_sum_up float comment '未来3个月(间隔1个月)每月应还金额上涨总金额',
--     af_3m_inter_1m_sum_down float comment '未来3个月(间隔1个月)每月应还金额下降总金额',
--     af_3m_inter_1m_count_up int comment '未来3个月(间隔1个月)每月应还金额上涨总次数',
--     af_3m_inter_1m_count_down int comment '未来3个月(间隔1个月)每月应还金额下降总次数',
--     abf_1y_inter_1m_sum_up float comment '前后1年(间隔1个月)每月应还金额上涨总金额',
--     abf_1y_inter_1m_sum_down float comment '前后1年(间隔1个月)每月应还金额下降总金额',
--     abf_1y_inter_1m_count_up int comment '前后1年(间隔1个月)每月应还金额上涨总次数',
--     abf_1y_inter_1m_count_down int comment '前后1年(间隔1个月)每月应还金额下降总次数',
--     bf_1y_inter_3m_sum_up float comment '近一年(间隔3个月)每月应还金额上涨总金额',
--     bf_1y_inter_3m_sum_down float comment '近一年(间隔3个月)每月应还金额下降总金额',
--     bf_1y_inter_3m_count_up int comment '近一年(间隔3个月)每月应还金额上涨总次数',
--     bf_1y_inter_3m_count_down int comment '近一年(间隔3个月)每月应还金额下降总次数',
--     af_1y_inter_3m_sum_up float comment '未来一年(间隔3个月)每月应还金额上涨总金额',
--     af_1y_inter_3m_sum_down float comment '未来一年(间隔3个月)每月应还金额下降总金额',
--     af_1y_inter_3m_count_up int comment '未来一年(间隔3个月)每月应还金额上涨总次数',
--     af_1y_inter_3m_count_down int comment '未来一年(间隔3个月)每月应还金额下降总次数',
--     abf_1y_inter_3m_sum_up float comment '前后1年(间隔3个月)每月应还金额上涨总金额',
--     abf_1y_inter_3m_sum_down float comment '前后1年(间隔3个月)每月应还金额下降总金额',
--     abf_1y_inter_3m_count_up int comment '前后1年(间隔3个月)每月应还金额上涨总次数',
--     abf_1y_inter_3m_count_down int comment '前后1年(间隔3个月)每月应还金额下降总次数',
--     rsi_bf_1y_inter_1m float comment '近一年(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_bf_9m_inter_1m float comment '近9个月(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_bf_6m_inter_1m float comment '近6个月(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_bf_3m_inter_1m float comment '近3个月(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_af_1y_inter_1m float comment '未来一年(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_af_9m_inter_1m float comment '未来9个月(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_af_6m_inter_1m float comment '未来6个月(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_af_3m_inter_1m float comment '未来3个月(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_abf_1y_inter_1m float comment '前后一年(间隔1个月)月应还金额相对强弱指标(RSI)',
--     rsi_bf_1y_inter_3m float comment '近一年(间隔3个月)月应还金额相对强弱指标(RSI)',
--     rsi_af_1y_inter_3m float comment '未来一年(间隔3个月)月应还金额相对强弱指标(RSI)',
--     rsi_abf_1y_inter_3m float comment '前后一年(间隔3个月)月应还金额相对强弱指标(RSI)'

-- ) comment '贷中宽表_偿债压力趋势类特征宽表'
-- partitioned by (ds string)
-- ;


----------------------------------------------------------
-----------/* Part I 样本 */-------------------
----------------------------------------------------------
drop table if exists dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp;
create table dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp as
select uid, grp as grp_new, date_add(to_date(ds,'yyyymmdd'),1) as mdl_dte,ds
from  dbus.dbus_f_yu_cus_grp_day_list_new_df
where ds = '${bizdate}'
and grp not like '%睡眠%'
;


----------------------------------------------------------
-----------/* Part II 后一年（间隔1个月）应还本金 */--------
----------------------------------------------------------
drop table if exists dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp01;
create table dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp01 as
select a.*
        ,coalesce(b1.bf_1m_amt,0) as bf_1m_amt
        ,coalesce(b2.bf_2m_amt,0) as bf_2m_amt
        ,coalesce(b3.bf_3m_amt,0) as bf_3m_amt
        ,coalesce(b4.bf_4m_amt,0) as bf_4m_amt
        ,coalesce(b5.bf_5m_amt,0) as bf_5m_amt
        ,coalesce(b6.bf_6m_amt,0) as bf_6m_amt
        ,coalesce(b7.bf_7m_amt,0) as bf_7m_amt
        ,coalesce(b8.bf_8m_amt,0) as bf_8m_amt
        ,coalesce(b9.bf_9m_amt,0) as bf_9m_amt
        ,coalesce(b10.bf_10m_amt,0) as bf_10m_amt
        ,coalesce(b11.bf_11m_amt,0) as bf_11m_amt
        ,coalesce(b12.bf_12m_amt,0) as bf_12m_amt
from dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp a
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_1m_amt  -- 前1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte 
                                    ,add_months(to_date(mdl_dte),-1) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp

                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= date(t1.mdl_dte) 
            )
            group by uid,mdl_dte
        ) b1
on a.uid=b1.uid and a.mdl_dte=b1.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_2m_amt  -- 前2个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-2) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <=  add_months(to_date(mdl_dte),-1)
            )
            group by uid,mdl_dte
        ) b2
on a.uid=b2.uid and a.mdl_dte=b2.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_3m_amt  -- 前3个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-3) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-2)
            )
            group by uid,mdl_dte
        ) b3
on a.uid=b3.uid and a.mdl_dte=b3.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_4m_amt  -- 前4个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-4) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-3)
            )
            group by uid,mdl_dte
        ) b4
on a.uid=b4.uid and a.mdl_dte=b4.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_5m_amt  -- 前5个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-5) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-4)
            )
            group by uid,mdl_dte
        ) b5
on a.uid=b5.uid and a.mdl_dte=b5.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_6m_amt  -- 前6个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-6) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-5)
            )
            group by uid,mdl_dte
        ) b6
on a.uid=b6.uid and a.mdl_dte=b6.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_7m_amt  -- 前7个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-7) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-6)
            )
            group by uid,mdl_dte
        ) b7
on a.uid=b7.uid and a.mdl_dte=b7.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_8m_amt  -- 前8个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-8) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-7)
            )
            group by uid,mdl_dte
        ) b8
on a.uid=b8.uid and a.mdl_dte=b8.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_9m_amt  -- 前9个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-9) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-8)
            )
            group by uid,mdl_dte
        ) b9
on a.uid=b9.uid and a.mdl_dte=b9.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_10m_amt  -- 前10个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-10) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-9)
            )
            group by uid,mdl_dte
        ) b10
on a.uid=b10.uid and a.mdl_dte=b10.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_11m_amt  -- 前11个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-11) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-10) 
            )
            group by uid,mdl_dte
        ) b11
on a.uid=b11.uid and a.mdl_dte=b11.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_12m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-12) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.begin_day) and date(t3.due_date) <= add_months(to_date(mdl_dte),-11) 
            )
            group by uid,mdl_dte
        ) b12
on a.uid=b12.uid and a.mdl_dte=b12.mdl_dte
;



----------------------------------------------------------
-----------/* Part III 后一年（间隔1个月）应还本金 */--------
----------------------------------------------------------
drop table if exists dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp02;
create table dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp02 as
select a.*
        ,coalesce(c1.af_1m_amt,0) as af_1m_amt
        ,coalesce(c2.af_2m_amt,0) as af_2m_amt
        ,coalesce(c3.af_3m_amt,0) as af_3m_amt
        ,coalesce(c4.af_4m_amt,0) as af_4m_amt
        ,coalesce(c5.af_5m_amt,0) as af_5m_amt
        ,coalesce(c6.af_6m_amt,0) as af_6m_amt
        ,coalesce(c7.af_7m_amt,0) as af_7m_amt
        ,coalesce(c8.af_8m_amt,0) as af_8m_amt
        ,coalesce(c9.af_9m_amt,0) as af_9m_amt
        ,coalesce(c10.af_10m_amt,0) as af_10m_amt
        ,coalesce(c11.af_11m_amt,0) as af_11m_amt
        ,coalesce(c12.af_12m_amt,0) as af_12m_amt
from dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp01 a
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_1m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),1) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no

                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')

                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.mdl_dte) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c1
on a.uid=c1.uid and a.mdl_dte=c1.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_2m_amt  -- 未来2个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),2) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),1) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c2
on a.uid=c2.uid and a.mdl_dte=c2.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_3m_amt  -- 未来3个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),3) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),2) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c3
on a.uid=c3.uid and a.mdl_dte=c3.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_4m_amt  -- 未来4个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),4) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),3) and date(t3.due_date) <= date(t1.begin_day) 
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c4
on a.uid=c4.uid and a.mdl_dte=c4.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_5m_amt  -- 未来5个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),5) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),4) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c5
on a.uid=c5.uid and a.mdl_dte=c5.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_6m_amt  -- 未来6个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),6) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),5) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c6
on a.uid=c6.uid and a.mdl_dte=c6.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_7m_amt  -- 未来7个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),7) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),6) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c7
on a.uid=c7.uid and a.mdl_dte=c7.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_8m_amt  -- 未来8个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),8) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),7) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c8
on a.uid=c8.uid and a.mdl_dte=c8.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_9m_amt  -- 未来9个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),9) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),8) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c9
on a.uid=c9.uid and a.mdl_dte=c9.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_10m_amt  -- 未来10个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),10) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),9) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c10
on a.uid=c10.uid and a.mdl_dte=c10.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_11m_amt  -- 未来11个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),11) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),10) and date(t3.due_date) <= date(t1.begin_day)
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c11
on a.uid=c11.uid and a.mdl_dte=c11.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_12m_amt  -- 未来12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),12) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),11) and date(t3.due_date) <= date(t1.begin_day) 
                       and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c12
on a.uid=c12.uid and a.mdl_dte=c12.mdl_dte
;



----------------------------------------------------------
-----------/* Part IV 前后一年（间隔3个月）应还本金 */------
----------------------------------------------------------
drop table if exists dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp03;
create table dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp03 as
select a.*
       ,coalesce(b1.bf_0_3m_amt,0) as bf_0_3m_amt
       ,coalesce(b2.bf_3_6m_amt,0) as bf_3_6m_amt
       ,coalesce(b3.bf_6_9m_amt,0) as bf_6_9m_amt
       ,coalesce(b4.bf_9_12m_amt,0) as bf_9_12m_amt
       ,coalesce(c1.af_0_3m_amt,0) as af_0_3m_amt
       ,coalesce(c2.af_3_6m_amt,0) as af_3_6m_amt
       ,coalesce(c3.af_6_9m_amt,0) as af_6_9m_amt
       ,coalesce(c4.af_9_12m_amt,0) as af_9_12m_amt
from dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp02 a
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_0_3m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-12) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-3) and date(t3.due_date) <= date(t1.mdl_dte)
            ) 
            group by uid,mdl_dte
        ) b1
on a.uid=b1.uid and a.mdl_dte=b1.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_3_6m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-12) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-6) and date(t3.due_date) <= add_months(to_date(mdl_dte),-3)
            )
            group by uid,mdl_dte
        ) b2
on a.uid=b2.uid and a.mdl_dte=b2.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_6_9m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-12) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-9) and date(t3.due_date) <= add_months(to_date(mdl_dte),-6)
            )
            group by uid,mdl_dte
        ) b3
on a.uid=b3.uid and a.mdl_dte=b3.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_9_12m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                    ,add_months(to_date(mdl_dte),-12) as begin_day
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-12) and date(t3.due_date) <= add_months(to_date(mdl_dte),-9)
            )
            group by uid,mdl_dte
        ) b4
on a.uid=b4.uid and a.mdl_dte=b4.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_0_3m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    --select *
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                               --where uid='03ec87ea-546d-4d60-922e-755822037c24'
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.mdl_dte) and date(t3.due_date) <= add_months(to_date(mdl_dte),3)
                      and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c1
on a.uid=c1.uid and a.mdl_dte=c1.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_3_6m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                   
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                         
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),3) and date(t3.due_date) <= add_months(to_date(mdl_dte),6)
                    and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c2
on a.uid=c2.uid and a.mdl_dte=c2.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_6_9m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            --where ds='${bizdate}'
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),6) and date(t3.due_date) <= add_months(to_date(mdl_dte),9)
                    and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c3
on a.uid=c3.uid and a.mdl_dte=c3.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_9_12m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            --where ds='${bizdate}'
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),9) and date(t3.due_date) <= add_months(to_date(mdl_dte),12)
                    and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c4
on a.uid=c4.uid and a.mdl_dte=c4.mdl_dte
;


----------------------------------------------------------
-----------/* Part V 前后一年（间隔6个月）应还本金 */------
----------------------------------------------------------
drop table if exists dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp04;
create table dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp04 as
select a.*
        ,coalesce(b1.bf_0_6m_amt,0) as bf_0_6m_amt
        ,coalesce(b2.bf_6_12m_amt,0) as bf_6_12m_amt
        ,coalesce(b3.bf_0_12m_amt,0) as bf_0_12m_amt
        ,coalesce(c1.af_0_6m_amt,0) as af_0_6m_amt
        ,coalesce(c2.af_6_12m_amt,0) as af_6_12m_amt
        ,coalesce(c3.af_0_12m_amt,0) as af_0_12m_amt
from dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp03 a
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_0_6m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-6) and date(t3.due_date) <= date(t1.mdl_dte)
            ) 
            group by uid,mdl_dte
        ) b1
on a.uid=b1.uid and a.mdl_dte=b1.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_6_12m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-12) and date(t3.due_date) <= add_months(to_date(mdl_dte),-6)
            ) 
            group by uid,mdl_dte
        ) b2
on a.uid=b2.uid and a.mdl_dte=b2.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as bf_0_12m_amt  -- 前12个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                    ) t1  -- 样本
                    left join (
                            select uid
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
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),-12) and date(t3.due_date) <= date(t1.mdl_dte)
            ) 
            group by uid,mdl_dte
        ) b3
on a.uid=b3.uid and a.mdl_dte=b3.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_0_6m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            --where ds='${bizdate}'
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.mdl_dte) and date(t3.due_date) <= add_months(to_date(mdl_dte),6)
                    and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c1
on a.uid=c1.uid and a.mdl_dte=c1.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_6_12m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            --where ds='${bizdate}'
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > add_months(to_date(mdl_dte),6) and date(t3.due_date) <= add_months(to_date(mdl_dte),12)
                    and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c2
on a.uid=c2.uid and a.mdl_dte=c2.mdl_dte
left join(
            select  uid
                    ,mdl_dte
                    ,sum(loan_original_principal) as af_0_12m_amt  -- 未来1个月应还本金
            from(
                    select t1.*,t3.loan_original_principal 
                    from  (
                            select uid
                                    ,mdl_dte -- 交易日
                                   
                            from   dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_sample_tmp
                            --where ds='${bizdate}'
                    ) t1  -- 样本
                    left join (
                            select uid
                                    ,order_no
                                    ,loan_date
                                    ,create_time as crt_time
                                    ,due_date
                                    ,original_loan_principal as loan_original_principal
                                    ,stage_plan_no
                            from    cdmx.cdmx_fct_heavy_stage_plan_df
                            where   ds='${bizdate}'
                                    and  original_stage_plan_status in ('S','A','U','X','O','E') 
                                    and  due_date is not null
                                    and  substr(order_no,1,2) in ('BT','CH','BL','HE')
            
                    ) t3  -- stage_plan
                    on t1.uid=t3.uid and date(t3.due_date) > date(t1.mdl_dte) and date(t3.due_date) <= add_months(to_date(mdl_dte),12)
                    and t3.loan_date < date(t1.mdl_dte)
            )
            group by uid,mdl_dte
        ) c3
on a.uid=c3.uid and a.mdl_dte=c3.mdl_dte
;


----------------------------------------------------------
-----------/* Part VI 特征加工 */---------------
----------------------------------------------------------
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_23changzhai_trend_df partition(ds='${bizdate}') 
select  uid
        ,mdl_dte
        ,bf_1m_trend
        ,af_1m_trend
        ,bf_q4_q3_trend
        ,bf_q3_q2_trend
        ,bf_q2_q1_trend
        ,af_q2_q1_trend
        ,af_q3_q2_trend
        ,af_q4_q3_trend
        ,bf_6m_trend
        ,af_6m_trend

        ,bf_1y_inter_1m_sum_up
        ,-bf_1y_inter_1m_sum_down as bf_1y_inter_1m_sum_down
        ,bf_1y_inter_1m_count_up
        ,bf_1y_inter_1m_count_down
        ,af_1y_inter_1m_sum_up
        ,-af_1y_inter_1m_sum_down as af_1y_inter_1m_sum_down
        ,af_1y_inter_1m_count_up
        ,af_1y_inter_1m_count_down

        ,bf_9m_inter_1m_sum_up
        ,-bf_9m_inter_1m_sum_down as bf_9m_inter_1m_sum_down
        ,bf_9m_inter_1m_count_up
        ,bf_9m_inter_1m_count_down
        ,af_9m_inter_1m_sum_up
        ,-af_9m_inter_1m_sum_down as af_9m_inter_1m_sum_down
        ,af_9m_inter_1m_count_up
        ,af_9m_inter_1m_count_down

        ,bf_6m_inter_1m_sum_up
        ,-bf_6m_inter_1m_sum_down as bf_6m_inter_1m_sum_down
        ,bf_6m_inter_1m_count_up
        ,bf_6m_inter_1m_count_down
        ,af_6m_inter_1m_sum_up
        ,-af_6m_inter_1m_sum_down as af_6m_inter_1m_sum_down
        ,af_6m_inter_1m_count_up
        ,af_6m_inter_1m_count_down

        ,bf_3m_inter_1m_sum_up
        ,-bf_3m_inter_1m_sum_down as bf_3m_inter_1m_sum_down
        ,bf_3m_inter_1m_count_up
        ,bf_3m_inter_1m_count_down
        ,af_3m_inter_1m_sum_up
        ,-af_3m_inter_1m_sum_down as af_3m_inter_1m_sum_down
        ,af_3m_inter_1m_count_up
        ,af_3m_inter_1m_count_down

        ,abf_1y_inter_1m_sum_up
        ,-abf_1y_inter_1m_sum_down as abf_1y_inter_1m_sum_down
        ,abf_1y_inter_1m_count_up
        ,abf_1y_inter_1m_count_down

        ,bf_1y_inter_3m_sum_up
        ,-bf_1y_inter_3m_sum_down as bf_1y_inter_3m_sum_down
        ,bf_1y_inter_3m_count_up
        ,bf_1y_inter_3m_count_down
        ,af_1y_inter_3m_sum_up
        ,-af_1y_inter_3m_sum_down as af_1y_inter_3m_sum_down
        ,af_1y_inter_3m_count_up
        ,af_1y_inter_3m_count_down
        
        ,abf_1y_inter_3m_sum_up
        ,-abf_1y_inter_3m_sum_down as abf_1y_inter_3m_sum_down
        ,abf_1y_inter_3m_count_up
        ,abf_1y_inter_3m_count_down

        ,((bf_1y_inter_1m_sum_up / bf_1y_inter_1m_count_up) / (bf_1y_inter_1m_sum_up / bf_1y_inter_1m_count_up - bf_1y_inter_1m_sum_down / bf_1y_inter_1m_count_down)) * 100 as RSI_bf_1y_inter_1m
        ,((bf_9m_inter_1m_sum_up / bf_9m_inter_1m_count_up) / (bf_9m_inter_1m_sum_up / bf_9m_inter_1m_count_up - bf_9m_inter_1m_sum_down / bf_9m_inter_1m_count_down)) * 100 as RSI_bf_9m_inter_1m
        ,((bf_6m_inter_1m_sum_up / bf_6m_inter_1m_count_up) / (bf_6m_inter_1m_sum_up / bf_6m_inter_1m_count_up - bf_6m_inter_1m_sum_down / bf_6m_inter_1m_count_down)) * 100 as RSI_bf_6m_inter_1m
        ,((bf_3m_inter_1m_sum_up / bf_3m_inter_1m_count_up) / (bf_3m_inter_1m_sum_up / bf_3m_inter_1m_count_up - bf_3m_inter_1m_sum_down / bf_3m_inter_1m_count_down)) * 100 as RSI_bf_3m_inter_1m

        ,((af_1y_inter_1m_sum_up / af_1y_inter_1m_count_up) / (af_1y_inter_1m_sum_up / af_1y_inter_1m_count_up - af_1y_inter_1m_sum_down / af_1y_inter_1m_count_down)) * 100 as RSI_af_1y_inter_1m
        ,((af_9m_inter_1m_sum_up / af_9m_inter_1m_count_up) / (af_9m_inter_1m_sum_up / af_9m_inter_1m_count_up - af_9m_inter_1m_sum_down / af_9m_inter_1m_count_down)) * 100 as RSI_af_9m_inter_1m
        ,((af_6m_inter_1m_sum_up / af_6m_inter_1m_count_up) / (af_6m_inter_1m_sum_up / af_6m_inter_1m_count_up - af_6m_inter_1m_sum_down / af_6m_inter_1m_count_down)) * 100 as RSI_af_6m_inter_1m
        ,((af_3m_inter_1m_sum_up / af_3m_inter_1m_count_up) / (af_3m_inter_1m_sum_up / af_3m_inter_1m_count_up - af_3m_inter_1m_sum_down / af_3m_inter_1m_count_down)) * 100 as RSI_af_3m_inter_1m

        ,((abf_1y_inter_1m_sum_up / abf_1y_inter_1m_count_up) / (abf_1y_inter_1m_sum_up / abf_1y_inter_1m_count_up - abf_1y_inter_1m_sum_down / abf_1y_inter_1m_count_down)) * 100 as RSI_abf_1y_inter_1m

        ,((bf_1y_inter_3m_sum_up / bf_1y_inter_3m_count_up) / (bf_1y_inter_3m_sum_up / bf_1y_inter_3m_count_up - bf_1y_inter_3m_sum_down / bf_1y_inter_3m_count_down)) * 100 as RSI_bf_1y_inter_3m
        ,((af_1y_inter_3m_sum_up / af_1y_inter_3m_count_up) / (af_1y_inter_3m_sum_up / af_1y_inter_3m_count_up - af_1y_inter_3m_sum_down / af_1y_inter_3m_count_down)) * 100 as RSI_af_1y_inter_3m
        ,((abf_1y_inter_3m_sum_up / abf_1y_inter_3m_count_up) / (abf_1y_inter_3m_sum_up / abf_1y_inter_3m_count_up - abf_1y_inter_3m_sum_down / abf_1y_inter_3m_count_down)) * 100 as RSI_abf_1y_inter_3m

from(
select  uid,mdl_dte
        
        ,bf_1m_trend
        ,af_1m_trend
        ,bf_q4_q3_trend
        ,bf_q3_q2_trend
        ,bf_q2_q1_trend
        ,af_q2_q1_trend
        ,af_q3_q2_trend
        ,af_q4_q3_trend
        ,bf_6m_trend
        ,af_6m_trend

        -- 近1年 1个月为间隔
        ,if(bf1_1m>0,bf1_1m,0)+if(bf2_1m>0,bf2_1m,0)+if(bf3_1m>0,bf3_1m,0)+if(bf4_1m>0,bf4_1m,0)+if(bf5_1m>0,bf5_1m,0)+if(bf6_1m>0,bf6_1m,0)+if(bf7_1m>0,bf7_1m,0)+if(bf8_1m>0,bf8_1m,0)+if(bf9_1m>0,bf9_1m,0)+if(bf10_1m>0,bf10_1m,0)+if(bf11_1m>0,bf11_1m,0) as bf_1y_inter_1m_sum_up
        ,if(bf1_1m<0,bf1_1m,0)+if(bf2_1m<0,bf2_1m,0)+if(bf3_1m<0,bf3_1m,0)+if(bf4_1m<0,bf4_1m,0)+if(bf5_1m<0,bf5_1m,0)+if(bf6_1m<0,bf6_1m,0)+if(bf7_1m<0,bf7_1m,0)+if(bf8_1m<0,bf8_1m,0)+if(bf9_1m<0,bf9_1m,0)+if(bf10_1m<0,bf10_1m,0)+if(bf11_1m<0,bf11_1m,0) as bf_1y_inter_1m_sum_down
        ,if(bf1_1m>0,1,0)+if(bf2_1m>0,1,0)+if(bf3_1m>0,1,0)+if(bf4_1m>0,1,0)+if(bf5_1m>0,1,0)+if(bf6_1m>0,1,0)+if(bf7_1m>0,1,0)+if(bf8_1m>0,1,0)+if(bf9_1m>0,1,0)+if(bf10_1m>0,1,0)+if(bf11_1m>0,1,0) as bf_1y_inter_1m_count_up
        ,if(bf1_1m<0,1,0)+if(bf2_1m<0,1,0)+if(bf3_1m<0,1,0)+if(bf4_1m<0,1,0)+if(bf5_1m<0,1,0)+if(bf6_1m<0,1,0)+if(bf7_1m<0,1,0)+if(bf8_1m<0,1,0)+if(bf9_1m<0,1,0)+if(bf10_1m<0,1,0)+if(bf11_1m<0,1,0) as bf_1y_inter_1m_count_down

        ,if(af1_1m>0,af1_1m,0)+if(af2_1m>0,af2_1m,0)+if(af3_1m>0,af3_1m,0)+if(af4_1m>0,af4_1m,0)+if(af5_1m>0,af5_1m,0)+if(af6_1m>0,af6_1m,0)+if(af7_1m>0,af7_1m,0)+if(af8_1m>0,af8_1m,0)+if(af9_1m>0,af9_1m,0)+if(af10_1m>0,af10_1m,0)+if(af11_1m>0,af11_1m,0) as af_1y_inter_1m_sum_up
        ,if(af1_1m<0,af1_1m,0)+if(af2_1m<0,af2_1m,0)+if(af3_1m<0,af3_1m,0)+if(af4_1m<0,af4_1m,0)+if(af5_1m<0,af5_1m,0)+if(af6_1m<0,af6_1m,0)+if(af7_1m<0,af7_1m,0)+if(af8_1m<0,af8_1m,0)+if(af9_1m<0,af9_1m,0)+if(af10_1m<0,af10_1m,0)+if(af11_1m<0,af11_1m,0) as af_1y_inter_1m_sum_down
        ,if(af1_1m>0,1,0)+if(af2_1m>0,1,0)+if(af3_1m>0,1,0)+if(af4_1m>0,1,0)+if(af5_1m>0,1,0)+if(af6_1m>0,1,0)+if(af7_1m>0,1,0)+if(af8_1m>0,1,0)+if(af9_1m>0,1,0)+if(af10_1m>0,1,0)+if(af11_1m>0,1,0) as af_1y_inter_1m_count_up
        ,if(af1_1m<0,1,0)+if(af2_1m<0,1,0)+if(af3_1m<0,1,0)+if(af4_1m<0,1,0)+if(af5_1m<0,1,0)+if(af6_1m<0,1,0)+if(af7_1m<0,1,0)+if(af8_1m<0,1,0)+if(af9_1m<0,1,0)+if(af10_1m<0,1,0)+if(af11_1m<0,1,0) as af_1y_inter_1m_count_down

        -- 近9年 1个月为间隔
        ,if(bf4_1m>0,bf4_1m,0)+if(bf5_1m>0,bf5_1m,0)+if(bf6_1m>0,bf6_1m,0)+if(bf7_1m>0,bf7_1m,0)+if(bf8_1m>0,bf8_1m,0)+if(bf9_1m>0,bf9_1m,0)+if(bf10_1m>0,bf10_1m,0)+if(bf11_1m>0,bf11_1m,0) as bf_9m_inter_1m_sum_up
        ,if(bf4_1m<0,bf4_1m,0)+if(bf5_1m<0,bf5_1m,0)+if(bf6_1m<0,bf6_1m,0)+if(bf7_1m<0,bf7_1m,0)+if(bf8_1m<0,bf8_1m,0)+if(bf9_1m<0,bf9_1m,0)+if(bf10_1m<0,bf10_1m,0)+if(bf11_1m<0,bf11_1m,0) as bf_9m_inter_1m_sum_down
        ,if(bf4_1m>0,1,0)+if(bf5_1m>0,1,0)+if(bf6_1m>0,1,0)+if(bf7_1m>0,1,0)+if(bf8_1m>0,1,0)+if(bf9_1m>0,1,0)+if(bf10_1m>0,1,0)+if(bf11_1m>0,1,0) as bf_9m_inter_1m_count_up
        ,if(bf4_1m<0,1,0)+if(bf5_1m<0,1,0)+if(bf6_1m<0,1,0)+if(bf7_1m<0,1,0)+if(bf8_1m<0,1,0)+if(bf9_1m<0,1,0)+if(bf10_1m<0,1,0)+if(bf11_1m<0,1,0) as bf_9m_inter_1m_count_down

        ,if(af4_1m>0,af4_1m,0)+if(af5_1m>0,af5_1m,0)+if(af6_1m>0,af6_1m,0)+if(af7_1m>0,af7_1m,0)+if(af8_1m>0,af8_1m,0)+if(af9_1m>0,af9_1m,0)+if(af10_1m>0,af10_1m,0)+if(af11_1m>0,af11_1m,0) as af_9m_inter_1m_sum_up
        ,if(af4_1m<0,af4_1m,0)+if(af5_1m<0,af5_1m,0)+if(af6_1m<0,af6_1m,0)+if(af7_1m<0,af7_1m,0)+if(af8_1m<0,af8_1m,0)+if(af9_1m<0,af9_1m,0)+if(af10_1m<0,af10_1m,0)+if(af11_1m<0,af11_1m,0) as af_9m_inter_1m_sum_down
        ,if(af4_1m>0,1,0)+if(af5_1m>0,1,0)+if(af6_1m>0,1,0)+if(af7_1m>0,1,0)+if(af8_1m>0,1,0)+if(af9_1m>0,1,0)+if(af10_1m>0,1,0)+if(af11_1m>0,1,0) as af_9m_inter_1m_count_up
        ,if(af4_1m<0,1,0)+if(af5_1m<0,1,0)+if(af6_1m<0,1,0)+if(af7_1m<0,1,0)+if(af8_1m<0,1,0)+if(af9_1m<0,1,0)+if(af10_1m<0,1,0)+if(af11_1m<0,1,0) as af_9m_inter_1m_count_down

        -- 近6个月 1个月为间隔
        ,if(bf6_1m>0,bf6_1m,0)+if(bf7_1m>0,bf7_1m,0)+if(bf8_1m>0,bf8_1m,0)+if(bf9_1m>0,bf9_1m,0)+if(bf10_1m>0,bf10_1m,0)+if(bf11_1m>0,bf11_1m,0) as bf_6m_inter_1m_sum_up
        ,if(bf6_1m<0,bf6_1m,0)+if(bf7_1m<0,bf7_1m,0)+if(bf8_1m<0,bf8_1m,0)+if(bf9_1m<0,bf9_1m,0)+if(bf10_1m<0,bf10_1m,0)+if(bf11_1m<0,bf11_1m,0) as bf_6m_inter_1m_sum_down
        ,if(bf6_1m>0,1,0)+if(bf7_1m>0,1,0)+if(bf8_1m>0,1,0)+if(bf9_1m>0,1,0)+if(bf10_1m>0,1,0)+if(bf11_1m>0,1,0) as bf_6m_inter_1m_count_up
        ,if(bf6_1m<0,1,0)+if(bf7_1m<0,1,0)+if(bf8_1m<0,1,0)+if(bf9_1m<0,1,0)+if(bf10_1m<0,1,0)+if(bf11_1m<0,1,0) as bf_6m_inter_1m_count_down

        ,if(af6_1m>0,af6_1m,0)+if(af7_1m>0,af7_1m,0)+if(af8_1m>0,af8_1m,0)+if(af9_1m>0,af9_1m,0)+if(af10_1m>0,af10_1m,0)+if(af11_1m>0,af11_1m,0) as af_6m_inter_1m_sum_up
        ,if(af6_1m<0,af6_1m,0)+if(af7_1m<0,af7_1m,0)+if(af8_1m<0,af8_1m,0)+if(af9_1m<0,af9_1m,0)+if(af10_1m<0,af10_1m,0)+if(af11_1m<0,af11_1m,0) as af_6m_inter_1m_sum_down
        ,if(af6_1m>0,1,0)+if(af7_1m>0,1,0)+if(af8_1m>0,1,0)+if(af9_1m>0,1,0)+if(af10_1m>0,1,0)+if(af11_1m>0,1,0) as af_6m_inter_1m_count_up
        ,if(af6_1m<0,1,0)+if(af7_1m<0,1,0)+if(af8_1m<0,1,0)+if(af9_1m<0,1,0)+if(af10_1m<0,1,0)+if(af11_1m<0,1,0) as af_6m_inter_1m_count_down

        -- 近3个月 1个月为间隔
        ,if(bf9_1m>0,bf9_1m,0)+if(bf10_1m>0,bf10_1m,0)+if(bf11_1m>0,bf11_1m,0) as bf_3m_inter_1m_sum_up
        ,if(bf9_1m<0,bf9_1m,0)+if(bf10_1m<0,bf10_1m,0)+if(bf11_1m<0,bf11_1m,0) as bf_3m_inter_1m_sum_down
        ,if(bf9_1m>0,1,0)+if(bf10_1m>0,1,0)+if(bf11_1m>0,1,0) as bf_3m_inter_1m_count_up
        ,if(bf9_1m<0,1,0)+if(bf10_1m<0,1,0)+if(bf11_1m<0,1,0) as bf_3m_inter_1m_count_down

        ,if(af9_1m>0,af9_1m,0)+if(af10_1m>0,af10_1m,0)+if(af11_1m>0,af11_1m,0) as af_3m_inter_1m_sum_up
        ,if(af9_1m<0,af9_1m,0)+if(af10_1m<0,af10_1m,0)+if(af11_1m<0,af11_1m,0) as af_3m_inter_1m_sum_down
        ,if(af9_1m>0,1,0)+if(af10_1m>0,1,0)+if(af11_1m>0,1,0) as af_3m_inter_1m_count_up
        ,if(af9_1m<0,1,0)+if(af10_1m<0,1,0)+if(af11_1m<0,1,0) as af_3m_inter_1m_count_down

        -- 前后一年 1个月为间隔
        ,if(bf1_1m>0,bf1_1m,0)+if(bf2_1m>0,bf2_1m,0)+if(bf3_1m>0,bf3_1m,0)+if(bf4_1m>0,bf4_1m,0)+if(bf5_1m>0,bf5_1m,0)+if(bf6_1m>0,bf6_1m,0)+if(bf7_1m>0,bf7_1m,0)+if(bf8_1m>0,bf8_1m,0)+if(bf9_1m>0,bf9_1m,0)+if(bf10_1m>0,bf10_1m,0)+if(bf11_1m>0,bf11_1m,0)+if(af1_1m>0,af1_1m,0)+if(af2_1m>0,af2_1m,0)+if(af3_1m>0,af3_1m,0)+if(af4_1m>0,af4_1m,0)+if(af5_1m>0,af5_1m,0)+if(af6_1m>0,af6_1m,0)+if(af7_1m>0,af7_1m,0)+if(af8_1m>0,af8_1m,0)+if(af9_1m>0,af9_1m,0)+if(af10_1m>0,af10_1m,0)+if(af11_1m>0,af11_1m,0) as abf_1y_inter_1m_sum_up
        ,if(bf1_1m<0,bf1_1m,0)+if(bf2_1m<0,bf2_1m,0)+if(bf3_1m<0,bf3_1m,0)+if(bf4_1m<0,bf4_1m,0)+if(bf5_1m<0,bf5_1m,0)+if(bf6_1m<0,bf6_1m,0)+if(bf7_1m<0,bf7_1m,0)+if(bf8_1m<0,bf8_1m,0)+if(bf9_1m<0,bf9_1m,0)+if(bf10_1m<0,bf10_1m,0)+if(bf11_1m<0,bf11_1m,0)+if(af1_1m<0,af1_1m,0)+if(af2_1m<0,af2_1m,0)+if(af3_1m<0,af3_1m,0)+if(af4_1m<0,af4_1m,0)+if(af5_1m<0,af5_1m,0)+if(af6_1m<0,af6_1m,0)+if(af7_1m<0,af7_1m,0)+if(af8_1m<0,af8_1m,0)+if(af9_1m<0,af9_1m,0)+if(af10_1m<0,af10_1m,0)+if(af11_1m<0,af11_1m,0) as abf_1y_inter_1m_sum_down
        ,if(bf1_1m>0,1,0)+if(bf2_1m>0,1,0)+if(bf3_1m>0,1,0)+if(bf4_1m>0,1,0)+if(bf5_1m>0,1,0)+if(bf6_1m>0,1,0)+if(bf7_1m>0,1,0)+if(bf8_1m>0,1,0)+if(bf9_1m>0,1,0)+if(bf10_1m>0,1,0)+if(bf11_1m>0,1,0)+if(af1_1m>0,1,0)+if(af2_1m>0,1,0)+if(af3_1m>0,1,0)+if(af4_1m>0,1,0)+if(af5_1m>0,1,0)+if(af6_1m>0,1,0)+if(af7_1m>0,1,0)+if(af8_1m>0,1,0)+if(af9_1m>0,1,0)+if(af10_1m>0,1,0)+if(af11_1m>0,1,0) as abf_1y_inter_1m_count_up
        ,if(af1_1m<0,1,0)+if(af2_1m<0,1,0)+if(af3_1m<0,1,0)+if(af4_1m<0,1,0)+if(af5_1m<0,1,0)+if(af6_1m<0,1,0)+if(af7_1m<0,1,0)+if(af8_1m<0,1,0)+if(af9_1m<0,1,0)+if(af10_1m<0,1,0)+if(af11_1m<0,1,0)+if(bf1_1m<0,1,0)+if(bf2_1m<0,1,0)+if(bf3_1m<0,1,0)+if(bf4_1m<0,1,0)+if(bf5_1m<0,1,0)+if(bf6_1m<0,1,0)+if(bf7_1m<0,1,0)+if(bf8_1m<0,1,0)+if(bf9_1m<0,1,0)+if(bf10_1m<0,1,0)+if(bf11_1m<0,1,0) as abf_1y_inter_1m_count_down

        -- 近一年 3个月为间隔
        ,if(bf1_3m>0,bf1_3m,0)+if(bf2_3m>0,bf2_3m,0)+if(bf3_3m>0,bf3_3m,0) as bf_1y_inter_3m_sum_up
        ,if(bf1_3m<0,bf1_3m,0)+if(bf2_3m<0,bf2_3m,0)+if(bf3_3m<0,bf3_3m,0) as bf_1y_inter_3m_sum_down
        ,if(bf1_3m>0,1,0)+if(bf2_3m>0,1,0)+if(bf3_3m>0,1,0) as bf_1y_inter_3m_count_up
        ,if(bf1_3m<0,1,0)+if(bf2_3m<0,1,0)+if(bf3_3m<0,1,0) as bf_1y_inter_3m_count_down

        ,if(af1_3m>0,af1_3m,0)+if(af2_3m>0,af2_3m,0)+if(af3_3m>0,af3_3m,0) as af_1y_inter_3m_sum_up
        ,if(af1_3m<0,af1_3m,0)+if(af2_3m<0,af2_3m,0)+if(af3_3m<0,af3_3m,0) as af_1y_inter_3m_sum_down
        ,if(af1_3m>0,1,0)+if(af2_3m>0,1,0)+if(af3_3m>0,1,0) as af_1y_inter_3m_count_up
        ,if(af1_3m<0,1,0)+if(af2_3m<0,1,0)+if(af3_3m<0,1,0) as af_1y_inter_3m_count_down

        -- 前后一年 3个月为间隔
        ,if(bf1_3m>0,bf1_3m,0)+if(bf2_3m>0,bf2_3m,0)+if(bf3_3m>0,bf3_3m,0)+if(af1_3m>0,af1_3m,0)+if(af2_3m>0,af2_3m,0)+if(af3_3m>0,af3_3m,0) as abf_1y_inter_3m_sum_up
        ,if(bf1_3m<0,bf1_3m,0)+if(bf2_3m<0,bf2_3m,0)+if(bf3_3m<0,bf3_3m,0)+if(af1_3m<0,af1_3m,0)+if(af2_3m<0,af2_3m,0)+if(af3_3m<0,af3_3m,0) as abf_1y_inter_3m_sum_down
        ,if(bf1_3m>0,1,0)+if(bf2_3m>0,1,0)+if(bf3_3m>0,1,0)+if(af1_3m>0,1,0)+if(af2_3m>0,1,0)+if(af3_3m>0,1,0) as abf_1y_inter_3m_count_up
        ,if(bf1_3m<0,1,0)+if(bf2_3m<0,1,0)+if(bf3_3m<0,1,0)+if(af1_3m<0,1,0)+if(af2_3m<0,1,0)+if(af3_3m<0,1,0) as abf_1y_inter_3m_count_down

from(
        select uid,mdl_dte
               
               ,bf_1m_amt/bf_2m_amt as bf_1m_trend
               ,af_2m_amt/af_1m_amt as af_1m_trend
               ,bf_0_3m_amt/bf_3_6m_amt as bf_q4_q3_trend
               ,bf_3_6m_amt/bf_6_9m_amt as bf_q3_q2_trend
               ,bf_6_9m_amt/bf_9_12m_amt as bf_q2_q1_trend
               ,af_3_6m_amt/af_0_3m_amt as af_q2_q1_trend
               ,af_6_9m_amt/af_3_6m_amt as af_q3_q2_trend
               ,af_9_12m_amt/af_6_9m_amt as af_q4_q3_trend
        
               ,bf_0_6m_amt/bf_6_12m_amt as bf_6m_trend
               ,af_6_12m_amt/af_0_6m_amt as af_6m_trend
        
               ,bf_1m_amt - bf_2m_amt as bf11_1m
               ,bf_2m_amt - bf_3m_amt as bf10_1m
               ,bf_3m_amt - bf_4m_amt as bf9_1m
               ,bf_4m_amt - bf_5m_amt as bf8_1m
               ,bf_5m_amt - bf_6m_amt as bf7_1m
               ,bf_6m_amt - bf_7m_amt as bf6_1m
               ,bf_7m_amt - bf_8m_amt as bf5_1m
               ,bf_8m_amt - bf_9m_amt as bf4_1m
               ,bf_9m_amt - bf_10m_amt as bf3_1m
               ,bf_10m_amt - bf_11m_amt as bf2_1m
               ,bf_11m_amt - bf_12m_amt as bf1_1m
        
               ,af_2m_amt - af_1m_amt as af1_1m
               ,af_3m_amt - af_2m_amt as af2_1m
               ,af_4m_amt - af_3m_amt as af3_1m
               ,af_5m_amt - af_4m_amt as af4_1m
               ,af_6m_amt - af_5m_amt as af5_1m
               ,af_7m_amt - af_6m_amt as af6_1m
               ,af_8m_amt - af_7m_amt as af7_1m
               ,af_9m_amt - af_8m_amt as af8_1m
               ,af_10m_amt - af_9m_amt as af9_1m
               ,af_11m_amt - af_10m_amt as af10_1m
               ,af_12m_amt - af_11m_amt as af11_1m
        
               ,bf_0_3m_amt - bf_3_6m_amt as bf3_3m
               ,bf_3_6m_amt - bf_6_9m_amt as bf2_3m
               ,bf_6_9m_amt - bf_9_12m_amt as bf1_3m
               ,af_3_6m_amt - af_0_3m_amt as af1_3m
               ,af_6_9m_amt - af_3_6m_amt as af2_3m
               ,af_9_12m_amt - af_6_9m_amt as af3_3m

        from dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df_tmp04
        )
);

--select * from dwa_risk.dwa_risk_dz_model_final_23changzhai_trend_df where ds='20231211' limit 100
-- feature-copilot:node-end ordinal=0
