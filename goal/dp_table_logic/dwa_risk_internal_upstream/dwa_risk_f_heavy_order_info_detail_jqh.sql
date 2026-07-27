-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_order_info_detail_jqh
-- node_id: n_6398893412930158592
-- task_name: dwa_risk_f_heavy_order_info_detail_jqh
-- owner_name: 王博韬
-- upstream_tables: dwa_risk.dwa_risk_f_dz_model_data_base_jqh_df, dwa_risk.dwa_risk_f_heavy_order_info_basic

create table if not exists ${dwa_risk}.dwa_risk_f_heavy_order_info_detail_jqh (
    uid string, mdl_dte date, lst_settle_up_date date, dtl_ord_no string,
    crt_dte date, crt_tim timestamp, prc_amt decimal(18,6), fst_its_dte date, stg_num int,
    ord_stt string, bsy_typ string, ord_stt_flg string, fst_ord_flg int, lst_ord_flg int,
    cur_ord_flg int, new_bsy_typ string, ddf_mdl_ord_crt_dte int,
    ddf_30_day_flag int, ddf_90_day_flag int, ddf_180_day_flag int, ddf_360_day_flag int,
    ddf_day_flag int, crt_hor_flg string,
    prc_amt_1_000_flg int, prc_amt_3_000_flg int, prc_amt_5_000_flg int, prc_amt_10_000_flg int
) comment '风险重资产订单明细表结清户' PARTITIONED BY (ds STRING);

insert OVERWRITE table ${dwa_risk}.dwa_risk_f_heavy_order_info_detail_jqh partition(ds='${bizdate}')
select main.uid, main.mdl_dte, main.lst_settle_up_date, main.dtl_ord_no,
  main.crt_dte, main.crt_tim, main.prc_amt, main.fst_its_dte, main.stg_num,
  main.ord_stt, main.bsy_typ, main.ord_stt_flg, main.fst_ord_flg, main.lst_ord_flg,
  main.cur_ord_flg, main.new_bsy_typ, main.ddf_mdl_ord_crt_dte,
  case when ddf_mdl_ord_crt_dte between 0 and 30 then 1 else 0 end as ddf_30_day_flag,
  case when ddf_mdl_ord_crt_dte between 0 and 90 then 1 else 0 end as ddf_90_day_flag,
  case when ddf_mdl_ord_crt_dte between 0 and 180 then 1 else 0 end as ddf_180_day_flag,
  case when ddf_mdl_ord_crt_dte between 0 and 360 then 1 else 0 end as ddf_360_day_flag,
  case when ddf_mdl_ord_crt_dte>=0 then 1 else 0 end as ddf_day_flag,
  case when hour(crt_tim) between 0 and 3 then '0到3点借款' ... end as crt_hor_flg,
  case when prc_amt>=1000 then 1 else 0 end as prc_amt_1_000_flg,
  case when prc_amt>=3000 then 1 else 0 end as prc_amt_3_000_flg,
  case when prc_amt>=5000 then 1 else 0 end as prc_amt_5_000_flg,
  case when prc_amt>=10000 then 1 else 0 end as prc_amt_10_000_flg
from (
  select model_data.uid, model_data.mdl_dte, model_data.lst_settle_up_date,
    order_info.ord_no as dtl_ord_no, order_info.crt_dte, order_info.crt_tim,
    order_info.prc_amt, order_info.fst_its_dte, order_info.stg_num,
    order_info.ord_stt, order_info.bsy_typ, order_info.ord_stt_flg,
    row_number() over(partition by model_data.uid,order_info.ord_stt_flg order by order_info.crt_tim asc) as fst_ord_flg,
    row_number() over(partition by model_data.uid,order_info.ord_stt_flg order by order_info.crt_tim desc) as lst_ord_flg,
    0 as cur_ord_flg,
    case when order_info.bsy_typ in('BALANCE_TRANSFER','CASH') then 'bt_cash' else 'not_bt_cash' end as new_bsy_typ,
    datediff(model_data.lst_settle_up_date,date(order_info.crt_dte)) as ddf_mdl_ord_crt_dte
  from (select uid, mdl_dte, lst_settle_up_date from ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df where ds='${bizdate}') model_data
  left join (select uid, ord_no, crt_tim, date(crt_tim) as crt_dte, prc_amt, stg_num, fst_its_dte, ord_stt, bsy_typ, ord_stt_flg
    from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic where bsy_typ in ('BALANCE_TRANSFER','CASH')) order_info
  on model_data.uid=order_info.uid
  where order_info.crt_tim<date(model_data.lst_settle_up_date)) main;
