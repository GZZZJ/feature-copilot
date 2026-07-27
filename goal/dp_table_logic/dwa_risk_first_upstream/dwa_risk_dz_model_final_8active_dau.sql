-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_8active_dau
-- node_id: n_4240514807283253248
-- task_name: dwa_risk_dz_model_final_8active_dau
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_8active_dau.json
-- source_json_sha256: 0b3a2a52948c7f2820b471ebe6ea66c01aebc3fc1bc4db807be3a8e75c585510
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_behavior_01
-- upstream_table: dwa_risk.dz_model_temp_8active_dau_model_data
-- upstream_table: ads_app_collect.dp_dmining_f_user_behavior_tracker
-- upstream_table: dwa_risk.dz_model_temp_8active_dau14_summary
-- upstream_table: dwa_risk.dz_model_temp_8active_dau7_summary
-- upstream_table: dwa_risk.dz_model_temp_8active_dau90_summary
-- upstream_table: dwa_risk.dz_model_temp_8active_dau30_summary

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 裴阳
--创建日期: 2022-10-27 11:49:25
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_8active_dau(
  uid STRING
  ,mdl_dte DATE
  ,dau_1d BIGINT
  ,dau_7d BIGINT
  ,max_con_dau_7d BIGINT
  ,ddf_mdl_max_dau_dt_7d BIGINT
  ,ddf_mdl_max_con_dau_dt_7d BIGINT
  ,dau_14d BIGINT
  ,max_con_dau_14d BIGINT
  ,ddf_mdl_max_dau_dt_14d BIGINT
  ,ddf_mdl_max_con_dau_dt_14d BIGINT
  ,dau_30d BIGINT
  ,max_con_dau_30d BIGINT
  ,ddf_mdl_max_dau_dt_30d BIGINT
  ,ddf_mdl_max_con_dau_dt_30d BIGINT
  ,dau_90d BIGINT
  ,max_con_dau_90d BIGINT
  ,ddf_mdl_max_dau_dt_90d BIGINT
  ,ddf_mdl_max_con_dau_dt_90d BIGINT
) comment "app点击信息数据表" 
partitioned by (ds string comment '分区字段,格式yyyymmdd');


drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_behavior_01;
create table ${dwa_risk}.dwa_risk_dz_model_temp_behavior_01 as 
select uid, 
    dat_dt dt, 
    pv clk_cnt,
    pv_00_06 clk_cnt_00_06, 
    pv_00_06_rep clk_cnt_00_06_rep,
    pv_00_06_drw clk_cnt_00_06_drw,
    pge_id_cnt,
    pge_id_cnt_00_06,
    drw_stp_0_clk_cnt,
    drw_stp_1_clk_cnt,
    drw_stp_2_clk_cnt,
    rep_ent_clk_cnt,
    rep_my_bil_clk_cnt,
    rep_con_clk_cnt
from ads_app_collect.dp_dmining_f_user_behavior_tracker
where date_add(to_date(ds, 'yyyymmdd'), 0) between  add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0),-4) and date_add(to_date('${bizdate}', 'yyyymmdd'), 0)
;



drop table if exists ${dwa_risk}.dz_model_temp_8active_dau_model_data;
create table ${dwa_risk}.dz_model_temp_8active_dau_model_data as
select model_data.uid
        ,dau_dt
        ,mdl_dte
        ,datediff(date(mdl_dte),dau_dt) as ddf_mdl_dau_dte
from    (select uid,dt dau_dt
        from ${dwa_risk}.dwa_risk_dz_model_temp_behavior_01  -- 优化成传入最大最小评分日，减少计算量
        ) uid_dau_dt
        join dwa_risk.dwa_risk_f_dz_model_data_base model_data on uid_dau_dt.uid = model_data.uid
        ;


drop table if exists ${dwa_risk}.dz_model_temp_8active_dau7_summary;
create table ${dwa_risk}.dz_model_temp_8active_dau7_summary as
select uid
        ,mdl_dte
-- features range start --
        ,sum(con_dts) as dau_7d
        ,max(max_dt) as max_dau_dt_7d
        ,max(con_dts) as max_con_dau_7d
        ,max(case when con_dts >=2 and rn = 1 then max_dt end) as max_con_dau_dt_7d
-- features range end --
from
        (select uid
                ,mdl_dte
                ,con_dts
                ,min_dt
                ,max_dt
                ,row_number() over(partition by uid order by con_dts desc,max_dt desc) rn
        from
                (select uid
                        ,mdl_dte
                        ,count(rn) AS con_dts
                        ,min(dau_dt) AS min_dt
                        ,max(dau_dt) AS max_dt
                from
                        (select uid
                                ,mdl_dte
                                ,row_number() over (partition by uid order by dau_dt) AS rn
                                ,date_add(dau_dt,-row_number() over (partition by uid order by dau_dt)) AS grp
                                ,dau_dt
                        from
                                (select uid
                                        ,dau_dt
                                        ,mdl_dte
                                from ${dwa_risk}.dz_model_temp_8active_dau_model_data
                                where ddf_mdl_dau_dte between 1 and 7
                                ) uid_dau_dt
                        ) groups
                GROUP BY uid,mdl_dte,grp
                ) flatted
        ) details
group by uid,mdl_dte;


drop table if exists ${dwa_risk}.dz_model_temp_8active_dau14_summary;
create table ${dwa_risk}.dz_model_temp_8active_dau14_summary as
select uid
        ,mdl_dte
-- features range start --
        ,sum(con_dts) as dau_14d
        ,max(max_dt) as max_dau_dt_14d
        ,max(con_dts) as max_con_dau_14d
        ,max(case when con_dts >=2 and rn = 1 then max_dt end) as max_con_dau_dt_14d
-- features range end --

from
        (select uid
                ,mdl_dte
                ,con_dts
                ,min_dt
                ,max_dt
                ,row_number() over(partition by uid order by con_dts desc,max_dt desc) rn
        from
                (select uid
                        ,mdl_dte
                        ,count(rn) AS con_dts
                        ,min(dau_dt) AS min_dt
                        ,max(dau_dt) AS max_dt
                from
                        (select uid
                                ,mdl_dte
                                ,row_number() over (partition by uid order by dau_dt) AS rn
                                ,date_add(dau_dt,-row_number() over (partition by uid order by dau_dt)) AS grp
                                ,dau_dt
                        from
                                (select uid
                                        ,dau_dt
                                        ,mdl_dte
                                from ${dwa_risk}.dz_model_temp_8active_dau_model_data
                                where ddf_mdl_dau_dte between 1 and 14
                                ) uid_dau_dt
                        ) groups
                GROUP BY uid,mdl_dte,grp
                ) flatted
        ) details
group by uid,mdl_dte;


drop table if exists ${dwa_risk}.dz_model_temp_8active_dau30_summary;
create table ${dwa_risk}.dz_model_temp_8active_dau30_summary as
select uid
        ,mdl_dte
-- features range start --
        ,sum(con_dts) as dau_30d
        ,max(max_dt) as max_dau_dt_30d
        ,max(con_dts) as max_con_dau_30d
        ,max(case when con_dts >=2 and rn = 1 then max_dt end) as max_con_dau_dt_30d
-- features range end --
from
        (select uid
                ,mdl_dte
                ,con_dts
                ,min_dt
                ,max_dt
                ,row_number() over(partition by uid order by con_dts desc,max_dt desc) rn
        from
                (select uid
                        ,mdl_dte
                        ,count(rn) AS con_dts
                        ,min(dau_dt) AS min_dt
                        ,max(dau_dt) AS max_dt
                from
                        (select uid
                                ,mdl_dte
                                ,row_number() over (partition by uid order by dau_dt) AS rn
                                ,date_add(dau_dt,-row_number() over (partition by uid order by dau_dt)) AS grp
                                ,dau_dt
                        from
                                (select uid
                                        ,dau_dt
                                        ,mdl_dte
                                from ${dwa_risk}.dz_model_temp_8active_dau_model_data
                                where ddf_mdl_dau_dte between 1 and 30
                                ) uid_dau_dt
                        ) groups
                GROUP BY uid,mdl_dte,grp
                ) flatted
        ) details
group by uid,mdl_dte;



drop table if exists ${dwa_risk}.dz_model_temp_8active_dau90_summary;
create table ${dwa_risk}.dz_model_temp_8active_dau90_summary as
select uid
        ,mdl_dte
-- features range start --
        ,sum(con_dts) as dau_90d
        ,max(max_dt) as max_dau_dt_90d
        ,max(con_dts) as max_con_dau_90d
        ,max(case when con_dts >=2 and rn = 1 then max_dt end) as max_con_dau_dt_90d
-- features range end --
from
        (select uid
                ,mdl_dte
                ,con_dts
                ,min_dt,max_dt
                ,row_number() over(partition by uid order by con_dts desc,max_dt desc) rn
        from
                (select uid
                        ,mdl_dte
                        ,count(rn) AS con_dts
                        ,min(dau_dt) AS min_dt
                        ,max(dau_dt) AS max_dt
                from
                        (select uid
                                ,mdl_dte
                                ,row_number() over (partition by uid order by dau_dt) AS rn
                                ,date_add(dau_dt,-row_number() over (partition by uid order by dau_dt)) AS grp
                                ,dau_dt
                        from
                                (select uid
                                        ,dau_dt
                                        ,mdl_dte
                                from ${dwa_risk}.dz_model_temp_8active_dau_model_data
                                where ddf_mdl_dau_dte between 1 and 90
                                ) uid_dau_dt
                        ) groups
                GROUP BY uid,mdl_dte,grp
                ) flatted
        ) details
group by uid,mdl_dte;



-- Merge sub-tables ！！！ 根据最终入模特征决定需要的 temp 表 ！！！
insert  overwrite table ${dwa_risk}.dwa_risk_dz_model_final_8active_dau partition(ds = '${bizdate}')
select  model_data.uid
        ,model_data.mdl_dte -- features range start --
        ,coalesce(dau_1d ,0) as dau_1d
        ,coalesce(dau_7d ,0) as dau_7d
        ,coalesce(max_con_dau_7d ,0) as max_con_dau_7d
        ,datediff(model_data.mdl_dte ,max_dau_dt_7d) as ddf_mdl_max_dau_dt_7d
        ,datediff(model_data.mdl_dte ,max_con_dau_dt_7d) as ddf_mdl_max_con_dau_dt_7d
        ,coalesce(dau_14d ,0) as dau_14d
        ,coalesce(max_con_dau_14d ,0) as max_con_dau_14d
        ,datediff(model_data.mdl_dte ,max_dau_dt_14d) as ddf_mdl_max_dau_dt_14d
        ,datediff(model_data.mdl_dte ,max_con_dau_dt_14d) as ddf_mdl_max_con_dau_dt_14d
        ,coalesce(dau_30d ,0) as dau_30d
        ,coalesce(max_con_dau_30d ,0) as max_con_dau_30d
        ,datediff(model_data.mdl_dte ,max_dau_dt_30d) as ddf_mdl_max_dau_dt_30d
        ,datediff(model_data.mdl_dte ,max_con_dau_dt_30d) as ddf_mdl_max_con_dau_dt_30d
        ,coalesce(dau_90d ,0) as dau_90d
        ,coalesce(max_con_dau_90d ,0) as max_con_dau_90d
        ,datediff(model_data.mdl_dte ,max_dau_dt_90d) as ddf_mdl_max_dau_dt_90d
        ,datediff(model_data.mdl_dte ,max_con_dau_dt_90d) as ddf_mdl_max_con_dau_dt_90d -- features range end --
from    (
            select  uid
                    ,mdl_dte
            from    dwa_risk.dwa_risk_f_dz_model_data_base 
        ) model_data --建模样本数据集
left join  (
              select  uid
                      ,mdl_dte -- features range start --
                      ,1 as dau_1d -- features range end --
              from    ${dwa_risk}.dz_model_temp_8active_dau_model_data
              where   ddf_mdl_dau_dte = 1
            ) uid_1d
on      model_data.uid = uid_1d.uid
left join  (
              select  uid
                      ,mdl_dte -- features range start --
                      ,dau_7d
                      ,max_dau_dt_7d
                      ,max_con_dau_7d
                      ,max_con_dau_dt_7d -- features range end --
              from    ${dwa_risk}.dz_model_temp_8active_dau7_summary
            ) uid_7d
on      model_data.uid = uid_7d.uid
left join  (
              select  uid
                      ,mdl_dte -- features range start --
                      ,dau_14d
                      ,max_dau_dt_14d
                      ,max_con_dau_14d
                      ,max_con_dau_dt_14d -- features range end --
              from    ${dwa_risk}.dz_model_temp_8active_dau14_summary
            ) uid_14d
on      model_data.uid = uid_14d.uid
left join  (
              select  uid
                      ,mdl_dte -- features range start --
                      ,dau_30d
                      ,max_dau_dt_30d
                      ,max_con_dau_30d
                      ,max_con_dau_dt_30d -- features range end --
              from    ${dwa_risk}.dz_model_temp_8active_dau30_summary
            ) uid_30d
on      model_data.uid = uid_30d.uid
left join  (
              select  uid
                      ,mdl_dte -- features range start --
                      ,dau_90d
                      ,max_dau_dt_90d
                      ,max_con_dau_90d
                      ,max_con_dau_dt_90d -- features range end --
              from    ${dwa_risk}.dz_model_temp_8active_dau90_summary
            ) uid_90d
on      model_data.uid = uid_90d.uid;
-- feature-copilot:node-end ordinal=0
