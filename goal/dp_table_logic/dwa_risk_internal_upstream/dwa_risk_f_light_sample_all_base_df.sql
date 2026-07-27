-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_light_sample_all_base_df
-- node_id: n_6919323739876687872
-- task_name: dwa_risk_f_light_sample_all_base_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_light_sample_all_base_df.json
-- source_json_sha256: ac19d4accbfcb6141bca33850343d399234adf1284f59737366ccdcce3a774e8
-- upstream_table: cdmx.cdmx_fct_light_loan_order_df
-- upstream_table: cdmx.cdmx_fct_light_diversion_record_di

INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_light_sample_all_base_df partition(ds='${bizdate}')
select uid, date_add(date(to_date('${bizdate}','yyyymmdd')),1)
from (
  select uid from ${cdmx}.cdmx_fct_light_diversion_record_di where ds <= '${bizdate}'
  union all
  select uid from ${cdmx}.cdmx_fct_light_loan_order_df where ds = '${bizdate}'
) group by uid, date_add(date(to_date('${bizdate}','yyyymmdd')),1);
-- feature-copilot:node-end ordinal=0
