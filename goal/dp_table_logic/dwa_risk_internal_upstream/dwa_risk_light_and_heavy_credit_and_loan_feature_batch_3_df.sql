-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_light_and_heavy_credit_and_loan_feature_batch_3_df
-- node_id: n_6910171233288716288
-- task_name: dwa_risk_light_rep_ability_new_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_light_and_heavy_credit_and_loan_feature_batch_3_df.json
-- source_json_sha256: 74fd559b41ff157ba6f3142b256a2b612e680c728aee98afebc1d940f2599200
-- upstream_table: dwa_risk.dwa_risk_light_rep_ability_stage_new_tmp1
-- upstream_table: cdmx.etl_cdmx_fct_light_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_f_light_sample_all_base_df
-- upstream_table: dwa_risk.dwa_risk_light_rep_ability_stage_new_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2025-05-16 16:11:32
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_light_rep_ability_new_df
(
    uid STRING comment 'uid',
    mdl_dte STRING comment '打分日',
    stg_pln_sum_prc_amt_1m_adv_light STRING COMMENT '近1个月提前还款的应还本金金额',
    stg_pln_sum_prc_amt_6m_adv_light STRING COMMENT '近6个月提前还款的应还本金金额', 
    stg_pln_sum_prc_amt_12m_adv_light STRING COMMENT '近12个月提前还款的应还本金金额', 
    stg_pln_sum_prc_amt_24m_adv_light STRING COMMENT '近24个月提前还款的应还本金金额', 
    stg_pln_sum_prc_amt_36m_adv_light STRING COMMENT '近36个月提前还款的应还本金金额', 
    stg_pln_sum_prc_amt_his_adv_light STRING COMMENT '历史至今提前还款的应还本金金额', 
    stg_pln_min_prc_amt_1m_adv_light STRING COMMENT '近1个月提前还款的最小应还本金金额', 
    stg_pln_min_prc_amt_6m_adv_light STRING COMMENT '近6个月提前还款的最小应还本金金额', 
    stg_pln_min_prc_amt_12m_adv_light STRING COMMENT '近12个月提前还款的最小应还本金金额', 
    stg_pln_min_prc_amt_24m_adv_light STRING COMMENT '近24个月提前还款的最小应还本金金额', 
    stg_pln_min_prc_amt_36m_adv_light STRING COMMENT '近36个月提前还款的最小应还本金金额', 
    stg_pln_min_prc_amt_his_adv_light STRING COMMENT '历史至今提前还款的最小应还本金金额', 
    stg_pln_max_prc_amt_1m_adv_light STRING COMMENT '近1个月提前还款的最大应还本金金额', 
    stg_pln_max_prc_amt_6m_adv_light STRING COMMENT '近6个月提前还款的最大应还本金金额', 
    stg_pln_max_prc_amt_12m_adv_light STRING COMMENT '近12个月提前还款的最大应还本金金额', 
    stg_pln_max_prc_amt_24m_adv_light STRING COMMENT '近24个月提前还款的最大应还本金金额', 
    stg_pln_max_prc_amt_36m_adv_light STRING COMMENT '近36个月提前还款的最大应还本金金额', 
    stg_pln_max_prc_amt_his_adv_light STRING COMMENT '历史至今提前还款的最大应还本金金额', 
    stg_pln_avg_prc_amt_1m_adv_light STRING COMMENT '近1个月提前还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_6m_adv_light STRING COMMENT '近6个月提前还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_12m_adv_light STRING COMMENT '近12个月提前还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_24m_adv_light STRING COMMENT '近24个月提前还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_36m_adv_light STRING COMMENT '近36个月提前还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_his_adv_light STRING COMMENT '历史至今提前还款的平均应还本金金额', 
    stg_pln_cnt_1m_adv_light STRING COMMENT '近1个月提前还款的应还分期计划数', 
    stg_pln_cnt_6m_adv_light STRING COMMENT '近6个月提前还款的应还分期计划数', 
    stg_pln_cnt_12m_adv_light STRING COMMENT '近12个月提前还款的应还分期计划数', 
    stg_pln_cnt_24m_adv_light STRING COMMENT '近24个月提前还款的应还分期计划数', 
    stg_pln_cnt_36m_adv_light STRING COMMENT '近36个月提前还款的应还分期计划数', 
    stg_pln_cnt_his_adv_light STRING COMMENT '历史至今提前还款的应还分期计划数', 
    stg_pln_sum_prc_amt_1m_on_light STRING COMMENT '近1个月按时还款的应还本金金额', 
    stg_pln_sum_prc_amt_6m_on_light STRING COMMENT '近6个月按时还款的应还本金金额', 
    stg_pln_sum_prc_amt_12m_on_light STRING COMMENT '近12个月按时还款的应还本金金额', 
    stg_pln_sum_prc_amt_24m_on_light STRING COMMENT '近24个月按时还款的应还本金金额', 
    stg_pln_sum_prc_amt_36m_on_light STRING COMMENT '近36个月按时还款的应还本金金额', 
    stg_pln_sum_prc_amt_his_on_light STRING COMMENT '历史至今按时还款的应还本金金额', 
    stg_pln_min_prc_amt_1m_on_light STRING COMMENT '近1个月按时还款的最小应还本金金额', 
    stg_pln_min_prc_amt_6m_on_light STRING COMMENT '近6个月按时还款的最小应还本金金额', 
    stg_pln_min_prc_amt_12m_on_light STRING COMMENT '近12个月按时还款的最小应还本金金额', 
    stg_pln_min_prc_amt_24m_on_light STRING COMMENT '近24个月按时还款的最小应还本金金额', 
    stg_pln_min_prc_amt_36m_on_light STRING COMMENT '近36个月按时还款的最小应还本金金额', 
    stg_pln_min_prc_amt_his_on_light STRING COMMENT '历史至今按时还款的最小应还本金金额', 
    stg_pln_max_prc_amt_1m_on_light STRING COMMENT '近1个月按时还款的最大应还本金金额', 
    stg_pln_max_prc_amt_6m_on_light STRING COMMENT '近6个月按时还款的最大应还本金金额', 
    stg_pln_max_prc_amt_12m_on_light STRING COMMENT '近12个月按时还款的最大应还本金金额', 
    stg_pln_max_prc_amt_24m_on_light STRING COMMENT '近24个月按时还款的最大应还本金金额', 
    stg_pln_max_prc_amt_36m_on_light STRING COMMENT '近36个月按时还款的最大应还本金金额', 
    stg_pln_max_prc_amt_his_on_light STRING COMMENT '历史至今按时还款的最大应还本金金额', 
    stg_pln_avg_prc_amt_1m_on_light STRING COMMENT '近1个月按时还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_6m_on_light STRING COMMENT '近6个月按时还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_12m_on_light STRING COMMENT '近12个月按时还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_24m_on_light STRING COMMENT '近24个月按时还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_36m_on_light STRING COMMENT '近36个月按时还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_his_on_light STRING COMMENT '历史至今按时还款的平均应还本金金额', 
    stg_pln_cnt_1m_on_light STRING COMMENT '近1个月按时还款的应还分期计划数', 
    stg_pln_cnt_6m_on_light STRING COMMENT '近6个月按时还款的应还分期计划数', 
    stg_pln_cnt_12m_on_light STRING COMMENT '近12个月按时还款的应还分期计划数', 
    stg_pln_cnt_24m_on_light STRING COMMENT '近24个月按时还款的应还分期计划数', 
    stg_pln_cnt_36m_on_light STRING COMMENT '近36个月按时还款的应还分期计划数', 
    stg_pln_cnt_his_on_light STRING COMMENT '历史至今按时还款的应还分期计划数', 
    stg_pln_sum_prc_amt_1m_due_light STRING COMMENT '近1个月逾期还款的应还本金金额', 
    stg_pln_sum_prc_amt_6m_due_light STRING COMMENT '近6个月逾期还款的应还本金金额', 
    stg_pln_sum_prc_amt_12m_due_light STRING COMMENT '近12个月逾期还款的应还本金金额', 
    stg_pln_sum_prc_amt_24m_due_light STRING COMMENT '近24个月逾期还款的应还本金金额', 
    stg_pln_sum_prc_amt_36m_due_light STRING COMMENT '近36个月逾期还款的应还本金金额', 
    stg_pln_sum_prc_amt_his_due_light STRING COMMENT '历史至今逾期还款的应还本金金额', 
    stg_pln_min_prc_amt_1m_due_light STRING COMMENT '近1个月逾期还款的最小应还本金金额', 
    stg_pln_min_prc_amt_6m_due_light STRING COMMENT '近6个月逾期还款的最小应还本金金额', 
    stg_pln_min_prc_amt_12m_due_light STRING COMMENT '近12个月逾期还款的最小应还本金金额', 
    stg_pln_min_prc_amt_24m_due_light STRING COMMENT '近24个月逾期还款的最小应还本金金额', 
    stg_pln_min_prc_amt_36m_due_light STRING COMMENT '近36个月逾期还款的最小应还本金金额', 
    stg_pln_min_prc_amt_his_due_light STRING COMMENT '历史至今逾期还款的最小应还本金金额', 
    stg_pln_max_prc_amt_1m_due_light STRING COMMENT '近1个月逾期还款的最大应还本金金额', 
    stg_pln_max_prc_amt_6m_due_light STRING COMMENT '近6个月逾期还款的最大应还本金金额', 
    stg_pln_max_prc_amt_12m_due_light STRING COMMENT '近12个月逾期还款的最大应还本金金额', 
    stg_pln_max_prc_amt_24m_due_light STRING COMMENT '近24个月逾期还款的最大应还本金金额', 
    stg_pln_max_prc_amt_36m_due_light STRING COMMENT '近36个月逾期还款的最大应还本金金额', 
    stg_pln_max_prc_amt_his_due_light STRING COMMENT '历史至今逾期还款的最大应还本金金额', 
    stg_pln_avg_prc_amt_1m_due_light STRING COMMENT '近1个月逾期还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_6m_due_light STRING COMMENT '近6个月逾期还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_12m_due_light STRING COMMENT '近12个月逾期还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_24m_due_light STRING COMMENT '近24个月逾期还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_36m_due_light STRING COMMENT '近36个月逾期还款的平均应还本金金额', 
    stg_pln_avg_prc_amt_his_due_light STRING COMMENT '历史至今逾期还款的平均应还本金金额', 
    stg_pln_cnt_1m_due_light STRING COMMENT '近1个月逾期还款的应还分期计划数', 
    stg_pln_cnt_6m_due_light STRING COMMENT '近6个月逾期还款的应还分期计划数', 
    stg_pln_cnt_12m_due_light STRING COMMENT '近12个月逾期还款的应还分期计划数', 
    stg_pln_cnt_24m_due_light STRING COMMENT '近24个月逾期还款的应还分期计划数', 
    stg_pln_cnt_36m_due_light STRING COMMENT '近36个月逾期还款的应还分期计划数', 
    stg_pln_cnt_his_due_light STRING COMMENT '历史至今逾期还款的应还分期计划数', 
    stg_pln_sum_prc_amt_1m_light STRING COMMENT '近1个月的应还本金金额', 
    stg_pln_sum_prc_amt_6m_light STRING COMMENT '近6个月的应还本金金额', 
    stg_pln_sum_prc_amt_12m_light STRING COMMENT '近12个月的应还本金金额', 
    stg_pln_sum_prc_amt_24m_light STRING COMMENT '近24个月的应还本金金额', 
    stg_pln_sum_prc_amt_36m_light STRING COMMENT '近36个月的应还本金金额', 
    stg_pln_sum_prc_amt_his_light STRING COMMENT '历史至今的应还本金金额', 
    stg_pln_min_prc_amt_1m_light STRING COMMENT '近1个月的最小应还本金金额', 
    stg_pln_min_prc_amt_6m_light STRING COMMENT '近6个月的最小应还本金金额', 
    stg_pln_min_prc_amt_12m_light STRING COMMENT '近12个月的最小应还本金金额', 
    stg_pln_min_prc_amt_24m_light STRING COMMENT '近24个月的最小应还本金金额', 
    stg_pln_min_prc_amt_36m_light STRING COMMENT '近36个月的最小应还本金金额', 
    stg_pln_min_prc_amt_his_light STRING COMMENT '历史至今的最小应还本金金额', 
    stg_pln_max_prc_amt_1m_light STRING COMMENT '近1个月的最大应还本金金额', 
    stg_pln_max_prc_amt_6m_light STRING COMMENT '近6个月的最大应还本金金额', 
    stg_pln_max_prc_amt_12m_light STRING COMMENT '近12个月的最大应还本金金额', 
    stg_pln_max_prc_amt_24m_light STRING COMMENT '近24个月的最大应还本金金额', 
    stg_pln_max_prc_amt_36m_light STRING COMMENT '近36个月的最大应还本金金额', 
    stg_pln_max_prc_amt_his_light STRING COMMENT '历史至今的最大应还本金金额', 
    stg_pln_avg_prc_amt_1m_light STRING COMMENT '近1个月的平均应还本金金额', 
    stg_pln_avg_prc_amt_6m_light STRING COMMENT '近6个月的平均应还本金金额', 
    stg_pln_avg_prc_amt_12m_light STRING COMMENT '近12个月的平均应还本金金额', 
    stg_pln_avg_prc_amt_24m_light STRING COMMENT '近24个月的平均应还本金金额', 
    stg_pln_avg_prc_amt_36m_light STRING COMMENT '近36个月的平均应还本金金额', 
    stg_pln_avg_prc_amt_his_light STRING COMMENT '历史至今的平均应还本金金额', 
    stg_pln_cnt_1m_light STRING COMMENT '近1个月的应还分期计划数', 
    stg_pln_cnt_6m_light STRING COMMENT '近6个月的应还分期计划数', 
    stg_pln_cnt_12m_light STRING COMMENT '近12个月的应还分期计划数', 
    stg_pln_cnt_24m_light STRING COMMENT '近24个月的应还分期计划数', 
    stg_pln_cnt_36m_light STRING COMMENT '近36个月的应还分期计划数', 
    stg_pln_cnt_his_light STRING COMMENT '历史至今的应还分期计划数', 
    stg_pln_sum_rep_prc_1m_due_light STRING COMMENT '近1个月逾期还款的实还本金金额', 
    stg_pln_sum_rep_prc_6m_due_light STRING COMMENT '近6个月逾期还款的实还本金金额', 
    stg_pln_sum_rep_prc_12m_due_light STRING COMMENT '近12个月逾期还款的实还本金金额', 
    stg_pln_sum_rep_prc_24m_due_light STRING COMMENT '近24个月逾期还款的实还本金金额', 
    stg_pln_sum_rep_prc_36m_due_light STRING COMMENT '近36个月逾期还款的实还本金金额', 
    stg_pln_sum_rep_prc_his_due_light STRING COMMENT '历史至今逾期还款的实还本金金额', 
    stg_pln_min_rep_prc_1m_due_light STRING COMMENT '近1个月逾期还款的最小实还本金金额', 
    stg_pln_min_rep_prc_6m_due_light STRING COMMENT '近6个月逾期还款的最小实还本金金额', 
    stg_pln_min_rep_prc_12m_due_light STRING COMMENT '近12个月逾期还款的最小实还本金金额', 
    stg_pln_min_rep_prc_24m_due_light STRING COMMENT '近24个月逾期还款的最小实还本金金额', 
    stg_pln_min_rep_prc_36m_due_light STRING COMMENT '近36个月逾期还款的最小实还本金金额', 
    stg_pln_min_rep_prc_his_due_light STRING COMMENT '历史至今逾期还款的最小实还本金金额', 
    stg_pln_max_rep_prc_1m_due_light STRING COMMENT '近1个月逾期还款的最大实还本金金额', 
    stg_pln_max_rep_prc_6m_due_light STRING COMMENT '近6个月逾期还款的最大实还本金金额', 
    stg_pln_max_rep_prc_12m_due_light STRING COMMENT '近12个月逾期还款的最大实还本金金额', 
    stg_pln_max_rep_prc_24m_due_light STRING COMMENT '近24个月逾期还款的最大实还本金金额', 
    stg_pln_max_rep_prc_36m_due_light STRING COMMENT '近36个月逾期还款的最大实还本金金额', 
    stg_pln_max_rep_prc_his_due_light STRING COMMENT '历史至今逾期还款的最大实还本金金额', 
    stg_pln_avg_rep_prc_1m_due_light STRING COMMENT '近1个月逾期还款的平均实还本金金额', 
    stg_pln_avg_rep_prc_6m_due_light STRING COMMENT '近6个月逾期还款的平均实还本金金额', 
    stg_pln_avg_rep_prc_12m_due_light STRING COMMENT '近12个月逾期还款的平均实还本金金额', 
    stg_pln_avg_rep_prc_24m_due_light STRING COMMENT '近24个月逾期还款的平均实还本金金额', 
    stg_pln_avg_rep_prc_36m_due_light STRING COMMENT '近36个月逾期还款的平均实还本金金额', 
    stg_pln_avg_rep_prc_his_due_light STRING COMMENT '历史至今逾期还款的平均实还本金金额', 
    stg_pln_sum_prc_amt_1m_ftr_light STRING COMMENT '近1个月的未来应还本金金额', 
    stg_pln_sum_prc_amt_6m_ftr_light STRING COMMENT '近6个月的未来应还本金金额', 
    stg_pln_sum_prc_amt_12m_ftr_light STRING COMMENT '近12个月的未来应还本金金额', 
    stg_pln_sum_prc_amt_24m_ftr_light STRING COMMENT '近24个月的未来应还本金金额', 
    stg_pln_sum_prc_amt_36m_ftr_light STRING COMMENT '近36个月的未来应还本金金额', 
    stg_pln_sum_prc_amt_his_ftr_light STRING COMMENT '历史至今的未来应还本金金额', 
    stg_pln_min_prc_amt_1m_ftr_light STRING COMMENT '近1个月的最小未来应还本金金额', 
    stg_pln_min_prc_amt_6m_ftr_light STRING COMMENT '近6个月的最小未来应还本金金额', 
    stg_pln_min_prc_amt_12m_ftr_light STRING COMMENT '近12个月的最小未来应还本金金额', 
    stg_pln_min_prc_amt_24m_ftr_light STRING COMMENT '近24个月的最小未来应还本金金额', 
    stg_pln_min_prc_amt_36m_ftr_light STRING COMMENT '近36个月的最小未来应还本金金额', 
    stg_pln_min_prc_amt_his_ftr_light STRING COMMENT '历史至今的最小未来应还本金金额', 
    stg_pln_max_prc_amt_1m_ftr_light STRING COMMENT '近1个月的最大未来应还本金金额', 
    stg_pln_max_prc_amt_6m_ftr_light STRING COMMENT '近6个月的最大未来应还本金金额', 
    stg_pln_max_prc_amt_12m_ftr_light STRING COMMENT '近12个月的最大未来应还本金金额', 
    stg_pln_max_prc_amt_24m_ftr_light STRING COMMENT '近24个月的最大未来应还本金金额', 
    stg_pln_max_prc_amt_36m_ftr_light STRING COMMENT '近36个月的最大未来应还本金金额', 
    stg_pln_max_prc_amt_his_ftr_light STRING COMMENT '历史至今的最大未来应还本金金额', 
    stg_pln_avg_prc_amt_1m_ftr_light STRING COMMENT '近1个月的平均未来应还本金金额', 
    stg_pln_avg_prc_amt_6m_ftr_light STRING COMMENT '近6个月的平均未来应还本金金额', 
    stg_pln_avg_prc_amt_12m_ftr_light STRING COMMENT '近12个月的平均未来应还本金金额', 
    stg_pln_avg_prc_amt_24m_ftr_light STRING COMMENT '近24个月的平均未来应还本金金额', 
    stg_pln_avg_prc_amt_36m_ftr_light STRING COMMENT '近36个月的平均未来应还本金金额', 
    stg_pln_avg_prc_amt_his_ftr_light STRING COMMENT '历史至今的平均未来应还本金金额', 
    stg_pln_cnt_1m_ftr_light STRING COMMENT '近1个月的未来应还分期计划数', 
    stg_pln_cnt_6m_ftr_light STRING COMMENT '近6个月的未来应还分期计划数', 
    stg_pln_cnt_12m_ftr_light STRING COMMENT '近12个月的未来应还分期计划数', 
    stg_pln_cnt_24m_ftr_light STRING COMMENT '近24个月的未来应还分期计划数', 
    stg_pln_cnt_36m_ftr_light STRING COMMENT '近36个月的未来应还分期计划数', 
    stg_pln_cnt_his_ftr_light STRING COMMENT '历史至今的未来应还分期计划数'

)
PARTITIONED BY (
	ds STRING COMMENT '分区字段格式yyyymmdd'
);





drop table if exists ${dwa_risk}.dwa_risk_light_rep_ability_stage_new_tmp1;
create table ${dwa_risk}.dwa_risk_light_rep_ability_stage_new_tmp1 as 
select 
         main2.uid
        ,main2.mdl_dte
        
        ,main2.crt_tim
        ,main2.due_date
        ,main2.settlement_time
        ,main2.stage_plan_no
        ,main2.actual_pay_principal as rep_prc  --实还金额--
        ,main2.schedule_pay_principal as prc_amt  --应还金额--
        --应还日和评分日的间隔
        ,main2.ddf_mdl_rep_dte
        ,main2.ddf_mdl_rep_tim
        --实还日和应还日的间隔
        ,main2.ddf_rep_tim_dte
        ,main2.ddf_mdl_crt_tim
        
        ,main2.rep_tim_type
       
        -- 应还日和评分日的间隔（月）时间切片的flag
        ,case when ddf_mdl_rep_dte between 1 and 30 then 1 else 0 end as rep_1m_flg
        ,case when ddf_mdl_rep_dte between 1 and 180 then 1 else 0 end as rep_6m_flg
        ,case when ddf_mdl_rep_dte between 1 and 360 then 1 else 0 end as rep_12m_flg
        ,case when ddf_mdl_rep_dte between 1 and 720 then 1 else 0 end as rep_24m_flg
        ,case when ddf_mdl_rep_dte between 1 and 1080 then 1 else 0 end as rep_36m_flg
        ,case when ddf_mdl_rep_dte > 1 then 1 else 0 end as rep_flg

        ,case when ddf_mdl_rep_dte between -30 and 0 then 1 else 0 end as ftr_rep_1m_flg
        ,case when ddf_mdl_rep_dte between -180 and 0 then 1 else 0 end as ftr_rep_6m_flg
        ,case when ddf_mdl_rep_dte between -360 and 0 then 1 else 0 end as ftr_rep_12m_flg
        ,case when ddf_mdl_rep_dte between -720 and 0 then 1 else 0 end as ftr_rep_24m_flg
        ,case when ddf_mdl_rep_dte between -1080 and 0 then 1 else 0 end as ftr_rep_36m_flg
        ,case when ddf_mdl_rep_dte <= 0 then 1 else 0 end as ftr_rep_flg


from 
        (
        select 
                main1.uid
                ,main1.mdl_dte
               
                ,main1.stage_plan_no
                ,main1.crt_tim
                ,main1.actual_pay_principal
                ,main1.schedule_pay_principal
                ,main1.settlement_time
                ,main1.due_date
                
                --应还日和评分日的间隔
                ,main1.ddf_mdl_rep_dte
                --实还日和评分日的间隔
                ,main1.ddf_mdl_rep_tim
                --实还日和应还日的间隔
                ,main1.ddf_rep_tim_dte
                ---订单创建日和评分日的间隔
                ,main1.ddf_mdl_crt_tim

                --打标签--还款时间类型
                ,case   when ddf_rep_tim_dte < 0  then '提前还款' 
                        when ddf_rep_tim_dte = 0 then '按时还款' 
                        when (ddf_rep_tim_dte > 0 or ddf_rep_tim_dte is null) then '逾期还款' 
                        else '其他' 
                        end as rep_tim_type

               

        from
                (
                select 
                        model_data.uid
                        ,model_data.mdl_dte
                       
                        ,repayment.stage_plan_no
                        ,crt_tim
                        ,repayment.actual_pay_principal
                        ,repayment.schedule_pay_principal
                        ,repayment.settlement_time
                        ,repayment.due_date
                        --应还日和评分日的间隔
                        ,datediff(model_data.mdl_dte, due_date) as ddf_mdl_rep_dte
                        --应还日和实还日之间的间隔（天），for判断逾期、提前、按时还款
                        ,datediff(settlement_time, due_date) as ddf_rep_tim_dte
                        --实还日和评分日的间隔
                        ,datediff(model_data.mdl_dte, settlement_time) as ddf_mdl_rep_tim
                        --订单创建日和评分日的间隔
                        ,datediff(model_data.mdl_dte, crt_tim) as ddf_mdl_crt_tim
                        
                        

                from    
                        (
                        select 
                            uid,
                            mdl_dte
                          
                        from  
                            (
                                select   *
                                from    ${dwa_risk}.dwa_risk_f_light_sample_all_base_df
                                where    ds = '${bizdate}' 
                                
                            ) t

                        ) model_data

                        left join
                        
                        ( 
                        select 
                            
                            uid,
                            stage_plan_no,
                            order_no,
                            TO_CHAR(TO_DATE(SUBSTR(order_no, 3, 8), 'yyyyMMdd'), 'yyyy-MM-dd') AS crt_tim,
                            schedule_pay_principal,
                            unpaid_principal,
                            actual_pay_principal,
                            light_loan_stage,
                            stage_status,
                            current_overdue_days,
                            current_overdue_status,
                            is_due,
                            due_date,
                            settlement_time,
                            history_max_overdue_status,
                            history_max_overdue_days

                        from cdmx.etl_cdmx_fct_light_stage_plan_df
                        where ds = '${bizdate}' 
                        ) repayment 
                        on model_data.uid = repayment.uid
                        and repayment.crt_tim < model_data.mdl_dte

                )main1
        )main2
;




------------------【特征计算中间表】--------------------


drop table if exists ${dwa_risk}.dwa_risk_light_rep_ability_stage_new_tmp2
create table  ${dwa_risk}.dwa_risk_light_rep_ability_stage_new_tmp2 as
select  uid
        ,mdl_dte
        
        ----按照不同的还款方式计算应还本金金额
        ----'提前还款'---
        ,sum(case when rep_tim_type='提前还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_adv_light
        ,sum(case when rep_tim_type='提前还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_adv_light
        ,sum(case when rep_tim_type='提前还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_adv_light
        ,sum(case when rep_tim_type='提前还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_24m_adv_light
        ,sum(case when rep_tim_type='提前还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_36m_adv_light
        ,sum(case when rep_tim_type='提前还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_adv_light
 
        ,min(case when rep_tim_type='提前还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_adv_light
        ,min(case when rep_tim_type='提前还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_adv_light
        ,min(case when rep_tim_type='提前还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_adv_light
        ,min(case when rep_tim_type='提前还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_24m_adv_light
        ,min(case when rep_tim_type='提前还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_36m_adv_light
        ,min(case when rep_tim_type='提前还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_his_adv_light

        ,max(case when rep_tim_type='提前还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_adv_light
        ,max(case when rep_tim_type='提前还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_adv_light
        ,max(case when rep_tim_type='提前还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_adv_light
        ,max(case when rep_tim_type='提前还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_24m_adv_light
        ,max(case when rep_tim_type='提前还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_36m_adv_light
        ,max(case when rep_tim_type='提前还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_his_adv_light

        ---单笔平均---
        ,avg(case when rep_tim_type='提前还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_1m_adv_light
        ,avg(case when rep_tim_type='提前还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_6m_adv_light
        ,avg(case when rep_tim_type='提前还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_12m_adv_light
        ,avg(case when rep_tim_type='提前还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_24m_adv_light
        ,avg(case when rep_tim_type='提前还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_36m_adv_light
        ,avg(case when rep_tim_type='提前还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_his_adv_light
    
        ---分期计划数---
        ,count(case when rep_tim_type='提前还款' and rep_1m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_1m_adv_light
        ,count(case when rep_tim_type='提前还款' and rep_6m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_6m_adv_light
        ,count(case when rep_tim_type='提前还款' and rep_12m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_12m_adv_light
        ,count(case when rep_tim_type='提前还款' and rep_24m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_24m_adv_light
        ,count(case when rep_tim_type='提前还款' and rep_36m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_36m_adv_light
        ,count(case when rep_tim_type='提前还款' and rep_flg=1 then stage_plan_no else null end) as stg_pln_cnt_his_adv_light


        ----按时还款----
        ,sum(case when rep_tim_type='按时还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_on_light
        ,sum(case when rep_tim_type='按时还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_on_light
        ,sum(case when rep_tim_type='按时还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_on_light
        ,sum(case when rep_tim_type='按时还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_24m_on_light
        ,sum(case when rep_tim_type='按时还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_36m_on_light
        ,sum(case when rep_tim_type='按时还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_on_light
        
        ,min(case when rep_tim_type='按时还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_on_light
        ,min(case when rep_tim_type='按时还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_on_light
        ,min(case when rep_tim_type='按时还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_on_light
        ,min(case when rep_tim_type='按时还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_24m_on_light
        ,min(case when rep_tim_type='按时还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_36m_on_light
        ,min(case when rep_tim_type='按时还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_his_on_light
        
        ,max(case when rep_tim_type='按时还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_on_light
        ,max(case when rep_tim_type='按时还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_on_light
        ,max(case when rep_tim_type='按时还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_on_light
        ,max(case when rep_tim_type='按时还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_24m_on_light
        ,max(case when rep_tim_type='按时还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_36m_on_light
        ,max(case when rep_tim_type='按时还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_his_on_light
        
        ,avg(case when rep_tim_type='按时还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_1m_on_light
        ,avg(case when rep_tim_type='按时还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_6m_on_light
        ,avg(case when rep_tim_type='按时还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_12m_on_light
        ,avg(case when rep_tim_type='按时还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_24m_on_light
        ,avg(case when rep_tim_type='按时还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_36m_on_light
        ,avg(case when rep_tim_type='按时还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_his_on_light

        ,count(case when rep_tim_type='按时还款' and rep_1m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_1m_on_light
        ,count(case when rep_tim_type='按时还款' and rep_6m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_6m_on_light
        ,count(case when rep_tim_type='按时还款' and rep_12m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_12m_on_light
        ,count(case when rep_tim_type='按时还款' and rep_24m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_24m_on_light
        ,count(case when rep_tim_type='按时还款' and rep_36m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_36m_on_light
        ,count(case when rep_tim_type='按时还款' and rep_flg=1 then stage_plan_no else null end) as stg_pln_cnt_his_on_light
        
        
        
        ---逾期还款---
        ,sum(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_24m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_36m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_due_light
        
        ,min(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_24m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_36m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_his_due_light
        
        ,max(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_24m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_36m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_his_due_light
        
        ,avg(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_1m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_6m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_12m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_24m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_36m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_his_due_light

        ,count(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_1m_due_light
        ,count(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_6m_due_light
        ,count(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_12m_due_light
        ,count(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_24m_due_light
        ,count(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_36m_due_light
        ,count(case when rep_tim_type='逾期还款' and rep_flg=1 then stage_plan_no else null end) as stg_pln_cnt_his_due_light


--/*应还本金金额|分期计划数(不分是否逾期)*/
        ,sum(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_light
        ,sum(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_light
        ,sum(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_light
        ,sum(case when rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_24m_light
        ,sum(case when rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_36m_light
        ,sum(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_light

        ,min(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_light
        ,min(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_light
        ,min(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_light
        ,min(case when rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_24m_light
        ,min(case when rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_36m_light
        ,min(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_his_light

        ,max(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_light
        ,max(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_light
        ,max(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_light
        ,max(case when rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_24m_light
        ,max(case when rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_36m_light
        ,max(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_his_light

        ,avg(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_1m_light
        ,avg(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_6m_light
        ,avg(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_12m_light
        ,avg(case when rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_24m_light
        ,avg(case when rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_36m_light
        ,avg(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_his_light

        ,count(case when rep_1m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_1m_light
        ,count(case when rep_6m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_6m_light
        ,count(case when rep_12m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_12m_light
        ,count(case when rep_24m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_24m_light
        ,count(case when rep_36m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_36m_light
        ,count(case when rep_flg=1 then stage_plan_no else null end) as stg_pln_cnt_his_light



--/实还本金金额(逾期样本)/因为不逾期的实还和应还是一样的
        ,sum(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_24m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_36m_due_light
        ,sum(case when rep_tim_type='逾期还款' and rep_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_due_light
        
        ,min(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_1m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_6m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_12m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_24m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_36m_due_light
        ,min(case when rep_tim_type='逾期还款' and rep_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_his_due_light
        
        ,max(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_1m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_6m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_12m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_24m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_36m_due_light
        ,max(case when rep_tim_type='逾期还款' and rep_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_his_due_light
        
        ,avg(case when rep_tim_type='逾期还款' and rep_1m_flg=1 then rep_prc else 0 end) as stg_pln_avg_rep_prc_1m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_6m_flg=1 then rep_prc else 0 end) as stg_pln_avg_rep_prc_6m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_12m_flg=1 then rep_prc else 0 end) as stg_pln_avg_rep_prc_12m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_24m_flg=1 then rep_prc else 0 end) as stg_pln_avg_rep_prc_24m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_36m_flg=1 then rep_prc else 0 end) as stg_pln_avg_rep_prc_36m_due_light
        ,avg(case when rep_tim_type='逾期还款' and rep_flg=1 then rep_prc else 0 end) as stg_pln_avg_rep_prc_his_due_light


-------未来应还------ 
        ,sum(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_light
        ,sum(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_light
        ,sum(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_light
        ,sum(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_24m_ftr_light
        ,sum(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_36m_ftr_light
        ,sum(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_ftr_light
        
        ,min(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_ftr_light
        ,min(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_ftr_light
        ,min(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_ftr_light
        ,min(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_24m_ftr_light
        ,min(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_36m_ftr_light
        ,min(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_his_ftr_light
        
        ,max(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_ftr_light
        ,max(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_ftr_light
        ,max(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_ftr_light
        ,max(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_24m_ftr_light
        ,max(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_36m_ftr_light
        ,max(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_his_ftr_light
        
        ,avg(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_1m_ftr_light
        ,avg(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_6m_ftr_light
        ,avg(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_12m_ftr_light
        ,avg(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_24m_ftr_light
        ,avg(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_36m_ftr_light
        ,avg(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_flg=1 then prc_amt else 0 end) as stg_pln_avg_prc_amt_his_ftr_light
        
        ,count(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_1m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_1m_ftr_light
        ,count(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_6m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_6m_ftr_light
        ,count(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_12m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_12m_ftr_light
        ,count(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_24m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_24m_ftr_light
        ,count(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_36m_flg=1 then stage_plan_no else null end) as stg_pln_cnt_36m_ftr_light
        ,count(case when (ddf_mdl_rep_tim < 0 or ddf_mdl_rep_tim is null) and ddf_mdl_crt_tim > 0 and ftr_rep_flg=1 then stage_plan_no else null end) as stg_pln_cnt_his_ftr_light


from  ${dwa_risk}.dwa_risk_light_rep_ability_stage_new_tmp1
group by uid, mdl_dte
;





------------------【特征计算结果表】--------------------
insert overwrite table ${dwa_risk}.dwa_risk_light_rep_ability_new_df partition(ds='${bizdate}')

select 
        model_data.uid,
        model_data.mdl_dte,
        
        stg_pln_sum_prc_amt_1m_adv_light,
        stg_pln_sum_prc_amt_6m_adv_light,
        stg_pln_sum_prc_amt_12m_adv_light,
        stg_pln_sum_prc_amt_24m_adv_light,
        stg_pln_sum_prc_amt_36m_adv_light,
        stg_pln_sum_prc_amt_his_adv_light,
        stg_pln_min_prc_amt_1m_adv_light,
        stg_pln_min_prc_amt_6m_adv_light,
        stg_pln_min_prc_amt_12m_adv_light,
        stg_pln_min_prc_amt_24m_adv_light,
        stg_pln_min_prc_amt_36m_adv_light,
        stg_pln_min_prc_amt_his_adv_light,
        stg_pln_max_prc_amt_1m_adv_light,
        stg_pln_max_prc_amt_6m_adv_light,
        stg_pln_max_prc_amt_12m_adv_light,
        stg_pln_max_prc_amt_24m_adv_light,
        stg_pln_max_prc_amt_36m_adv_light,
        stg_pln_max_prc_amt_his_adv_light,
        stg_pln_avg_prc_amt_1m_adv_light,
        stg_pln_avg_prc_amt_6m_adv_light,
        stg_pln_avg_prc_amt_12m_adv_light,
        stg_pln_avg_prc_amt_24m_adv_light,
        stg_pln_avg_prc_amt_36m_adv_light,
        stg_pln_avg_prc_amt_his_adv_light,
        stg_pln_cnt_1m_adv_light,
        stg_pln_cnt_6m_adv_light,
        stg_pln_cnt_12m_adv_light,
        stg_pln_cnt_24m_adv_light,
        stg_pln_cnt_36m_adv_light,
        stg_pln_cnt_his_adv_light,
        stg_pln_sum_prc_amt_1m_on_light,
        stg_pln_sum_prc_amt_6m_on_light,
        stg_pln_sum_prc_amt_12m_on_light,
        stg_pln_sum_prc_amt_24m_on_light,
        stg_pln_sum_prc_amt_36m_on_light,
        stg_pln_sum_prc_amt_his_on_light,
        stg_pln_min_prc_amt_1m_on_light,
        stg_pln_min_prc_amt_6m_on_light,
        stg_pln_min_prc_amt_12m_on_light,
        stg_pln_min_prc_amt_24m_on_light,
        stg_pln_min_prc_amt_36m_on_light,
        stg_pln_min_prc_amt_his_on_light,
        stg_pln_max_prc_amt_1m_on_light,
        stg_pln_max_prc_amt_6m_on_light,
        stg_pln_max_prc_amt_12m_on_light,
        stg_pln_max_prc_amt_24m_on_light,
        stg_pln_max_prc_amt_36m_on_light,
        stg_pln_max_prc_amt_his_on_light,
        stg_pln_avg_prc_amt_1m_on_light,
        stg_pln_avg_prc_amt_6m_on_light,
        stg_pln_avg_prc_amt_12m_on_light,
        stg_pln_avg_prc_amt_24m_on_light,
        stg_pln_avg_prc_amt_36m_on_light,
        stg_pln_avg_prc_amt_his_on_light,
        stg_pln_cnt_1m_on_light,
        stg_pln_cnt_6m_on_light,
        stg_pln_cnt_12m_on_light,
        stg_pln_cnt_24m_on_light,
        stg_pln_cnt_36m_on_light,
        stg_pln_cnt_his_on_light,
        stg_pln_sum_prc_amt_1m_due_light,
        stg_pln_sum_prc_amt_6m_due_light,
        stg_pln_sum_prc_amt_12m_due_light,
        stg_pln_sum_prc_amt_24m_due_light,
        stg_pln_sum_prc_amt_36m_due_light,
        stg_pln_sum_prc_amt_his_due_light,
        stg_pln_min_prc_amt_1m_due_light,
        stg_pln_min_prc_amt_6m_due_light,
        stg_pln_min_prc_amt_12m_due_light,
        stg_pln_min_prc_amt_24m_due_light,
        stg_pln_min_prc_amt_36m_due_light,
        stg_pln_min_prc_amt_his_due_light,
        stg_pln_max_prc_amt_1m_due_light,
        stg_pln_max_prc_amt_6m_due_light,
        stg_pln_max_prc_amt_12m_due_light,
        stg_pln_max_prc_amt_24m_due_light,
        stg_pln_max_prc_amt_36m_due_light,
        stg_pln_max_prc_amt_his_due_light,
        stg_pln_avg_prc_amt_1m_due_light,
        stg_pln_avg_prc_amt_6m_due_light,
        stg_pln_avg_prc_amt_12m_due_light,
        stg_pln_avg_prc_amt_24m_due_light,
        stg_pln_avg_prc_amt_36m_due_light,
        stg_pln_avg_prc_amt_his_due_light,
        stg_pln_cnt_1m_due_light,
        stg_pln_cnt_6m_due_light,
        stg_pln_cnt_12m_due_light,
        stg_pln_cnt_24m_due_light,
        stg_pln_cnt_36m_due_light,
        stg_pln_cnt_his_due_light,
        stg_pln_sum_prc_amt_1m_light,
        stg_pln_sum_prc_amt_6m_light,
        stg_pln_sum_prc_amt_12m_light,
        stg_pln_sum_prc_amt_24m_light,
        stg_pln_sum_prc_amt_36m_light,
        stg_pln_sum_prc_amt_his_light,
        stg_pln_min_prc_amt_1m_light,
        stg_pln_min_prc_amt_6m_light,
        stg_pln_min_prc_amt_12m_light,
        stg_pln_min_prc_amt_24m_light,
        stg_pln_min_prc_amt_36m_light,
        stg_pln_min_prc_amt_his_light,
        stg_pln_max_prc_amt_1m_light,
        stg_pln_max_prc_amt_6m_light,
        stg_pln_max_prc_amt_12m_light,
        stg_pln_max_prc_amt_24m_light,
        stg_pln_max_prc_amt_36m_light,
        stg_pln_max_prc_amt_his_light,
        stg_pln_avg_prc_amt_1m_light,
        stg_pln_avg_prc_amt_6m_light,
        stg_pln_avg_prc_amt_12m_light,
        stg_pln_avg_prc_amt_24m_light,
        stg_pln_avg_prc_amt_36m_light,
        stg_pln_avg_prc_amt_his_light,
        stg_pln_cnt_1m_light,
        stg_pln_cnt_6m_light,
        stg_pln_cnt_12m_light,
        stg_pln_cnt_24m_light,
        stg_pln_cnt_36m_light,
        stg_pln_cnt_his_light,
        stg_pln_sum_rep_prc_1m_due_light,
        stg_pln_sum_rep_prc_6m_due_light,
        stg_pln_sum_rep_prc_12m_due_light,
        stg_pln_sum_rep_prc_24m_due_light,
        stg_pln_sum_rep_prc_36m_due_light,
        stg_pln_sum_rep_prc_his_due_light,
        stg_pln_min_rep_prc_1m_due_light,
        stg_pln_min_rep_prc_6m_due_light,
        stg_pln_min_rep_prc_12m_due_light,
        stg_pln_min_rep_prc_24m_due_light,
        stg_pln_min_rep_prc_36m_due_light,
        stg_pln_min_rep_prc_his_due_light,
        stg_pln_max_rep_prc_1m_due_light,
        stg_pln_max_rep_prc_6m_due_light,
        stg_pln_max_rep_prc_12m_due_light,
        stg_pln_max_rep_prc_24m_due_light,
        stg_pln_max_rep_prc_36m_due_light,
        stg_pln_max_rep_prc_his_due_light,
        stg_pln_avg_rep_prc_1m_due_light,
        stg_pln_avg_rep_prc_6m_due_light,
        stg_pln_avg_rep_prc_12m_due_light,
        stg_pln_avg_rep_prc_24m_due_light,
        stg_pln_avg_rep_prc_36m_due_light,
        stg_pln_avg_rep_prc_his_due_light,
        stg_pln_sum_prc_amt_1m_ftr_light,
        stg_pln_sum_prc_amt_6m_ftr_light,
        stg_pln_sum_prc_amt_12m_ftr_light,
        stg_pln_sum_prc_amt_24m_ftr_light,
        stg_pln_sum_prc_amt_36m_ftr_light,
        stg_pln_sum_prc_amt_his_ftr_light,
        stg_pln_min_prc_amt_1m_ftr_light,
        stg_pln_min_prc_amt_6m_ftr_light,
        stg_pln_min_prc_amt_12m_ftr_light,
        stg_pln_min_prc_amt_24m_ftr_light,
        stg_pln_min_prc_amt_36m_ftr_light,
        stg_pln_min_prc_amt_his_ftr_light,
        stg_pln_max_prc_amt_1m_ftr_light,
        stg_pln_max_prc_amt_6m_ftr_light,
        stg_pln_max_prc_amt_12m_ftr_light,
        stg_pln_max_prc_amt_24m_ftr_light,
        stg_pln_max_prc_amt_36m_ftr_light,
        stg_pln_max_prc_amt_his_ftr_light,
        stg_pln_avg_prc_amt_1m_ftr_light,
        stg_pln_avg_prc_amt_6m_ftr_light,
        stg_pln_avg_prc_amt_12m_ftr_light,
        stg_pln_avg_prc_amt_24m_ftr_light,
        stg_pln_avg_prc_amt_36m_ftr_light,
        stg_pln_avg_prc_amt_his_ftr_light,
        stg_pln_cnt_1m_ftr_light,
        stg_pln_cnt_6m_ftr_light,
        stg_pln_cnt_12m_ftr_light,
        stg_pln_cnt_24m_ftr_light,  
        stg_pln_cnt_36m_ftr_light,
        stg_pln_cnt_his_ftr_light

from 
(
    select
        uid,
        mdl_dte
        
    from  
    (
        select   *
        from    ${dwa_risk}.dwa_risk_f_light_sample_all_base_df
        where    ds = '${bizdate}' 
            
        
    ) t

) model_data

left join 

(
    SELECT * from
    ${dwa_risk}.dwa_risk_light_rep_ability_stage_new_tmp2
) repayment 

on model_data.uid = repayment.uid
and model_data.mdl_dte = repayment.mdl_dte
-- feature-copilot:node-end ordinal=0
