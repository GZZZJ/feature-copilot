-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_bizdate
-- node_id: n_6185031357581361152
-- task_name: dwa_risk_dz_model_final_used_lmt_trend_time_series_df
-- owner_name: 黄皓俞
-- upstream_tables: dwa_risk.dwa_risk_f_dz_model_data_base, dwa_risk.dwa_risk_f_customer_credit_limit_basic_df
-- note: 本SQL同时创建 used_lmt_trend_time_series_df, 及其 tmp1/tmp2/part1 中间表

create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df(
  uid string, mdl_dte string,
  3m_used_lmt_first_der_max string, 6m_used_lmt_first_der_max string, 12m_used_lmt_first_der_max string, 18m_used_lmt_first_der_max string,
  3m_used_lmt_first_der_min string, 6m_used_lmt_first_der_min string, 12m_used_lmt_first_der_min string, 18m_used_lmt_first_der_min string,
  -- avg/median/stddev/sum/count/mean_diff/mean_rto for 3/6/12/18m 一阶和二阶导数 (约80列)
  3m_used_lmt_second_der_max string, 6m_used_lmt_second_der_max string, 12m_used_lmt_second_der_max string, 18m_used_lmt_second_der_max string
  -- ... 完整列定义见dp_mcp返回SQL
) comment '贷中额度使用率时间序列变量' partitioned by (ds string);

-- tmp1: 从customer_credit_limit_basic_df取近18月额度使用率, 按月分桶聚合
create table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate} as
select uid, rn1, avg(rto) as lmt_used_rto
from (
  select t1.uid, rto,
    (case when date(t2.lmt_mdl_dte)>add_months(to_date(mdl_dte),-1) and date(t2.lmt_mdl_dte)<=add_months(to_date(mdl_dte),0) then 1 ... end) as rn1
  from (select uid, date_add(to_date('${bizdate}','yyyymmdd'),1) as mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base) t1
  left join (select uid, mdl_dte as lmt_mdl_dte, (rsk_adt_lmt_cash-rsk_avl_lmt_cash)/rsk_adt_lmt_cash as rto
    from dwa_risk.dwa_risk_f_customer_credit_limit_basic_df
    where ds between add_months(to_date('${bizdate}','yyyymmdd'),-18) and '${bizdate}') t2
  on t1.uid=t2.uid and t1.mdl_dte>t2.lmt_mdl_dte) where rn1 is not null group by uid, rn1;

-- tmp2: 计算一阶和二阶导数
create table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate} as
select uid, rn1, first_derivative, first_derivative-previous_first_derivative as second_derivative
from (
  select uid, rn1, lmt_used_rto-previous_lmt_used_rto as first_derivative,
    lead(lmt_used_rto,1,null) over(partition by uid order by rn1 asc) as previous_lmt_used_rto
  from ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate});

-- part1: 聚合 max/min/avg/median/stddev/sum/count/mean_diff/mean_rto 一阶+二阶导数
create table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate} as
select uid,
  max(case when rn1<=3 then first_derivative else null end) as 3m_used_lmt_first_der_max,
  -- ... 80+聚合列
from ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate} group by uid;

-- 最终insert
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df partition(ds='${bizdate}')
select a.uid, a.mdl_dte, b.*
from (select uid, date_add(to_date('${bizdate}','yyyymmdd'),1) as mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base) a
left join ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate} b on a.uid=b.uid;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp1_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_tmp2_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_used_lmt_trend_time_series_df_part1_${bizdate};
