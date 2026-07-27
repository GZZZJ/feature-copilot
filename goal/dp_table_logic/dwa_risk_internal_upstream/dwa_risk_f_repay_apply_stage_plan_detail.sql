-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_repay_apply_stage_plan_detail
-- node_id: n_4039676845122256896
-- task_name: dwa_risk_f_repay_apply_stage_plan_detail
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_repay_apply_stage_plan_detail.json
-- source_json_sha256: 1860d62b9af6b6f174b758606cdf8e4f1a8e7db05463f8c2165cb072f34c60bd
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsrepayali_repayengine_repay_apply_stage_plan_item_di
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_f_repay_apply_stage_plan_detail_tmp1
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: dwa_risk.dwa_risk_f_repay_apply_stage_plan_detail_tmp2
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsrepayali_repayengine_repay_apply_df

-- tmp1: 还款申请明细(近6月)
create table ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail_tmp1 as
select a.uid, a.mdl_dte, b.*, datediff(mdl_dte, crt_dat) as ddf_mdl_crt_dte, m1/m3/m6时间切片flag, 还款方式desc, 时间段类型
from (select uid, date_add(to_date('${bizdate}','yyyymmdd'),1) as mdl_dte from dwt.dwt_heavy_order_df where ds='${bizdate}' and loan_success_flag=1 group by uid) a
left join (
  select uid, repay_apply_no, biz_serial, repay_type, repay_amount/100 as rep_amt, repay_success_amount/100 as rep_suc_amt, repay_failure_amount/100 as rep_fal_amt, status_desc, repay_way, batch_flag, request_source,
    case when repay_way='AUTO_DEDUCT' and request_source='autodeduct' then batch_flag when repay_way='AUTO_DEDUCT' and request_source<>'autodeduct' then 'normalBatch' else repay_way END as rpy_way, create_at, date(create_at) as crt_dat, asset_type
  from ods_pdw_loan.ods_pdw_loan_dsrepayali_repayengine_repay_apply_df
  where ds=replace(current_date()-1,'-','') and date(create_at)<=date(to_date('${bizdate}','yyyymmdd'))
) b on a.uid=b.uid where asset_type='heavyAsset' and crt_dat>=add_months(a.mdl_dte,-6) and crt_dat<date(a.mdl_dte);

-- tmp2: 还款-订单关联
create table ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail_tmp2 as
select *, datediff(date(rep_tim_new),due_date) as ddf_rep_tim_dte
from (select a.*, b.stg_pln_no, b.order_no, b.amt, c.stg_typ, c.stage_no, c.due_date, c.rep_tim, c.schedule_total_amount,
  case when date(c.rep_tim)<=date(a.mdl_dte) then date(c.rep_tim) else a.mdl_dte end as rep_tim_new
  from ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail_tmp1 a
  left join ods_pdw_loan.ods_pdw_loan_dsrepayali_repayengine_repay_apply_stage_plan_item_di b on a.repay_apply_no=b.repay_apply_no
  left join (cdmx.cdmx_fct_heavy_stage_plan_df a left join dwt.dwt_heavy_order_df b on a.order_no=b.order_no) c
  on b.order_no=c.order_no and b.stg_pln_no=c.stg_pln_no
  where b.repay_apply_no is not null and c.stg_pln_no is not null);

-- 最终insert
insert overwrite table ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail
select t1.*, t2.stg_pln_no, t2.order_no, t2.amt, t2.stg_typ, t2.stage_no, t2.due_date, t2.rep_tim, t2.rep_tim_new, t2.schedule_total_amount, t2.ddf_rep_tim_dte,
  case when ddf_rep_tim_dte<0 then '提前还款' when ddf_rep_tim_dte=0 then 'D0还款' when ddf_rep_tim_dte>30 then '历史逾期30天以上(m2+)' ... end as rep_tim_type
from ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail_tmp1 t1
left join ${dwa_risk}.dwa_risk_f_repay_apply_stage_plan_detail_tmp2 t2 on t1.repay_apply_no=t2.repay_apply_no;
-- feature-copilot:node-end ordinal=0
