-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_customer_credit_limit_basic_df
-- node_id: n_5962913275577761792
-- task_name: dwa_risk_f_customer_credit_limit_basic_df
-- owner_name: 牛莲泽
-- upstream_tables: dwa_risk.dwa_risk_f_dz_model_data_base, cdmx.cdmx_dim_credit_account_df

create table if not exists ${dwa_risk}.dwa_risk_f_customer_credit_limit_basic_df (
    uid string comment '客户号',
    mdl_dte string comment '模型评分日',
    rsk_adt_lmt_cash double comment 'CASH.BT授信额度',
    rsk_avl_lmt_cash double comment 'CASH.BT可用额度',
    rsk_adt_lmt_dcp double comment 'DCP授信额度',
    rsk_avl_lmt_dcp double comment 'DCP可用额度',
    rsk_adt_lmt_hug double comment '大额贷授信额度',
    rsk_avl_lmt_hug double comment '大额贷可用额度'
) comment "用户账户额度表，by日存储"
PARTITIONED BY (ds STRING comment '分区字段，yyyymmdd');

insert overwrite table ${dwa_risk}.dwa_risk_f_customer_credit_limit_basic_df partition (ds='${bizdate}')
select model_data.uid, model_data.mdl_dte,
  max(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') then rsk_adt_lmt else NULL end) as rsk_adt_lmt_cash,
  max(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') then rsk_avl_lmt else NULL end) as rsk_avl_lmt_cash,
  max(case when b.bsy_typ='ENJOY_PAY' then rsk_adt_lmt else NULL end) as rsk_adt_lmt_dcp,
  max(case when b.bsy_typ='ENJOY_PAY' then rsk_avl_lmt else NULL end) as rsk_avl_lmt_dcp,
  max(case when b.bsy_typ='HUGE_LOAN' then rsk_adt_lmt else NULL end) as rsk_adt_lmt_hug,
  max(case when b.bsy_typ='HUGE_LOAN' then rsk_avl_lmt else NULL end) as rsk_avl_lmt_hug
from (select uid, date_add(to_date('${bizdate}','yyyymmdd'),1) as mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base) model_data
left join (
  select uid, account_no as act_no, credit_account_biz_type as bsy_typ,
    latest_risk_credit_limit as rsk_adt_lmt, latest_risk_available_limit as rsk_avl_lmt,
    date_add(to_date('${bizdate}','yyyymmdd'),0) as ds
  from cdmx.cdmx_dim_credit_account_df
  where credit_account_biz_type in ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN')
    and ds='${bizdate}' and account_channel is not null) b
on model_data.uid=b.uid and date_sub(model_data.mdl_dte,1)=b.ds
group by model_data.uid, model_data.mdl_dte;
