-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_8active_page_view_n_click_cnt
-- node_id: n_4240514154448289794
-- task_name: dwa_risk_dz_model_final_8active_page_view_n_click_cnt
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_8active_page_view_n_click_cnt.json
-- source_json_sha256: 96d8fb98aef2b193bb6eacf05cbb54949488a8687ace6c826134be7a9ec15b19
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_behavior
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dbus.dbus_dp_dmining_f_user_behavior_tracker

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 裴阳
--创建日期: 2022-10-27 11:25:32
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_8active_page_view_n_click_cnt(
  uid STRING
  ,mdl_dte DATE
  ,dau_00_06_1d BIGINT
  ,clk_cnt_1d BIGINT
  ,clk_cnt_00_06_1d BIGINT
  ,clk_cnt_00_06_rep_1d BIGINT
  ,clk_cnt_00_06_drw_1d BIGINT
  ,pge_id_cnt_00_06_1d BIGINT
  ,pge_id_cnt_1d BIGINT
  ,dau_00_06_7d BIGINT
  ,clk_cnt_7d BIGINT
  ,clk_cnt_00_06_7d BIGINT
  ,clk_cnt_00_06_rep_7d BIGINT
  ,clk_cnt_00_06_drw_7d BIGINT
  ,pge_id_cnt_00_06_7d BIGINT
  ,pge_id_cnt_7d BIGINT
  ,dau_00_06_14d BIGINT
  ,clk_cnt_14d BIGINT
  ,clk_cnt_00_06_14d BIGINT
  ,clk_cnt_00_06_rep_14d BIGINT
  ,clk_cnt_00_06_drw_14d BIGINT
  ,pge_id_cnt_00_06_14d BIGINT
  ,pge_id_cnt_14d BIGINT
  ,dau_00_06_30d BIGINT
  ,clk_cnt_30d BIGINT
  ,clk_cnt_00_06_30d BIGINT
  ,clk_cnt_00_06_rep_30d BIGINT
  ,clk_cnt_00_06_drw_30d BIGINT
  ,pge_id_cnt_00_06_30d BIGINT
  ,pge_id_cnt_30d BIGINT
  ,dau_00_06_90d BIGINT
  ,clk_cnt_90d BIGINT
  ,clk_cnt_00_06_90d BIGINT
  ,clk_cnt_00_06_rep_90d BIGINT
  ,clk_cnt_00_06_drw_90d BIGINT
  ,pge_id_cnt_00_06_90d BIGINT
  ,pge_id_cnt_90d BIGINT
) comment "app点击信息数据表" 
partitioned by (ds string comment '分区字段,格式yyyymmdd');
------------------------临时表1------------------------------
drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_behavior;
create table ${dwa_risk}.dwa_risk_dz_model_temp_behavior as 
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
from dbus.dbus_dp_dmining_f_user_behavior_tracker
where date_add(to_date(ds, 'yyyymmdd'), 0) between  add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0),-4) and date_add(to_date('${bizdate}', 'yyyymmdd'), 0)
;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_8active_page_view_n_click_cnt partition(ds='${bizdate}')
select model_data.uid
      ,model_data.mdl_dte
-- features range start --
       ,count(case when datediff(model_data.mdl_dte,dt) = 1 and clk_cnt_00_06 > 0 then clk_cnt_00_06 end) as dau_00_06_1d
       ,sum(case when datediff(model_data.mdl_dte,dt) = 1 then coalesce(clk_cnt,0) else 0 end) as clk_cnt_1d
       ,sum(case when datediff(model_data.mdl_dte,dt) = 1 then coalesce(clk_cnt_00_06,0) else 0 end) as clk_cnt_00_06_1d
       ,sum(case when datediff(model_data.mdl_dte,dt) = 1 then coalesce(clk_cnt_00_06_rep,0) else 0 end) as clk_cnt_00_06_rep_1d
       ,sum(case when datediff(model_data.mdl_dte,dt) = 1 then coalesce(clk_cnt_00_06_drw,0) else 0 end) as clk_cnt_00_06_drw_1d
       ,sum(case when datediff(model_data.mdl_dte,dt) = 1 then coalesce(pge_id_cnt_00_06,0) else 0 end) as pge_id_cnt_00_06_1d
       ,sum(case when datediff(model_data.mdl_dte,dt) = 1 then coalesce(pge_id_cnt,0) else 0 end) as pge_id_cnt_1d
       
       ,count(case when datediff(model_data.mdl_dte,dt) between 1 and 7 and clk_cnt_00_06 > 0 then clk_cnt_00_06 end) as dau_00_06_7d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 7 then coalesce(clk_cnt,0) else 0 end) as clk_cnt_7d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 7 then coalesce(clk_cnt_00_06,0) else 0 end) as clk_cnt_00_06_7d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 7 then coalesce(clk_cnt_00_06_rep,0) else 0 end) as clk_cnt_00_06_rep_7d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 7 then coalesce(clk_cnt_00_06_drw,0) else 0 end) as clk_cnt_00_06_drw_7d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 7 then coalesce(pge_id_cnt_00_06,0) else 0 end) as pge_id_cnt_00_06_7d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 7 then coalesce(pge_id_cnt,0) else 0 end) as pge_id_cnt_7d
       
       ,count(case when datediff(model_data.mdl_dte,dt) between 1 and 14 and clk_cnt_00_06 > 0 then clk_cnt_00_06 end) as dau_00_06_14d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 14 then coalesce(clk_cnt,0) else 0 end) as clk_cnt_14d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 14 then coalesce(clk_cnt_00_06,0) else 0 end) as clk_cnt_00_06_14d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 14 then coalesce(clk_cnt_00_06_rep,0) else 0 end) as clk_cnt_00_06_rep_14d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 14 then coalesce(clk_cnt_00_06_drw,0) else 0 end) as clk_cnt_00_06_drw_14d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 14 then coalesce(pge_id_cnt_00_06,0) else 0 end) as pge_id_cnt_00_06_14d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 14 then coalesce(pge_id_cnt,0) else 0 end) as pge_id_cnt_14d
       
       ,count(case when datediff(model_data.mdl_dte,dt) between 1 and 30 and clk_cnt_00_06 > 0 then clk_cnt_00_06 end) as dau_00_06_30d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 30 then coalesce(clk_cnt,0) else 0 end) as clk_cnt_30d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 30 then coalesce(clk_cnt_00_06,0) else 0 end) as clk_cnt_00_06_30d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 30 then coalesce(clk_cnt_00_06_rep,0) else 0 end) as clk_cnt_00_06_rep_30d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 30 then coalesce(clk_cnt_00_06_drw,0) else 0 end) as clk_cnt_00_06_drw_30d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 30 then coalesce(pge_id_cnt_00_06,0) else 0 end) as pge_id_cnt_00_06_30d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 30 then coalesce(pge_id_cnt,0) else 0 end) as pge_id_cnt_30d
       
       ,count(case when datediff(model_data.mdl_dte,dt) between 1 and 90 and clk_cnt_00_06 > 0 then clk_cnt_00_06 end) as dau_00_06_90d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 90 then coalesce(clk_cnt,0) else 0 end) as clk_cnt_90d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 90 then coalesce(clk_cnt_00_06,0) else 0 end) as clk_cnt_00_06_90d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 90 then coalesce(clk_cnt_00_06_rep,0) else 0 end) as clk_cnt_00_06_rep_90d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 90 then coalesce(clk_cnt_00_06_drw,0) else 0 end) as clk_cnt_00_06_drw_90d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 90 then coalesce(pge_id_cnt_00_06,0) else 0 end) as pge_id_cnt_00_06_90d
       ,sum(case when datediff(model_data.mdl_dte,dt) between 1 and 90 then coalesce(pge_id_cnt,0) else 0 end) as pge_id_cnt_90d
-- features range end --
from dwa_risk.dwa_risk_f_dz_model_data_base model_data
left join ${dwa_risk}.dwa_risk_dz_model_temp_behavior uid_clk_cnt on model_data.uid = uid_clk_cnt.uid
group by model_data.uid
          ,model_data.mdl_dte;
-- feature-copilot:node-end ordinal=0
