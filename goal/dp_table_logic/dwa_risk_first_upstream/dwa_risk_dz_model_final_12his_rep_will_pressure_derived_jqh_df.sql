-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_will_pressure_derived_jqh_df
-- node_id: n_6399232612267458560
-- task_name: dwa_risk_dz_model_final_12his_rep_will_pressure_derived_jqh_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_will_pressure_derived_jqh_df.json
-- source_json_sha256: 597246670e374527840ddd3022a628ba775f1e36797ab4f1811da6d1e7b87493
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_jqh_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2024-11-25 13:53:50
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_derived_jqh_df
(
	`uid` STRING COMMENT '用户ID',
	`mdl_dte` DATE COMMENT '模型评分日',
	`stg_pln_pay_off_sum_prc_amt_d0_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_pay_off_cnt_d0_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_avg_prc_amt_adv_3d_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_adv_7d_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_adv_14d_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_adv_1m_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_adv_2m_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_adv_3m_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_adv_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_sum_prc_amt_adv_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_cnt_adv_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_avg_prc_amt_d0_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_sum_prc_amt_d0_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_cnt_d0_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_avg_prc_amt_adv_d0_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_sum_prc_amt_adv_d0_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_cnt_adv_d0_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_avg_prc_amt_ovd_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_ovd_3d_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_ovd_7d_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_ovd_14d_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_ovd_m2_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_ovd_m3_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_ovd_m4_pls_rep_bjq_12m` DECIMAL(38, 16),
	`stg_pln_sum_prc_amt_ovd_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_ovd_3d_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_ovd_7d_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_ovd_14d_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_ovd_m2_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_ovd_m3_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_sum_prc_amt_ovd_m4_pls_rep_bjq_12m_rto` DECIMAL(38, 10),
	`stg_pln_cnt_ovd_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_cnt_ovd_3d_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_cnt_ovd_7d_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_cnt_ovd_14d_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_cnt_ovd_m2_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_cnt_ovd_m3_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_cnt_ovd_m4_pls_rep_bjq_12m_rto` DOUBLE,
	`stg_pln_avg_prc_amt_bjq_12m_his` DECIMAL(38, 16),
	`stg_pln_avg_prc_amt_bjq_12m_his_per_mth` DECIMAL(31, 9)
)
PARTITIONED BY (`ds` STRING COMMENT '日期分区,格式:yyyymmdd');

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_derived_jqh_df partition(ds='${bizdate}') 
select uid,mdl_dte,
case when stg_pln_pay_off_sum_prc_amt_bjq_12m=0 then null else stg_pln_sum_prc_amt_d0_rep_bjq_12m/stg_pln_pay_off_sum_prc_amt_bjq_12m end as stg_pln_pay_off_sum_prc_amt_d0_rep_12m_rto,
case when stg_pln_pay_off_cnt_bjq_12m=0 then null else stg_pln_cnt_d0_rep_bjq_12m/stg_pln_pay_off_cnt_bjq_12m end as stg_pln_pay_off_cnt_d0_rep_12m_rto,
case when stg_pln_cnt_adv_3d_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_3d_bjq_12m/stg_pln_cnt_adv_3d_bjq_12m end as stg_pln_avg_prc_amt_adv_3d,
case when stg_pln_cnt_adv_7d_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_7d_bjq_12m/stg_pln_cnt_adv_7d_bjq_12m end as stg_pln_avg_prc_amt_adv_7d,
case when stg_pln_cnt_adv_14d_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_14d_bjq_12m/stg_pln_cnt_adv_14d_bjq_12m end as stg_pln_avg_prc_amt_adv_14d,
case when stg_pln_cnt_adv_1m_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_1m_bjq_12m/stg_pln_cnt_adv_1m_bjq_12m end as stg_pln_avg_prc_amt_adv_1m,
case when stg_pln_cnt_adv_2m_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_2m_bjq_12m/stg_pln_cnt_adv_2m_bjq_12m end as stg_pln_avg_prc_amt_adv_2m,
case when stg_pln_cnt_adv_3m_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_3m_bjq_12m/stg_pln_cnt_adv_3m_bjq_12m end as stg_pln_avg_prc_amt_adv_3m,
case when stg_pln_cnt_adv_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_rep_bjq_12m/stg_pln_cnt_adv_rep_bjq_12m end as stg_pln_avg_prc_amt_adv_rep_12m,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_adv_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_adv_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_adv_rep_12m_rto,
case when stg_pln_cnt_d0_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_d0_rep_bjq_12m/stg_pln_cnt_d0_rep_bjq_12m end as stg_pln_avg_prc_amt_d0_rep_12m,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_d0_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_d0_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_d0_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_d0_rep_12m_rto,
case when stg_pln_cnt_adv_d0_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_d0_rep_bjq_12m/stg_pln_cnt_adv_d0_rep_bjq_12m end as stg_pln_avg_prc_amt_adv_d0_rep_12m,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_adv_d0_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_adv_d0_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_adv_d0_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_adv_d0_rep_12m_rto,
case when stg_pln_cnt_ovd_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_pls_rep_bjq_12m/stg_pln_cnt_ovd_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_pls_rep_12m,
case when stg_pln_cnt_ovd_3d_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_3d_pls_rep_bjq_12m/stg_pln_cnt_ovd_3d_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_3d_pls_rep_12m,
case when stg_pln_cnt_ovd_7d_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_7d_pls_rep_bjq_12m/stg_pln_cnt_ovd_7d_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_7d_pls_rep_12m,
case when stg_pln_cnt_ovd_14d_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_14d_pls_rep_bjq_12m/stg_pln_cnt_ovd_14d_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_14d_pls_rep_12m,
case when stg_pln_cnt_ovd_m2_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_m2_pls_rep_bjq_12m/stg_pln_cnt_ovd_m2_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_m2_pls_rep_12m,
case when stg_pln_cnt_ovd_m3_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_m3_pls_rep_bjq_12m/stg_pln_cnt_ovd_m3_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_m3_pls_rep_12m,
case when stg_pln_cnt_ovd_m4_pls_rep_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_m4_pls_rep_bjq_12m/stg_pln_cnt_ovd_m4_pls_rep_bjq_12m end as stg_pln_avg_prc_amt_ovd_m4_pls_rep_12m,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_pls_rep_12m_rto,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_3d_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_3d_pls_rep_12m_rto,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_7d_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_7d_pls_rep_12m_rto,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_14d_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_14d_pls_rep_12m_rto,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_m2_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_m2_pls_rep_12m_rto,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_m3_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_m3_pls_rep_12m_rto,
case when stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_ovd_m4_pls_rep_bjq_12m/stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m end as stg_pln_sum_prc_amt_ovd_m4_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_3d_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_3d_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_7d_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_7d_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_14d_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_14d_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_m2_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_m2_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_m3_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_m3_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_cnt_ovd_m4_pls_rep_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_cnt_ovd_m4_pls_rep_12m_rto,
case when stg_pln_cnt_bjq_12m_his_bjq_12m=0 then null else stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m/stg_pln_cnt_bjq_12m_his_bjq_12m end as stg_pln_avg_prc_amt_12m_his,
stg_pln_sum_prc_amt_bjq_12m_his_bjq_12m/12 as stg_pln_avg_prc_amt_12m_his_per_mth
from (select * from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_jqh_df where ds = '${bizdate}') a;
-- feature-copilot:node-end ordinal=0
