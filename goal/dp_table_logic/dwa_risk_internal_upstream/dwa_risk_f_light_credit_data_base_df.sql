-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_light_credit_data_base_df
-- node_id: n_6903460673306230784
-- task_name: dwa_risk_f_light_credit_data_base_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_light_credit_data_base_df.json
-- source_json_sha256: 06c99e569e819a7e5c3126bd2db30361a7a99c49fcd709af064cfad875354032
-- upstream_table: cdmx.cdmx_fct_light_diversion_record_di

INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_light_credit_data_base_df partition(ds='${bizdate}') 
select uid, substr(create_time,1,10) as credit_apply_date, create_time, light_diversion_sn, fund_code, sort_strategy, light_diversion_scene, light_credit_status, light_credit_limit, fund_annual_ir, fail_reason, fund_credit_time, update_time, batch_time
from cdmx.cdmx_fct_light_diversion_record_di
where ds <= '${bizdate}';
-- feature-copilot:node-end ordinal=0
