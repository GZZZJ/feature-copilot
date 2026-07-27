-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_stage_plan_detail
-- node_id: n_3766281320367915008
-- task_name: dwa_risk_f_heavy_stage_plan_detail
-- owner_name: 周志华
-- upstream_tables: dwa_risk.dwa_risk_f_heavy_stage_plan_basic, dwa_risk.dwa_risk_f_dz_model_data_base, dwa_risk.dwa_risk_f_heavy_order_info_detail

insert overwrite table ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail 
select main2.uid, main2.mdl_dte, main2.dtl_ord_no, main2.dtl_stg_pln_no,
  main2.dtl_rep_dte, main2.rep_tim, main2.prc_amt, main2.stg_stt, main2.stg_no,
  main2.ddf_rep_tim_dte, main2.ddf_mdl_rep_tim, main2.ddf_mdl_rep_dte,
  -- 历史/未来/逾期/提前还款 时间切片flag (3d/7d/1m/2m/3m/6m/12m), 约40+列case when
  case when ddf_mdl_rep_dte>0 or ddf_mdl_rep_tim>0 then 1 else 0 end as is_his_rep_rpm_stg_pln,
  case when ddf_mdl_rep_dte>0 then 1 else 0 end as is_his_rep_stg_pln,
  case when ddf_mdl_rep_dte<=0 then 1 else 0 end as is_ftr_rep_stg_pln,
  case when ddf_mdl_rep_dte>0 and ddf_mdl_rep_tim is null then 1 end as is_ovd_future_repay_stg_pln,
  case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then 1 else 0 end adv_rep_flg,
  case when ddf_rep_tim_dte>0 then 1 else 0 end as ovd_rep_flg,
  case when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then 1 else 0 end as d0_rep_flg,
  -- 历史时间切片: 3d/7d/1m/2m/3m/6m/12m
  -- 未来时间切片: -3d/-7d/-1m/-2m/-3m/-6m/-12m
  -- 逾期切片: 1-3d/3d+/7d+/14d+/30d+/60d+/90d+
  -- 提前还款切片: -3d/-7d/-14d/-1m/-2m/-3m
  -- 还清口径切片: 7d/14d/1m/3m/6m/12m
  sum(case when ddf_mdl_rep_tim>0 then prc_amt else 0 end) over(partition by main2.uid,rep_tim) as prc_amt_pday,
  order_info_tmp.fst_ord_flg, order_info_tmp.cur_ord_flg
from (
  select main1.uid, main1.mdl_dte, main1.dtl_ord_no, main1.dtl_stg_pln_no,
    main1.dtl_rep_dte, main1.rep_tim, main1.prc_amt, main1.stg_stt, main1.stg_no,
    case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte) else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte,
    datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim,
    datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte
  from (
    select model_data.uid, model_data.mdl_dte, plan.*
    from (select uid, mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base) model_data
    left join (
      select uid, ord_no as dtl_ord_no, stg_pln_no as dtl_stg_pln_no, rep_dte as dtl_rep_dte,
        rep_tim, prc_amt, stg_stt, stg_no
      from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
      where bsy_typ in ('BALANCE_TRANSFER','CASH') and stg_stt<>'R') plan on model_data.uid=plan.uid) main1) main2
left join (select uid, mdl_dte, crt_tim, dtl_ord_no,
    case when fst_ord_flg=1 then 1 else 0 end as fst_ord_flg, cur_ord_flg
  from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail where ord_stt_flg='success') order_info_tmp
on main2.uid=order_info_tmp.uid and main2.dtl_ord_no=order_info_tmp.dtl_ord_no
where order_info_tmp.crt_tim<date(main2.mdl_dte);
