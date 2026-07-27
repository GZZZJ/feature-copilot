-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_light_trans_inner_cross_behaviour_df
-- node_id: n_6918426435309404160
-- task_name: dwa_risk_dz_model_light_trans_inner_cross_behaviour_df
-- owner_name: 蔡杰斐
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_light_trans_inner_cross_behaviour_df.json
-- source_json_sha256: fe17944b7b79faeb10f6e9096a774b0bdf73a93d84fa105ce27d2ce59bb68c50
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp04
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp07
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp05
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp01
-- upstream_table: dwa_risk.dwa_risk_f_light_credit_data_base_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_2
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_1
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp03
-- upstream_table: dwa_risk.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp06
-- upstream_table: cdmx.cdmx_fct_light_loan_order_df
-- upstream_table: cdmx.etl_cdmx_fct_light_stage_plan_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 蔡杰斐
--创建日期: 2025-04-24 18:22:42
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

-- drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp_dt;
-- create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp_dt
-- as
-- select cast(gap as int) as gap
-- from (
--     select row_number()over() as gap
--     from (
--         select explode(array_repeat('', datediff(to_date('${bizdate}', 'yyyymmdd'), to_date('20180101', 'yyyymmdd'),'MM')))
--     ) q
-- ) g
;

-- drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_old;
-- create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_old
-- as
-- select t.uid -- 用户
--     ,t.mdl_dte
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth = 0 then t.mth end end) as recent_1m_overdue_3d_month_cnt -- 近1个月_有逾期还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 5 then t.mth end end) as recent_6m_overdue_3d_month_cnt -- 近6个月_有逾期还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 11 then t.mth end end) as recent_12m_overdue_3d_month_cnt -- 近12个月_有逾期还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 23 then t.mth end end) as recent_24m_overdue_3d_month_cnt -- 近24个月_有逾期还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 35 then t.mth end end) as recent_36m_overdue_3d_month_cnt -- 近36个月_有逾期还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth = 0 then t.mth end end) / 1 as recent_1m_overdue_3d_month_rto -- 近1个月_有逾期还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 5 then t.mth end end) / 6 as recent_6m_overdue_3d_month_rto -- 近6个月_有逾期还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 11 then t.mth end end) / 12 as recent_12m_overdue_3d_month_rto -- 近12个月_有逾期还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 23 then t.mth end end) / 24 as recent_24m_overdue_3d_month_rto -- 近24个月_有逾期还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 35 then t.mth end end) / 36 as recent_36m_overdue_3d_month_rto -- 近36个月_有逾期还款3天以上_的月份数_占比
--     ,avg(case when due_settle_diff < -3 then case when diff_mth = 0 then month(t.mth) end end) as recent_1m_overdue_3d_month_no_avg -- 近1个月_有逾期还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 5 then month(t.mth) end end) as recent_6m_overdue_3d_month_no_avg -- 近6个月_有逾期还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 11 then month(t.mth) end end) as recent_12m_overdue_3d_month_no_avg -- 近12个月_有逾期还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 23 then month(t.mth) end end) as recent_24m_overdue_3d_month_no_avg -- 近24个月_有逾期还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 35 then month(t.mth) end end) as recent_36m_overdue_3d_month_no_avg -- 近36个月_有逾期还款3天以上_的月份编号_均值
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth = 0 then t.mth end end) as recent_1m_prepay_3d_month_cnt -- 近1个月_有提前还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 5 then t.mth end end) as recent_6m_prepay_3d_month_cnt -- 近6个月_有提前还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 11 then t.mth end end) as recent_12m_prepay_3d_month_cnt -- 近12个月_有提前还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 23 then t.mth end end) as recent_24m_prepay_3d_month_cnt -- 近24个月_有提前还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 35 then t.mth end end) as recent_36m_prepay_3d_month_cnt -- 近36个月_有提前还款3天以上_的月份数_总和
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth = 0 then t.mth end end) / 1 as recent_1m_prepay_3d_month_rto -- 近1个月_有提前还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 5 then t.mth end end) / 6 as recent_6m_prepay_3d_month_rto -- 近6个月_有提前还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 11 then t.mth end end) / 12 as recent_12m_prepay_3d_month_rto -- 近12个月_有提前还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 23 then t.mth end end) / 24 as recent_24m_prepay_3d_month_rto -- 近24个月_有提前还款3天以上_的月份数_占比
--     ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 35 then t.mth end end) / 36 as recent_36m_prepay_3d_month_rto -- 近36个月_有提前还款3天以上_的月份数_占比
--     ,avg(case when due_settle_diff > 3 then case when diff_mth = 0 then month(t.mth) end end) as recent_1m_prepay_3d_month_no_avg -- 近1个月_有提前还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 5 then month(t.mth) end end) as recent_6m_prepay_3d_month_no_avg -- 近6个月_有提前还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 11 then month(t.mth) end end) as recent_12m_prepay_3d_month_no_avg -- 近12个月_有提前还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 23 then month(t.mth) end end) as recent_24m_prepay_3d_month_no_avg -- 近24个月_有提前还款3天以上_的月份编号_均值
--     ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 35 then month(t.mth) end end) as recent_36m_prepay_3d_month_no_avg -- 近36个月_有提前还款3天以上_的月份编号_均值
--     ,avg(case when diff_mth = 0 then month(t.mth) end) as recent_1m_settle_month_no_avg -- 近1个月_发生过结清订单行为_的月份编号_均值
--     ,avg(case when diff_mth between 0 and 5 then month(t.mth) end) as recent_6m_settle_month_no_avg -- 近6个月_发生过结清订单行为_的月份编号_均值
--     ,avg(case when diff_mth between 0 and 11 then month(t.mth) end) as recent_12m_settle_month_no_avg -- 近12个月_发生过结清订单行为_的月份编号_均值
--     ,avg(case when diff_mth between 0 and 23 then month(t.mth) end) as recent_24m_settle_month_no_avg -- 近24个月_发生过结清订单行为_的月份编号_均值
--     ,avg(case when diff_mth between 0 and 35 then month(t.mth) end) as recent_36m_settle_month_no_avg -- 近36个月_发生过结清订单行为_的月份编号_均值
--     ,count(distinct case when diff_due_mth = 0 then t.due_mth end) as recent_1m_due_month_cnt -- 近1个月_有应还日_的月份数_总和
--     ,count(distinct case when diff_due_mth between 0 and 5 then t.due_mth end) as recent_6m_due_month_cnt -- 近6个月_有应还日_的月份数_总和
--     ,count(distinct case when diff_due_mth between 0 and 11 then t.due_mth end) as recent_12m_due_month_cnt -- 近12个月_有应还日_的月份数_总和
--     ,count(distinct case when diff_due_mth between 0 and 23 then t.due_mth end) as recent_24m_due_month_cnt -- 近24个月_有应还日_的月份数_总和
--     ,count(distinct case when diff_due_mth between 0 and 35 then t.due_mth end) as recent_36m_due_month_cnt -- 近36个月_有应还日_的月份数_总和
--     ,count(distinct case when diff_due_mth = 0 then t.due_mth end) / 1 as recent_1m_due_month_rto -- 近1个月_有应还日_的月份数_占比
--     ,count(distinct case when diff_due_mth between 0 and 5 then t.due_mth end) / 6 as recent_6m_due_month_rto -- 近6个月_有应还日_的月份数_占比
--     ,count(distinct case when diff_due_mth between 0 and 11 then t.due_mth end) / 12 as recent_12m_due_month_rto -- 近12个月_有应还日_的月份数_占比
--     ,count(distinct case when diff_due_mth between 0 and 23 then t.due_mth end) / 24 as recent_24m_due_month_rto -- 近24个月_有应还日_的月份数_占比
--     ,count(distinct case when diff_due_mth between 0 and 35 then t.due_mth end) / 36 as recent_36m_due_month_rto -- 近36个月_有应还日_的月份数_占比
-- from (
--     select /*+ mapjoin(gp) */
--         t0.uid 
--         ,case when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
--                 and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
--             then dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM') end as mth
--         ,case when cast(a.due_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
--                 and cast(a.due_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
--             then dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1, 'MM') end as due_mth
--         ,a.due_settle_diff
--         ,cast(gp.gap as int) diff_due_mth
--         ,cast(gp.gap as int) diff_mth
--         ,t0.mdl_dte as  mdl_dte
--     from (
--             select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
--             from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
--             where    ds = '${bizdate}' 
--             group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
--     ) t0
--     left join (
--         select  sp.uid
--                ,sp.order_no
--                ,sp.stage_plan_no
--                ,sp.settlement_time
--                ,cast(sp.settlement_time as date) as settlement_date
--                ,od.fund_loan_date
--                ,sp.due_date
--                ,sp.schedule_pay_total_amount
--                ,od.loan_principal
--                ,od.fund_code
--                ,case
--                   when to_char(sp.settlement_time , 'yyyymmdd') <= '${bizdate}' then datediff(sp.due_date , cast(sp.settlement_time as date) , 'DD')
--                   else null
--                 end                              as due_settle_diff
--         from    ${cdmx}.etl_cdmx_fct_light_stage_plan_df sp
--         left join ${cdmx}.cdmx_fct_light_loan_order_df od
--         on      od.ds = '${bizdate}'
--         and     sp.order_no = od.order_no
--         where   sp.ds = '${bizdate}'
--         and     to_char(od.fund_loan_date , 'yyyymmdd') <= '${bizdate}'
--     ) a
--     on t0.uid = a.uid
--     left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp_dt gp
--     on 1 = 1
-- ) t
-- group by t.uid
-- ,t.mdl_dte
-- ;


drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_1;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_1
as
select t.uid -- 用户
    ,t.mdl_dte
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth = 0 then t.mth end end) as recent_1m_overdue_3d_month_cnt -- 近1个月_有逾期还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 5 then t.mth end end) as recent_6m_overdue_3d_month_cnt -- 近6个月_有逾期还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 11 then t.mth end end) as recent_12m_overdue_3d_month_cnt -- 近12个月_有逾期还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 23 then t.mth end end) as recent_24m_overdue_3d_month_cnt -- 近24个月_有逾期还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 35 then t.mth end end) as recent_36m_overdue_3d_month_cnt -- 近36个月_有逾期还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth = 0 then t.mth end end) / 1 as recent_1m_overdue_3d_month_rto -- 近1个月_有逾期还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 5 then t.mth end end) / 6 as recent_6m_overdue_3d_month_rto -- 近6个月_有逾期还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 11 then t.mth end end) / 12 as recent_12m_overdue_3d_month_rto -- 近12个月_有逾期还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 23 then t.mth end end) / 24 as recent_24m_overdue_3d_month_rto -- 近24个月_有逾期还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff < -3 then case when diff_mth between 0 and 35 then t.mth end end) / 36 as recent_36m_overdue_3d_month_rto -- 近36个月_有逾期还款3天以上_的月份数_占比
    ,avg(case when due_settle_diff < -3 then case when diff_mth = 0 then month(t.mth) end end) as recent_1m_overdue_3d_month_no_avg -- 近1个月_有逾期还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 5 then month(t.mth) end end) as recent_6m_overdue_3d_month_no_avg -- 近6个月_有逾期还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 11 then month(t.mth) end end) as recent_12m_overdue_3d_month_no_avg -- 近12个月_有逾期还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 23 then month(t.mth) end end) as recent_24m_overdue_3d_month_no_avg -- 近24个月_有逾期还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff < -3 then case when diff_mth between 0 and 35 then month(t.mth) end end) as recent_36m_overdue_3d_month_no_avg -- 近36个月_有逾期还款3天以上_的月份编号_均值
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth = 0 then t.mth end end) as recent_1m_prepay_3d_month_cnt -- 近1个月_有提前还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 5 then t.mth end end) as recent_6m_prepay_3d_month_cnt -- 近6个月_有提前还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 11 then t.mth end end) as recent_12m_prepay_3d_month_cnt -- 近12个月_有提前还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 23 then t.mth end end) as recent_24m_prepay_3d_month_cnt -- 近24个月_有提前还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 35 then t.mth end end) as recent_36m_prepay_3d_month_cnt -- 近36个月_有提前还款3天以上_的月份数_总和
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth = 0 then t.mth end end) / 1 as recent_1m_prepay_3d_month_rto -- 近1个月_有提前还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 5 then t.mth end end) / 6 as recent_6m_prepay_3d_month_rto -- 近6个月_有提前还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 11 then t.mth end end) / 12 as recent_12m_prepay_3d_month_rto -- 近12个月_有提前还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 23 then t.mth end end) / 24 as recent_24m_prepay_3d_month_rto -- 近24个月_有提前还款3天以上_的月份数_占比
    ,count(distinct case when due_settle_diff > 3 then case when diff_mth between 0 and 35 then t.mth end end) / 36 as recent_36m_prepay_3d_month_rto -- 近36个月_有提前还款3天以上_的月份数_占比
    ,avg(case when due_settle_diff > 3 then case when diff_mth = 0 then month(t.mth) end end) as recent_1m_prepay_3d_month_no_avg -- 近1个月_有提前还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 5 then month(t.mth) end end) as recent_6m_prepay_3d_month_no_avg -- 近6个月_有提前还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 11 then month(t.mth) end end) as recent_12m_prepay_3d_month_no_avg -- 近12个月_有提前还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 23 then month(t.mth) end end) as recent_24m_prepay_3d_month_no_avg -- 近24个月_有提前还款3天以上_的月份编号_均值
    ,avg(case when due_settle_diff > 3 then case when diff_mth between 0 and 35 then month(t.mth) end end) as recent_36m_prepay_3d_month_no_avg -- 近36个月_有提前还款3天以上_的月份编号_均值
    ,avg(case when diff_mth = 0 then month(t.mth) end) as recent_1m_settle_month_no_avg -- 近1个月_发生过结清订单行为_的月份编号_均值
    ,avg(case when diff_mth between 0 and 5 then month(t.mth) end) as recent_6m_settle_month_no_avg -- 近6个月_发生过结清订单行为_的月份编号_均值
    ,avg(case when diff_mth between 0 and 11 then month(t.mth) end) as recent_12m_settle_month_no_avg -- 近12个月_发生过结清订单行为_的月份编号_均值
    ,avg(case when diff_mth between 0 and 23 then month(t.mth) end) as recent_24m_settle_month_no_avg -- 近24个月_发生过结清订单行为_的月份编号_均值
    ,avg(case when diff_mth between 0 and 35 then month(t.mth) end) as recent_36m_settle_month_no_avg -- 近36个月_发生过结清订单行为_的月份编号_均值
from (
    select /*+ mapjoin(gp) */
        t0.uid 
        ,case when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
                and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
            then dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM') end as mth
        ,a.due_settle_diff
        ,cast(gp.gap as int) diff_mth
        ,t0.mdl_dte as  mdl_dte
    from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
    ) t0
    left join (
        select  sp.uid
               ,sp.order_no
               ,sp.stage_plan_no
               ,sp.settlement_time
               ,cast(sp.settlement_time as date) as settlement_date
               ,od.fund_loan_date
               ,sp.due_date
               ,sp.schedule_pay_total_amount
               ,od.loan_principal
               ,od.fund_code
               ,datediff(sp.due_date , cast(sp.settlement_time as date) , 'DD') as due_settle_diff
        from    ${cdmx}.etl_cdmx_fct_light_stage_plan_df sp
        left join ${cdmx}.cdmx_fct_light_loan_order_df od
        on      od.ds = '${bizdate}'
        and     sp.order_no = od.order_no
        where   sp.ds = '${bizdate}'
    ) a
    on t0.uid = a.uid
    left join (
        select cast(gap as int) as gap
        from (
            select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
        ) gg
    ) gp
    on 1 = 1
) t
where t.mth is not null
group by t.uid
,t.mdl_dte
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_2;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_2
as
select t.uid -- 用户
    ,t.mdl_dte
    ,count(distinct case when diff_due_mth = 0 then t.due_mth end) as recent_1m_due_month_cnt -- 近1个月_有应还日_的月份数_总和
    ,count(distinct case when diff_due_mth between 0 and 5 then t.due_mth end) as recent_6m_due_month_cnt -- 近6个月_有应还日_的月份数_总和
    ,count(distinct case when diff_due_mth between 0 and 11 then t.due_mth end) as recent_12m_due_month_cnt -- 近12个月_有应还日_的月份数_总和
    ,count(distinct case when diff_due_mth between 0 and 23 then t.due_mth end) as recent_24m_due_month_cnt -- 近24个月_有应还日_的月份数_总和
    ,count(distinct case when diff_due_mth between 0 and 35 then t.due_mth end) as recent_36m_due_month_cnt -- 近36个月_有应还日_的月份数_总和
    ,cast(count(distinct case when diff_due_mth = 0 then t.due_mth end) / 1 as decimal(26, 10)) as recent_1m_due_month_rto -- 近1个月_有应还日_的月份数_占比
    ,cast(count(distinct case when diff_due_mth between 0 and 5 then t.due_mth end) / 6 as decimal(26, 10)) as recent_6m_due_month_rto -- 近6个月_有应还日_的月份数_占比
    ,cast(count(distinct case when diff_due_mth between 0 and 11 then t.due_mth end) / 12 as decimal(26, 10)) as recent_12m_due_month_rto -- 近12个月_有应还日_的月份数_占比
    ,cast(count(distinct case when diff_due_mth between 0 and 23 then t.due_mth end) / 24 as decimal(26, 10)) as recent_24m_due_month_rto -- 近24个月_有应还日_的月份数_占比
    ,cast(count(distinct case when diff_due_mth between 0 and 35 then t.due_mth end) / 36 as decimal(26, 10)) as recent_36m_due_month_rto -- 近36个月_有应还日_的月份数_占比
from (
    select /*+ mapjoin(gp) */
        t0.uid 
        ,case when cast(a.due_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
                and cast(a.due_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
            then dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1, 'MM') end as due_mth
        ,a.due_settle_diff
        ,cast(gp.gap as int) diff_due_mth
        ,t0.mdl_dte as  mdl_dte
    from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}'
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
    ) t0
    left join (
        select  sp.uid
               ,sp.order_no
               ,sp.stage_plan_no
               ,sp.settlement_time
               ,cast(sp.settlement_time as date) as settlement_date
               ,od.fund_loan_date
               ,sp.due_date
               ,sp.schedule_pay_total_amount
               ,od.loan_principal
               ,od.fund_code
               ,datediff(sp.due_date , cast(sp.settlement_time as date) , 'DD') as due_settle_diff
        from    ${cdmx}.etl_cdmx_fct_light_stage_plan_df sp
        left join ${cdmx}.cdmx_fct_light_loan_order_df od
        on      od.ds = '${bizdate}'
        and     sp.order_no = od.order_no
        where   sp.ds = '${bizdate}'
    ) a
    on t0.uid = a.uid
    left join (
        select cast(gap as int) as gap
        from (
            select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
        ) gg
    ) gp
    on 1 = 1
) t
where t.due_mth is not null
group by t.uid
,t.mdl_dte
;



-- 近XX个月_每个月还款进度_均值/最大值
-- 近XX个月_还款进度升高_的月份数_占比
drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp01;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp01
as
select uid
    ,mdl_dte
    ,avg(case when diff_mth = 0 then repay_progess end) as recent_1m_repay_progress_avg -- 近1个月_每个月还款进度_均值
    ,avg(case when diff_mth between 0 and 5 then repay_progess end) as recent_6m_repay_progress_avg -- 近6个月_每个月还款进度_均值
    ,avg(case when diff_mth between 0 and 11 then repay_progess end) as recent_12m_repay_progress_avg -- 近12个月_每个月还款进度_均值
    ,avg(case when diff_mth between 0 and 23 then repay_progess end) as recent_24m_repay_progress_avg -- 近24个月_每个月还款进度_均值
    ,avg(case when diff_mth between 0 and 35 then repay_progess end) as recent_36m_repay_progress_avg -- 近36个月_每个月还款进度_均值
    ,avg(case when diff_mth >= 0 then repay_progess end) as his_repay_progress_avg -- 历史全部_每个月还款进度_均值
    ,avg(case when diff_mth = 0 then repay_progess end) as recent_1m_repay_progress_max -- 近1个月_每个月还款进度_最大值
    ,max(case when diff_mth between 0 and 5 then repay_progess end) as recent_6m_repay_progress_max -- 近6个月_每个月还款进度_最大值
    ,max(case when diff_mth between 0 and 11 then repay_progess end) as recent_12m_repay_progress_max -- 近12个月_每个月还款进度_最大值
    ,max(case when diff_mth between 0 and 23 then repay_progess end) as recent_24m_repay_progress_max -- 近24个月_每个月还款进度_最大值
    ,max(case when diff_mth between 0 and 35 then repay_progess end) as recent_36m_repay_progress_max -- 近36个月_每个月还款进度_最大值
    ,max(case when diff_mth >= 0 then repay_progess end) as his_repay_progress_max -- 历史全部_每个月还款进度_最大值
    ,count(distinct case when diff_mth = 0 and repay_progess > repay_progess_y then mth end) as recent_1m_repay_progress_rise_month_cnt -- 近1个月_还款进度升高_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 and repay_progess > repay_progess_y then mth end) as recent_6m_repay_progress_rise_month_cnt -- 近6个月_还款进度升高_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 and repay_progess > repay_progess_y then mth end) as recent_12m_repay_progress_rise_month_cnt -- 近12个月_还款进度升高_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 and repay_progess > repay_progess_y then mth end) as recent_24m_repay_progress_rise_month_cnt -- 近24个月_还款进度升高_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 and repay_progess > repay_progess_y then mth end) as recent_36m_repay_progress_rise_month_cnt -- 近36个月_还款进度升高_的月份数_总和
    ,count(distinct case when diff_mth = 0 and repay_progess > repay_progess_y then mth end) / 1 as recent_1m_repay_progress_rise_month_rto -- 近1个月_还款进度升高_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 5 and repay_progess > repay_progess_y then mth end) / 6 as recent_6m_repay_progress_rise_month_rto -- 近6个月_还款进度升高_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 11 and repay_progess > repay_progess_y then mth end) / 12 as recent_12m_repay_progress_rise_month_rto -- 近12个月_还款进度升高_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 23 and repay_progess > repay_progess_y then mth end) / 24 as recent_24m_repay_progress_rise_month_rto -- 近24个月_还款进度升高_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 35 and repay_progess > repay_progess_y then mth end) / 36 as recent_36m_repay_progress_rise_month_rto -- 近36个月_还款进度升高_的月份数_占比
from (
    select uid
        ,mdl_dte
        ,diff_mth
        ,mth
        ,repay_progess
        ,lead(repay_progess) over(partition by uid, mdl_dte order by diff_mth) as repay_progess_y
    from(
        select uid
            ,mdl_dte
        	,diff_mth
            ,mth
            ,case when fm = 0 then null else fz / fm end as repay_progess
        from (
            select /*+ mapjoin(gp) */
            t0.uid
            ,t0.mdl_dte
        	,gp.gap as diff_mth
        	,count(case when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM') then a.stage_plan_no end) as fz
            ,count(case when cast(a.fund_loan_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM') then a.stage_plan_no end) as fm
            ,dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) -1 , 'MM') as mth
        from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
        ) t0
        left join (
        select  sp.uid
               ,sp.order_no
               ,sp.stage_plan_no
               ,sp.settlement_time
               ,cast(sp.settlement_time as date) as settlement_date
               ,od.fund_loan_date
               ,sp.due_date
               ,current_timestamp()
               ,sp.schedule_pay_total_amount
               ,od.loan_principal
               ,od.fund_code
        from    ${cdmx}.etl_cdmx_fct_light_stage_plan_df sp
        left join ${cdmx}.cdmx_fct_light_loan_order_df od
        on      od.ds = '${bizdate}'
        and     sp.order_no = od.order_no
        where   sp.ds = '${bizdate}'
    ) a
        on t0.uid = a.uid
        left join (
            select cast(gap as int) as gap
            from (
                select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
            ) gg
        ) gp
        on 1 = 1
        group by t0.uid
            ,t0.mdl_dte
        	,gp.gap
        ) t2
    ) t1
) t
where t.mth is not null
group by uid
,mdl_dte
;


-- 近XX个月_月供上升_的月份数_占比/总和 （这个跟与发生借款基本一致，砍）

-- 近XX个月_月平均借款期限提升_的月份数_占比/总和
-- 平均借款期限指的是借款的时候的接的订单的期数，比如用户A当月借了2笔，其中一笔6期，一笔12期间。平均就是9期
drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp03;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp03
as
select /*+ mapjoin(d) */
    uid
    ,mdl_dte
    ,count(distinct case when diff_mth = 0 and stgs_avg > stgs_avg_y then mth end) as recent_1m_stg_rise_month_cnt -- 近1个月_月平均借款期限提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 and stgs_avg > stgs_avg_y then mth end) as recent_6m_stg_rise_month_cnt -- 近6个月_月平均借款期限提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 and stgs_avg > stgs_avg_y then mth end) as recent_12m_stg_rise_month_cnt -- 近12个月_月平均借款期限提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 and stgs_avg > stgs_avg_y then mth end) as recent_24m_stg_rise_month_cnt -- 近24个月_月平均借款期限提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 and stgs_avg > stgs_avg_y then mth end) as recent_36m_stg_rise_month_cnt -- 近36个月_月平均借款期限提升_的月份数_总和
    ,count(distinct case when diff_mth = 0 and stgs_avg > stgs_avg_y then mth end) / 1 as recent_1m_stg_rise_month_rto -- 近1个月_月平均借款期限提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 5 and stgs_avg > stgs_avg_y then mth end) / 6 as recent_6m_stg_rise_month_rto -- 近6个月_月平均借款期限提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 11 and stgs_avg > stgs_avg_y then mth end) / 12 as recent_12m_stg_rise_month_rto -- 近12个月_月平均借款期限提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 23 and stgs_avg > stgs_avg_y then mth end) / 24 as recent_24m_stg_rise_month_rto -- 近24个月_月平均借款期限提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 35 and stgs_avg > stgs_avg_y then mth end) / 36 as recent_36m_stg_rise_month_rto -- 近36个月_月平均借款期限提升_的月份数_占比
from (
    select uid
        ,mdl_dte
        ,diff_mth
        ,mth
        ,stgs_avg
        ,lead(stgs_avg) over(partition by uid, mdl_dte order by diff_mth) as stgs_avg_y
    from (
        select /*+ mapjoin(gp) */
            t0.uid
            ,t0.mdl_dte as mdl_dte
        	,cast(gp.gap as int) as diff_mth
            ,dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) -1 , 'MM') as mth
        	-- 处于该月内的月平均订单分期数
        	,coalesce(
                avg(case when cast(a.fund_loan_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
        	        and cast(a.fund_loan_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
        	    then a.light_loan_stage end)
                , 0) as stgs_avg
        from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
        ) t0
        left join(
        	select  od.uid
                   ,od.order_no
                   ,od.fund_loan_date
        		   ,od.light_loan_stage
            from    ${cdmx}.cdmx_fct_light_loan_order_df od
            where   od.ds = '${bizdate}'
    		and     od.loan_success_flag = '1'
        ) a
        on t0.uid = a.uid
        left join (
            select cast(gap as int) as gap
            from (
                select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
            ) gg
        ) gp
        on 1 = 1
        group by t0.uid
            ,t0.mdl_dte
        	,gp.gap
    ) q0
) q
where q.mth is not null
group by uid
    ,mdl_dte
;

-- 近XX个月_月平均借款金额提升_的月份数_占比/总和
drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp04;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp04
as
select /*+ mapjoin(d) */
    uid
    ,mdl_dte
    ,count(distinct case when diff_mth = 0 and loan_pri_avg > loan_pri_avg_y then mth end) as recent_1m_lend_amt_rise_month_cnt -- 近1个月_月平均借款金额提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 and loan_pri_avg > loan_pri_avg_y then mth end) as recent_6m_lend_amt_rise_month_cnt -- 近6个月_月平均借款金额提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 and loan_pri_avg > loan_pri_avg_y then mth end) as recent_12m_lend_amt_rise_month_cnt -- 近12个月_月平均借款金额提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 and loan_pri_avg > loan_pri_avg_y then mth end) as recent_24m_lend_amt_rise_month_cnt -- 近24个月_月平均借款金额提升_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 and loan_pri_avg > loan_pri_avg_y then mth end) as recent_36m_lend_amt_rise_month_cnt -- 近36个月_月平均借款金额提升_的月份数_总和
    ,count(distinct case when diff_mth = 0 and loan_pri_avg > loan_pri_avg_y then mth end) / 1 as recent_1m_lend_amt_rise_month_rto -- 近1个月_月平均借款金额提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 5 and loan_pri_avg > loan_pri_avg_y then mth end) / 6 as recent_6m_lend_amt_rise_month_rto -- 近6个月_月平均借款金额提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 11 and loan_pri_avg > loan_pri_avg_y then mth end) / 12 as recent_12m_lend_amt_rise_month_rto -- 近12个月_月平均借款金额提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 23 and loan_pri_avg > loan_pri_avg_y then mth end) / 24 as recent_24m_lend_amt_rise_month_rto -- 近24个月_月平均借款金额提升_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 35 and loan_pri_avg > loan_pri_avg_y then mth end) / 36 as recent_36m_lend_amt_rise_month_rto -- 近36个月_月平均借款金额提升_的月份数_占比
from (
    select uid
        ,mdl_dte
        ,diff_mth
        ,mth
        ,loan_pri_avg
        ,lead(loan_pri_avg) over(partition by uid, mdl_dte order by diff_mth) as loan_pri_avg_y
    from (
        select /*+ mapjoin(gp) */
            t0.uid
            ,t0.mdl_dte as mdl_dte
        	,cast(gp.gap as int) as diff_mth
            ,dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM') as mth
        	-- 处于该月内的月平均订单分期数
        	,coalesce(
                avg(case when cast(a.fund_loan_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
        	        and cast(a.fund_loan_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
        	    then a.loan_principal end)
                , 0) as loan_pri_avg
        from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}'
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
        ) t0
        left join(
        	select  od.uid
                   ,od.order_no
                   ,od.fund_loan_date
        		   ,od.loan_principal
            from    ${cdmx}.cdmx_fct_light_loan_order_df od
            where   od.ds = '${bizdate}'
    		and     od.loan_success_flag = '1'
        ) a
        on t0.uid = a.uid
        left join (
            select cast(gap as int) as gap
            from (
                select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
            ) gg
        ) gp
        on 1 = 1
        group by t0.uid
            ,t0.mdl_dte
        	,gp.gap
    ) q0
) q
where q.mth is not null
group by uid
    ,mdl_dte
;



-- 近XX个月_授信成功_的月份数_占比/总和
-- 近XX个月_授信成功_的月份编号_均值（砍了）
drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp05;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp05
as
select 
    uid
    ,mdl_dte
    ,count(distinct case when diff_mth = 0 then mth end) as recent_1m_credit_month_cnt -- 近1个月_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 then mth end) as recent_6m_credit_month_cnt -- 近6个月_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 then mth end) as recent_12m_credit_month_cnt -- 近12个月_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 then mth end) as recent_24m_credit_month_cnt -- 近24个月_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 then mth end) as recent_36m_credit_month_cnt -- 近36个月_授信成功_的月份数_总和
    ,count(distinct case when diff_mth >= 0 then mth end) as his_credit_month_cnt -- 历史至今_授信成功_的月份数_总和
    ,count(distinct case when diff_mth = 0 and fund_class = 'level1' then mth end) as recent_1m_credit_fundcls_lv1_month_cnt -- 近1个月_lv1资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 and fund_class = 'level1' then mth end) as recent_6m_credit_fundcls_lv1_month_cnt -- 近6个月_lv1资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 and fund_class = 'level1' then mth end) as recent_12m_credit_fundcls_lv1_month_cnt -- 近12个月_lv1资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 and fund_class = 'level1' then mth end) as recent_24m_credit_fundcls_lv1_month_cnt -- 近24个月_lv1资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 and fund_class = 'level1' then mth end) as recent_36m_credit_fundcls_lv1_month_cnt -- 近36个月_lv1资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth >= 0 and fund_class = 'level1' then mth end) as his_credit_fundcls_lv1_month_cnt -- 历史至今_lv1资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth = 0 and fund_class = 'level2' then mth end) as recent_1m_credit_fundcls_lv2_month_cnt -- 近1个月_lv2资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 and fund_class = 'level2' then mth end) as recent_6m_credit_fundcls_lv2_month_cnt -- 近6个月_lv2资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 and fund_class = 'level2' then mth end) as recent_12m_credit_fundcls_lv2_month_cnt -- 近12个月_lv2资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 and fund_class = 'level2' then mth end) as recent_24m_credit_fundcls_lv2_month_cnt -- 近24个月_lv2资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 and fund_class = 'level2' then mth end) as recent_36m_credit_fundcls_lv2_month_cnt -- 近36个月_lv2资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth >= 0 and fund_class = 'level2' then mth end) as his_credit_fundcls_lv2_month_cnt -- 历史至今_lv2资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth = 0 and fund_class = 'other' then mth end) as recent_1m_credit_fundcls_other_month_cnt -- 近1个月_other资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 and fund_class = 'other' then mth end) as recent_6m_credit_fundcls_other_month_cnt -- 近6个月_other资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 and fund_class = 'other' then mth end) as recent_12m_credit_fundcls_other_month_cnt -- 近12个月_other资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 and fund_class = 'other' then mth end) as recent_24m_credit_fundcls_other_month_cnt -- 近24个月_other资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 and fund_class = 'other' then mth end) as recent_36m_credit_fundcls_other_month_cnt -- 近36个月_other资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth >= 0 and fund_class = 'other' then mth end) as his_credit_fundcls_other_month_cnt -- 历史至今_other资方等级_授信成功_的月份数_总和
    ,count(distinct case when diff_mth = 0 then mth end) / 1 as recent_1m_credit_month_rto -- 近1个月_授信成功_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 5 then mth end) / 6 as recent_6m_credit_month_rto -- 近6个月_授信成功_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 11 then mth end) / 12 as recent_12m_credit_month_rto -- 近12个月_授信成功_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 23 then mth end) / 24 as recent_24m_credit_month_rto -- 近24个月_授信成功_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 35 then mth end) / 36 as recent_36m_credit_month_rto -- 近36个月_授信成功_的月份数_占比
from (
    select /*+ mapjoin(gp) */
        t0.uid
        ,case when date(a.create_time) < date(dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM'))
            and date(a.create_time) >= date(dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) -1 , 'MM'))
            then dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
            end as mth
        ,cast(gp.gap as int) as diff_mth
        ,t0.mdl_dte
        ,a.light_credit_status
        ,case when a.fund_code in ('PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI') then 'level1'
					  when a.fund_code in ('YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF') then 'level2'
					  else 'other' end as fund_class
    from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
    ) t0
    left join dwa_risk.dwa_risk_f_light_credit_data_base_df a
    on t0.uid = a.uid
    and a.ds = '${bizdate}'
    and a.light_credit_status = '成功'
    left join (
        select cast(gap as int) as gap
        from (
            select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
        ) gg
    ) gp
    on 1 = 1
) q
where q.mth is not null
group by uid
,mdl_dte
;

-- 近XX个月_发起交易金额>=10000元_的月份数_占比/总和
-- 近XX个月_发起交易_的月份数_占比/总和
-- 近XX个月_发起交易_的月份编号_均值
drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp06;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp06
as
select uid
    ,mdl_dte
    ,count(distinct case when loan_principal >= 10000 and diff_mth = 0 then mth end) as recent_1m_lend_amt_over10k_month_cnt -- 近1个月_发起交易金额>=10000元_的月份数_总和
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 5 then mth end) as recent_6m_lend_amt_over10k_month_cnt -- 近6个月_发起交易金额>=10000元_的月份数_总和
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 11 then mth end) as recent_12m_lend_amt_over10k_month_cnt -- 近12个月_发起交易金额>=10000元_的月份数_总和
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 23 then mth end) as recent_24m_lend_amt_over10k_month_cnt -- 近24个月_发起交易金额>=10000元_的月份数_总和
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 35 then mth end) as recent_36m_lend_amt_over10k_month_cnt -- 近36个月_发起交易金额>=10000元_的月份数_总和
    ,count(distinct case when loan_principal >= 10000 then mth end) as his_lend_amt_over10k_month_cnt -- 历史至今_发起交易金额>=10000元_的月份数_总和
    ,count(distinct case when loan_principal >= 10000 and diff_mth = 0 then mth end) / 1 as recent_1m_lend_amt_over10k_month_rto -- 近1个月_发起交易金额>=10000元_的月份数_占比
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 5 then mth end) / 6 as recent_6m_lend_amt_over10k_month_rto -- 近6个月_发起交易金额>=10000元_的月份数_占比
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 11 then mth end) / 12 as recent_12m_lend_amt_over10k_month_rto -- 近12个月_发起交易金额>=10000元_的月份数_占比
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 23 then mth end) / 24 as recent_24m_lend_amt_over10k_month_rto -- 近24个月_发起交易金额>=10000元_的月份数_占比
    ,count(distinct case when loan_principal >= 10000 and diff_mth between 0 and 35 then mth end) / 36 as recent_36m_lend_amt_over10k_month_rto -- 近36个月_发起交易金额>=10000元_的月份数_占比
    ,count(distinct case when diff_mth = 0 then mth end) as recent_1m_lend_month_cnt -- 近1个月_发起交易_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 5 then mth end) as recent_6m_lend_month_cnt -- 近6个月_发起交易_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 11 then mth end) as recent_12m_lend_month_cnt -- 近12个月_发起交易_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 23 then mth end) as recent_24m_lend_month_cnt -- 近24个月_发起交易_的月份数_总和
    ,count(distinct case when diff_mth between 0 and 35 then mth end) as recent_36m_lend_month_cnt -- 近36个月_发起交易_的月份数_总和
    ,count(distinct case when diff_mth >= 0 then mth end) as his_lend_month_cnt -- 历史至今_发起交易_的月份数_总和
    ,count(distinct case when diff_mth = 0 then mth end) / 1 as recent_1m_lend_month_rto -- 近1个月_发起交易_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 5 then mth end) / 6 as recent_6m_lend_month_rto -- 近6个月_发起交易_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 11 then mth end) / 12 as recent_12m_lend_month_rto -- 近12个月_发起交易_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 23 then mth end) / 24 as recent_24m_lend_month_rto -- 近24个月_发起交易_的月份数_占比
    ,count(distinct case when diff_mth between 0 and 35 then mth end) / 36 as recent_36m_lend_month_rto -- 近36个月_发起交易_的月份数_占比
    ,avg(case when diff_mth = 0 then month(mth) end) as recent_1m_lend_month_no_avg -- 近1个月_发起交易_的月份编号_均值
    ,avg(case when diff_mth between 0 and 5 then month(mth) end) as recent_6m_lend_month_no_avg -- 近6个月_发起交易_的月份编号_均值
    ,avg(case when diff_mth between 0 and 11 then month(mth) end) as recent_12m_lend_month_no_avg -- 近12个月_发起交易_的月份编号_均值
    ,avg(case when diff_mth between 0 and 23 then month(mth) end) as recent_24m_lend_month_no_avg -- 近24个月_发起交易_的月份编号_均值
    ,avg(case when diff_mth between 0 and 35 then month(mth) end) as recent_36m_lend_month_no_avg -- 近36个月_发起交易_的月份编号_均值
from (
        select /*+ mapjoin(gp) */
            t0.uid -- 用户
            ,cast(gp.gap as int) as diff_mth
            ,a.loan_principal
            ,case when cast(a.fund_loan_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) , 'MM')
                and cast(a.fund_loan_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) -1 , 'MM')
                then dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), cast(-1*gp.gap as int) - 1 , 'MM')
                end as mth
            ,t0.mdl_dte
        from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
        ) t0
        left join (
            select  sp.uid
                   ,sp.order_no
                   ,sp.stage_plan_no
                   ,sp.settlement_time
                   ,cast(sp.settlement_time as date) as settlement_date
                   ,od.fund_loan_date
                   ,sp.due_date
                   ,sp.schedule_pay_total_amount
                   ,od.loan_principal
                   ,od.fund_code
            from    ${cdmx}.etl_cdmx_fct_light_stage_plan_df sp
            left join ${cdmx}.cdmx_fct_light_loan_order_df od
            on      od.ds = '${bizdate}'
            and     sp.order_no = od.order_no
            where   sp.ds = '${bizdate}'
        ) a
        on t0.uid = a.uid
        left join (
            select cast(gap as int) as gap
            from (
                select explode(split('0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55', ',')) as gap
            ) gg
        ) gp
        on 1 = 1
) q
where q.mth is not null
group by q.uid
    ,q.mdl_dte
;

-- 近XX个月_的借还间隔天数_均值/最大值/最小值
drop table if exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp07;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp07
as
select uid
    ,mdl_dte
    ,avg(case when diff_mth = 0 then settle_loan_diff end) as recent_1m_settle_loan_diff_days_avg -- 近1个月_的借还间隔天数_均值
    ,avg(case when diff_mth between 0 and 5 then settle_loan_diff end) as recent_6m_settle_loan_diff_days_avg -- 近6个月_的借还间隔天数_均值
    ,avg(case when diff_mth between 0 and 11 then settle_loan_diff end) as recent_12m_settle_loan_diff_days_avg -- 近12个月_的借还间隔天数_均值
    ,avg(case when diff_mth between 0 and 23 then settle_loan_diff end) as recent_24m_settle_loan_diff_days_avg -- 近24个月_的借还间隔天数_均值
    ,avg(case when diff_mth between 0 and 35 then settle_loan_diff end) as recent_36m_settle_loan_diff_days_avg -- 近36个月_的借还间隔天数_均值
    ,avg(case when diff_mth >= 0 then settle_loan_diff end) as his_settle_loan_diff_days_avg -- 历史至今_的借还间隔天数_均值
    ,max(case when diff_mth = 0 then settle_loan_diff end) as recent_1m_settle_loan_diff_days_max -- 近1个月_的借还间隔天数_最大值
    ,max(case when diff_mth between 0 and 5 then settle_loan_diff end) as recent_6m_settle_loan_diff_days_max -- 近6个月_的借还间隔天数_最大值
    ,max(case when diff_mth between 0 and 11 then settle_loan_diff end) as recent_12m_settle_loan_diff_days_max -- 近12个月_的借还间隔天数_最大值
    ,max(case when diff_mth between 0 and 23 then settle_loan_diff end) as recent_24m_settle_loan_diff_days_max -- 近24个月_的借还间隔天数_最大值
    ,max(case when diff_mth between 0 and 35 then settle_loan_diff end) as recent_36m_settle_loan_diff_days_max -- 近36个月_的借还间隔天数_最大值
    ,max(case when diff_mth >= 0 then settle_loan_diff end) as his_settle_loan_diff_days_max -- 历史至今_的借还间隔天数_最大值
    ,min(case when diff_mth = 0 then settle_loan_diff end) as recent_1m_settle_loan_diff_days_min -- 近1个月_的借还间隔天数_最小值
    ,min(case when diff_mth between 0 and 5 then settle_loan_diff end) as recent_6m_settle_loan_diff_days_min -- 近6个月_的借还间隔天数_最小值
    ,min(case when diff_mth between 0 and 11 then settle_loan_diff end) as recent_12m_settle_loan_diff_days_min -- 近12个月_的借还间隔天数_最小值
    ,min(case when diff_mth between 0 and 23 then settle_loan_diff end) as recent_24m_settle_loan_diff_days_min -- 近24个月_的借还间隔天数_最小值
    ,min(case when diff_mth between 0 and 35 then settle_loan_diff end) as recent_36m_settle_loan_diff_days_min -- 近36个月_的借还间隔天数_最小值
    ,min(case when diff_mth >= 0 then settle_loan_diff end) as his_settle_loan_diff_days_min -- 历史至今_的借还间隔天数_最小值
from (
    select t0.uid -- 用户
            ,case when cast(a.settlement_date as datetime) < to_date(t0.mdl_dte, 'yyyy-mm-dd') and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -1, 'MM') then 0
            when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -1, 'MM') and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -6, 'MM') then 1
            when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -6, 'MM') and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -12, 'MM') then 6
            when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -12, 'MM') and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -24, 'MM') then 12
            when cast(a.settlement_date as datetime) < dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -24, 'MM') and cast(a.settlement_date as datetime) >= dateadd(to_date(t0.mdl_dte, 'yyyy-mm-dd'), -36, 'MM') then 24
            else 99 end as diff_mth
        ,datediff(a.settlement_date, a.fund_loan_date, 'DD') as settle_loan_diff
        ,t0.mdl_dte
    from (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
    ) t0
    left join (
        select  sp.uid
               ,sp.order_no
               ,sp.stage_plan_no
               ,sp.settlement_time
               ,cast(sp.settlement_time as date) as settlement_date
               ,od.fund_loan_date
               ,sp.due_date
               ,sp.schedule_pay_total_amount
               ,od.loan_principal
               ,od.fund_code
        from   ${cdmx}.etl_cdmx_fct_light_stage_plan_df sp
        left join ${cdmx}.cdmx_fct_light_loan_order_df od
        on      od.ds = '${bizdate}'
        and     sp.order_no = od.order_no
        where   sp.ds = '${bizdate}'
    ) a
    on t0.uid = a.uid
    and cast(a.settlement_date as datetime) < to_date(t0.mdl_dte, 'yyyy-mm-dd')
) q
group by q.uid
,mdl_dte
;

-- alter table ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df rename to dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_cjf_bak

-- drop table ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df (
 uid string comment '用户id'
 ,mdl_dte string comment '模型日期'
 ,recent_1m_overdue_3d_month_cnt                    bigint              comment '近1个月_有逾期还款3天以上_的月份数_总和'
 ,recent_6m_overdue_3d_month_cnt                    bigint              comment '近6个月_有逾期还款3天以上_的月份数_总和'
 ,recent_12m_overdue_3d_month_cnt                   bigint              comment '近12个月_有逾期还款3天以上_的月份数_总和'
 ,recent_24m_overdue_3d_month_cnt                   bigint              comment '近24个月_有逾期还款3天以上_的月份数_总和'
 ,recent_36m_overdue_3d_month_cnt                   bigint              comment '近36个月_有逾期还款3天以上_的月份数_总和'
 ,recent_1m_overdue_3d_month_rto                    decimal(26,10)      comment '近1个月_有逾期还款3天以上_的月份数_占比'
 ,recent_6m_overdue_3d_month_rto                    decimal(26,10)      comment '近6个月_有逾期还款3天以上_的月份数_占比'
 ,recent_12m_overdue_3d_month_rto                   decimal(26,10)      comment '近12个月_有逾期还款3天以上_的月份数_占比'
 ,recent_24m_overdue_3d_month_rto                   decimal(26,10)      comment '近24个月_有逾期还款3天以上_的月份数_占比'
 ,recent_36m_overdue_3d_month_rto                   decimal(26,10)      comment '近36个月_有逾期还款3天以上_的月份数_占比'
 ,recent_1m_overdue_3d_month_no_avg                 decimal(26,10)      comment '近1个月_有逾期还款3天以上_的月份编号_均值'
 ,recent_6m_overdue_3d_month_no_avg                 decimal(26,10)      comment '近6个月_有逾期还款3天以上_的月份编号_均值'
 ,recent_12m_overdue_3d_month_no_avg                decimal(26,10)      comment '近12个月_有逾期还款3天以上_的月份编号_均值'
 ,recent_24m_overdue_3d_month_no_avg                decimal(26,10)      comment '近24个月_有逾期还款3天以上_的月份编号_均值'
 ,recent_36m_overdue_3d_month_no_avg                decimal(26,10)      comment '近36个月_有逾期还款3天以上_的月份编号_均值'
 ,recent_1m_prepay_3d_month_cnt                     bigint              comment '近1个月_有提前还款3天以上_的月份数_总和'
 ,recent_6m_prepay_3d_month_cnt                     bigint              comment '近6个月_有提前还款3天以上_的月份数_总和'
 ,recent_12m_prepay_3d_month_cnt                    bigint              comment '近12个月_有提前还款3天以上_的月份数_总和'
 ,recent_24m_prepay_3d_month_cnt                    bigint              comment '近24个月_有提前还款3天以上_的月份数_总和'
 ,recent_36m_prepay_3d_month_cnt                    bigint              comment '近36个月_有提前还款3天以上_的月份数_总和'
 ,recent_1m_prepay_3d_month_rto                     decimal(26,10)      comment '近1个月_有提前还款3天以上_的月份数_占比'
 ,recent_6m_prepay_3d_month_rto                     decimal(26,10)      comment '近6个月_有提前还款3天以上_的月份数_占比'
 ,recent_12m_prepay_3d_month_rto                    decimal(26,10)      comment '近12个月_有提前还款3天以上_的月份数_占比'
 ,recent_24m_prepay_3d_month_rto                    decimal(26,10)      comment '近24个月_有提前还款3天以上_的月份数_占比'
 ,recent_36m_prepay_3d_month_rto                    decimal(26,10)      comment '近36个月_有提前还款3天以上_的月份数_占比'
 ,recent_1m_prepay_3d_month_no_avg                  decimal(26,10)      comment '近1个月_有提前还款3天以上_的月份编号_均值'
 ,recent_6m_prepay_3d_month_no_avg                  decimal(26,10)      comment '近6个月_有提前还款3天以上_的月份编号_均值'
 ,recent_12m_prepay_3d_month_no_avg                 decimal(26,10)      comment '近12个月_有提前还款3天以上_的月份编号_均值'
 ,recent_24m_prepay_3d_month_no_avg                 decimal(26,10)      comment '近24个月_有提前还款3天以上_的月份编号_均值'
 ,recent_36m_prepay_3d_month_no_avg                 decimal(26,10)      comment '近36个月_有提前还款3天以上_的月份编号_均值'
 ,recent_1m_settle_month_no_avg                     decimal(26,10)      comment '近1个月_发生过结清订单行为_的月份编号_均值'
 ,recent_6m_settle_month_no_avg                     decimal(26,10)      comment '近6个月_发生过结清订单行为_的月份编号_均值'
 ,recent_12m_settle_month_no_avg                    decimal(26,10)      comment '近12个月_发生过结清订单行为_的月份编号_均值'
 ,recent_24m_settle_month_no_avg                    decimal(26,10)      comment '近24个月_发生过结清订单行为_的月份编号_均值'
 ,recent_36m_settle_month_no_avg                    decimal(26,10)      comment '近36个月_发生过结清订单行为_的月份编号_均值'
 ,recent_1m_due_month_cnt                           bigint              comment '近1个月_有应还日_的月份数_总和'
 ,recent_6m_due_month_cnt                           bigint              comment '近6个月_有应还日_的月份数_总和'
 ,recent_12m_due_month_cnt                          bigint              comment '近12个月_有应还日_的月份数_总和'
 ,recent_24m_due_month_cnt                          bigint              comment '近24个月_有应还日_的月份数_总和'
 ,recent_36m_due_month_cnt                          bigint              comment '近36个月_有应还日_的月份数_总和'
 ,recent_1m_due_month_rto                           decimal(26,10)      comment '近1个月_有应还日_的月份数_占比'
 ,recent_6m_due_month_rto                           decimal(26,10)      comment '近6个月_有应还日_的月份数_占比'
 ,recent_12m_due_month_rto                          decimal(26,10)      comment '近12个月_有应还日_的月份数_占比'
 ,recent_24m_due_month_rto                          decimal(26,10)      comment '近24个月_有应还日_的月份数_占比'
 ,recent_36m_due_month_rto                          decimal(26,10)      comment '近36个月_有应还日_的月份数_占比'
 ,recent_1m_repay_progress_avg                      decimal(26,10)      comment '近1个月_每个月还款进度_均值'
 ,recent_6m_repay_progress_avg                      decimal(26,10)      comment '近6个月_每个月还款进度_均值'
 ,recent_12m_repay_progress_avg                     decimal(26,10)      comment '近12个月_每个月还款进度_均值'
 ,recent_24m_repay_progress_avg                     decimal(26,10)      comment '近24个月_每个月还款进度_均值'
 ,recent_36m_repay_progress_avg                     decimal(26,10)      comment '近36个月_每个月还款进度_均值'
 ,his_repay_progress_avg                            decimal(26,10)      comment '历史全部_每个月还款进度_均值'
 ,recent_1m_repay_progress_max                      decimal(26,10)      comment '近1个月_每个月还款进度_最大值'
 ,recent_6m_repay_progress_max                      decimal(26,10)      comment '近6个月_每个月还款进度_最大值'
 ,recent_12m_repay_progress_max                     decimal(26,10)      comment '近12个月_每个月还款进度_最大值'
 ,recent_24m_repay_progress_max                     decimal(26,10)      comment '近24个月_每个月还款进度_最大值'
 ,recent_36m_repay_progress_max                     decimal(26,10)      comment '近36个月_每个月还款进度_最大值'
 ,his_repay_progress_max                            decimal(26,10)      comment '历史全部_每个月还款进度_最大值'
 ,recent_1m_repay_progress_rise_month_cnt           bigint              comment '近1个月_还款进度升高_的月份数_总和'
 ,recent_6m_repay_progress_rise_month_cnt           bigint              comment '近6个月_还款进度升高_的月份数_总和'
 ,recent_12m_repay_progress_rise_month_cnt          bigint              comment '近12个月_还款进度升高_的月份数_总和'
 ,recent_24m_repay_progress_rise_month_cnt          bigint              comment '近24个月_还款进度升高_的月份数_总和'
 ,recent_36m_repay_progress_rise_month_cnt          bigint              comment '近36个月_还款进度升高_的月份数_总和'
 ,recent_1m_repay_progress_rise_month_rto           decimal(26,10)      comment '近1个月_还款进度升高_的月份数_占比'
 ,recent_6m_repay_progress_rise_month_rto           decimal(26,10)      comment '近6个月_还款进度升高_的月份数_占比'
 ,recent_12m_repay_progress_rise_month_rto          decimal(26,10)      comment '近12个月_还款进度升高_的月份数_占比'
 ,recent_24m_repay_progress_rise_month_rto          decimal(26,10)      comment '近24个月_还款进度升高_的月份数_占比'
 ,recent_36m_repay_progress_rise_month_rto          decimal(26,10)      comment '近36个月_还款进度升高_的月份数_占比'
 ,recent_1m_stg_rise_month_cnt                      bigint              comment '近1个月_月平均借款期限提升_的月份数_总和'
 ,recent_6m_stg_rise_month_cnt                      bigint              comment '近6个月_月平均借款期限提升_的月份数_总和'
 ,recent_12m_stg_rise_month_cnt                     bigint              comment '近12个月_月平均借款期限提升_的月份数_总和'
 ,recent_24m_stg_rise_month_cnt                     bigint              comment '近24个月_月平均借款期限提升_的月份数_总和'
 ,recent_36m_stg_rise_month_cnt                     bigint              comment '近36个月_月平均借款期限提升_的月份数_总和'
 ,recent_1m_stg_rise_month_rto                      decimal(26,10)      comment '近1个月_月平均借款期限提升_的月份数_占比'
 ,recent_6m_stg_rise_month_rto                      decimal(26,10)      comment '近6个月_月平均借款期限提升_的月份数_占比'
 ,recent_12m_stg_rise_month_rto                     decimal(26,10)      comment '近12个月_月平均借款期限提升_的月份数_占比'
 ,recent_24m_stg_rise_month_rto                     decimal(26,10)      comment '近24个月_月平均借款期限提升_的月份数_占比'
 ,recent_36m_stg_rise_month_rto                     decimal(26,10)      comment '近36个月_月平均借款期限提升_的月份数_占比'
 ,recent_1m_lend_amt_rise_month_cnt                 bigint              comment '近1个月_月平均借款金额提升_的月份数_总和'
 ,recent_6m_lend_amt_rise_month_cnt                 bigint              comment '近6个月_月平均借款金额提升_的月份数_总和'
 ,recent_12m_lend_amt_rise_month_cnt                bigint              comment '近12个月_月平均借款金额提升_的月份数_总和'
 ,recent_24m_lend_amt_rise_month_cnt                bigint              comment '近24个月_月平均借款金额提升_的月份数_总和'
 ,recent_36m_lend_amt_rise_month_cnt                bigint              comment '近36个月_月平均借款金额提升_的月份数_总和'
 ,recent_1m_lend_amt_rise_month_rto                 decimal(26,10)      comment '近1个月_月平均借款金额提升_的月份数_占比'
 ,recent_6m_lend_amt_rise_month_rto                 decimal(26,10)      comment '近6个月_月平均借款金额提升_的月份数_占比'
 ,recent_12m_lend_amt_rise_month_rto                decimal(26,10)      comment '近12个月_月平均借款金额提升_的月份数_占比'
 ,recent_24m_lend_amt_rise_month_rto                decimal(26,10)      comment '近24个月_月平均借款金额提升_的月份数_占比'
 ,recent_36m_lend_amt_rise_month_rto                decimal(26,10)      comment '近36个月_月平均借款金额提升_的月份数_占比'
 ,recent_1m_credit_month_cnt                        bigint              comment '近1个月_授信成功_的月份数_总和'
 ,recent_6m_credit_month_cnt                        bigint              comment '近6个月_授信成功_的月份数_总和'
 ,recent_12m_credit_month_cnt                       bigint              comment '近12个月_授信成功_的月份数_总和'
 ,recent_24m_credit_month_cnt                       bigint              comment '近24个月_授信成功_的月份数_总和'
 ,recent_36m_credit_month_cnt                       bigint              comment '近36个月_授信成功_的月份数_总和'
 ,his_credit_month_cnt                              bigint              comment '历史至今_授信成功_的月份数_总和'
 ,recent_1m_credit_fundcls_lv1_month_cnt            bigint              comment '近1个月_lv1资方等级_授信成功_的月份数_总和'
 ,recent_6m_credit_fundcls_lv1_month_cnt            bigint              comment '近6个月_lv1资方等级_授信成功_的月份数_总和'
 ,recent_12m_credit_fundcls_lv1_month_cnt           bigint              comment '近12个月_lv1资方等级_授信成功_的月份数_总和'
 ,recent_24m_credit_fundcls_lv1_month_cnt           bigint              comment '近24个月_lv1资方等级_授信成功_的月份数_总和'
 ,recent_36m_credit_fundcls_lv1_month_cnt           bigint              comment '近36个月_lv1资方等级_授信成功_的月份数_总和'
 ,his_credit_fundcls_lv1_month_cnt                  bigint              comment '历史至今_lv1资方等级_授信成功_的月份数_总和'
 ,recent_1m_credit_fundcls_lv2_month_cnt            bigint              comment '近1个月_lv2资方等级_授信成功_的月份数_总和'
 ,recent_6m_credit_fundcls_lv2_month_cnt            bigint              comment '近6个月_lv2资方等级_授信成功_的月份数_总和'
 ,recent_12m_credit_fundcls_lv2_month_cnt           bigint              comment '近12个月_lv2资方等级_授信成功_的月份数_总和'
 ,recent_24m_credit_fundcls_lv2_month_cnt           bigint              comment '近24个月_lv2资方等级_授信成功_的月份数_总和'
 ,recent_36m_credit_fundcls_lv2_month_cnt           bigint              comment '近36个月_lv2资方等级_授信成功_的月份数_总和'
 ,his_credit_fundcls_lv2_month_cnt                  bigint              comment '历史至今_lv2资方等级_授信成功_的月份数_总和'
 ,recent_1m_credit_fundcls_other_month_cnt          bigint              comment '近1个月_other资方等级_授信成功_的月份数_总和'
 ,recent_6m_credit_fundcls_other_month_cnt          bigint              comment '近6个月_other资方等级_授信成功_的月份数_总和'
 ,recent_12m_credit_fundcls_other_month_cnt         bigint              comment '近12个月_other资方等级_授信成功_的月份数_总和'
 ,recent_24m_credit_fundcls_other_month_cnt         bigint              comment '近24个月_other资方等级_授信成功_的月份数_总和'
 ,recent_36m_credit_fundcls_other_month_cnt         bigint              comment '近36个月_other资方等级_授信成功_的月份数_总和'
 ,his_credit_fundcls_other_month_cnt                bigint              comment '历史至今_other资方等级_授信成功_的月份数_总和'
 ,recent_1m_credit_month_rto                        decimal(26,10)      comment '近1个月_授信成功_的月份数_占比'
 ,recent_6m_credit_month_rto                        decimal(26,10)      comment '近6个月_授信成功_的月份数_占比'
 ,recent_12m_credit_month_rto                       decimal(26,10)      comment '近12个月_授信成功_的月份数_占比'
 ,recent_24m_credit_month_rto                       decimal(26,10)      comment '近24个月_授信成功_的月份数_占比'
 ,recent_36m_credit_month_rto                       decimal(26,10)      comment '近36个月_授信成功_的月份数_占比'
 ,recent_1m_lend_amt_over10k_month_cnt              bigint              comment '近1个月_发起交易金额>=10000元_的月份数_总和'
 ,recent_6m_lend_amt_over10k_month_cnt              bigint              comment '近6个月_发起交易金额>=10000元_的月份数_总和'
 ,recent_12m_lend_amt_over10k_month_cnt             bigint              comment '近12个月_发起交易金额>=10000元_的月份数_总和'
 ,recent_24m_lend_amt_over10k_month_cnt             bigint              comment '近24个月_发起交易金额>=10000元_的月份数_总和'
 ,recent_36m_lend_amt_over10k_month_cnt             bigint              comment '近36个月_发起交易金额>=10000元_的月份数_总和'
 ,his_lend_amt_over10k_month_cnt                    bigint              comment '历史至今_发起交易金额>=10000元_的月份数_总和'
 ,recent_1m_lend_amt_over10k_month_rto              decimal(26,10)      comment '近1个月_发起交易金额>=10000元_的月份数_占比'
 ,recent_6m_lend_amt_over10k_month_rto              decimal(26,10)      comment '近6个月_发起交易金额>=10000元_的月份数_占比'
 ,recent_12m_lend_amt_over10k_month_rto             decimal(26,10)      comment '近12个月_发起交易金额>=10000元_的月份数_占比'
 ,recent_24m_lend_amt_over10k_month_rto             decimal(26,10)      comment '近24个月_发起交易金额>=10000元_的月份数_占比'
 ,recent_36m_lend_amt_over10k_month_rto             decimal(26,10)      comment '近36个月_发起交易金额>=10000元_的月份数_占比'
 ,recent_1m_lend_month_cnt                          bigint              comment '近1个月_发起交易_的月份数_总和'
 ,recent_6m_lend_month_cnt                          bigint              comment '近6个月_发起交易_的月份数_总和'
 ,recent_12m_lend_month_cnt                         bigint              comment '近12个月_发起交易_的月份数_总和'
 ,recent_24m_lend_month_cnt                         bigint              comment '近24个月_发起交易_的月份数_总和'
 ,recent_36m_lend_month_cnt                         bigint              comment '近36个月_发起交易_的月份数_总和'
 ,his_lend_month_cnt                                bigint              comment '历史至今_发起交易_的月份数_总和'
 ,recent_1m_lend_month_rto                          decimal(26,10)      comment '近1个月_发起交易_的月份数_占比'
 ,recent_6m_lend_month_rto                          decimal(26,10)      comment '近6个月_发起交易_的月份数_占比'
 ,recent_12m_lend_month_rto                         decimal(26,10)      comment '近12个月_发起交易_的月份数_占比'
 ,recent_24m_lend_month_rto                         decimal(26,10)      comment '近24个月_发起交易_的月份数_占比'
 ,recent_36m_lend_month_rto                         decimal(26,10)      comment '近36个月_发起交易_的月份数_占比'
 ,recent_1m_lend_month_no_avg                       decimal(26,10)      comment '近1个月_发起交易_的月份编号_均值'
 ,recent_6m_lend_month_no_avg                       decimal(26,10)      comment '近6个月_发起交易_的月份编号_均值'
 ,recent_12m_lend_month_no_avg                      decimal(26,10)      comment '近12个月_发起交易_的月份编号_均值'
 ,recent_24m_lend_month_no_avg                      decimal(26,10)      comment '近24个月_发起交易_的月份编号_均值'
 ,recent_36m_lend_month_no_avg                      decimal(26,10)      comment '近36个月_发起交易_的月份编号_均值'
 ,recent_1m_settle_loan_diff_days_avg               double              comment '近1个月_的借还间隔天数_均值'
 ,recent_6m_settle_loan_diff_days_avg               double              comment '近6个月_的借还间隔天数_均值'
 ,recent_12m_settle_loan_diff_days_avg              double              comment '近12个月_的借还间隔天数_均值'
 ,recent_24m_settle_loan_diff_days_avg              double              comment '近24个月_的借还间隔天数_均值'
 ,recent_36m_settle_loan_diff_days_avg              double              comment '近36个月_的借还间隔天数_均值'
 ,his_settle_loan_diff_days_avg                     double              comment '历史至今_的借还间隔天数_均值'
 ,recent_1m_settle_loan_diff_days_max               bigint              comment '近1个月_的借还间隔天数_最大值'
 ,recent_6m_settle_loan_diff_days_max               bigint              comment '近6个月_的借还间隔天数_最大值'
 ,recent_12m_settle_loan_diff_days_max              bigint              comment '近12个月_的借还间隔天数_最大值'
 ,recent_24m_settle_loan_diff_days_max              bigint              comment '近24个月_的借还间隔天数_最大值'
 ,recent_36m_settle_loan_diff_days_max              bigint              comment '近36个月_的借还间隔天数_最大值'
 ,his_settle_loan_diff_days_max                     bigint              comment '历史至今_的借还间隔天数_最大值'
 ,recent_1m_settle_loan_diff_days_min               bigint              comment '近1个月_的借还间隔天数_最小值'
 ,recent_6m_settle_loan_diff_days_min               bigint              comment '近6个月_的借还间隔天数_最小值'
 ,recent_12m_settle_loan_diff_days_min              bigint              comment '近12个月_的借还间隔天数_最小值'
 ,recent_24m_settle_loan_diff_days_min              bigint              comment '近24个月_的借还间隔天数_最小值'
 ,recent_36m_settle_loan_diff_days_min              bigint              comment '近36个月_的借还间隔天数_最小值'
 ,his_settle_loan_diff_days_min                     bigint              comment '历史至今_的借还间隔天数_最小值'
) COMMENT '掘金3.0轻资产衍生特征2.3还款行为部分特征表'
partitioned by(ds string comment '业务日期分区，格式yyyymmdd')
;

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df partition (ds = '${bizdate}')
select  t0.uid
       ,to_char(t0.mdl_dte, 'yyyy-mm-dd') as mdl_dte
       ,recent_1m_overdue_3d_month_cnt
        ,recent_6m_overdue_3d_month_cnt
        ,recent_12m_overdue_3d_month_cnt
        ,recent_24m_overdue_3d_month_cnt
        ,recent_36m_overdue_3d_month_cnt
        ,recent_1m_overdue_3d_month_rto
        ,recent_6m_overdue_3d_month_rto
        ,recent_12m_overdue_3d_month_rto
        ,recent_24m_overdue_3d_month_rto
        ,recent_36m_overdue_3d_month_rto
        ,recent_1m_overdue_3d_month_no_avg
        ,recent_6m_overdue_3d_month_no_avg
        ,recent_12m_overdue_3d_month_no_avg
        ,recent_24m_overdue_3d_month_no_avg
        ,recent_36m_overdue_3d_month_no_avg
        ,recent_1m_prepay_3d_month_cnt
        ,recent_6m_prepay_3d_month_cnt
        ,recent_12m_prepay_3d_month_cnt
        ,recent_24m_prepay_3d_month_cnt
        ,recent_36m_prepay_3d_month_cnt
        ,recent_1m_prepay_3d_month_rto
        ,recent_6m_prepay_3d_month_rto
        ,recent_12m_prepay_3d_month_rto
        ,recent_24m_prepay_3d_month_rto
        ,recent_36m_prepay_3d_month_rto
        ,recent_1m_prepay_3d_month_no_avg
        ,recent_6m_prepay_3d_month_no_avg
        ,recent_12m_prepay_3d_month_no_avg
        ,recent_24m_prepay_3d_month_no_avg
        ,recent_36m_prepay_3d_month_no_avg
        ,recent_1m_settle_month_no_avg
        ,recent_6m_settle_month_no_avg
        ,recent_12m_settle_month_no_avg
        ,recent_24m_settle_month_no_avg
        ,recent_36m_settle_month_no_avg
        ,recent_1m_due_month_cnt
        ,recent_6m_due_month_cnt
        ,recent_12m_due_month_cnt
        ,recent_24m_due_month_cnt
        ,recent_36m_due_month_cnt
        ,recent_1m_due_month_rto
        ,recent_6m_due_month_rto
        ,recent_12m_due_month_rto
        ,recent_24m_due_month_rto
        ,recent_36m_due_month_rto
        ,recent_1m_repay_progress_avg
        ,recent_6m_repay_progress_avg
        ,recent_12m_repay_progress_avg
        ,recent_24m_repay_progress_avg
        ,recent_36m_repay_progress_avg
        ,his_repay_progress_avg
        ,recent_1m_repay_progress_max
        ,recent_6m_repay_progress_max
        ,recent_12m_repay_progress_max
        ,recent_24m_repay_progress_max
        ,recent_36m_repay_progress_max
        ,his_repay_progress_max
        ,recent_1m_repay_progress_rise_month_cnt
        ,recent_6m_repay_progress_rise_month_cnt
        ,recent_12m_repay_progress_rise_month_cnt
        ,recent_24m_repay_progress_rise_month_cnt
        ,recent_36m_repay_progress_rise_month_cnt
        ,recent_1m_repay_progress_rise_month_rto
        ,recent_6m_repay_progress_rise_month_rto
        ,recent_12m_repay_progress_rise_month_rto
        ,recent_24m_repay_progress_rise_month_rto
        ,recent_36m_repay_progress_rise_month_rto
        ,recent_1m_stg_rise_month_cnt
        ,recent_6m_stg_rise_month_cnt
        ,recent_12m_stg_rise_month_cnt
        ,recent_24m_stg_rise_month_cnt
        ,recent_36m_stg_rise_month_cnt
        ,recent_1m_stg_rise_month_rto
        ,recent_6m_stg_rise_month_rto
        ,recent_12m_stg_rise_month_rto
        ,recent_24m_stg_rise_month_rto
        ,recent_36m_stg_rise_month_rto
        ,recent_1m_lend_amt_rise_month_cnt
        ,recent_6m_lend_amt_rise_month_cnt
        ,recent_12m_lend_amt_rise_month_cnt
        ,recent_24m_lend_amt_rise_month_cnt
        ,recent_36m_lend_amt_rise_month_cnt
        ,recent_1m_lend_amt_rise_month_rto
        ,recent_6m_lend_amt_rise_month_rto
        ,recent_12m_lend_amt_rise_month_rto
        ,recent_24m_lend_amt_rise_month_rto
        ,recent_36m_lend_amt_rise_month_rto
        ,recent_1m_credit_month_cnt
        ,recent_6m_credit_month_cnt
        ,recent_12m_credit_month_cnt
        ,recent_24m_credit_month_cnt
        ,recent_36m_credit_month_cnt
        ,his_credit_month_cnt
        ,recent_1m_credit_fundcls_lv1_month_cnt
        ,recent_6m_credit_fundcls_lv1_month_cnt
        ,recent_12m_credit_fundcls_lv1_month_cnt
        ,recent_24m_credit_fundcls_lv1_month_cnt
        ,recent_36m_credit_fundcls_lv1_month_cnt
        ,his_credit_fundcls_lv1_month_cnt
        ,recent_1m_credit_fundcls_lv2_month_cnt
        ,recent_6m_credit_fundcls_lv2_month_cnt
        ,recent_12m_credit_fundcls_lv2_month_cnt
        ,recent_24m_credit_fundcls_lv2_month_cnt
        ,recent_36m_credit_fundcls_lv2_month_cnt
        ,his_credit_fundcls_lv2_month_cnt
        ,recent_1m_credit_fundcls_other_month_cnt
        ,recent_6m_credit_fundcls_other_month_cnt
        ,recent_12m_credit_fundcls_other_month_cnt
        ,recent_24m_credit_fundcls_other_month_cnt
        ,recent_36m_credit_fundcls_other_month_cnt
        ,his_credit_fundcls_other_month_cnt
        ,recent_1m_credit_month_rto
        ,recent_6m_credit_month_rto
        ,recent_12m_credit_month_rto
        ,recent_24m_credit_month_rto
        ,recent_36m_credit_month_rto
        ,recent_1m_lend_amt_over10k_month_cnt
        ,recent_6m_lend_amt_over10k_month_cnt
        ,recent_12m_lend_amt_over10k_month_cnt
        ,recent_24m_lend_amt_over10k_month_cnt
        ,recent_36m_lend_amt_over10k_month_cnt
        ,his_lend_amt_over10k_month_cnt
        ,recent_1m_lend_amt_over10k_month_rto
        ,recent_6m_lend_amt_over10k_month_rto
        ,recent_12m_lend_amt_over10k_month_rto
        ,recent_24m_lend_amt_over10k_month_rto
        ,recent_36m_lend_amt_over10k_month_rto
        ,recent_1m_lend_month_cnt
        ,recent_6m_lend_month_cnt
        ,recent_12m_lend_month_cnt
        ,recent_24m_lend_month_cnt
        ,recent_36m_lend_month_cnt
        ,his_lend_month_cnt
        ,recent_1m_lend_month_rto
        ,recent_6m_lend_month_rto
        ,recent_12m_lend_month_rto
        ,recent_24m_lend_month_rto
        ,recent_36m_lend_month_rto
        ,recent_1m_lend_month_no_avg
        ,recent_6m_lend_month_no_avg
        ,recent_12m_lend_month_no_avg
        ,recent_24m_lend_month_no_avg
        ,recent_36m_lend_month_no_avg
        ,recent_1m_settle_loan_diff_days_avg
        ,recent_6m_settle_loan_diff_days_avg
        ,recent_12m_settle_loan_diff_days_avg
        ,recent_24m_settle_loan_diff_days_avg
        ,recent_36m_settle_loan_diff_days_avg
        ,his_settle_loan_diff_days_avg
        ,recent_1m_settle_loan_diff_days_max
        ,recent_6m_settle_loan_diff_days_max
        ,recent_12m_settle_loan_diff_days_max
        ,recent_24m_settle_loan_diff_days_max
        ,recent_36m_settle_loan_diff_days_max
        ,his_settle_loan_diff_days_max
        ,recent_1m_settle_loan_diff_days_min
        ,recent_6m_settle_loan_diff_days_min
        ,recent_12m_settle_loan_diff_days_min
        ,recent_24m_settle_loan_diff_days_min
        ,recent_36m_settle_loan_diff_days_min
        ,his_settle_loan_diff_days_min
        -- ,replace(t0.mdl_dte, '-', '') as ds
from    (
            select   uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
            from     ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
            where    ds = '${bizdate}' 
            group by uid,date_add(date(to_date('${bizdate}','yyyymmdd')),1)
        ) t0
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_1 a01
on      a01.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp00_2 a02
on      a02.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp01 a1
on      a1.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp03 a3
on      a3.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp04 a4
on      a4.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp05 a5
on      a5.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp06 a6
on      a6.uid = t0.uid
left join ${dwa_risk}.dwa_risk_dz_model_light_trans_inner_cross_behaviour_df_temp07 a7
on      a7.uid = t0.uid

-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp00 // Done 提前、逾期、有应还、有结清
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp01 // Done 还款进度均值等
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp02 // Done 近XX个月_月供上升_的月份数_占比/总和 （砍了）
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp03 // Done 近XX个月_月平均借款期限提升_的月份数_占比/总和
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp04 // Done 近XX个月_月平均借款金额提升_的月份数_占比/总和
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp05 // Done 近XX个月_授信成功_的月份数_占比/总和 近XX个月_授信成功_的月份编号_均值
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp06 // Done XX个月_发起交易金额>=10000元_的月份数_占比/总和 近XX个月_发起交易_的月份数_占比/总和 近XX个月_发起交易_的月份编号_均值
-- dwa_risk_dz_model_131light_inner_cross_behaviour_df_temp07 // Done his_settle_loan_diff_days_min
-- feature-copilot:node-end ordinal=0
