-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_dz_model_data_base_jqh_df
-- node_id: n_6355137076392624128
-- task_name: dwa_risk_f_dz_model_data_base_jqh_df
-- owner_name: 王博韬
-- upstream_tables: dwa_risk.dwa_risk_f_dz_model_data_base_df, cdmx.cdmx_fct_heavy_stage_plan_df

CREATE TABLE if not exists ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df (
  uid STRING COMMENT '用户ID', mdl_dte STRING COMMENT '评分日',
  lst_settle_up_date STRING COMMENT '最近一次结清时间'
) PARTITIONED BY (ds STRING COMMENT '分区字段格式yyyymmdd');

insert OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df partition(ds='${bizdate}')
SELECT * from (
  select a.uid, a.mdl_dte,
    max(case when b.settle_up_date is null then DATE '2099-01-01' else b.settle_up_date end) lst_settle_up_date
  from (select * from ${dwa_risk}.dwa_risk_f_dz_model_data_base_df where ds='${bizdate}') a
  left join (
    select uid, DATE(settlement_time) AS settle_up_date
    from cdmx.cdmx_fct_heavy_stage_plan_df
    where original_stage_plan_status in ('S','A','U','X','O','E')
      and original_biz_type in ('BUSINESS_LOAN','BALANCE_TRANSFER','CASH')
      and ds='${bizdate}' and original_loan_principal>0) b
  on a.uid=b.uid group by a.uid, a.mdl_dte) c
where c.lst_settle_up_date<c.mdl_dte;
