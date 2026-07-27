-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_stage_plan_detail_jqh
-- node_id: n_6398908050178506752
-- task_name: dwa_risk_f_heavy_stage_plan_detail_jqh
-- owner_name: 王博韬
-- upstream_tables: dwa_risk.dwa_risk_f_heavy_stage_plan_basic, dwa_risk.dwa_risk_f_dz_model_data_base_jqh_df, dwa_risk.dwa_risk_f_heavy_order_info_detail

CREATE TABLE if not EXISTS ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_jqh (
  uid STRING, mdl_dte STRING, lst_settle_up_date STRING,
  dtl_ord_no STRING, dtl_stg_pln_no STRING, dtl_rep_dte DATE, rep_tim DATE,
  prc_amt DECIMAL(18,6), stg_stt STRING, stg_no INT,
  ddf_rep_tim_dte INT, ddf_mdl_rep_tim INT, ddf_mdl_rep_dte INT,
  -- 历史/未来/逾期/提前还款 flag列 (50+列)
  is_his_rep_rpm_stg_pln INT, is_his_rep_stg_pln INT, is_ftr_rep_stg_pln INT,
  is_ovd_future_repay_stg_pln INT, adv_rep_flg INT, ovd_rep_flg INT, d0_rep_flg INT,
  his_rep_stg_pln_3d_flg INT, his_rep_stg_pln_7d_flg INT, his_rep_stg_pln_1m_flg INT,
  his_rep_stg_pln_2m_flg INT, his_rep_stg_pln_3m_flg INT, his_rep_stg_pln_6m_flg INT,
  his_rep_stg_pln_12m_flg INT, ftr_rep_stg_pln_3d_flg INT, ftr_rep_stg_pln_7d_flg INT,
  ftr_rep_stg_pln_1m_flg INT, ftr_rep_stg_pln_2m_flg INT, ftr_rep_stg_pln_3m_flg INT,
  ftr_rep_stg_pln_6m_flg INT, ftr_rep_stg_pln_12m_flg INT,
  ovd_1d_3d_flg INT, ovd_3d_pls_flg INT, ovd_7d_pls_flg INT, ovd_14d_pls_flg INT,
  ovd_m2_pls_flg INT, ovd_m3_pls_flg INT, ovd_m4_pls_flg INT,
  adv_3d_flg INT, adv_7d_flg INT, adv_14d_flg INT, adv_1m_flg INT, adv_2m_flg INT, adv_3m_flg INT,
  rep_flg INT, rep_7d_flg INT, rep_14d_flg INT, rep_1m_flg INT, rep_3m_flg INT, rep_6m_flg INT, rep_12m_flg INT,
  prc_amt_pday DECIMAL(28,6), per_rep_mth_flg INT, fst_ord_flg INT, cur_ord_flg INT
) COMMENT '风险重资产还款计划明细表结清户' PARTITIONED BY (ds STRING);

insert overwrite table ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_jqh partition(ds='${bizdate}')
-- 加工逻辑: 从dz_model_data_base_jqh_df取结清户样本 -> left join stage_plan_basic取分期计划
-- -> 计算datediff(结清日-应还日/实还日) -> case when打时间切片flag(历史/未来/逾期/提前/还清)
-- -> left join heavy_order_info_detail取得首借/当前订单flag
-- 详细完整SQL已通过dp_mcp获取(约6K chars)
select main2.*, order_info_tmp.fst_ord_flg, order_info_tmp.cur_ord_flg
from (
  select main1.*,
    case when rep_tim is null then datediff(lst_settle_up_date,dtl_rep_dte) else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte,
    datediff(lst_settle_up_date,rep_tim) as ddf_mdl_rep_tim,
    datediff(lst_settle_up_date,dtl_rep_dte) as ddf_mdl_rep_dte
  from (
    select model_data.uid, model_data.mdl_dte, model_data.lst_settle_up_date, plan.*
    from (select uid, mdl_dte, lst_settle_up_date from ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df where ds='${bizdate}') model_data
    left join (
      select uid, ord_no as dtl_ord_no, stg_pln_no as dtl_stg_pln_no, rep_dte as dtl_rep_dte,
        rep_tim, prc_amt, stg_stt, stg_no
      from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
      where bsy_typ in ('BALANCE_TRANSFER','CASH') and stg_stt<>'R') plan on model_data.uid=plan.uid) main1) main2
left join (select uid, mdl_dte, crt_tim, dtl_ord_no,
    case when fst_ord_flg=1 then 1 else 0 end as fst_ord_flg, cur_ord_flg
  from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail where ord_stt_flg='success') order_info_tmp
on main2.uid=order_info_tmp.uid and main2.dtl_ord_no=order_info_tmp.dtl_ord_no
where order_info_tmp.crt_tim<date(main2.lst_settle_up_date);
