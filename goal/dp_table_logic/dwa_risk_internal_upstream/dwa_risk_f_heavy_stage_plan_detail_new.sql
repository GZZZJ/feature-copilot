-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_stage_plan_detail_new
-- node_id: n_6398806001755881472
-- task_name: dwa_risk_f_heavy_stage_plan_detail_new
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_f_heavy_stage_plan_detail_new.json
-- source_json_sha256: ef64ad7347591e3ee8dd40e11a98197c6f876e026c2e25a92f399fb3e8628656
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_detail_new
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_df

CREATE TABLE if not EXISTS ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_new(
	`uid` STRING COMMENT '用户id',
	`mdl_dte` STRING COMMENT '模型日期',
	`dtl_ord_no` STRING COMMENT '订单号',
	`dtl_stg_pln_no` STRING COMMENT '分期计划号码',
	`dtl_rep_dte` DATE COMMENT '应还日',
	`rep_tim` DATE COMMENT '还款时间',
	`prc_amt` DECIMAL(18, 6) COMMENT '实际应收本金',
	`stg_stt` STRING COMMENT '分期计划状态:U-未到期、O-已逾期、C-已代偿、S-已还款、X-未到期还款、A-退货结清、R-已退汇、E-已售',
	`stg_no` INT COMMENT '期数',
	`ddf_rep_tim_dte` INT COMMENT '应还日和实还日的间隔',
	`ddf_mdl_rep_tim` INT COMMENT '实还日和评分日的间隔',
	`ddf_mdl_rep_dte` INT COMMENT '应还日和评分日的间隔',
	`is_his_rep_rpm_stg_pln` INT COMMENT '历史应还分期计划或历史已还分期计划',
	`is_his_rep_stg_pln` INT COMMENT '历史应还分期计划',
	`is_ftr_rep_stg_pln` INT COMMENT '评分日当天和之后未到期分期计划',
	`is_ovd_future_repay_stg_pln` INT COMMENT '截止到评分日之前已到期未还分期计划',
	`adv_rep_flg` INT COMMENT '是否提前还款',
	`ovd_rep_flg` INT COMMENT '是否逾期还款',
	`d0_rep_flg` INT COMMENT '是否还款日当天按时还款',
	-- 历史/未来时间切片flag (3d/7d/1m/2m/3m/6m/12m/24m/36m)
	-- 逾期/提前还款时间切片flag
	`prc_amt_pday` DECIMAL(28, 6) COMMENT '单日还请金额',
	`per_rep_mth_flg` INT COMMENT '还清日-单月flag',
	`fst_ord_flg` INT COMMENT '首借订单',
	`cur_ord_flg` INT COMMENT '当前订单'
)
COMMENT '风险重资产还款计划明细表新'
PARTITIONED BY (ds STRING COMMENT '分区字段格式yyyymmdd');

INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_new partition(ds='${bizdate}') 
select main2.uid, main2.mdl_dte, main2.dtl_ord_no, ..., order_info_tmp.fst_ord_flg, order_info_tmp.cur_ord_flg
from (
  select main1.*, 
    case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte) else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte,
    datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim, datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte
  from (
    select model_data.uid, model_data.mdl_dte, plan.*
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base_df model_data
    left join (select uid, ord_no, stg_pln_no, rep_dte, rep_tim, prc_amt, stg_stt, stg_no
      from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic where bsy_typ in ('BALANCE_TRANSFER','CASH') and stg_stt <> 'R') plan
    on model_data.uid=plan.uid) main1) main2
left join ${dwa_risk}.dwa_risk_f_heavy_order_info_detail_new order_info_tmp
on main2.uid=order_info_tmp.uid and main2.dtl_ord_no=order_info_tmp.dtl_ord_no
where order_info_tmp.crt_tim<date(main2.mdl_dte);
-- 详细SQL包含60+个case when时间切片flag的计算逻辑
-- feature-copilot:node-end ordinal=0
