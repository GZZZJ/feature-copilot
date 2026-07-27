-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_continue_ovd_days_df
-- node_id: n_3769223957081423872
-- task_name: dwa_risk_dz_model_final_12his_continue_ovd_days_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_continue_ovd_days_df.json
-- source_json_sha256: 339f2da73c14573e5af68670654082816961846465caa96d86fa496f88e88746
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_continue_ovd_days_his_tmp2
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_continue_ovd_days_max_tmp1
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_detail

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_final_12his_continue_ovd_days
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_max_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_max_tmp1 as
select *
        ,case when is_lag_continue=1 and is_lead_continue=1 then '连续逾期中间记录'
                when is_lead_continue=1 and is_lag_continue=0 then '首条连续逾期记录'
                when is_lag_continue=1 and is_lead_continue=0 then '末条连续逾期记录'
                else '其他记录'
                end as continue_stt
from
        (select *
                ,case when datediff(lag_rep_tim,dtl_rep_dte)>0 then 1 else 0 end as is_lag_continue
                ,case when datediff(rep_tim,lead_dtl_rep_dte)>0 then 1 else 0 end as is_lead_continue
        from
                (select uid
                        ,mdl_dte
                        ,dtl_stg_pln_no
                        ,rep_tim
                        ,dtl_rep_dte
                        ,lead(dtl_rep_dte) over(partition by uid order by dtl_rep_dte asc) as lead_dtl_rep_dte
                        ,lag(rep_tim) over(partition by uid order by dtl_rep_dte asc) as lag_rep_tim
                from
                        (select uid
                                ,mdl_dte
                                ,dtl_stg_pln_no
                                ,dtl_rep_dte
                                ,rep_tim
                                ,lag(rep_tim) over(partition by uid order by dtl_rep_dte asc,rep_tim asc) as lag_rep_tim
                        from
                                (select uid
                                        ,mdl_dte
                                        ,dtl_stg_pln_no
                                        ,dtl_rep_dte
                                        ,coalesce(rep_tim,date(mdl_dte)) as rep_tim
                                from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail
                                where ovd_rep_flg=1
                                )main
                        )a
                where datediff(a.rep_tim,a.lag_rep_tim)>=0 or a.lag_rep_tim is null
                )b
        )c
;


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_his_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_his_tmp2 as
select uid
        ,mdl_dte
        ,max(datediff(lead_rep_tim,dtl_rep_dte)) as max_ctn_ovd_day
        ,min(datediff(lead_rep_tim,dtl_rep_dte)) as min_ctn_ovd_day
from
        (select uid
                ,mdl_dte
                ,dtl_stg_pln_no
                ,dtl_rep_dte
                ,rep_tim
                ,lead(rep_tim) over(partition by uid order by dtl_rep_dte asc,continue_stt desc) as lead_rep_tim
                ,continue_stt
        from ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_max_tmp1
        where continue_stt in ('首条连续逾期记录','末条连续逾期记录')
        )b
where continue_stt='首条连续逾期记录'
group by uid
        ,mdl_dte;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_df partition(ds='${bizdate}')
select   model_data.uid
        ,model_data.mdl_dte
        ,coalesce(max_ctn_ovd_day,0) as max_ctn_ovd_day
        ,coalesce(min_ctn_ovd_day,0) as min_ctn_ovd_day
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_continue_ovd_days_his_tmp2 max_min_ovd on model_data.uid=max_min_ovd.uid;
-- feature-copilot:node-end ordinal=0
