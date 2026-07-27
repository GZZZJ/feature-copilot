-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_active_device_detail
-- node_id: n_3789898623974572032
-- task_name: dwa_risk_f_active_device_detail
-- owner_name: 周志华
-- upstream_tables: dwa_risk.dwa_risk_f_dz_model_data_base, ods_pdw_loan.ods_pdw_loan_tidbxd_stats_device_info_log_di

insert overwrite table ${dwa_risk}.dwa_risk_f_active_device_detail 
select model_data.uid, model_data.mdl_dte, cjj_id, lst_app_str_tim,
  to_date(lst_app_str_tim) as lst_app_str_dte, lat_tud, alt_tud, lng_tud,
  os_typ, prv_val, cty_val,
  row_number() over(partition by model_data.uid order by device_event_detail.lst_app_str_tim desc) as num,
  datediff(model_data.mdl_dte,to_date(lst_app_str_tim)) as ddf_mdl_lst_app_str_dte
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join (
  select uid, cjj_id, latitude as lat_tud, altitude as alt_tud, longitude as lng_tud,
    lbs_province as prv_val, lbs_city as cty_val, os_name as os_typ, created_at as lst_app_str_tim
  from ${ods_pdw_loan}.ods_pdw_loan_tidbxd_stats_device_info_log_di
  where date_add(to_date(ds,'yyyymmdd'),0) between add_months(date_add(to_date('${bizdate}','yyyymmdd'),0),-4) and date_add(to_date('${bizdate}','yyyymmdd'),0)
    and (collect_source='startClient' or event='login')) device_event_detail
on model_data.uid=device_event_detail.uid
where device_event_detail.lst_app_str_tim<date(model_data.mdl_dte)
  and datediff(model_data.mdl_dte,to_date(lst_app_str_tim))<=90;
