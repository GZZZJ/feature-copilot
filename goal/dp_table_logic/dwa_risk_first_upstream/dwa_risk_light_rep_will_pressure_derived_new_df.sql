-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_light_rep_will_pressure_derived_new_df
-- node_id: n_6910415805906419712
-- task_name: dwa_risk_light_rep_will_pressure_derived_new_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_light_rep_will_pressure_derived_new_df.json
-- source_json_sha256: f0c9fc9df38f1144c4a92082e0176f80d02f4ce51997866b96e4ae6913d48ceb
-- upstream_table: dwa_risk.dwa_risk_light_rep_ability_new_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2025-05-16 18:21:25
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_light_rep_will_pressure_derived_new_df
(
    uid STRING comment 'uid',
    mdl_dte STRING comment '打分日',
    stg_pln_sum_prc_amt_1m_6m_rto_light STRING COMMENT '近1个月的应还本金金额/近6个月的应还本金金额',
    stg_pln_sum_prc_amt_6m_12m_rto_light STRING COMMENT '近6个月的应还本金金额/近12个月的应还本金金额',
    stg_pln_sum_prc_amt_12m_24m_rto_light STRING COMMENT '近12个月的应还本金金额/近24个月的应还本金金额',
    stg_pln_sum_prc_amt_24m_36m_rto_light STRING COMMENT '近24个月的应还本金金额/近36个月的应还本金金额',
    stg_pln_sum_prc_amt_36m_his_rto_light STRING COMMENT '近36个月的应还本金金额/历史至今的应还本金金额',
    stg_pln_cnt_1m_6m_rto_light STRING COMMENT '近1个月的应还分期计划数/近6个月的应还分期计划数',
    stg_pln_cnt_6m_12m_rto_light STRING COMMENT '近6个月的应还分期计划数/近12个月的应还分期计划数',
    stg_pln_cnt_12m_24m_rto_light STRING COMMENT '近12个月的应还分期计划数/近24个月的应还分期计划数',
    stg_pln_cnt_24m_36m_rto_light STRING COMMENT '近24个月的应还分期计划数/近36个月的应还分期计划数',
    stg_pln_cnt_36m_his_rto_light STRING COMMENT '近36个月的应还分期计划数/历史至今的应还分期计划数',
    stg_pln_sum_prc_amt_adv_1m_rto_light STRING COMMENT '近1个月提前还款的应还本金金额/近1个月的应还本金金额',
    stg_pln_sum_prc_amt_adv_6m_rto_light STRING COMMENT '近6个月提前还款的应还本金金额/近6个月的应还本金金额',
    stg_pln_sum_prc_amt_adv_12m_rto_light STRING COMMENT '近12个月提前还款的应还本金金额/近12个月的应还本金金额',
    stg_pln_sum_prc_amt_adv_24m_rto_light STRING COMMENT '近24个月提前还款的应还本金金额/近24个月的应还本金金额',
    stg_pln_sum_prc_amt_adv_36m_rto_light STRING COMMENT '近36个月提前还款的应还本金金额/近36个月的应还本金金额',
    stg_pln_sum_prc_amt_adv_his_rto_light STRING COMMENT '历史至今提前还款的应还本金金额/历史至今的应还本金金额',
    stg_pln_cnt_adv_1m_rto_light STRING COMMENT '近1个月提前还款的应还分期计划数/近1个月的应还分期计划数',
    stg_pln_cnt_adv_6m_rto_light STRING COMMENT '近6个月提前还款的应还分期计划数/近6个月的应还分期计划数',
    stg_pln_cnt_adv_12m_rto_light STRING COMMENT '近12个月提前还款的应还分期计划数/近12个月的应还分期计划数',
    stg_pln_cnt_adv_24m_rto_light STRING COMMENT '近24个月提前还款的应还分期计划数/近24个月的应还分期计划数',
    stg_pln_cnt_adv_36m_rto_light STRING COMMENT '近36个月提前还款的应还分期计划数/近36个月的应还分期计划数',
    stg_pln_cnt_adv_his_rto_light STRING COMMENT '历史至今提前还款的应还分期计划数/历史至今的应还分期计划数',
    stg_pln_sum_prc_amt_on_1m_rto_light STRING COMMENT '近1个月按时还款的应还本金金额/近1个月的应还本金金额',
    stg_pln_sum_prc_amt_on_6m_rto_light STRING COMMENT '近6个月按时还款的应还本金金额/近6个月的应还本金金额',
    stg_pln_sum_prc_amt_on_12m_rto_light STRING COMMENT '近12个月按时还款的应还本金金额/近12个月的应还本金金额',
    stg_pln_sum_prc_amt_on_24m_rto_light STRING COMMENT '近24个月按时还款的应还本金金额/近24个月的应还本金金额',
    stg_pln_sum_prc_amt_on_36m_rto_light STRING COMMENT '近36个月按时还款的应还本金金额/近36个月的应还本金金额',
    stg_pln_sum_prc_amt_on_his_rto_light STRING COMMENT '历史至今按时还款的应还本金金额/历史至今的应还本金金额',
    stg_pln_cnt_on_1m_rto_light STRING COMMENT '近1个月按时还款的应还分期计划数/近1个月的应还分期计划数',
    stg_pln_cnt_on_6m_rto_light STRING COMMENT '近6个月按时还款的应还分期计划数/近6个月的应还分期计划数',
    stg_pln_cnt_on_12m_rto_light STRING COMMENT '近12个月按时还款的应还分期计划数/近12个月的应还分期计划数',
    stg_pln_cnt_on_24m_rto_light STRING COMMENT '近24个月按时还款的应还分期计划数/近24个月的应还分期计划数',
    stg_pln_cnt_on_36m_rto_light STRING COMMENT '近36个月按时还款的应还分期计划数/近36个月的应还分期计划数',
    stg_pln_cnt_on_his_rto_light STRING COMMENT '历史至今按时还款的应还分期计划数/历史至今的应还分期计划数',
    stg_pln_sum_prc_amt_due_1m_rto_light STRING COMMENT '近1个月逾期还款的应还本金金额/近1个月的应还本金金额',
    stg_pln_sum_prc_amt_due_6m_rto_light STRING COMMENT '近6个月逾期还款的应还本金金额/近6个月的应还本金金额',
    stg_pln_sum_prc_amt_due_12m_rto_light STRING COMMENT '近12个月逾期还款的应还本金金额/近12个月的应还本金金额',
    stg_pln_sum_prc_amt_due_24m_rto_light STRING COMMENT '近24个月逾期还款的应还本金金额/近24个月的应还本金金额',
    stg_pln_sum_prc_amt_due_36m_rto_light STRING COMMENT '近36个月逾期还款的应还本金金额/近36个月的应还本金金额',
    stg_pln_sum_prc_amt_due_his_rto_light STRING COMMENT '历史至今逾期还款的应还本金金额/历史至今的应还本金金额',
    stg_pln_cnt_due_1m_rto_light STRING COMMENT '近1个月逾期还款的应还分期计划数/近1个月的应还分期计划数',
    stg_pln_cnt_due_6m_rto_light STRING COMMENT '近6个月逾期还款的应还分期计划数/近6个月的应还分期计划数',
    stg_pln_cnt_due_12m_rto_light STRING COMMENT '近12个月逾期还款的应还分期计划数/近12个月的应还分期计划数',
    stg_pln_cnt_due_24m_rto_light STRING COMMENT '近24个月逾期还款的应还分期计划数/近24个月的应还分期计划数',
    stg_pln_cnt_due_36m_rto_light STRING COMMENT '近36个月逾期还款的应还分期计划数/近36个月的应还分期计划数',
    stg_pln_cnt_due_his_rto_light STRING COMMENT '历史至今逾期还款的应还分期计划数/历史至今的应还分期计划数',
    stg_pln_sum_prc_amt_adv_1m_rto_his_light STRING COMMENT '近1个月提前还款的应还本金金额/历史至今提前还款的应还本金金额',
    stg_pln_sum_prc_amt_adv_6m_rto_his_light STRING COMMENT '近6个月提前还款的应还本金金额/历史至今提前还款的应还本金金额',
    stg_pln_sum_prc_amt_adv_12m_rto_his_light STRING COMMENT '近12个月提前还款的应还本金金额/历史至今提前还款的应还本金金额',
    stg_pln_sum_prc_amt_adv_24m_rto_his_light STRING COMMENT '近24个月提前还款的应还本金金额/历史至今提前还款的应还本金金额',
    stg_pln_sum_prc_amt_adv_36m_rto_his_light STRING COMMENT '近36个月提前还款的应还本金金额/历史至今提前还款的应还本金金额',
    stg_pln_cnt_adv_1m_rto_his_light STRING COMMENT '近1个月提前还款的应还分期计划数/历史至今提前还款的应还分期计划数',
    stg_pln_cnt_adv_6m_rto_his_light STRING COMMENT '近6个月提前还款的应还分期计划数/历史至今提前还款的应还分期计划数',
    stg_pln_cnt_adv_12m_rto_his_light STRING COMMENT '近12个月提前还款的应还分期计划数/历史至今提前还款的应还分期计划数',
    stg_pln_cnt_adv_24m_rto_his_light STRING COMMENT '近24个月提前还款的应还分期计划数/历史至今提前还款的应还分期计划数',
    stg_pln_cnt_adv_36m_rto_his_light STRING COMMENT '近36个月提前还款的应还分期计划数/历史至今提前还款的应还分期计划数',
    stg_pln_sum_prc_amt_on_1m_rto_his_light STRING COMMENT '近1个月按时还款的应还本金金额/历史至今按时还款的应还本金金额',
    stg_pln_sum_prc_amt_on_6m_rto_his_light STRING COMMENT '近6个月按时还款的应还本金金额/历史至今按时还款的应还本金金额',
    stg_pln_sum_prc_amt_on_12m_rto_his_light STRING COMMENT '近12个月按时还款的应还本金金额/历史至今按时还款的应还本金金额',
    stg_pln_sum_prc_amt_on_24m_rto_his_light STRING COMMENT '近24个月按时还款的应还本金金额/历史至今按时还款的应还本金金额',
    stg_pln_sum_prc_amt_on_36m_rto_his_light STRING COMMENT '近36个月按时还款的应还本金金额/历史至今按时还款的应还本金金额',
    stg_pln_cnt_on_1m_rto_his_light STRING COMMENT '近1个月按时还款的应还分期计划数/历史至今按时还款的应还分期计划数',
    stg_pln_cnt_on_6m_rto_his_light STRING COMMENT '近6个月按时还款的应还分期计划数/历史至今按时还款的应还分期计划数',
    stg_pln_cnt_on_12m_rto_his_light STRING COMMENT '近12个月按时还款的应还分期计划数/历史至今按时还款的应还分期计划数',
    stg_pln_cnt_on_24m_rto_his_light STRING COMMENT '近24个月按时还款的应还分期计划数/历史至今按时还款的应还分期计划数',
    stg_pln_cnt_on_36m_rto_his_light STRING COMMENT '近36个月按时还款的应还分期计划数/历史至今按时还款的应还分期计划数',
    stg_pln_sum_prc_amt_due_1m_rto_his_light STRING COMMENT '近1个月逾期还款的应还本金金额/历史至今逾期还款的应还本金金额',
    stg_pln_sum_prc_amt_due_6m_rto_his_light STRING COMMENT '近6个月逾期还款的应还本金金额/历史至今逾期还款的应还本金金额',
    stg_pln_sum_prc_amt_due_12m_rto_his_light STRING COMMENT '近12个月逾期还款的应还本金金额/历史至今逾期还款的应还本金金额',
    stg_pln_sum_prc_amt_due_24m_rto_his_light STRING COMMENT '近24个月逾期还款的应还本金金额/历史至今逾期还款的应还本金金额',
    stg_pln_sum_prc_amt_due_36m_rto_his_light STRING COMMENT '近36个月逾期还款的应还本金金额/历史至今逾期还款的应还本金金额',
    stg_pln_cnt_due_1m_rto_his_light STRING COMMENT '近1个月逾期还款的应还分期计划数/历史至今逾期还款的应还分期计划数',
    stg_pln_cnt_due_6m_rto_his_light STRING COMMENT '近6个月逾期还款的应还分期计划数/历史至今逾期还款的应还分期计划数',
    stg_pln_cnt_due_12m_rto_his_light STRING COMMENT '近12个月逾期还款的应还分期计划数/历史至今逾期还款的应还分期计划数',
    stg_pln_cnt_due_24m_rto_his_light STRING COMMENT '近24个月逾期还款的应还分期计划数/历史至今逾期还款的应还分期计划数',
    stg_pln_cnt_due_36m_rto_his_light STRING COMMENT '近36个月逾期还款的应还分期计划数/历史至今逾期还款的应还分期计划数',
    stg_pln_avg_prc_amt_6m_per_mth_light STRING COMMENT '近6个月的单月平均应还金额',
    stg_pln_avg_prc_amt_12m_per_mth_light STRING COMMENT '近12个月的单月平均应还金额',
    stg_pln_avg_prc_amt_24m_per_mth_light STRING COMMENT '近24个月的单月平均应还金额',
    stg_pln_avg_prc_amt_36m_per_mth_light STRING COMMENT '近36个月的单月平均应还金额',
    stg_pln_sum_prc_amt_1m_6m_diff_rto_light STRING COMMENT '近1个月应还本金金额/(近6个月应还本金金额-近1个月应还本金金额）',
    stg_pln_sum_prc_amt_6m_12m_diff_rto_light STRING COMMENT '近6个月应还本金金额/(近12个月应还本金金额-近6个月应还本金金额）',
    stg_pln_sum_prc_amt_12m_24m_diff_rto_light STRING COMMENT '近12个月应还本金金额/(近24个月应还本金金额-近12个月应还本金金额）',
    stg_pln_sum_prc_amt_24m_36m_diff_rto_light STRING COMMENT '近24个月应还本金金额/(近36个月应还本金金额-近24个月应还本金金额）',
    stg_pln_cnt_1m_6m_diff_rto_light STRING COMMENT '近1个月应还分期计划数/(近6个月应还分期计划数-近1个月应还分期计划数）',
    stg_pln_cnt_6m_12m_diff_rto_light STRING COMMENT '近6个月应还分期计划数/(近12个月应还分期计划数-近6个月应还分期计划数）',
    stg_pln_cnt_12m_24m_diff_rto_light STRING COMMENT '近12个月应还分期计划数/(近24个月应还分期计划数-近12个月应还分期计划数）',
    stg_pln_cnt_24m_36m_diff_rto_light STRING COMMENT '近24个月应还分期计划数/(近36个月应还分期计划数-近24个月应还分期计划数）'
)
PARTITIONED BY (
	ds STRING COMMENT '分区字段格式yyyymmdd'
);









insert overwrite table ${dwa_risk}.dwa_risk_light_rep_will_pressure_derived_new_df partition(ds='${bizdate}')


select uid
        ,mdl_dte
        
-- features range start --

        ---------/*【还清口径：实还日和评分日间隔】近1/6/12/24/36/历史*/---------------
        --衍生变量--趋势类-还清金额在时间切片上的变化
        ,case when stg_pln_sum_prc_amt_6m_light=0 then null else stg_pln_sum_prc_amt_1m_light/stg_pln_sum_prc_amt_6m_light end as stg_pln_sum_prc_amt_1m_6m_rto_light
        ,case when stg_pln_sum_prc_amt_12m_light=0 then null else stg_pln_sum_prc_amt_6m_light/stg_pln_sum_prc_amt_12m_light end as stg_pln_sum_prc_amt_6m_12m_rto_light
        ,case when stg_pln_sum_prc_amt_24m_light=0 then null else stg_pln_sum_prc_amt_12m_light/stg_pln_sum_prc_amt_24m_light end as stg_pln_sum_prc_amt_12m_24m_rto_light
        ,case when stg_pln_sum_prc_amt_36m_light=0 then null else stg_pln_sum_prc_amt_24m_light/stg_pln_sum_prc_amt_36m_light end as stg_pln_sum_prc_amt_24m_36m_rto_light
        ,case when stg_pln_sum_prc_amt_his_light=0 then null else stg_pln_sum_prc_amt_36m_light/stg_pln_sum_prc_amt_his_light end as stg_pln_sum_prc_amt_36m_his_rto_light

        ,case when stg_pln_cnt_6m_light=0 then null else stg_pln_cnt_1m_light/stg_pln_cnt_6m_light end as stg_pln_cnt_1m_6m_rto_light
        ,case when stg_pln_cnt_12m_light=0 then null else stg_pln_cnt_6m_light/stg_pln_cnt_12m_light end as stg_pln_cnt_6m_12m_rto_light
        ,case when stg_pln_cnt_24m_light=0 then null else stg_pln_cnt_12m_light/stg_pln_cnt_24m_light end as stg_pln_cnt_12m_24m_rto_light
        ,case when stg_pln_cnt_36m_light=0 then null else stg_pln_cnt_24m_light/stg_pln_cnt_36m_light end as stg_pln_cnt_24m_36m_rto_light
        ,case when stg_pln_cnt_his_light=0 then null else stg_pln_cnt_36m_light/stg_pln_cnt_his_light end as stg_pln_cnt_36m_his_rto_light
       

        --衍生变量--按还清时间：提前还款/按时还款/逾期还款在同时间窗口下的总金额的占比
        --提前还款
        ,case when stg_pln_sum_prc_amt_1m_light=0 then null else stg_pln_sum_prc_amt_1m_adv_light/stg_pln_sum_prc_amt_1m_light end as stg_pln_sum_prc_amt_adv_1m_rto_light
        ,case when stg_pln_sum_prc_amt_6m_light=0 then null else stg_pln_sum_prc_amt_6m_adv_light/stg_pln_sum_prc_amt_6m_light end as stg_pln_sum_prc_amt_adv_6m_rto_light
        ,case when stg_pln_sum_prc_amt_12m_light=0 then null else stg_pln_sum_prc_amt_12m_adv_light/stg_pln_sum_prc_amt_12m_light end as stg_pln_sum_prc_amt_adv_12m_rto_light
        ,case when stg_pln_sum_prc_amt_24m_light=0 then null else stg_pln_sum_prc_amt_24m_adv_light/stg_pln_sum_prc_amt_24m_light end as stg_pln_sum_prc_amt_adv_24m_rto_light
        ,case when stg_pln_sum_prc_amt_36m_light=0 then null else stg_pln_sum_prc_amt_36m_adv_light/stg_pln_sum_prc_amt_36m_light end as stg_pln_sum_prc_amt_adv_36m_rto_light
        ,case when stg_pln_sum_prc_amt_his_light=0 then null else stg_pln_sum_prc_amt_his_adv_light/stg_pln_sum_prc_amt_his_light end as stg_pln_sum_prc_amt_adv_his_rto_light

        ,case when stg_pln_cnt_1m_light=0 then null else stg_pln_cnt_1m_adv_light/stg_pln_cnt_1m_light end as stg_pln_cnt_adv_1m_rto_light
        ,case when stg_pln_cnt_6m_light=0 then null else stg_pln_cnt_6m_adv_light/stg_pln_cnt_6m_light end as stg_pln_cnt_adv_6m_rto_light
        ,case when stg_pln_cnt_12m_light=0 then null else stg_pln_cnt_12m_adv_light/stg_pln_cnt_12m_light end as stg_pln_cnt_adv_12m_rto_light
        ,case when stg_pln_cnt_24m_light=0 then null else stg_pln_cnt_24m_adv_light/stg_pln_cnt_24m_light end as stg_pln_cnt_adv_24m_rto_light
        ,case when stg_pln_cnt_36m_light=0 then null else stg_pln_cnt_36m_adv_light/stg_pln_cnt_36m_light end as stg_pln_cnt_adv_36m_rto_light
        ,case when stg_pln_cnt_his_light=0 then null else stg_pln_cnt_his_adv_light/stg_pln_cnt_his_light end as stg_pln_cnt_adv_his_rto_light
       
        
        --按时还款
        ,case when stg_pln_sum_prc_amt_1m_light=0 then null else stg_pln_sum_prc_amt_1m_on_light/stg_pln_sum_prc_amt_1m_light end as stg_pln_sum_prc_amt_on_1m_rto_light
        ,case when stg_pln_sum_prc_amt_6m_light=0 then null else stg_pln_sum_prc_amt_6m_on_light/stg_pln_sum_prc_amt_6m_light end as stg_pln_sum_prc_amt_on_6m_rto_light
        ,case when stg_pln_sum_prc_amt_12m_light=0 then null else stg_pln_sum_prc_amt_12m_on_light/stg_pln_sum_prc_amt_12m_light end as stg_pln_sum_prc_amt_on_12m_rto_light
        ,case when stg_pln_sum_prc_amt_24m_light=0 then null else stg_pln_sum_prc_amt_24m_on_light/stg_pln_sum_prc_amt_24m_light end as stg_pln_sum_prc_amt_on_24m_rto_light
        ,case when stg_pln_sum_prc_amt_36m_light=0 then null else stg_pln_sum_prc_amt_36m_on_light/stg_pln_sum_prc_amt_36m_light end as stg_pln_sum_prc_amt_on_36m_rto_light
        ,case when stg_pln_sum_prc_amt_his_light=0 then null else stg_pln_sum_prc_amt_his_on_light/stg_pln_sum_prc_amt_his_light end as stg_pln_sum_prc_amt_on_his_rto_light

        ,case when stg_pln_cnt_1m_light=0 then null else stg_pln_cnt_1m_on_light/stg_pln_cnt_1m_light end as stg_pln_cnt_on_1m_rto_light
        ,case when stg_pln_cnt_6m_light=0 then null else stg_pln_cnt_6m_on_light/stg_pln_cnt_6m_light end as stg_pln_cnt_on_6m_rto_light
        ,case when stg_pln_cnt_12m_light=0 then null else stg_pln_cnt_12m_on_light/stg_pln_cnt_12m_light end as stg_pln_cnt_on_12m_rto_light
        ,case when stg_pln_cnt_24m_light=0 then null else stg_pln_cnt_24m_on_light/stg_pln_cnt_24m_light end as stg_pln_cnt_on_24m_rto_light
        ,case when stg_pln_cnt_36m_light=0 then null else stg_pln_cnt_36m_on_light/stg_pln_cnt_36m_light end as stg_pln_cnt_on_36m_rto_light
        ,case when stg_pln_cnt_his_light=0 then null else stg_pln_cnt_his_on_light/stg_pln_cnt_his_light end as stg_pln_cnt_on_his_rto_light


        --逾期还款
        ,case when stg_pln_sum_prc_amt_1m_light=0 then null else stg_pln_sum_prc_amt_1m_due_light/stg_pln_sum_prc_amt_1m_light end as stg_pln_sum_prc_amt_due_1m_rto_light
        ,case when stg_pln_sum_prc_amt_6m_light=0 then null else stg_pln_sum_prc_amt_6m_due_light/stg_pln_sum_prc_amt_6m_light end as stg_pln_sum_prc_amt_due_6m_rto_light
        ,case when stg_pln_sum_prc_amt_12m_light=0 then null else stg_pln_sum_prc_amt_12m_due_light/stg_pln_sum_prc_amt_12m_light end as stg_pln_sum_prc_amt_due_12m_rto_light
        ,case when stg_pln_sum_prc_amt_24m_light=0 then null else stg_pln_sum_prc_amt_24m_due_light/stg_pln_sum_prc_amt_24m_light end as stg_pln_sum_prc_amt_due_24m_rto_light
        ,case when stg_pln_sum_prc_amt_36m_light=0 then null else stg_pln_sum_prc_amt_36m_due_light/stg_pln_sum_prc_amt_36m_light end as stg_pln_sum_prc_amt_due_36m_rto_light
        ,case when stg_pln_sum_prc_amt_his_light=0 then null else stg_pln_sum_prc_amt_his_due_light/stg_pln_sum_prc_amt_his_light end as stg_pln_sum_prc_amt_due_his_rto_light

        ,case when stg_pln_cnt_1m_light=0 then null else stg_pln_cnt_1m_due_light/stg_pln_cnt_1m_light end as stg_pln_cnt_due_1m_rto_light
        ,case when stg_pln_cnt_6m_light=0 then null else stg_pln_cnt_6m_due_light/stg_pln_cnt_6m_light end as stg_pln_cnt_due_6m_rto_light
        ,case when stg_pln_cnt_12m_light=0 then null else stg_pln_cnt_12m_due_light/stg_pln_cnt_12m_light end as stg_pln_cnt_due_12m_rto_light
        ,case when stg_pln_cnt_24m_light=0 then null else stg_pln_cnt_24m_due_light/stg_pln_cnt_24m_light end as stg_pln_cnt_due_24m_rto_light
        ,case when stg_pln_cnt_36m_light=0 then null else stg_pln_cnt_36m_due_light/stg_pln_cnt_36m_light end as stg_pln_cnt_due_36m_rto_light
        ,case when stg_pln_cnt_his_light=0 then null else stg_pln_cnt_his_due_light/stg_pln_cnt_his_light end as stg_pln_cnt_due_his_rto_light


        --衍生变量--按还清时间：近n个月提前还款/按时还款/逾期还款占历史至今的提前还款/按时还款/逾期还款金额占比
        --提前还款
        ,case when stg_pln_sum_prc_amt_his_adv_light=0 then null else stg_pln_sum_prc_amt_1m_adv_light/stg_pln_sum_prc_amt_his_adv_light end as stg_pln_sum_prc_amt_adv_1m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_adv_light=0 then null else stg_pln_sum_prc_amt_6m_adv_light/stg_pln_sum_prc_amt_his_adv_light end as stg_pln_sum_prc_amt_adv_6m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_adv_light=0 then null else stg_pln_sum_prc_amt_12m_adv_light/stg_pln_sum_prc_amt_his_adv_light end as stg_pln_sum_prc_amt_adv_12m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_adv_light=0 then null else stg_pln_sum_prc_amt_24m_adv_light/stg_pln_sum_prc_amt_his_adv_light end as stg_pln_sum_prc_amt_adv_24m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_adv_light=0 then null else stg_pln_sum_prc_amt_36m_adv_light/stg_pln_sum_prc_amt_his_adv_light end as stg_pln_sum_prc_amt_adv_36m_rto_his_light
       
        ,case when stg_pln_cnt_his_adv_light=0 then null else stg_pln_cnt_1m_adv_light/stg_pln_cnt_his_adv_light end as stg_pln_cnt_adv_1m_rto_his_light
        ,case when stg_pln_cnt_his_adv_light=0 then null else stg_pln_cnt_6m_adv_light/stg_pln_cnt_his_adv_light end as stg_pln_cnt_adv_6m_rto_his_light
        ,case when stg_pln_cnt_his_adv_light=0 then null else stg_pln_cnt_12m_adv_light/stg_pln_cnt_his_adv_light end as stg_pln_cnt_adv_12m_rto_his_light
        ,case when stg_pln_cnt_his_adv_light=0 then null else stg_pln_cnt_24m_adv_light/stg_pln_cnt_his_adv_light end as stg_pln_cnt_adv_24m_rto_his_light
        ,case when stg_pln_cnt_his_adv_light=0 then null else stg_pln_cnt_36m_adv_light/stg_pln_cnt_his_adv_light end as stg_pln_cnt_adv_36m_rto_his_light

        --按时还款
        ,case when stg_pln_sum_prc_amt_his_on_light=0 then null else stg_pln_sum_prc_amt_1m_on_light/stg_pln_sum_prc_amt_his_on_light end as stg_pln_sum_prc_amt_on_1m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_on_light=0 then null else stg_pln_sum_prc_amt_6m_on_light/stg_pln_sum_prc_amt_his_on_light end as stg_pln_sum_prc_amt_on_6m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_on_light=0 then null else stg_pln_sum_prc_amt_12m_on_light/stg_pln_sum_prc_amt_his_on_light end as stg_pln_sum_prc_amt_on_12m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_on_light=0 then null else stg_pln_sum_prc_amt_24m_on_light/stg_pln_sum_prc_amt_his_on_light end as stg_pln_sum_prc_amt_on_24m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_on_light=0 then null else stg_pln_sum_prc_amt_36m_on_light/stg_pln_sum_prc_amt_his_on_light end as stg_pln_sum_prc_amt_on_36m_rto_his_light
        
        ,case when stg_pln_cnt_his_on_light=0 then null else stg_pln_cnt_1m_on_light/stg_pln_cnt_his_on_light end as stg_pln_cnt_on_1m_rto_his_light
        ,case when stg_pln_cnt_his_on_light=0 then null else stg_pln_cnt_6m_on_light/stg_pln_cnt_his_on_light end as stg_pln_cnt_on_6m_rto_his_light
        ,case when stg_pln_cnt_his_on_light=0 then null else stg_pln_cnt_12m_on_light/stg_pln_cnt_his_on_light end as stg_pln_cnt_on_12m_rto_his_light
        ,case when stg_pln_cnt_his_on_light=0 then null else stg_pln_cnt_24m_on_light/stg_pln_cnt_his_on_light end as stg_pln_cnt_on_24m_rto_his_light
        ,case when stg_pln_cnt_his_on_light=0 then null else stg_pln_cnt_36m_on_light/stg_pln_cnt_his_on_light end as stg_pln_cnt_on_36m_rto_his_light

        --逾期还款
        ,case when stg_pln_sum_prc_amt_his_due_light=0 then null else stg_pln_sum_prc_amt_1m_due_light/stg_pln_sum_prc_amt_his_due_light end as stg_pln_sum_prc_amt_due_1m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_due_light=0 then null else stg_pln_sum_prc_amt_6m_due_light/stg_pln_sum_prc_amt_his_due_light end as stg_pln_sum_prc_amt_due_6m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_due_light=0 then null else stg_pln_sum_prc_amt_12m_due_light/stg_pln_sum_prc_amt_his_due_light end as stg_pln_sum_prc_amt_due_12m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_due_light=0 then null else stg_pln_sum_prc_amt_24m_due_light/stg_pln_sum_prc_amt_his_due_light end as stg_pln_sum_prc_amt_due_24m_rto_his_light
        ,case when stg_pln_sum_prc_amt_his_due_light=0 then null else stg_pln_sum_prc_amt_36m_due_light/stg_pln_sum_prc_amt_his_due_light end as stg_pln_sum_prc_amt_due_36m_rto_his_light
        
        ,case when stg_pln_cnt_his_due_light=0 then null else stg_pln_cnt_1m_due_light/stg_pln_cnt_his_due_light end as stg_pln_cnt_due_1m_rto_his_light
        ,case when stg_pln_cnt_his_due_light=0 then null else stg_pln_cnt_6m_due_light/stg_pln_cnt_his_due_light end as stg_pln_cnt_due_6m_rto_his_light
        ,case when stg_pln_cnt_his_due_light=0 then null else stg_pln_cnt_12m_due_light/stg_pln_cnt_his_due_light end as stg_pln_cnt_due_12m_rto_his_light
        ,case when stg_pln_cnt_his_due_light=0 then null else stg_pln_cnt_24m_due_light/stg_pln_cnt_his_due_light end as stg_pln_cnt_due_24m_rto_his_light
        ,case when stg_pln_cnt_his_due_light=0 then null else stg_pln_cnt_36m_due_light/stg_pln_cnt_his_due_light end as stg_pln_cnt_due_36m_rto_his_light

        


        ----------------------------------------------------------
        --/*12.1.3 历史还款压力*/---衍生变量
        ----------------------------------------------------------

        --单月平均应还金额
        ,stg_pln_sum_prc_amt_6m_light/6 as stg_pln_avg_prc_amt_6m_per_mth_light
        ,stg_pln_sum_prc_amt_12m_light/12 as stg_pln_avg_prc_amt_12m_per_mth_light
        ,stg_pln_sum_prc_amt_24m_light/24 as stg_pln_avg_prc_amt_24m_per_mth_light
        ,stg_pln_sum_prc_amt_36m_light/36 as stg_pln_avg_prc_amt_36m_per_mth_light
                
        --历史应还金额/分期计划数的变化（能体现一部分借新还旧变化）
        ,stg_pln_sum_prc_amt_1m_light/(stg_pln_sum_prc_amt_6m_light - stg_pln_sum_prc_amt_1m_light) as stg_pln_sum_prc_amt_1m_6m_diff_rto_light
        ,stg_pln_sum_prc_amt_6m_light/(stg_pln_sum_prc_amt_12m_light - stg_pln_sum_prc_amt_6m_light) as stg_pln_sum_prc_amt_6m_12m_diff_rto_light
        ,stg_pln_sum_prc_amt_12m_light/(stg_pln_sum_prc_amt_24m_light - stg_pln_sum_prc_amt_12m_light) as stg_pln_sum_prc_amt_12m_24m_diff_rto_light
        ,stg_pln_sum_prc_amt_24m_light/(stg_pln_sum_prc_amt_36m_light - stg_pln_sum_prc_amt_24m_light) as stg_pln_sum_prc_amt_24m_36m_diff_rto_light

        ,stg_pln_cnt_1m_light/(stg_pln_cnt_6m_light - stg_pln_cnt_1m_light) as stg_pln_cnt_1m_6m_diff_rto_light
        ,stg_pln_cnt_6m_light/(stg_pln_cnt_12m_light - stg_pln_cnt_6m_light) as stg_pln_cnt_6m_12m_diff_rto_light
        ,stg_pln_cnt_12m_light/(stg_pln_cnt_24m_light - stg_pln_cnt_12m_light) as stg_pln_cnt_12m_24m_diff_rto_light
        ,stg_pln_cnt_24m_light/(stg_pln_cnt_36m_light - stg_pln_cnt_24m_light) as stg_pln_cnt_24m_36m_diff_rto_light
        


-- features range end --

from 
(select * from ${dwa_risk}.dwa_risk_light_rep_ability_new_df where ds='${bizdate}') a
;
-- feature-copilot:node-end ordinal=0
