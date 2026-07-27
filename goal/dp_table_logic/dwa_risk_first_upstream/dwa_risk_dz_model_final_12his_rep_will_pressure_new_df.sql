-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_will_pressure_new_df
-- node_id: n_6398851494049480704
-- task_name: dwa_risk_dz_model_final_12his_rep_will_pressure_new_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_will_pressure_new_df.json
-- source_json_sha256: c75e69cbd16408504dae0e5fdbbf51a1fffef87ef0df713324fcd33f25da654e
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_bizdate
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1_new_bizdate
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_detail_new

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2024-11-25 10:43:30
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_new_df
(
	`uid` STRING COMMENT '用户ID',
	`mdl_dte` DATE,
        `stg_pln_pay_off_sum_prc_amt_24m` DECIMAL(28, 6),
        `stg_pln_pay_off_sum_prc_amt_36m` DECIMAL(28, 6),
        `stg_pln_pay_off_cnt_24m` BIGINT,
        `stg_pln_pay_off_cnt_36m` BIGINT,
        `stg_pln_sum_prc_amt_adv_rct_24m` DECIMAL(28, 6),
	`stg_pln_max_prc_amt_adv_rct_24m` DECIMAL(18, 6),
	`stg_pln_min_prc_amt_adv_rct_24m` DECIMAL(18, 6),
	`stg_pln_cnt_adv_rct_24m` BIGINT,
        `stg_pln_sum_prc_amt_adv_rct_36m` DECIMAL(28, 6),
	`stg_pln_max_prc_amt_adv_rct_36m` DECIMAL(18, 6),
	`stg_pln_min_prc_amt_adv_rct_36m` DECIMAL(18, 6),
	`stg_pln_cnt_adv_rct_36m` BIGINT,
        `stg_pln_sum_prc_amt_adv_rct` DECIMAL(28, 6),
	`stg_pln_max_prc_amt_adv_rct` DECIMAL(18, 6),
	`stg_pln_min_prc_amt_adv_rct` DECIMAL(18, 6),
	`stg_pln_cnt_adv_rct` BIGINT,
        `stg_pln_sum_prc_amt_d0_rep_24m` DECIMAL(28, 6),
	`stg_pln_max_prc_amt_d0_rep_24m` DECIMAL(18, 6),
	`stg_pln_min_prc_amt_d0_rep_24m` DECIMAL(18, 6),
	`stg_pln_cnt_d0_rep_24m` BIGINT,
        `stg_pln_sum_prc_amt_d0_rep_36m` DECIMAL(28, 6),
	`stg_pln_max_prc_amt_d0_rep_36m` DECIMAL(18, 6),
	`stg_pln_min_prc_amt_d0_rep_36m` DECIMAL(18, 6),
	`stg_pln_cnt_d0_rep_36m` BIGINT,
        `stg_pln_sum_prc_amt_d0_rep` DECIMAL(28, 6),
	`stg_pln_max_prc_amt_d0_rep` DECIMAL(18, 6),
	`stg_pln_min_prc_amt_d0_rep` DECIMAL(18, 6),
	`stg_pln_cnt_d0_rep` BIGINT,
        `stg_pln_sum_prc_amt_24m_his` DECIMAL(28, 6),
        `stg_pln_sum_prc_amt_36m_his` DECIMAL(28, 6),
        `stg_pln_cnt_24m_his` BIGINT,
        `stg_pln_cnt_36m_his` BIGINT
) comment "还款信息表1拉长至3年"
PARTITIONED BY (`ds` STRING COMMENT '日期分区,格式:yyyymmdd');

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1_new_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1_new_${bizdate} as 
select uid,mdl_dte,
sum(case when rep_24m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_24m,
sum(case when rep_36m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_36m,
count(case when rep_24m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_24m,
count(case when rep_36m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_36m,
sum(case when rep_24m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_24m,
max(case when rep_24m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_24m,
min(case when rep_24m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_24m,
count(case when rep_24m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_24m,
sum(case when rep_36m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_36m,
max(case when rep_36m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_36m,
min(case when rep_36m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_36m,
count(case when rep_36m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_36m,
sum(case when rep_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct,
max(case when rep_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct,
min(case when rep_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct,
count(case when rep_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct,
sum(case when his_rep_stg_pln_24m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_24m,
max(case when his_rep_stg_pln_24m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_24m,
min(case when his_rep_stg_pln_24m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_24m,
count(case when his_rep_stg_pln_24m_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_24m,
sum(case when his_rep_stg_pln_36m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_36m,
max(case when his_rep_stg_pln_36m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_36m,
min(case when his_rep_stg_pln_36m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_36m,
count(case when his_rep_stg_pln_36m_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_36m,
sum(case when his_rep_stg_pln_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep,
max(case when his_rep_stg_pln_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep,
min(case when his_rep_stg_pln_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep,
count(case when his_rep_stg_pln_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep
from (select *,sum(case when per_rep_mth_flg is not null then prc_amt else 0 end) over(partition by uid,per_rep_mth_flg) as prc_amt_pmth_3m from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_new where is_his_rep_rpm_stg_pln=1 and ds = '${bizdate}') main group by uid,mdl_dte;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_${bizdate} as 
select uid,mdl_dte,
sum(case when his_rep_stg_pln_24m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_24m_his,
sum(case when his_rep_stg_pln_36m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_36m_his,
count(case when his_rep_stg_pln_24m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_24m_his,
count(case when his_rep_stg_pln_36m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_36m_his
from (select *,sum(case when per_rep_mth_flg is not null then prc_amt else 0 end) over(partition by uid,per_rep_mth_flg) as prc_amt_pmth_3m from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_new where is_his_rep_rpm_stg_pln=1 and ds = '${bizdate}') main group by uid,mdl_dte;

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_new_df partition(ds='${bizdate}') 
select model_data.uid,model_data.mdl_dte,
coalesce(plan1.stg_pln_pay_off_sum_prc_amt_24m,0) as stg_pln_pay_off_sum_prc_amt_24m,
coalesce(plan1.stg_pln_pay_off_sum_prc_amt_36m,0) as stg_pln_pay_off_sum_prc_amt_36m,
coalesce(plan1.stg_pln_pay_off_cnt_24m,0) as stg_pln_pay_off_cnt_24m,
coalesce(plan1.stg_pln_pay_off_cnt_36m,0) as stg_pln_pay_off_cnt_36m,
coalesce(stg_pln_sum_prc_amt_adv_rct_24m,0) as stg_pln_sum_prc_amt_adv_rct_24m,
coalesce(stg_pln_max_prc_amt_adv_rct_24m,0) as stg_pln_max_prc_amt_adv_rct_24m,
coalesce(stg_pln_min_prc_amt_adv_rct_24m,0) as stg_pln_min_prc_amt_adv_rct_24m,
coalesce(stg_pln_cnt_adv_rct_24m,0) as stg_pln_cnt_adv_rct_24m,
coalesce(stg_pln_sum_prc_amt_adv_rct_36m,0) as stg_pln_sum_prc_amt_adv_rct_36m,
coalesce(stg_pln_max_prc_amt_adv_rct_36m,0) as stg_pln_max_prc_amt_adv_rct_36m,
coalesce(stg_pln_min_prc_amt_adv_rct_36m,0) as stg_pln_min_prc_amt_adv_rct_36m,
coalesce(stg_pln_cnt_adv_rct_36m,0) as stg_pln_cnt_adv_rct_36m,
coalesce(stg_pln_sum_prc_amt_adv_rct,0) as stg_pln_sum_prc_amt_adv_rct,
coalesce(stg_pln_max_prc_amt_adv_rct,0) as stg_pln_max_prc_amt_adv_rct,
coalesce(stg_pln_min_prc_amt_adv_rct,0) as stg_pln_min_prc_amt_adv_rct,
coalesce(stg_pln_cnt_adv_rct,0) as stg_pln_cnt_adv_rct,
coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_24m,0) as stg_pln_sum_prc_amt_d0_rep_24m,
coalesce(plan1.stg_pln_max_prc_amt_d0_rep_24m,0) as stg_pln_max_prc_amt_d0_rep_24m,
coalesce(plan1.stg_pln_min_prc_amt_d0_rep_24m,0) as stg_pln_min_prc_amt_d0_rep_24m,
coalesce(plan1.stg_pln_cnt_d0_rep_24m,0) as stg_pln_cnt_d0_rep_24m,
coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_36m,0) as stg_pln_sum_prc_amt_d0_rep_36m,
coalesce(plan1.stg_pln_max_prc_amt_d0_rep_36m,0) as stg_pln_max_prc_amt_d0_rep_36m,
coalesce(plan1.stg_pln_min_prc_amt_d0_rep_36m,0) as stg_pln_min_prc_amt_d0_rep_36m,
coalesce(plan1.stg_pln_cnt_d0_rep_36m,0) as stg_pln_cnt_d0_rep_36m,
coalesce(plan1.stg_pln_sum_prc_amt_d0_rep,0) as stg_pln_sum_prc_amt_d0_rep,
coalesce(plan1.stg_pln_max_prc_amt_d0_rep,0) as stg_pln_max_prc_amt_d0_rep,
coalesce(plan1.stg_pln_min_prc_amt_d0_rep,0) as stg_pln_min_prc_amt_d0_rep,
coalesce(plan1.stg_pln_cnt_d0_rep,0) as stg_pln_cnt_d0_rep,
coalesce(plan2.stg_pln_sum_prc_amt_24m_his,0) as stg_pln_sum_prc_amt_24m_his,
coalesce(plan2.stg_pln_sum_prc_amt_36m_his,0) as stg_pln_sum_prc_amt_36m_his,
coalesce(plan2.stg_pln_cnt_24m_his,0) as stg_pln_cnt_24m_his,
coalesce(plan2.stg_pln_cnt_36m_his,0) as stg_pln_cnt_36m_his
from (select * from ${dwa_risk}.dwa_risk_f_dz_model_data_base_df where ds = '${bizdate}') model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1_new_${bizdate} plan1 on model_data.uid=plan1.uid
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_${bizdate} plan2 on model_data.uid=plan2.uid;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1_new_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_${bizdate};
-- feature-copilot:node-end ordinal=0
