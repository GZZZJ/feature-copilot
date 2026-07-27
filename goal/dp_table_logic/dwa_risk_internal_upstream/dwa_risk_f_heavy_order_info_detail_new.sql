-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_order_info_detail_new
-- node_id: n_6398775387228995584
-- task_name: dwa_risk_f_heavy_order_info_detail_new
-- owner_name: 王博韬
-- upstream_tables: dwa_risk.dwa_risk_f_dz_model_data_base_df, dwa_risk.dwa_risk_f_heavy_order_info_basic

CREATE TABLE if not EXISTS ${dwa_risk}.dwa_risk_f_heavy_order_info_detail_new (
  `uid` STRING COMMENT '用户id', `mdl_dte` DATE COMMENT '模型日期',
  `dtl_ord_no` STRING COMMENT '订单号', `crt_dte` DATE COMMENT '订单创建日期',
  `crt_tim` TIMESTAMP COMMENT '订单创建日期（时间戳）', `prc_amt` DECIMAL(18,6) COMMENT '借款本金',
  `fst_its_dte` DATE COMMENT '起息日', `stg_num` INT COMMENT '分期数',
  `ord_stt` STRING COMMENT '订单状态', `bsy_typ` STRING COMMENT '业务类型',
  `ord_stt_flg` STRING COMMENT '订单状态标示', `fst_ord_flg` INT COMMENT '首次动支订单flag',
  `lst_ord_flg` INT COMMENT '最近动支订单flag', `cur_ord_flg` INT COMMENT '当前动支订单flag',
  `new_bsy_typ` STRING COMMENT 'bt_cash_flag', `ddf_mdl_ord_crt_dte` INT COMMENT '间隔天数',
  `ddf_30_day_flag` INT, `ddf_90_day_flag` INT, `ddf_180_day_flag` INT,
  `ddf_360_day_flag` INT, `ddf_720_day_flag` INT, `ddf_1080_day_flag` INT, `ddf_day_flag` INT,
  `crt_hor_flg` STRING COMMENT '订单创建时间区间',
  `prc_amt_1_000_flg` INT, `prc_amt_3_000_flg` INT, `prc_amt_5_000_flg` INT, `prc_amt_10_000_flg` INT
) COMMENT '风险重资产订单明细表新'
PARTITIONED BY (`ds` STRING);

INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_heavy_order_info_detail_new partition(ds='${bizdate}')
select main.uid, main.mdl_dte, main.dtl_ord_no, main.crt_dte, main.crt_tim, main.prc_amt,
  main.fst_its_dte, main.stg_num, main.ord_stt, main.bsy_typ, main.ord_stt_flg,
  main.fst_ord_flg, main.lst_ord_flg, main.cur_ord_flg, main.new_bsy_typ, main.ddf_mdl_ord_crt_dte,
  case when ddf_mdl_ord_crt_dte between 1 and 30 then 1 else 0 end as ddf_30_day_flag,
  case when ddf_mdl_ord_crt_dte between 1 and 90 then 1 else 0 end as ddf_90_day_flag,
  case when ddf_mdl_ord_crt_dte between 1 and 180 then 1 else 0 end as ddf_180_day_flag,
  case when ddf_mdl_ord_crt_dte between 1 and 360 then 1 else 0 end as ddf_360_day_flag,
  case when ddf_mdl_ord_crt_dte between 1 and 720 then 1 else 0 end as ddf_720_day_flag,
  case when ddf_mdl_ord_crt_dte between 1 and 1080 then 1 else 0 end as ddf_1080_day_flag,
  case when ddf_mdl_ord_crt_dte>=1 then 1 else 0 end as ddf_day_flag,
  case when hour(crt_tim) between 0 and 3 then '0到3点借款' when hour(crt_tim) between 4 and 6 then '4到6点借款'
       when hour(crt_tim) between 7 and 12 then '7到12点借款' when hour(crt_tim) between 13 and 18 then '13到18点借款'
       when hour(crt_tim) between 19 and 23 then '19到23点借款' else '其他时间段借款' end as crt_hor_flg,
  case when prc_amt>=1000 then 1 else 0 end as prc_amt_1_000_flg,
  case when prc_amt>=3000 then 1 else 0 end as prc_amt_3_000_flg,
  case when prc_amt>=5000 then 1 else 0 end as prc_amt_5_000_flg,
  case when prc_amt>=10000 then 1 else 0 end as prc_amt_10_000_flg
from (
  select model_data.uid, model_data.mdl_dte, order_info.ord_no as dtl_ord_no,
    order_info.crt_dte, order_info.crt_tim, order_info.prc_amt, order_info.fst_its_dte,
    order_info.stg_num, order_info.ord_stt, order_info.bsy_typ, order_info.ord_stt_flg,
    row_number() over(partition by model_data.uid,order_info.ord_stt_flg order by order_info.crt_tim asc) as fst_ord_flg,
    row_number() over(partition by model_data.uid,order_info.ord_stt_flg order by order_info.crt_tim desc) as lst_ord_flg,
    0 as cur_ord_flg,
    case when order_info.bsy_typ in('BALANCE_TRANSFER','CASH') then 'bt_cash' else 'not_bt_cash' end as new_bsy_typ,
    datediff(model_data.mdl_dte,date(order_info.crt_dte)) as ddf_mdl_ord_crt_dte
  from (select uid, mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base_df where ds='${bizdate}') model_data
  left join (
    select uid, ord_no, crt_tim, date(crt_tim) as crt_dte, prc_amt, stg_num, fst_its_dte, ord_stt, bsy_typ, ord_stt_flg
    from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic
    where bsy_typ in ('BALANCE_TRANSFER','CASH')) order_info on model_data.uid=order_info.uid
  where order_info.crt_tim<date(model_data.mdl_dte)) main;
