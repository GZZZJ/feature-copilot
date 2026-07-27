-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_unpaid_order_amount_basic_df
-- node_id: n_5962915027924418560
-- task_name: dwa_risk_f_unpaid_order_amount_basic_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_unpaid_order_amount_basic_df.json
-- source_json_sha256: 9508185e1c6a8cf646b01474ae4027c89790d95287d6888c3fce17f02d16fc76
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df

CREATE TABLE IF NOT EXISTS dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df (
uid string, mdl_dte STRING, unpaid_principal_tot DECIMAL(26,10), unpaid_principal_his DECIMAL(26,10), unpaid_principal_future DECIMAL(26,10),
unpaid_interest_tot DECIMAL(26,10), unpaid_gurantee_amount_tot DECIMAL(26,10), unpaid_penalty_tot DECIMAL(26,10),
unpaid_compound_interest_tot DECIMAL(26,10), unpaid_late_fee_tot DECIMAL(26,10), unpaid_total_amount_tot DECIMAL(26,10)
) PARTITIONED BY (ds STRING);

insert OVERWRITE table dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df partition (ds='${bizdate}')
select uid, mdl_dte,
sum(unpaid_principal) as unpaid_principal_tot,
sum(case when date(due_date)<=date(mdl_dte) then unpaid_principal else 0 end) as unpaid_principal_his,
sum(case when date(due_date)>date(mdl_dte) then unpaid_principal else 0 end) as unpaid_principal_future,
sum(unpaid_interest) as unpaid_interest_tot, sum(unpaid_gurantee_amount) as unpaid_gurantee_amount_tot,
sum(unpaid_penalty) as unpaid_penalty_tot, sum(unpaid_compound_interest) as unpaid_compound_interest_tot,
sum(unpaid_late_fee) as unpaid_late_fee_tot, sum(unpaid_total_amount) as unpaid_total_amount_tot
from (
  select t1.*, t3.unpaid_principal, t3.unpaid_interest, t3.unpaid_gurantee_amount, t3.unpaid_penalty, t3.unpaid_compound_interest, t3.unpaid_late_fee, t3.unpaid_total_amount, t3.due_date
  from (
    select uid, date_add(to_date('${bizdate}','yyyymmdd'),1) as mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base) t1
  left join (
    select uid, date_add(to_date(ds,'yyyymmdd'),0) as ds, due_date, unpaid_principal, unpaid_interest, unpaid_guarantee_fee as unpaid_gurantee_amount,
    unpaid_penalty_interest as unpaid_penalty, unpaid_compound_interest, unpaid_default_fee as unpaid_late_fee, unpaid_total_amount
    from cdmx.cdmx_fct_heavy_stage_plan_df where ds='${bizdate}'
    and (original_stage_plan_status in ('S','A','U','X','O','E') OR original_stage_plan_status IS NULL)
    and due_date is not null and substr(order_no,1,2) in ('BT','CH')) t3
  on t1.uid=t3.uid and date_sub(t1.mdl_dte,1)=t3.ds) group by uid,mdl_dte;
-- feature-copilot:node-end ordinal=0
