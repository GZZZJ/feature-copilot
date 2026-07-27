-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_12his_rep_pressure_trend_df
-- node_id: n_5347950409208037379
-- task_name: dwa_risk_dz_model_12his_rep_pressure_trend_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_12his_rep_pressure_trend_df.json
-- source_json_sha256: 9ef90c8bba094236041f29a067b6d111257767767d728fc18eda94d43cb82035
-- upstream_table: dwa_risk.dwa_risk_dz_model_12his_rep_pressure_trend_df_stg_detail_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp1
-- upstream_table: dwa_risk.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp2
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_12his_rep_pressure_trend_df_rep_amt_tmp
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_12his_rep_pressure_trend_df_m6_up_flg

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 裴阳
--创建日期: 2023-12-07 10:42:34
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
--MaxCompute_SQL
--********************************************************************--
--所属主题: 贷中宽表_历史还款压力趋势特征
--功能描述: _btch后缀的变量是指统计的业务类型为BT\CASH,_all后缀的变量是指统计的业务类型为'BALANCE_TRANSFER','CASH','ENJOY_PAY','API_ASSET','BUSINESS_LOAN','HUGE_LOAN'
--创建者: 刘诗涵
--创建日期: 2023-11-21 13:37:56
--修改日期	修改人	修改内容
--20231131	刘诗涵	注：ld_loan.fct_txn_heavy_loancore_stage_plan_df.schedule_pay_principal在不同切片下的取值存在精度差异，导致最新切片和历史评分日T-1下聚合后的变量数值会不一致
--********************************************************************--

create table if not exists ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df(
    uid  string  comment '客户号',
    mdl_dte  date  comment '模型评分日',
    d30_his_rep_amt_sum_btch  decimal(38, 18)  comment '近30天历史应还本金总和_btch',
    d60_his_rep_amt_sum_btch  decimal(38, 18)  comment '近60天历史应还本金总和_btch',
    d90_his_rep_amt_sum_btch  decimal(38, 18)  comment '近90天历史应还本金总和_btch',
    d180_his_rep_amt_sum_btch  decimal(38, 18)  comment '近180天历史应还本金总和_btch',
    d360_his_rep_amt_sum_btch  decimal(38, 18)  comment '近360天历史应还本金总和_btch',
    d30_his_rep_amt_sum_all  decimal(38, 18)  comment '近30天历史应还本金总和_all',
    d60_his_rep_amt_sum_all  decimal(38, 18)  comment '近60天历史应还本金总和_all',
    d90_his_rep_amt_sum_all  decimal(38, 18)  comment '近90天历史应还本金总和_all',
    d180_his_rep_amt_sum_all  decimal(38, 18)  comment '近180天历史应还本金总和_all',
    d360_his_rep_amt_sum_all  decimal(38, 18)  comment '近360天历史应还本金总和_all',
    d30_d60_his_rep_amt_sum_rat_btch  decimal(38, 18)  comment '近30天/近60天历史应还本金总和比例_btch',
    d30_d90_his_rep_amt_sum_rat_btch  decimal(38, 18)  comment '近30天/近90天历史应还本金总和比例_btch',
    d30_d180_his_rep_amt_sum_rat_btch  decimal(38, 18)  comment '近30天/近180天历史应还本金总和比例_btch',
    d90_d180_his_rep_amt_sum_rat_btch  decimal(38, 18)  comment '近90天/近180天历史应还本金总和比例_btch',
    d90_d360_his_rep_amt_sum_rat_btch  decimal(38, 18)  comment '近90天/近360天历史应还本金总和比例_btch',
    d180_d360_his_rep_amt_sum_rat_btch  decimal(38, 18)  comment '近180天/近360天历史应还本金总和比例_btch',
    d30_d60_his_rep_amt_sum_rat_all  decimal(38, 18)  comment '近30天/近60天历史应还本金总和比例_all',
    d30_d90_his_rep_amt_sum_rat_all  decimal(38, 18)  comment '近30天/近90天历史应还本金总和比例_all',
    d30_d180_his_rep_amt_sum_rat_all  decimal(38, 18)  comment '近30天/近180天历史应还本金总和比例_all',
    d90_d180_his_rep_amt_sum_rat_all  decimal(38, 18)  comment '近90天/近180天历史应还本金总和比例_all',
    d90_d360_his_rep_amt_sum_rat_all  decimal(38, 18)  comment '近90天/近360天历史应还本金总和比例_all',
    d180_d360_his_rep_amt_sum_rat_all  decimal(38, 18)  comment '近180天/近360天历史应还本金总和比例_all',
    lag_his_rep_amt_sum_per_mth_btch_rat_max  decimal(38, 18)  comment '近6个月当月/上个月历史应还本金总和比例_最大_btch',
    lag_his_rep_amt_sum_per_mth_btch_rat_avg  decimal(38, 18)  comment '近6个月当月/上个月历史应还本金总和比例_平均_btch',
    m6_up_flg_btch_cnt  bigint   comment '近6个月当月应还本金总和比上月应还本金总和多的月份数_btch',
    m6_up_flg_btch_cnt_rat  double  comment '近6个月当月应还本金总和比上月应还本金总和多的月份数占比_btch',
    lag_his_rep_amt_sum_per_mth_btch_rat_mor_50_per_cnt  bigint   comment '近6个月当月/上个月历史应还本金总和比例大于1.5的月份数_btch',
    lag_his_rep_amt_sum_per_mth_all_rat_max  decimal(38, 18)  comment '近6个月当月/上个月历史应还本金总和比例_最大_all',
    lag_his_rep_amt_sum_per_mth_all_rat_avg  decimal(38, 18)  comment '近6个月当月/上个月历史应还本金总和比例_平均_all',
    m6_up_flg_all_cnt  bigint   comment '近6个月当月应还本金总和比上月应还本金总和多的月份数_all',
    m6_up_flg_all_cnt_rat  double  comment '近6个月当月应还本金总和比上月应还本金总和多的月份数占比_all',
    lag_his_rep_amt_sum_per_mth_all_rat_mor_50_per_cnt  bigint   comment '近6个月当月/上个月历史应还本金总和比例大于1.5的月份数_all'
)comment '贷中宽表_历史还款压力趋势特征,对全量复借户打分'
partitioned by (ds string)
;

set odps.stage.mapper.split.size=20;
-- 用户借还款明细
drop table if exists ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_stg_detail_tmp;
create table ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_stg_detail_tmp as
select uid
        ,mdl_dte
        ,loan_date
        ,order_no
        ,stage_plan_no
        ,due_date
        ,settle_up_time
        ,settle_up_time_new
        ,to_date(settle_up_time_new) as rep_dte
        ,schedule_pay_principal
        ,business_type
        ,ddf_mdl_due_dte
        ,ddf_rep_due_dte
        ,case when business_type in ('BALANCE_TRANSFER','CASH') then 1 else 0 end as btch_flg
        ,case when settle_up_time_new is null then 1 else 0 end as cur_ovd_flg -- 当前逾期标识
        ,case when ddf_rep_due_dte is null then datediff(mdl_dte,date(due_date)) 
              when ddf_rep_due_dte <= 0 then 0
              else ddf_rep_due_dte end as ovd_days
        ,case when ddf_mdl_due_dte <= 30 then 1
              when ddf_mdl_due_dte <= 60 then 2
              when ddf_mdl_due_dte <= 90 then 3
              when ddf_mdl_due_dte <= 120 then 4
              when ddf_mdl_due_dte <= 150 then 5
              when ddf_mdl_due_dte <= 180 then 6
              else 999 end as ddf_mdl_due_dte_flg
        --评分日和应还日的间隔时间切片的flag
        ,case when ddf_mdl_due_dte <= 30 then 1 else 0 end as d30_flg
        ,case when ddf_mdl_due_dte <= 60 then 1 else 0 end as d60_flg
        ,case when ddf_mdl_due_dte <= 90 then 1 else 0 end as d90_flg
        ,case when ddf_mdl_due_dte <= 180 then 1 else 0 end as d180_flg
        ,case when ddf_mdl_due_dte <= 360 then 1 else 0 end as d360_flg
from
(
    select a.uid
        ,a.mdl_dte
        ,loan_date
        ,order_no
        ,stage_plan_no
        ,due_date
        ,settle_up_time
        ,case when to_date(settle_up_time) >= a.mdl_dte then null else settle_up_time end as settle_up_time_new
        ,schedule_pay_principal
        ,business_type
        ,datediff(a.mdl_dte,date(due_date)) as ddf_mdl_due_dte
        ,case when to_date(settle_up_time) >= a.mdl_dte then null else datediff(to_date(settle_up_time),due_date) end as ddf_rep_due_dte
    from 
    (
        select uid
                ,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
        from dwt.dwt_heavy_order_df 
        where ds = '${bizdate}'
        and loan_success_flag = 1
        group by uid
    ) a
    left join 
    (
        select uid,
            loan_date,
            order_no,
            stage_plan_no,
            settlement_time as settle_up_time,
            schedule_pay_principal,-- 应还本金(单位:元)
            -- schedule_total_amount, -- 应还总金额(单位:元),
            due_date,
            original_biz_type as business_type
        from cdmx.cdmx_fct_heavy_stage_plan_df
        where ds = '${bizdate}'
        and original_stage_plan_status in ('U','X','O','S','A','E')
        and original_biz_type in ('BALANCE_TRANSFER','CASH','ENJOY_PAY','API_ASSET','BUSINESS_LOAN','HUGE_LOAN')
    ) b 
    on a.uid = b.uid 
    where date(b.loan_date) < mdl_dte -- 历史订单
    and due_date >= date_add(mdl_dte,-360) and due_date < mdl_dte -- 历史一年的到期订单
) as aa
;


set odps.stage.mapper.split.size=20; 

drop table if exists ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_rep_amt_tmp;
create table ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_rep_amt_tmp as
select uid
       ,mdl_dte
       -- /*还款金额*/
       ,sum(case when d30_flg = 1 then schedule_pay_principal else 0 end) as d30_his_rep_amt_sum_all
       ,sum(case when d60_flg = 1 then schedule_pay_principal else 0 end) as d60_his_rep_amt_sum_all
       ,sum(case when d90_flg = 1 then schedule_pay_principal else 0 end) as d90_his_rep_amt_sum_all
       ,sum(case when d180_flg = 1 then schedule_pay_principal else 0 end) as d180_his_rep_amt_sum_all
       ,sum(case when d360_flg = 1 then schedule_pay_principal else 0 end) as d360_his_rep_amt_sum_all
       -- /*重资产*/
       ,sum(case when btch_flg = 1 and d30_flg = 1 then schedule_pay_principal else 0 end) as d30_his_rep_amt_sum_btch
       ,sum(case when btch_flg = 1 and d60_flg = 1 then schedule_pay_principal else 0 end) as d60_his_rep_amt_sum_btch
       ,sum(case when btch_flg = 1 and d90_flg = 1 then schedule_pay_principal else 0 end) as d90_his_rep_amt_sum_btch
       ,sum(case when btch_flg = 1 and d180_flg = 1 then schedule_pay_principal else 0 end) as d180_his_rep_amt_sum_btch
       ,sum(case when btch_flg = 1 and d360_flg = 1 then schedule_pay_principal else 0 end) as d360_his_rep_amt_sum_btch
from ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_stg_detail_tmp
group by uid
        ,mdl_dte
;



-- 历史还款趋势
set odps.stage.mapper.split.size=20; 

drop table if exists ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp1 as
select uid
        ,mdl_dte
        ,d30_his_rep_amt_sum_btch
        ,d60_his_rep_amt_sum_btch
        ,d90_his_rep_amt_sum_btch
        ,d180_his_rep_amt_sum_btch
        ,d360_his_rep_amt_sum_btch
        ,d30_his_rep_amt_sum_all
        ,d60_his_rep_amt_sum_all
        ,d90_his_rep_amt_sum_all
        ,d180_his_rep_amt_sum_all
        ,d360_his_rep_amt_sum_all
        ,case when d60_his_rep_amt_sum_btch = 0 then -1 else d30_his_rep_amt_sum_btch/d60_his_rep_amt_sum_btch end as d30_d60_his_rep_amt_sum_rat_btch
        ,case when d90_his_rep_amt_sum_btch = 0 then -1 else d30_his_rep_amt_sum_btch/d90_his_rep_amt_sum_btch end as d30_d90_his_rep_amt_sum_rat_btch
        ,case when d180_his_rep_amt_sum_btch = 0 then -1 else d30_his_rep_amt_sum_btch/d180_his_rep_amt_sum_btch end as d30_d180_his_rep_amt_sum_rat_btch
        ,case when d180_his_rep_amt_sum_btch = 0 then -1 else d90_his_rep_amt_sum_btch/d180_his_rep_amt_sum_btch end as d90_d180_his_rep_amt_sum_rat_btch
        ,case when d360_his_rep_amt_sum_btch = 0 then -1 else d90_his_rep_amt_sum_btch/d360_his_rep_amt_sum_btch end as d90_d360_his_rep_amt_sum_rat_btch
        ,case when d360_his_rep_amt_sum_btch = 0 then -1 else d180_his_rep_amt_sum_btch/d360_his_rep_amt_sum_btch end as d180_d360_his_rep_amt_sum_rat_btch
        ,case when d60_his_rep_amt_sum_all = 0 then -1 else d30_his_rep_amt_sum_all/d60_his_rep_amt_sum_all end as d30_d60_his_rep_amt_sum_rat_all
        ,case when d90_his_rep_amt_sum_all = 0 then -1 else d30_his_rep_amt_sum_all/d90_his_rep_amt_sum_all end as d30_d90_his_rep_amt_sum_rat_all
        ,case when d180_his_rep_amt_sum_all = 0 then -1 else d30_his_rep_amt_sum_all/d180_his_rep_amt_sum_all end as d30_d180_his_rep_amt_sum_rat_all
        ,case when d180_his_rep_amt_sum_all = 0 then -1 else d90_his_rep_amt_sum_all/d180_his_rep_amt_sum_all end as d90_d180_his_rep_amt_sum_rat_all
        ,case when d360_his_rep_amt_sum_all = 0 then -1 else d90_his_rep_amt_sum_all/d360_his_rep_amt_sum_all end as d90_d360_his_rep_amt_sum_rat_all
        ,case when d360_his_rep_amt_sum_all = 0 then -1 else d180_his_rep_amt_sum_all/d360_his_rep_amt_sum_all end as d180_d360_his_rep_amt_sum_rat_all
from ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_rep_amt_tmp
;


-- 近6个月的还款趋势幅度
set odps.stage.mapper.split.size=20; 

drop table if exists ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_m6_up_flg;
create table ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_m6_up_flg as
select uid
       ,mdl_dte
       ,ddf_mdl_due_dte_flg
       ,his_rep_amt_sum_per_mth_btch
       ,his_rep_amt_sum_per_mth_all
       ,lag_his_rep_amt_sum_per_mth_btch
       ,lag_his_rep_amt_sum_per_mth_all
       ,his_rep_amt_sum_per_mth_btch/lag_his_rep_amt_sum_per_mth_btch as lag_his_rep_amt_sum_per_mth_btch_rat
       ,his_rep_amt_sum_per_mth_all/lag_his_rep_amt_sum_per_mth_all as lag_his_rep_amt_sum_per_mth_all_rat
       ,case when lag_his_rep_amt_sum_per_mth_all is null or his_rep_amt_sum_per_mth_all<=lag_his_rep_amt_sum_per_mth_all then 0 
              when his_rep_amt_sum_per_mth_all > lag_his_rep_amt_sum_per_mth_all then 1
              else null end as m6_up_flg_all
       ,case when lag_his_rep_amt_sum_per_mth_btch is null or his_rep_amt_sum_per_mth_btch<=lag_his_rep_amt_sum_per_mth_btch then 0 
              when his_rep_amt_sum_per_mth_btch > lag_his_rep_amt_sum_per_mth_btch then 1
              else null end as m6_up_flg_btch   
from
(
    select uid
           ,mdl_dte
           ,ddf_mdl_due_dte_flg
           ,his_rep_amt_sum_per_mth_btch
           ,his_rep_amt_sum_per_mth_all
           ,lag(his_rep_amt_sum_per_mth_btch, 1, NULL) over(partition by uid,mdl_dte order by ddf_mdl_due_dte_flg desc) as lag_his_rep_amt_sum_per_mth_btch
           ,lag(his_rep_amt_sum_per_mth_all, 1, NULL) over(partition by uid,mdl_dte order by ddf_mdl_due_dte_flg desc) as lag_his_rep_amt_sum_per_mth_all
    from
    (
        select uid
               ,mdl_dte
               ,ddf_mdl_due_dte_flg
               ,sum(case when btch_flg = 1 then schedule_pay_principal else 0 end) as his_rep_amt_sum_per_mth_btch
               ,sum(schedule_pay_principal) as his_rep_amt_sum_per_mth_all
        from ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_stg_detail_tmp
        where ddf_mdl_due_dte_flg <= 6
        group by uid
                 ,mdl_dte
                 ,ddf_mdl_due_dte_flg
    ) as a
) as aa
;


set odps.stage.mapper.split.size=20; 

drop table if exists ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp2 as
select uid
        ,mdl_dte
        ,max(lag_his_rep_amt_sum_per_mth_btch_rat) as lag_his_rep_amt_sum_per_mth_btch_rat_max
        ,sum(case when lag_his_rep_amt_sum_per_mth_btch_rat is not null then lag_his_rep_amt_sum_per_mth_btch_rat else 0 end)/sum(case when lag_his_rep_amt_sum_per_mth_btch_rat is not null then 1 else 0 end) as lag_his_rep_amt_sum_per_mth_btch_rat_avg
        ,sum(m6_up_flg_btch) as m6_up_flg_btch_cnt
        ,sum(m6_up_flg_btch)/count(ddf_mdl_due_dte_flg) as m6_up_flg_btch_cnt_rat
        ,sum(case when lag_his_rep_amt_sum_per_mth_btch_rat>1.5 then 1 else 0 end) as lag_his_rep_amt_sum_per_mth_btch_rat_mor_50_per_cnt
        ,max(lag_his_rep_amt_sum_per_mth_all_rat) as lag_his_rep_amt_sum_per_mth_all_rat_max
        ,sum(case when lag_his_rep_amt_sum_per_mth_all_rat is not null then lag_his_rep_amt_sum_per_mth_all_rat else 0 end)/sum(case when lag_his_rep_amt_sum_per_mth_all_rat is not null then 1 else 0 end) as lag_his_rep_amt_sum_per_mth_all_rat_avg
        ,sum(m6_up_flg_all) as m6_up_flg_all_cnt
        ,sum(m6_up_flg_all)/count(ddf_mdl_due_dte_flg) as m6_up_flg_all_cnt_rat   
        ,sum(case when lag_his_rep_amt_sum_per_mth_all_rat>1.5 then 1 else 0 end) as lag_his_rep_amt_sum_per_mth_all_rat_mor_50_per_cnt   
from ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_m6_up_flg
group by uid
            ,mdl_dte
;




-- 合并

set odps.stage.mapper.split.size=20; 

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df partition(ds)
select main_table.uid
        ,main_table.mdl_dte
        ,d30_his_rep_amt_sum_btch
        ,d60_his_rep_amt_sum_btch
        ,d90_his_rep_amt_sum_btch
        ,d180_his_rep_amt_sum_btch
        ,d360_his_rep_amt_sum_btch
        ,d30_his_rep_amt_sum_all
        ,d60_his_rep_amt_sum_all
        ,d90_his_rep_amt_sum_all
        ,d180_his_rep_amt_sum_all
        ,d360_his_rep_amt_sum_all
        ,d30_d60_his_rep_amt_sum_rat_btch
        ,d30_d90_his_rep_amt_sum_rat_btch
        ,d30_d180_his_rep_amt_sum_rat_btch
        ,d90_d180_his_rep_amt_sum_rat_btch
        ,d90_d360_his_rep_amt_sum_rat_btch
        ,d180_d360_his_rep_amt_sum_rat_btch
        ,d30_d60_his_rep_amt_sum_rat_all
        ,d30_d90_his_rep_amt_sum_rat_all
        ,d30_d180_his_rep_amt_sum_rat_all
        ,d90_d180_his_rep_amt_sum_rat_all
        ,d90_d360_his_rep_amt_sum_rat_all
        ,d180_d360_his_rep_amt_sum_rat_all
        ,lag_his_rep_amt_sum_per_mth_btch_rat_max
        ,lag_his_rep_amt_sum_per_mth_btch_rat_avg
        ,m6_up_flg_btch_cnt
        ,m6_up_flg_btch_cnt_rat
        ,lag_his_rep_amt_sum_per_mth_btch_rat_mor_50_per_cnt
        ,lag_his_rep_amt_sum_per_mth_all_rat_max
        ,lag_his_rep_amt_sum_per_mth_all_rat_avg
        ,m6_up_flg_all_cnt
        ,m6_up_flg_all_cnt_rat
        ,lag_his_rep_amt_sum_per_mth_all_rat_mor_50_per_cnt
        ,ds
from 
(
       select uid
                ,date_add(date(to_date(ds,'yyyymmdd')),1) as mdl_dte
                ,ds
        from dwt.dwt_heavy_order_df 
        where ds = '${bizdate}'
        and loan_success_flag = 1  
        group by uid,ds
) as main_table
left join
(
    select uid
        ,mdl_dte
        ,d30_his_rep_amt_sum_btch
        ,d60_his_rep_amt_sum_btch
        ,d90_his_rep_amt_sum_btch
        ,d180_his_rep_amt_sum_btch
        ,d360_his_rep_amt_sum_btch
        ,d30_his_rep_amt_sum_all
        ,d60_his_rep_amt_sum_all
        ,d90_his_rep_amt_sum_all
        ,d180_his_rep_amt_sum_all
        ,d360_his_rep_amt_sum_all
        ,d30_d60_his_rep_amt_sum_rat_btch
        ,d30_d90_his_rep_amt_sum_rat_btch
        ,d30_d180_his_rep_amt_sum_rat_btch
        ,d90_d180_his_rep_amt_sum_rat_btch
        ,d90_d360_his_rep_amt_sum_rat_btch
        ,d180_d360_his_rep_amt_sum_rat_btch
        ,d30_d60_his_rep_amt_sum_rat_all
        ,d30_d90_his_rep_amt_sum_rat_all
        ,d30_d180_his_rep_amt_sum_rat_all
        ,d90_d180_his_rep_amt_sum_rat_all
        ,d90_d360_his_rep_amt_sum_rat_all
        ,d180_d360_his_rep_amt_sum_rat_all
    from ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp1
) as b
on main_table.uid = b.uid and main_table.mdl_dte = b.mdl_dte
left join
(
    select uid
        ,mdl_dte
        ,lag_his_rep_amt_sum_per_mth_btch_rat_max
        ,lag_his_rep_amt_sum_per_mth_btch_rat_avg
        ,m6_up_flg_btch_cnt
        ,m6_up_flg_btch_cnt_rat
        ,lag_his_rep_amt_sum_per_mth_btch_rat_mor_50_per_cnt
        ,lag_his_rep_amt_sum_per_mth_all_rat_max
        ,lag_his_rep_amt_sum_per_mth_all_rat_avg
        ,m6_up_flg_all_cnt
        ,m6_up_flg_all_cnt_rat
        ,lag_his_rep_amt_sum_per_mth_all_rat_mor_50_per_cnt
    from ${dwa_risk}.dwa_risk_dz_model_12his_rep_pressure_trend_df_tmp2
) as c
on main_table.uid = c.uid and main_table.mdl_dte = c.mdl_dte
;
-- feature-copilot:node-end ordinal=0
