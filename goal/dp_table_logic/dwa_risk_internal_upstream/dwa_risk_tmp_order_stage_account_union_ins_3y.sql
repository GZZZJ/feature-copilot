-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_tmp_order_stage_account_union_ins_3y
-- node_id: n_6215710240257212416
-- task_name: dwa_risk_tmp_order_stage_account_union_ins_3y
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_tmp_order_stage_account_union_ins_3y.json
-- source_json_sha256: 3eb4d551aa24151816b05d2c93d5174405f6a7c787a946ff021e65406204ab8d
-- upstream_table: cdmx.cdmx_dim_credit_account_df
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_dz_model_limit_ins_tmp_3y
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic

-- 增量额度临时表(3年)
create table if not exists ${dwa_risk}.dwa_risk_dz_model_limit_ins_tmp_3y as
select uid, account_no as act_no, credit_account_biz_type as bsy_typ, max(latest_risk_credit_limit) as rsk_adt_lmt, max(latest_risk_available_limit) as rsk_avl_lmt, date_add(to_date(ds,'yyyymmdd'),1) as day_dff1, ds
from cdmx.cdmx_dim_credit_account_df
where credit_account_biz_type in ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN') and ds='${bizdate_1}'
group by uid,account_no,credit_account_biz_type,ds;

INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_tmp_order_stage_account_union_ins_3y partition (ds='${bizdate}')
-- 借款记录 union 还款记录
select a.uid, a.biz_no, a.biz_typ, a.bsy_typ, a.time, a.ord_stt, a.stg_stt, a.prc_amt, b.rsk_adt_lmt, b.rsk_avl_lmt
from (
  select uid, ord_no as biz_no, 'brw' as biz_typ, bsy_typ, crt_tim as time, date(crt_tim) as ds, ord_stt, null as stg_stt, prc_amt
  from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic where date(crt_tim)=date_add(to_date('${bizdate}','yyyymmdd'),0)) a
left join ${dwa_risk}.dwa_risk_dz_model_limit_ins_tmp_3y b on a.uid=b.uid and a.bsy_typ=b.bsy_typ and a.ds=b.day_dff1
union all
select a.uid, a.biz_no, a.biz_typ, a.bsy_typ, a.time, a.ord_stt, a.stg_stt, a.prc_amt, b.rsk_adt_lmt, b.rsk_avl_lmt
from (
  select uid, stg_pln_no as biz_no, 'pln' as biz_typ, bsy_typ, rep_tim as time, date(rep_tim) as ds, null as ord_stt, stg_stt, prc_amt
  from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic where to_date(rep_tim)=date_add(to_date('${bizdate}','yyyymmdd'),0)) a
left join ${dwa_risk}.dwa_risk_dz_model_limit_ins_tmp_3y b on a.uid=b.uid and a.bsy_typ=b.bsy_typ and a.ds=b.day_dff1;
-- feature-copilot:node-end ordinal=0
