-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_order_crt_date_credit_limit_upaid_principal_di
-- node_id: n_6007949649808850944
-- task_name: dwa_risk_f_heavy_order_crt_date_credit_limit_upaid_principal_di
-- owner_name: 牛莲泽
-- upstream_tables: dwa_risk.dwa_risk_f_heavy_order_info_basic, dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df, dwa_risk.dwa_risk_f_customer_credit_limit_basic_df

create table if not exists ${dwa_risk}.dwa_risk_f_heavy_order_crt_date_credit_limit_upaid_principal_di (
uid string comment 'uid', ord_no string comment '借款订单编号',
crt_tim timestamp comment '借款订单创建时间（到时分秒）',
crt_dte date comment '借款订单创建日（到天）',
prc_amt decimal(18,6) comment '借款订单本金',
stg_num int comment '借款订单期数',
fst_its_dte date comment '首借日期',
ord_stt_flg string comment '借款订单状态',
rsk_adt_lmt_cash_his_t_day double comment '借款订单所在创建日的授信额度',
rsk_avl_lmt_cash_his_t_day double comment '借款订单所在创建日的可用额度',
unpaid_principal_tot_amt_t_day decimal(26,10) comment '借款订单所在创建日的未还本金总额',
unpaid_principal_his_amt_t_day decimal(26,10) comment '借款订单所在创建日的历史未还本金总额',
unpaid_principal_future_amt_t_day decimal(26,10) comment '借款订单所在创建日的未来未还本金总额',
unpaid_interest_tot_amt_t_day decimal(26,10), unpaid_gurantee_amount_tot_amt_t_day decimal(26,10),
unpaid_penalty_tot_amt_t_day decimal(26,10), unpaid_compound_interest_tot_amt_t_day decimal(26,10),
unpaid_late_fee_tot_amt_t_day decimal(26,10), unpaid_total_amount_tot_amt_t_day decimal(26,10)
) comment "借款订单所在创建日的额度与负债信息"
PARTITIONED BY (ds STRING);

insert OVERWRITE table dwa_risk.dwa_risk_f_heavy_order_crt_date_credit_limit_upaid_principal_di partition (ds='${bizdate}')
select order_info.*,
  rsk_adt_lmt_cash_his_t_day, rsk_avl_lmt_cash_his_t_day,
  unpaid_principal_tot_amt_t_day, unpaid_principal_his_amt_t_day, unpaid_principal_future_amt_t_day,
  unpaid_interest_tot_amt_t_day, unpaid_gurantee_amount_tot_amt_t_day, unpaid_penalty_tot_amt_t_day,
  unpaid_compound_interest_tot_amt_t_day, unpaid_late_fee_tot_amt_t_day, unpaid_total_amount_tot_amt_t_day
FROM (
  select uid, ord_no, crt_tim, date(crt_tim) as crt_dte, prc_amt, stg_num, fst_its_dte, ord_stt_flg
  from dwa_risk.dwa_risk_f_heavy_order_info_basic
  where bsy_typ in ('BALANCE_TRANSFER','CASH')
    and to_char(date(crt_tim),'yyyy-mm-dd')=to_char(to_date('${bizdate}','yyyymmdd'),'yyyy-mm-dd')) order_info
left join (
  select uid, date_add(to_date(ds,'yyyymmdd'),0) as ds, rsk_adt_lmt_cash as rsk_adt_lmt_cash_his_t_day,
    rsk_avl_lmt_cash as rsk_avl_lmt_cash_his_t_day
  from dwa_risk.dwa_risk_f_customer_credit_limit_basic_df where ds='${bizdate}') credit_limit
on order_info.uid=credit_limit.uid and date_sub(order_info.crt_dte,0)=credit_limit.ds
left join (
  select uid, date_add(to_date(ds,'yyyymmdd'),0) as ds,
    unpaid_principal_tot as unpaid_principal_tot_amt_t_day,
    unpaid_principal_his as unpaid_principal_his_amt_t_day,
    unpaid_principal_future as unpaid_principal_future_amt_t_day,
    unpaid_interest_tot as unpaid_interest_tot_amt_t_day,
    unpaid_gurantee_amount_tot as unpaid_gurantee_amount_tot_amt_t_day,
    unpaid_penalty_tot as unpaid_penalty_tot_amt_t_day,
    unpaid_compound_interest_tot as unpaid_compound_interest_tot_amt_t_day,
    unpaid_late_fee_tot as unpaid_late_fee_tot_amt_t_day,
    unpaid_total_amount_tot as unpaid_total_amount_tot_amt_t_day
  from dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df where ds='${bizdate}') debate
on order_info.uid=debate.uid and date_sub(order_info.crt_dte,0)=debate.ds;
