-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_dz_model_data_base_df
-- node_id: n_6390778261202927616
-- task_name: dwa_risk_f_dz_model_data_base_df
-- owner_name: 王博韬
-- upstream_tables: dwt.dwt_heavy_order_df

CREATE TABLE if not exists ${dwa_risk}.dwa_risk_f_dz_model_data_base_df (
  uid STRING COMMENT '用户ID', mdl_dte STRING COMMENT '评分日'
) PARTITIONED BY (ds STRING COMMENT '分区字段格式yyyymmdd');

insert OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_dz_model_data_base_df partition(ds='${bizdate}')
select uid, date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from (
  select uid, order_no, business_type bsy_typ,
    coalesce(order_status,apply_status) ord_stt,
    case when loan_success_flag=1 then 'success' when apply_status in ('LEND_FAIL','LOAN_DENIED') then 'fail'
         when order_status='R' then 'fail' else 'else' end ord_stt_flg,
    coalesce(loan_principal_amount,apply_amount) as prc_amt,
    coalesce(init_total_stage,apply_total_stage) stg_num,
    apply_record_crt_time crt_tim,
    coalesce(loan_date,date(apply_record_crt_time)) as loan_date
  from dwt.dwt_heavy_order_df where ds='${bizdate}') a
where ord_stt_flg='success'
group by uid;
