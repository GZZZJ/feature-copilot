-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_will_pressure_derived_new_df
-- node_id: n_6398865203584761856
-- task_name: dwa_risk_dz_model_final_12his_rep_will_pressure_derived_new_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_will_pressure_derived_new_df.json
-- source_json_sha256: e6b236beeaddd0bb536a22156b61f17f99864dda7401bdc819794e18193c2c5c
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_new_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2024-11-25 10:55:13
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists  ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_derived_new_df
(
	`uid` STRING COMMENT '用户ID',
	`mdl_dte` DATE,
	`stg_pln_pay_off_sum_prc_amt_12m_24m_rto` DECIMAL(38, 10),
	`stg_pln_pay_off_sum_prc_amt_12m_36m_rto` DECIMAL(38, 10),
        `stg_pln_pay_off_sum_prc_amt_12m_all_rto` DECIMAL(38, 10),
	`stg_pln_pay_off_cnt_12m_24m_rto` DOUBLE,
	`stg_pln_pay_off_cnt_12m_36m_rto` DOUBLE,
        `stg_pln_pay_off_cnt_12m_all_rto` DOUBLE,
	`stg_pln_sum_prc_amt_adv_rct_24m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_adv_rct_36m_rto` DECIMAL(38, 10),
        `stg_pln_sum_prc_amt_adv_rct_all_rto` DECIMAL(38, 10),
	`stg_pln_cnt_adv_rct_24m_rto` DOUBLE,
        `stg_pln_cnt_adv_rct_36m_rto` DOUBLE,
	`stg_pln_cnt_adv_rct_all_rto` DOUBLE,
	`stg_pln_pay_off_sum_prc_amt_d0_rep_24m_rto` DECIMAL(38, 10),
	`stg_pln_pay_off_sum_prc_amt_d0_rep_36m_rto` DECIMAL(38, 10),
        `stg_pln_pay_off_sum_prc_amt_d0_rep_rto` DECIMAL(38, 10),
	`stg_pln_pay_off_cnt_d0_rep_24m_rto` DOUBLE,
	`stg_pln_pay_off_cnt_d0_rep_36m_rto` DOUBLE,
        `stg_pln_pay_off_cnt_d0_rep_rto` DOUBLE,
	`stg_pln_avg_prc_amt_24m_his` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_36m_his` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_24m_his_per_mth` DECIMAL(30, 8),
	`stg_pln_avg_prc_amt_36m_his_per_mth` DECIMAL(31, 9),
	`stg_pln_sum_prc_amt_12m_24m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_12m_36m_rto` DECIMAL(38, 10)
)
comment "还款信息表三拉长至3年"
PARTITIONED BY (`ds` STRING COMMENT '日期分区,格式:yyyymmdd');

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_derived_new_df partition(ds='${bizdate}') 
select uid,mdl_dte,
case when stg_pln_pay_off_sum_prc_amt_24m=0 then null else stg_pln_pay_off_sum_prc_amt_12m/stg_pln_pay_off_sum_prc_amt_24m end as stg_pln_pay_off_sum_prc_amt_12m_24m_rto,
case when stg_pln_pay_off_sum_prc_amt_36m=0 then null else stg_pln_pay_off_sum_prc_amt_12m/stg_pln_pay_off_sum_prc_amt_36m end as stg_pln_pay_off_sum_prc_amt_12m_36m_rto,
case when stg_pln_pay_off_sum_prc_amt=0 then null else stg_pln_pay_off_sum_prc_amt_12m/stg_pln_pay_off_sum_prc_amt end as stg_pln_pay_off_sum_prc_amt_12m_all_rto,
case when stg_pln_pay_off_cnt_24m=0 then null else stg_pln_pay_off_cnt_12m/stg_pln_pay_off_cnt_24m end as stg_pln_pay_off_cnt_12m_24m_rto,
case when stg_pln_pay_off_cnt_36m=0 then null else stg_pln_pay_off_cnt_12m/stg_pln_pay_off_cnt_36m end as stg_pln_pay_off_cnt_12m_36m_rto,
case when stg_pln_pay_off_cnt=0 then null else stg_pln_pay_off_cnt_12m/stg_pln_pay_off_cnt end as stg_pln_pay_off_cnt_12m_all_rto,
case when stg_pln_pay_off_sum_prc_amt_24m=0 then null else stg_pln_sum_prc_amt_adv_rct_24m/stg_pln_pay_off_sum_prc_amt_24m end as stg_pln_sum_prc_amt_adv_rct_24m_rto,
case when stg_pln_pay_off_sum_prc_amt_36m=0 then null else stg_pln_sum_prc_amt_adv_rct_36m/stg_pln_pay_off_sum_prc_amt_36m end as stg_pln_sum_prc_amt_adv_rct_36m_rto,
case when stg_pln_pay_off_sum_prc_amt=0 then null else stg_pln_sum_prc_amt_adv_rct/stg_pln_pay_off_sum_prc_amt end as stg_pln_sum_prc_amt_adv_rct_all_rto,
case when stg_pln_pay_off_cnt_24m=0 then null else stg_pln_cnt_adv_rct_24m/stg_pln_pay_off_cnt_24m end as stg_pln_cnt_adv_rct_24m_rto,
case when stg_pln_pay_off_cnt_36m=0 then null else stg_pln_cnt_adv_rct_36m/stg_pln_pay_off_cnt_36m end as stg_pln_cnt_adv_rct_36m_rto,
case when stg_pln_pay_off_cnt=0 then null else stg_pln_cnt_adv_rct/stg_pln_pay_off_cnt end as stg_pln_cnt_adv_rct_all_rto,
case when stg_pln_pay_off_sum_prc_amt_24m=0 then null else stg_pln_sum_prc_amt_d0_rep_24m/stg_pln_pay_off_sum_prc_amt_24m end as stg_pln_pay_off_sum_prc_amt_d0_rep_24m_rto,
case when stg_pln_pay_off_sum_prc_amt_36m=0 then null else stg_pln_sum_prc_amt_d0_rep_36m/stg_pln_pay_off_sum_prc_amt_36m end as stg_pln_pay_off_sum_prc_amt_d0_rep_36m_rto,
case when stg_pln_pay_off_sum_prc_amt=0 then null else stg_pln_sum_prc_amt_d0_rep/stg_pln_pay_off_sum_prc_amt end as stg_pln_pay_off_sum_prc_amt_d0_rep_rto,
case when stg_pln_pay_off_cnt_24m=0 then null else stg_pln_cnt_d0_rep_24m/stg_pln_pay_off_cnt_24m end as stg_pln_pay_off_cnt_d0_rep_24m_rto,
case when stg_pln_pay_off_cnt_36m=0 then null else stg_pln_cnt_d0_rep_36m/stg_pln_pay_off_cnt_36m end as stg_pln_pay_off_cnt_d0_rep_36m_rto,
case when stg_pln_pay_off_cnt=0 then null else stg_pln_cnt_d0_rep/stg_pln_pay_off_cnt end as stg_pln_pay_off_cnt_d0_rep_rto,
case when stg_pln_cnt_24m_his=0 then null else stg_pln_sum_prc_amt_24m_his/stg_pln_cnt_24m_his end as stg_pln_avg_prc_amt_24m_his,
case when stg_pln_cnt_36m_his=0 then null else stg_pln_sum_prc_amt_36m_his/stg_pln_cnt_36m_his end as stg_pln_avg_prc_amt_36m_his,
stg_pln_sum_prc_amt_24m_his/24 as stg_pln_avg_prc_amt_24m_his_per_mth,
stg_pln_sum_prc_amt_36m_his/36 as stg_pln_avg_prc_amt_36m_his_per_mth,
stg_pln_sum_prc_amt_12m_his/(stg_pln_sum_prc_amt_24m_his-stg_pln_sum_prc_amt_12m_his) as stg_pln_sum_prc_amt_12m_24m_rto,
stg_pln_sum_prc_amt_12m_his/(stg_pln_sum_prc_amt_36m_his-stg_pln_sum_prc_amt_12m_his) as stg_pln_sum_prc_amt_12m_36m_rto
from (SELECT a.* , b.stg_pln_pay_off_sum_prc_amt, b.stg_pln_pay_off_sum_prc_amt_12m, b.stg_pln_pay_off_cnt, b.stg_pln_pay_off_cnt_12m, b.stg_pln_sum_prc_amt_12m_his FROM (SELECT * FROM ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_new_df WHERE ds = '${bizdate}') AS a LEFT JOIN (SELECT * FROM ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_df WHERE ds = '${bizdate}') AS b ON a.uid = b.uid AND a.mdl_dte = b.mdl_dte) c;
-- feature-copilot:node-end ordinal=0
