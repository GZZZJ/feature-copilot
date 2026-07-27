-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_8active_device_extra_1_df
-- node_id: n_3789904362050879488
-- task_name: dwa_risk_dz_model_final_8active_device_extra_1_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_8active_device_extra_1_df.json
-- source_json_sha256: 2d59bea1680358c5a9a482a109c839a465cfe2f156cf0677461d5764ce9b0001
-- upstream_table: dwa_risk.dwa_risk_f_active_device_detail

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应 ${pdm_risk}.pdm_risk_dz_model_final_8active_device_extra_1_df
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_8active_device_extra_1_df partition (ds='${bizdate}')
select
        uid
        ,mdl_dte
-- features range start --

      -- ,cjj_id -- 动支前最近一次使用设备,
      -- ,datediff(date(lst_app_start_tim),'评分日') ddf_mdl_lst_app_str_dt-- 最近一次app启动时间,
      -- ,to_date(lst_app_start_tim) as lst_app_start_dte --app启动日起,
      ,lat_tud -- 当前最新定位数据,
      ,alt_tud
      ,lng_tud
      -- ,sid_id
      ,os_typ
      ,prv_val
      ,cty_val
      -- 最近一次app启动距动支时长
      ,unix_timestamp(mdl_dte) - unix_timestamp(lst_app_str_tim) as ddf_lst_app_str_tim_to_mdl_tim_sec
      -- 最近一次app启动时间分段（小时）
      ,substr(lst_app_str_tim, 12, 2) as lst_app_str_hr
      
-- features range end --

from ${dwa_risk}.dwa_risk_f_active_device_detail temp
where temp.num = 1;
-- feature-copilot:node-end ordinal=0
