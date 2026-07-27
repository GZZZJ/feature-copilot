-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di
-- node_id: n_6007729541324865536
-- task_name: dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di.json
-- source_json_sha256: 75ccf8b8ecfaa3aead0fc678b3c49a2756edd2154d719f6747f0dedc3dd80a6c
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_customer_credit_limit_basic_df

create table if not exists ${dwa_risk}.dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di (
uid string comment 'uid',
dtl_ord_no string comment '分期所在订单编号',
dtl_stg_pln_no string comment '分期计划编号',
dtl_rep_dte date comment '分期应还款日',
rep_tim timestamp comment '分期结清时间',
prc_amt decimal(18,6) comment '分期应还本金',
stg_stt string comment '分期状态',
stg_no int comment '分期所在期数',
rsk_adt_lmt_cash_his_t_day double comment '分期应还款日当天授信额度',
rsk_avl_lmt_cash_his_t_day double comment '分期应还款日当天可用额度'
) PARTITIONED BY (ds STRING COMMENT '分区字段，日期，yyyymmdd');

insert OVERWRITE table dwa_risk.dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di partition (ds = '${bizdate}')
select plan.*, credit_limit.rsk_adt_lmt_cash_his_t_day, credit_limit.rsk_avl_lmt_cash_his_t_day
from (
  select uid, ord_no as dtl_ord_no, stg_pln_no as dtl_stg_pln_no, rep_dte as dtl_rep_dte, rep_tim, prc_amt, stg_stt, stg_no
  from dwa_risk.dwa_risk_f_heavy_stage_plan_basic
  where bsy_typ in ('BALANCE_TRANSFER','CASH') and stg_stt <> 'R'
  and rep_dte = to_char(to_date('${bizdate}','yyyymmdd'),'yyyy-mm-dd')) plan
left JOIN (
  select uid, date_add(to_date(ds,'yyyymmdd'),0) as ds, rsk_adt_lmt_cash as rsk_adt_lmt_cash_his_t_day, rsk_avl_lmt_cash as rsk_avl_lmt_cash_his_t_day
  from dwa_risk.dwa_risk_f_customer_credit_limit_basic_df where ds = '${bizdate}') as credit_limit
on plan.uid = credit_limit.uid and date_sub(plan.dtl_rep_dte,0) = credit_limit.ds;
-- feature-copilot:node-end ordinal=0
