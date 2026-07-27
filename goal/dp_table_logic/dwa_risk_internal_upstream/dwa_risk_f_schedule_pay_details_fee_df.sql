-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_schedule_pay_details_fee_df
-- node_id: n_6004492682171908096
-- task_name: dwa_risk_f_schedule_pay_details_fee_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_schedule_pay_details_fee_df.json
-- source_json_sha256: f4e0114faf64a00aa8cd9fa70c4153281d1e462a015a550243f7ce39401de344
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df

create table if not exists ${dwa_risk}.dwa_risk_f_schedule_pay_details_fee_df (
uid string, mdl_dte string, dtl_stg_pln_no string, dtl_rep_dte date, rep_tim timestamp,
schedule_pay_principal decimal(38,18), schedule_pay_interest decimal(38,18), schedule_pay_gurantee_amount decimal(38,18),
schedule_pay_penalty decimal(38,18), schedule_pay_late_fee decimal(38,18), schedule_pay_prerepayment_fee decimal(38,18), schedule_total_amount decimal(38,18)
) PARTITIONED BY (ds STRING);

insert OVERWRITE table dwa_risk.dwa_risk_f_schedule_pay_details_fee_df partition (ds='${bizdate}')
select model_data.uid, model_data.mdl_dte, dtl_stg_pln_no, dtl_rep_dte, rep_tim,
schedule_pay_principal, schedule_pay_interest, schedule_pay_gurantee_amount, schedule_pay_penalty,
schedule_pay_late_fee, schedule_pay_prerepayment_fee, schedule_total_amount
from (
  select uid, date_add(to_date('${bizdate}','yyyymmdd'),1) as mdl_dte from dwa_risk.dwa_risk_f_dz_model_data_base) model_data
left join (
  select uid, date_add(to_date(ds,'yyyymmdd'),1) as mdl_dte, stage_plan_no as dtl_stg_pln_no, due_date as dtl_rep_dte,
    settlement_time as rep_tim, schedule_pay_principal, schedule_pay_interest, schedule_pay_guarantee_fee as schedule_pay_gurantee_amount,
    schedule_pay_penalty_interest as schedule_pay_penalty, schedule_pay_default_fee as schedule_pay_late_fee,
    schedule_pay_prepayment_fee as schedule_pay_prerepayment_fee, schedule_pay_total_amount as schedule_total_amount
  from cdmx.cdmx_fct_heavy_stage_plan_df
  where ds='${bizdate}' and original_biz_type in ('CASH','BALANCE_TRANSFER') and original_stage_plan_status <> 'R'
) b on model_data.uid=b.uid and model_data.mdl_dte=b.mdl_dte;
-- feature-copilot:node-end ordinal=0
