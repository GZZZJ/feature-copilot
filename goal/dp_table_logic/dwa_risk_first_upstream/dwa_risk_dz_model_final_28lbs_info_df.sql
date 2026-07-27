-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_28lbs_info_df
-- node_id: n_6054966794236854273
-- task_name: dwa_risk_dz_model_final_28lbs_info_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_28lbs_info_df.json
-- source_json_sha256: c1060934aa79a3b4b46608f690fe8682eedb786a96feadf295d3150829efecd9
-- upstream_table: ods_pdw_loan.ods_pdw_loan_log_data_collection_di
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 沈喜望
--创建日期: 2024-07-22 11:42:46
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_28lbs_info_df (
uid string comment '用户id',
mdl_dte string comment '评分日',
d3_lbs_collect_cnt string comment'近3天地理位置采集次数',
d3_lbs_collect_uniq_cnt string comment'近3天地理位置变更次数',
d7_lbs_collect_cnt string comment'近7天地理位置采集次数',
d7_lbs_collect_uniq_cnt string comment'近7天地理位置变更次数',
m1_lbs_collect_cnt string comment'近1个月地理位置采集次数',
m1_lbs_collect_uniq_cnt string comment'近1个月地理位置变更次数',
m3_lbs_collect_cnt string comment'近3个月地理位置采集次数',
m3_lbs_collect_uniq_cnt string comment'近3个月地理位置变更次数',
m6_lbs_collect_cnt string comment'近6个月地理位置采集次数',
m6_lbs_collect_uniq_cnt string comment'近6个月地理位置变更次数',
d3_00_03_lbs_collect_cnt string comment'近3天0点-3点地理位置采集次数',
d3_00_03_lbs_collect_uniq_cnt string comment'近3天0点-3点地理位置变更次数',
d3_04_06_lbs_collect_cnt string comment'近3天4点-6点地理位置采集次数',
d3_04_06_lbs_collect_uniq_cnt string comment'近3天4点-6点地理位置变更次数',
d3_07_12_lbs_collect_cnt string comment'近3天7点-12点地理位置采集次数',
d3_07_12_lbs_collect_uniq_cnt string comment'近3天7点-12点地理位置变更次数',
d3_13_18_lbs_collect_cnt string comment'近3天13点-18点地理位置采集次数',
d3_13_18_lbs_collect_uniq_cnt string comment'近3天13点-18点地理位置变更次数',
d3_19_23_lbs_collect_cnt string comment'近3天19点-23点地理位置采集次数',
d3_19_23_lbs_collect_uniq_cnt string comment'近3天19点-23点地理位置变更次数',
d7_00_03_lbs_collect_cnt string comment'近7天0点-3点地理位置采集次数',
d7_00_03_lbs_collect_uniq_cnt string comment'近7天0点-3点地理位置变更次数',
d7_04_06_lbs_collect_cnt string comment'近7天4点-6点地理位置采集次数',
d7_04_06_lbs_collect_uniq_cnt string comment'近7天4点-6点地理位置变更次数',
d7_07_12_lbs_collect_cnt string comment'近7天7点-12点地理位置采集次数',
d7_07_12_lbs_collect_uniq_cnt string comment'近7天7点-12点地理位置变更次数',
d7_13_18_lbs_collect_cnt string comment'近7天13点-18点地理位置采集次数',
d7_13_18_lbs_collect_uniq_cnt string comment'近7天13点-18点地理位置变更次数',
d7_19_23_lbs_collect_cnt string comment'近7天19点-23点地理位置采集次数',
d7_19_23_lbs_collect_uniq_cnt string comment'近7天19点-23点地理位置变更次数',
m1_00_03_lbs_collect_cnt string comment'近1个月0点-3点地理位置采集次数',
m1_00_03_lbs_collect_uniq_cnt string comment'近1个月0点-3点地理位置变更次数',
m1_04_06_lbs_collect_cnt string comment'近1个月4点-6点地理位置采集次数',
m1_04_06_lbs_collect_uniq_cnt string comment'近1个月4点-6点地理位置变更次数',
m1_07_12_lbs_collect_cnt string comment'近1个月7点-12点地理位置采集次数',
m1_07_12_lbs_collect_uniq_cnt string comment'近1个月7点-12点地理位置变更次数',
m1_13_18_lbs_collect_cnt string comment'近1个月13点-18点地理位置采集次数',
m1_13_18_lbs_collect_uniq_cnt string comment'近1个月13点-18点地理位置变更次数',
m1_19_23_lbs_collect_cnt string comment'近1个月19点-23点地理位置采集次数',
m1_19_23_lbs_collect_uniq_cnt string comment'近1个月19点-23点地理位置变更次数',
m3_00_03_lbs_collect_cnt string comment'近3个月0点-3点地理位置采集次数',
m3_00_03_lbs_collect_uniq_cnt string comment'近3个月0点-3点地理位置变更次数',
m3_04_06_lbs_collect_cnt string comment'近3个月4点-6点地理位置采集次数',
m3_04_06_lbs_collect_uniq_cnt string comment'近3个月4点-6点地理位置变更次数',
m3_07_12_lbs_collect_cnt string comment'近3个月7点-12点地理位置采集次数',
m3_07_12_lbs_collect_uniq_cnt string comment'近3个月7点-12点地理位置变更次数',
m3_13_18_lbs_collect_cnt string comment'近3个月13点-18点地理位置采集次数',
m3_13_18_lbs_collect_uniq_cnt string comment'近3个月13点-18点地理位置变更次数',
m3_19_23_lbs_collect_cnt string comment'近3个月19点-23点地理位置采集次数',
m3_19_23_lbs_collect_uniq_cnt string comment'近3个月19点-23点地理位置变更次数',
m6_00_03_lbs_collect_cnt string comment'近6个月0点-3点地理位置采集次数',
m6_00_03_lbs_collect_uniq_cnt string comment'近6个月0点-3点地理位置变更次数',
m6_04_06_lbs_collect_cnt string comment'近6个月4点-6点地理位置采集次数',
m6_04_06_lbs_collect_uniq_cnt string comment'近6个月4点-6点地理位置变更次数',
m6_07_12_lbs_collect_cnt string comment'近6个月7点-12点地理位置采集次数',
m6_07_12_lbs_collect_uniq_cnt string comment'近6个月7点-12点地理位置变更次数',
m6_13_18_lbs_collect_cnt string comment'近6个月13点-18点地理位置采集次数',
m6_13_18_lbs_collect_uniq_cnt string comment'近6个月13点-18点地理位置变更次数',
m6_19_23_lbs_collect_cnt string comment'近6个月19点-23点地理位置采集次数',
m6_19_23_lbs_collect_uniq_cnt string comment'近6个月19点-23点地理位置变更次数',
d3_east_lbs_collect_cnt string comment'近3天华东地区地理位置采集次数',
d3_east_lbs_collect_uniq_cnt string comment'近3天华东地区地理位置变更次数',
d3_northwest_lbs_collect_cnt string comment'近3天西北地区地理位置采集次数',
d3_northwest_lbs_collect_uniq_cnt string comment'近3天西北地区地理位置变更次数',
d3_north_lbs_collect_cnt string comment'近3天华北地区地理位置采集次数',
d3_north_lbs_collect_uniq_cnt string comment'近3天华北地区地理位置变更次数',
d3_central_lbs_collect_cnt string comment'近3天华中地区地理位置采集次数',
d3_central_lbs_collect_uniq_cnt string comment'近3天华中地区地理位置变更次数',
d3_northeast_lbs_collect_cnt string comment'近3天东北地区地理位置采集次数',
d3_northeast_lbs_collect_uniq_cnt string comment'近3天东北地区地理位置变更次数',
d3_south_lbs_collect_cnt string comment'近3天华南地区地理位置采集次数',
d3_south_lbs_collect_uniq_cnt string comment'近3天华南地区地理位置变更次数',
d3_other_lbs_collect_cnt string comment'近3天其他地区地理位置采集次数',
d3_other_lbs_collect_uniq_cnt string comment'近3天其他地区地理位置变更次数',
d7_east_lbs_collect_cnt string comment'近7天华东地区地理位置采集次数',
d7_east_lbs_collect_uniq_cnt string comment'近7天华东地区地理位置变更次数',
d7_northwest_lbs_collect_cnt string comment'近7天西北地区地理位置采集次数',
d7_northwest_lbs_collect_uniq_cnt string comment'近7天西北地区地理位置变更次数',
d7_north_lbs_collect_cnt string comment'近7天华北地区地理位置采集次数',
d7_north_lbs_collect_uniq_cnt string comment'近7天华北地区地理位置变更次数',
d7_central_lbs_collect_cnt string comment'近7天华中地区地理位置采集次数',
d7_central_lbs_collect_uniq_cnt string comment'近7天华中地区地理位置变更次数',
d7_northeast_lbs_collect_cnt string comment'近7天东北地区地理位置采集次数',
d7_northeast_lbs_collect_uniq_cnt string comment'近7天东北地区地理位置变更次数',
d7_south_lbs_collect_cnt string comment'近7天华南地区地理位置采集次数',
d7_south_lbs_collect_uniq_cnt string comment'近7天华南地区地理位置变更次数',
d7_other_lbs_collect_cnt string comment'近7天其他地区地理位置采集次数',
d7_other_lbs_collect_uniq_cnt string comment'近7天其他地区地理位置变更次数',
m1_east_lbs_collect_cnt string comment'近1个月华东地区地理位置采集次数',
m1_east_lbs_collect_uniq_cnt string comment'近1个月天华东地区地理位置变更次数',
m1_northwest_lbs_collect_cnt string comment'近1个月西北地区地理位置采集次数',
m1_northwest_lbs_collect_uniq_cnt string comment'近1个月天西北地区地理位置变更次数',
m1_north_lbs_collect_cnt string comment'近1个月华北地区地理位置采集次数',
m1_north_lbs_collect_uniq_cnt string comment'近1个月华北地区地理位置变更次数',
m1_central_lbs_collect_cnt string comment'近1个月华中地区地理位置采集次数',
m1_central_lbs_collect_uniq_cnt string comment'近1个月华中地区地理位置变更次数',
m1_northeast_lbs_collect_cnt string comment'近1个月东北地区地理位置采集次数',
m1_northeast_lbs_collect_uniq_cnt string comment'近1个月东北地区地理位置变更次数',
m1_south_lbs_collect_cnt string comment'近1个月华南地区地理位置采集次数',
m1_south_lbs_collect_uniq_cnt string comment'近1个月华南地区地理位置变更次数',
m1_other_lbs_collect_cnt string comment'近1个月其他地区地理位置采集次数',
m1_other_lbs_collect_uniq_cnt string comment'近1个月其他地区地理位置变更次数',
m3_east_lbs_collect_cnt string comment'近3个月华东地区地理位置采集次数',
m3_east_lbs_collect_uniq_cnt string comment'近3个月天华东地区地理位置变更次数',
m3_northwest_lbs_collect_cnt string comment'近3个月西北地区地理位置采集次数',
m3_northwest_lbs_collect_uniq_cnt string comment'近3个月天西北地区地理位置变更次数',
m3_north_lbs_collect_cnt string comment'近3个月华北地区地理位置采集次数',
m3_north_lbs_collect_uniq_cnt string comment'近3个月华北地区地理位置变更次数',
m3_central_lbs_collect_cnt string comment'近3个月华中地区地理位置采集次数',
m3_central_lbs_collect_uniq_cnt string comment'近3个月华中地区地理位置变更次数',
m3_northeast_lbs_collect_cnt string comment'近3个月东北地区地理位置采集次数',
m3_northeast_lbs_collect_uniq_cnt string comment'近3个月东北地区地理位置变更次数',
m3_south_lbs_collect_cnt string comment'近3个月华南地区地理位置采集次数',
m3_south_lbs_collect_uniq_cnt string comment'近3个月华南地区地理位置变更次数',
m3_other_lbs_collect_cnt string comment'近3个月其他地区地理位置采集次数',
m3_other_lbs_collect_uniq_cnt string comment'近3个月其他地区地理位置变更次数',
m6_east_lbs_collect_cnt string comment'近6个月华东地区地理位置采集次数',
m6_east_lbs_collect_uniq_cnt string comment'近6个月天华东地区地理位置变更次数',
m6_northwest_lbs_collect_cnt string comment'近6个月西北地区地理位置采集次数',
m6_northwest_lbs_collect_uniq_cnt string comment'近6个月天西北地区地理位置变更次数',
m6_north_lbs_collect_cnt string comment'近6个月华北地区地理位置采集次数',
m6_north_lbs_collect_uniq_cnt string comment'近6个月华北地区地理位置变更次数',
m6_central_lbs_collect_cnt string comment'近6个月华中地区地理位置采集次数',
m6_central_lbs_collect_uniq_cnt string comment'近6个月华中地区地理位置变更次数',
m6_northeast_lbs_collect_cnt string comment'近6个月东北地区地理位置采集次数',
m6_northeast_lbs_collect_uniq_cnt string comment'近6个月东北地区地理位置变更次数',
m6_south_lbs_collect_cnt string comment'近6个月华南地区地理位置采集次数',
m6_south_lbs_collect_uniq_cnt string comment'近6个月华南地区地理位置变更次数',
m6_other_lbs_collect_cnt string comment'近6个月其他地区地理位置采集次数',
m6_other_lbs_collect_uniq_cnt string comment'近6个月其他地区地理位置变更次数',
d3_level0_city_lbs_collect_cnt string comment'近3天超一线城市地理位置采集次数',
d3_level0_city_lbs_collect_uniq_cnt string comment'近3天超一线城市地理位置变更次数',
d3_level1_city_lbs_collect_cnt string comment'近3天一线城市地理位置采集次数',
d3_level1_city_lbs_collect_uniq_cnt string comment'近3天一线城市地理位置变更次数',
d3_level2_city_lbs_collect_cnt string comment'近3天二线城市地理位置采集次数',
d3_level2_city_lbs_collect_uniq_cnt string comment'近3天二线城市地理位置变更次数',
d3_level3_city_lbs_collect_cnt string comment'近3天三线城市地理位置采集次数',
d3_level3_city_lbs_collect_uniq_cnt string comment'近3天三线城市地理位置变更次数',
d3_level4_city_lbs_collect_cnt string comment'近3天四线城市地理位置采集次数',
d3_level4_city_lbs_collect_uniq_cnt string comment'近3天四线城市地理位置变更次数',
d3_level5_city_lbs_collect_cnt string comment'近3天五线城市地理位置采集次数',
d3_level5_city_lbs_collect_uniq_cnt string comment'近3天五线城市地理位置变更次数',
d3_other_city_lbs_collect_cnt string comment'近3天其他城市地理位置采集次数',
d3_other_city_lbs_collect_uniq_cnt string comment'近3天其他城市地理位置变更次数',
d7_level0_city_lbs_collect_cnt string comment'近7天超一线城市地理位置采集次数',
d7_level0_city_lbs_collect_uniq_cnt string comment'近7天超一线城市地理位置变更次数',
d7_level1_city_lbs_collect_cnt string comment'近7天一线城市地理位置采集次数',
d7_level1_city_lbs_collect_uniq_cnt string comment'近7天一线城市地理位置变更次数',
d7_level2_city_lbs_collect_cnt string comment'近7天二线城市地理位置采集次数',
d7_level2_city_lbs_collect_uniq_cnt string comment'近7天二线城市地理位置变更次数',
d7_level3_city_lbs_collect_cnt string comment'近7天三线城市地理位置采集次数',
d7_level3_city_lbs_collect_uniq_cnt string comment'近7天三线城市地理位置变更次数',
d7_level4_city_lbs_collect_cnt string comment'近7天四线城市地理位置采集次数',
d7_level4_city_lbs_collect_uniq_cnt string comment'近7天四线城市地理位置变更次数',
d7_level5_city_lbs_collect_cnt string comment'近7天五线城市地理位置采集次数',
d7_level5_city_lbs_collect_uniq_cnt string comment'近7天五线城市地理位置变更次数',
d7_other_city_lbs_collect_cnt string comment'近7天其他城市地理位置采集次数',
d7_other_city_lbs_collect_uniq_cnt string comment'近7天其他城市地理位置变更次数',
m1_level0_city_lbs_collect_cnt string comment'近1个月超一线城市地理位置采集次数',
m1_level0_city_lbs_collect_uniq_cnt string comment'近1个月超一线城市地理位置变更次数',
m1_level1_city_lbs_collect_cnt string comment'近1个月一线城市地理位置采集次数',
m1_level1_city_lbs_collect_uniq_cnt string comment'近1个月一线城市地理位置变更次数',
m1_level2_city_lbs_collect_cnt string comment'近1个月二线城市地理位置采集次数',
m1_level2_city_lbs_collect_uniq_cnt string comment'近1个月二线城市地理位置变更次数',
m1_level3_city_lbs_collect_cnt string comment'近1个月三线城市地理位置采集次数',
m1_level3_city_lbs_collect_uniq_cnt string comment'近1个月三线城市地理位置变更次数',
m1_level4_city_lbs_collect_cnt string comment'近1个月四线城市地理位置采集次数',
m1_level4_city_lbs_collect_uniq_cnt string comment'近1个月四线城市地理位置变更次数',
m1_level5_city_lbs_collect_cnt string comment'近1个月五线城市地理位置采集次数',
m1_level5_city_lbs_collect_uniq_cnt string comment'近1个月五线城市地理位置变更次数',
m1_other_city_lbs_collect_cnt string comment'近1个月其他城市地理位置采集次数',
m1_other_city_lbs_collect_uniq_cnt string comment'近1个月其他城市地理位置变更次数',
m3_level0_city_lbs_collect_cnt string comment'近3个月超一线城市地理位置采集次数',
m3_level0_city_lbs_collect_uniq_cnt string comment'近3个月超一线城市地理位置变更次数',
m3_level1_city_lbs_collect_cnt string comment'近3个月一线城市地理位置采集次数',
m3_level1_city_lbs_collect_uniq_cnt string comment'近3个月一线城市地理位置变更次数',
m3_level2_city_lbs_collect_cnt string comment'近3个月二线城市地理位置采集次数',
m3_level2_city_lbs_collect_uniq_cnt string comment'近3个月二线城市地理位置变更次数',
m3_level3_city_lbs_collect_cnt string comment'近3个月三线城市地理位置采集次数',
m3_level3_city_lbs_collect_uniq_cnt string comment'近3个月三线城市地理位置变更次数',
m3_level4_city_lbs_collect_cnt string comment'近3个月四线城市地理位置采集次数',
m3_level4_city_lbs_collect_uniq_cnt string comment'近3个月四线城市地理位置变更次数',
m3_level5_city_lbs_collect_cnt string comment'近3个月五线城市地理位置采集次数',
m3_level5_city_lbs_collect_uniq_cnt string comment'近3个月五线城市地理位置变更次数',
m3_other_city_lbs_collect_cnt string comment'近3个月其他城市地理位置采集次数',
m3_other_city_lbs_collect_uniq_cnt string comment'近3个月其他城市地理位置变更次数',
m6_level0_city_lbs_collect_cnt string comment'近6个月超一线城市地理位置采集次数',
m6_level0_city_lbs_collect_uniq_cnt string comment'近6个月超一线城市地理位置变更次数',
m6_level1_city_lbs_collect_cnt string comment'近6个月一线城市地理位置采集次数',
m6_level1_city_lbs_collect_uniq_cnt string comment'近6个月一线城市地理位置变更次数',
m6_level2_city_lbs_collect_cnt string comment'近6个月二线城市地理位置采集次数',
m6_level2_city_lbs_collect_uniq_cnt string comment'近6个月二线城市地理位置变更次数',
m6_level3_city_lbs_collect_cnt string comment'近6个月三线城市地理位置采集次数',
m6_level3_city_lbs_collect_uniq_cnt string comment'近6个月三线城市地理位置变更次数',
m6_level4_city_lbs_collect_cnt string comment'近6个月四线城市地理位置采集次数',
m6_level4_city_lbs_collect_uniq_cnt string comment'近6个月四线城市地理位置变更次数',
m6_level5_city_lbs_collect_cnt string comment'近6个月五线城市地理位置采集次数',
m6_level5_city_lbs_collect_uniq_cnt string comment'近6个月五线城市地理位置变更次数',
m6_other_city_lbs_collect_cnt string comment'近6个月其他城市地理位置采集次数',
m6_other_city_lbs_collect_uniq_cnt string comment'近6个月其他城市地理位置变更次数',
m1_lbs_collect_distance_sum string comment'近1个月地理位置活动范围总计值（公里）',
m1_lbs_collect_distance_min string comment'近1个月地理位置活动范围最小值（公里）',
m1_lbs_collect_distance_max string comment'近1个月地理位置活动范围最大值（公里）',
m1_lbs_collect_distance_avg string comment'近1个月地理位置活动范围平均值（公里）',
m3_lbs_collect_distance_sum string comment'近3个月地理位置活动范围总计值（公里）',
m3_lbs_collect_distance_min string comment'近3个月地理位置活动范围最小值（公里）',
m3_lbs_collect_distance_max string comment'近3个月地理位置活动范围最大值（公里）',
m3_lbs_collect_distance_avg string comment'近3个月地理位置活动范围平均值（公里）',
m6_lbs_collect_distance_sum string comment'近6个月地理位置活动范围总计值（公里）',
m6_lbs_collect_distance_min string comment'近6个月地理位置活动范围最小值（公里）',
m6_lbs_collect_distance_max string comment'近6个月地理位置活动范围最大值（公里）',
m6_lbs_collect_distance_avg string comment'近6个月地理位置活动范围平均值（公里）'
) comment '贷中lbs变量宽表' partitioned by (ds string comment '业务日期分区，格式yyyymmdd');


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_28lbs_info_df partition (ds = '${bizdate}')
select uid,
       mdl_dte,

       ---- 不同时间窗口内lbs采集与uniq采集数
	   count(case when ddf_mdl_event_time between 1 and 3 then lbs_info else null end) as d3_lbs_collect_cnt, 
       count(distinct case when ddf_mdl_event_time between 1 and 3 then lbs_info else null end) as d3_lbs_collect_uniq_cnt,
	   count(case when ddf_mdl_event_time between 1 and 7 then lbs_info else null end) as d7_lbs_collect_cnt, 
       count(distinct case when ddf_mdl_event_time between 1 and 7 then lbs_info else null end) as d7_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 then lbs_info else null end) as m1_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 then lbs_info else null end) as m1_lbs_collect_uniq_cnt,      
       count(case when m3_flg = 1 then lbs_info else null end) as m3_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 then lbs_info else null end) as m3_lbs_collect_uniq_cnt,      
       count(case when m6_flg = 1 then lbs_info else null end) as m6_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 then lbs_info else null end) as m6_lbs_collect_uniq_cnt, 

    --- 不同时间窗口内不同时间段采集与uniq采集数
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d3_00_03_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d3_00_03_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d3_04_06_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d3_04_06_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d3_07_12_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d3_07_12_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d3_13_18_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d3_13_18_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d3_19_23_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d3_19_23_lbs_collect_uniq_cnt,
     
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d7_00_03_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d7_00_03_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d7_04_06_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d7_04_06_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d7_07_12_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d7_07_12_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d7_13_18_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d7_13_18_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d7_19_23_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d7_19_23_lbs_collect_uniq_cnt,

       count(case when m1_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m1_00_03_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m1_00_03_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m1_04_06_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m1_04_06_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m1_07_12_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m1_07_12_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m1_13_18_lbs_collect_cnt,
       count(distinct case when m1_flg = 1  and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m1_13_18_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m1_19_23_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m1_19_23_lbs_collect_uniq_cnt,

       count(case when m3_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m3_00_03_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m3_00_03_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m3_04_06_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m3_04_06_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m3_07_12_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m3_07_12_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m3_13_18_lbs_collect_cnt,
       count(distinct case when m3_flg = 1  and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m3_13_18_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m3_19_23_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m3_19_23_lbs_collect_uniq_cnt,

       count(case when m6_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m6_00_03_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m6_00_03_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m6_04_06_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m6_04_06_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m6_07_12_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m6_07_12_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m6_13_18_lbs_collect_cnt,
       count(distinct case when m6_flg = 1  and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m6_13_18_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m6_19_23_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m6_19_23_lbs_collect_uniq_cnt,
    
       --- 不同时间窗口内不同地区采集与uniq采集数
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '01_华东' then lbs_info else null end) as d3_east_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '01_华东' then lbs_info else null end) as d3_east_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '02_西北' then lbs_info else null end) as d3_northwest_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '02_西北' then lbs_info else null end) as d3_northwest_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '03_华北' then lbs_info else null end) as d3_north_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '03_华北' then lbs_info else null end) as d3_north_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '04_华中' then lbs_info else null end) as d3_central_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '04_华中' then lbs_info else null end) as d3_central_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '05_东北' then lbs_info else null end) as d3_northeast_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '05_东北' then lbs_info else null end) as d3_northeast_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '06_华南' then lbs_info else null end) as d3_south_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '06_华南' then lbs_info else null end) as d3_south_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '07_其他' then lbs_info else null end) as d3_other_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '07_其他' then lbs_info else null end) as d3_other_lbs_collect_uniq_cnt,

       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '01_华东' then lbs_info else null end) as d7_east_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '01_华东' then lbs_info else null end) as d7_east_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '02_西北' then lbs_info else null end) as d7_northwest_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '02_西北' then lbs_info else null end) as d7_northwest_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '03_华北' then lbs_info else null end) as d7_north_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '03_华北' then lbs_info else null end) as d7_north_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '04_华中' then lbs_info else null end) as d7_central_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '04_华中' then lbs_info else null end) as d7_central_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '05_东北' then lbs_info else null end) as d7_northeast_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '05_东北' then lbs_info else null end) as d7_northeast_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '06_华南' then lbs_info else null end) as d7_south_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '06_华南' then lbs_info else null end) as d7_south_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '07_其他' then lbs_info else null end) as d7_other_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '07_其他' then lbs_info else null end) as d7_other_lbs_collect_uniq_cnt,

       count(case when m1_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m1_east_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m1_east_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m1_northwest_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m1_northwest_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m1_north_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m1_north_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m1_central_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m1_central_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m1_northeast_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m1_northeast_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m1_south_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m1_south_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m1_other_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m1_other_lbs_collect_uniq_cnt,

       count(case when m3_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m3_east_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m3_east_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m3_northwest_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m3_northwest_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m3_north_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m3_north_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m3_central_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m3_central_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m3_northeast_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m3_northeast_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m3_south_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m3_south_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m3_other_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m3_other_lbs_collect_uniq_cnt,

       count(case when m6_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m6_east_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m6_east_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m6_northwest_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m6_northwest_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m6_north_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m6_north_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m6_central_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m6_central_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m6_northeast_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m6_northeast_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m6_south_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m6_south_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m6_other_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m6_other_lbs_collect_uniq_cnt,
    
       --- 不同时间窗口内不同等级城市采集与uniq采集数
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '0级' then lbs_info else null end) as d3_level0_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '0级' then lbs_info else null end) as d3_level0_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '1级' then lbs_info else null end) as d3_level1_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '1级' then lbs_info else null end) as d3_level1_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '2级' then lbs_info else null end) as d3_level2_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '2级' then lbs_info else null end) as d3_level2_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '3级' then lbs_info else null end) as d3_level3_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '3级' then lbs_info else null end) as d3_level3_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '4级' then lbs_info else null end) as d3_level4_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '4级' then lbs_info else null end) as d3_level4_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '5级' then lbs_info else null end) as d3_level5_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '5级' then lbs_info else null end) as d3_level5_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '其他' then lbs_info else null end) as d3_other_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '其他' then lbs_info else null end) as d3_other_city_lbs_collect_uniq_cnt,

       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '0级' then lbs_info else null end) as d7_level0_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '0级' then lbs_info else null end) as d7_level0_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '1级' then lbs_info else null end) as d7_level1_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '1级' then lbs_info else null end) as d7_level1_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '2级' then lbs_info else null end) as d7_level2_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '2级' then lbs_info else null end) as d7_level2_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '3级' then lbs_info else null end) as d7_level3_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '3级' then lbs_info else null end) as d7_level3_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '4级' then lbs_info else null end) as d7_level4_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '4级' then lbs_info else null end) as d7_level4_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '5级' then lbs_info else null end) as d7_level5_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '5级' then lbs_info else null end) as d7_level5_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '其他' then lbs_info else null end) as d7_other_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '其他' then lbs_info else null end) as d7_other_city_lbs_collect_uniq_cnt,

       count(case when m1_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m1_level0_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m1_level0_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m1_level1_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m1_level1_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m1_level2_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m1_level2_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m1_level3_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m1_level3_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m1_level4_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m1_level4_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m1_level5_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m1_level5_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m1_other_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m1_other_city_lbs_collect_uniq_cnt,

       count(case when m3_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m3_level0_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m3_level0_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m3_level1_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m3_level1_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m3_level2_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m3_level2_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m3_level3_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m3_level3_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m3_level4_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m3_level4_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m3_level5_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m3_level5_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m3_other_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m3_other_city_lbs_collect_uniq_cnt,

       count(case when m6_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m6_level0_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m6_level0_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m6_level1_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m6_level1_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m6_level2_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m6_level2_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m6_level3_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m6_level3_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m6_level4_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m6_level4_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m6_level5_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m6_level5_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m6_other_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m6_other_city_lbs_collect_uniq_cnt,

       --- 不同时间窗口内lbs活动范围
       sum(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_sum,
       min(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_min,
       max(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_max,
       avg(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_avg,

       sum(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_sum,
       min(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_min,
       max(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_max,
       avg(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_avg,

       sum(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_sum,
       min(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_min,
       max(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_max,
       avg(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_avg

from (
select uid,
       mdl_dte,
       event_tim,
       longitude,
       latitude,
       lbs_info,
       lbs_province,
       lbs_city,
       lbs_province_seg,
       lbs_city_level,
       ddf_mdl_event_time,
       collect_hor_flg,
       m1_flg,
       m3_flg,
       m6_flg,
       rnk_m1,
       previous_longitude_m1,
       previous_latitude_m1,
       rnk_m3,
       previous_longitude_m3,
       previous_latitude_m3,
       rnk_m6,
       previous_longitude_m6,
       previous_latitude_m6,
       case when rnk_m1 =1 then 0 
            else acos(sin(radians(previous_latitude_m1)) * sin(radians(latitude)) + cos(radians(previous_latitude_m1)) * cos(radians(latitude)) * cos(radians(longitude - previous_longitude_m1))) * 6371 
            end as distance_m1,
       case when rnk_m3 =1 then 0 
            else acos(sin(radians(previous_latitude_m3)) * sin(radians(latitude)) + cos(radians(previous_latitude_m3)) * cos(radians(latitude)) * cos(radians(longitude - previous_longitude_m3))) * 6371 
            end as distance_m3,
      case when rnk_m6 =1 then 0 
            else acos(sin(radians(previous_latitude_m6)) * sin(radians(latitude)) + cos(radians(previous_latitude_m6)) * cos(radians(latitude)) * cos(radians(longitude - previous_longitude_m6))) * 6371 
            end as distance_m6

from (
select uid,
       mdl_dte,
       event_tim,
       longitude,
       latitude,
       lbs_info,
       lbs_province,
       lbs_city,
       lbs_province_seg,
       lbs_city_level,
       ddf_mdl_event_time,
       collect_hor_flg,
       m1_flg,
       m3_flg,
       m6_flg,
       row_number() over (partition by uid, mdl_dte, m1_flg order by event_tim) as rnk_m1,
       cast(LAG(longitude, 1, 0) over (partition by uid, mdl_dte, m1_flg order by event_tim asc) as double) as previous_longitude_m1,
       cast(LAG(latitude, 1, 0) over (partition by uid, mdl_dte, m1_flg order by event_tim asc) as double) as previous_latitude_m1,
       row_number() over (partition by uid, mdl_dte, m3_flg order by event_tim) as rnk_m3,
       cast(lag(longitude, 1, 0) over (partition by uid, mdl_dte, m3_flg order by event_tim asc) as double) as previous_longitude_m3,
       cast(lag(latitude, 1, 0) over (partition by uid, mdl_dte, m3_flg order by event_tim asc) as double) as previous_latitude_m3,
       row_number() over (partition by uid, mdl_dte, m6_flg order by event_tim) as rnk_m6,
       cast(lag(longitude, 1, 0) over (partition by uid, mdl_dte, m6_flg order by event_tim asc) as double) as previous_longitude_m6,
       cast(lag(latitude, 1, 0) over (partition by uid, mdl_dte, m6_flg order by event_tim asc) as double) as previous_latitude_m6
from(
select a.uid,
       a.mdl_dte,
       event_tim,
	   longitude,
	   latitude,
       concat_ws('_',regexp_extract(longitude ,'([0-9]*.[0-9][0-9][0-9])' ,1),regexp_extract(latitude ,'([0-9]*.[0-9][0-9][0-9])' ,1)) as lbs_info,
	   lbs_province,
	   lbs_city,
	   case when lbs_province in ('安徽','江苏','上海','浙江','Anhui','Jiangsu','Shanghai','Zhejiang') then '01_华东'
            when lbs_province in ('西藏','新疆','青海','内蒙古','宁夏','四川','Xizang','Xinjiang','Qinghai','Nei Monggol','Ningxia','Sichuan') then '02_西北'
            when lbs_province in ('山东','北京','河北','天津','Shandong','Beijing','Hebei','Tianjin') then '03_华北'
            when lbs_province in ('河南','重庆','甘肃','山西','湖南','湖北','云南','陕西','江西','Henan','Chongqing','Gansu','Shanxi','Hunan','Hubei','Yunnan','Shanxi','Jiangxi') then '04_华中'
            when lbs_province in ('黑龙江','吉林','辽宁','Heilongjiang','Jilin','Liaoning') then '05_东北'
            when lbs_province in ('台湾','香港','澳门','澳門','广西','贵州','广东','海南','福建','台北','台中','Taiwan','Hong Kong','Macao','Guangxi','Guizhou','Guangdong','Hainan','Fujian') then '06_华南'
            else '07_其他' end as lbs_province_seg,
	   case when lbs_city in ('北京','上海','广州','深圳') then '0级'
            when lbs_city in ('台中','台北','香港','香港特别行政区','成都','重庆','杭州','武汉','西安','天津','苏州','南京','郑州','长沙','东莞','沈阳','青岛','合肥','佛山') then '1级' 
            when lbs_city in ( '昆明','福州','无锡','厦门','哈尔滨','长春','南昌','济南','宁波','大连','贵阳','温州','石家庄',
                    '泉州','南宁','金华','常州','珠海','惠州','嘉兴','南通','中山','保定','兰州','台州','徐州','太原','绍兴','烟台','廊坊') then '2级' 
            when lbs_city in ('海口','汕头', '潍坊', '扬州', '洛阳', '乌鲁木齐', '临沂', '唐山', '镇江', '盐城', '湖州', '赣州', '漳州', '揭阳', '江门', '桂林', 
                '邯郸','泰州', '济宁', '呼和浩特', '咸阳', '芜湖', '三亚', '阜阳', '淮安','遵义', '银川', '衡阳', '上饶', '柳州', '淄博', '莆田',
                '绵阳','湛江', '商丘', '宜昌', '沧州', '连云港', '南阳','蚌埠', '驻马店', '滁州', '邢台', '潮州', '秦皇岛', '肇庆', '荆州', 
                '周口','马鞍山','清远','宿州', '威海', '九江', '新乡', '信阳', '襄阳', '岳阳', '安庆', '菏泽', '宜春', '黄冈', '泰安', '宿迁', 
                '株洲','宁德', '鞍山', '南充', '六安', '大庆', '舟山') then '3级' 
            when lbs_city in ('常德', '渭南湖','渭南','孝感', '丽水', '运城', '德州', '张家口', '鄂尔多斯', '阳江', '泸州', '丹东', '曲靖', '乐山', '许昌', 
                '湘潭', '晋中', '安阳', '齐齐哈尔', '北海', '宝鸡', '抚州', '景德镇', '延安', '三明', '抚顺','亳州', '日照', '西宁', '衢州', 
                '拉萨', '淮北', '焦作','平顶山', '滨州', '吉安', '濮阳', '眉山', '池州', '荆门', '铜仁', '长治', '衡水', '铜陵', '承德',
                '达州', '邵阳', '德阳', '龙岩', '南平', '淮南', '黄石', '营口', '东营', '吉林', '韶关', '枣庄', '包头', '怀化', '宣城', '临汾', 
                    '聊城', '梅州', '盘锦', '锦州', '榆林', '玉林', '十堰', '汕尾', '咸宁', '宜宾', '永州', '益阳', '黔南州','黔南','黔南布依族苗族自治州','黔东南','黔东南苗族侗族自治州','恩施', '恩施土家族苗族自治州',
                        '红河', '红河哈尼族彝族自治州','大理', '大理白族自治州','大同', '鄂州', '忻州', '吕梁', '黄山', '开封', '郴州', '茂名', '漯河', '葫芦岛', '河源', '娄底', '延边','延边朝鲜族自治州', '琼海','天门','陵水黎族自治县') then '4级'
            when lbs_city in ('汉中', '辽阳', '四平', '内江', '六盘水', '安顺', '新余', '牡丹江', '晋城', '自贡', '三门峡', '赤峰', '本溪', 
                '防城港', '铁岭', '随州', '广安', '广元', '天水', '遂宁', '萍乡', '西双版纳', '西双版纳傣族自治州','绥化', '鹤壁', '湘西', '湘西土家族苗族自治州','松原', '阜新', 
                '酒泉', '张家界', '黔西南','黔西南布依族苗族自治州', '保山', '昭通', '河池', '来宾', '玉溪', '梧州', '鹰潭', '钦州', '云浮', '佳木斯', 
                '克拉玛依', '呼伦贝尔', '贺州', '通化', '阳泉', '朝阳', '百色', '毕节', '贵港', '丽江', '安康', '通辽', '德宏', '德宏傣族景颇族自治州','朔州', 
                '伊犁', '文山', '文山壮族苗族自治州','楚雄','楚雄彝族自治州', '嘉峪关', '凉山', '凉山彝族自治州','资阳', '锡林郭勒盟','锡林郭勒', '雅安', '普洱', '崇左', '庆阳', '巴音郭楞（巴州）','巴音郭楞','巴音郭楞蒙古自治州', '阿拉善',
                '乌兰察布', '白山', '昌吉', '昌吉回族自治州','白城', '兴安盟','兴安', '定西', '喀什','喀什地区', '白银', '陇南', '巴彦淖尔', '巴中', '鸡西', '乌海', 
                '临沧', '海东', '张掖', '商洛', '黑河', '哈密', '吴忠', '攀枝花', '双鸭山', '阿克苏', '阿克苏地区','石嘴山', '阿拉善盟', 
                '海西','海西蒙古族藏族自治州', '平凉', '林芝', '固原', '武威', '儋州', '吐鲁番', '甘孜', '甘孜藏族自治州','辽源', '临夏', '铜川', '金昌', '鹤岗', '伊春', '铁力',
                '中卫', '怒江', '怒江傈僳族自治州','和田', '迪庆', '迪庆藏族自治州','甘南','甘南藏族自治州', '阿坝', '阿坝藏族羌族自治州','大兴安岭', '七台河', '山南', '日喀则', '塔城', '博尔塔拉','博尔塔拉蒙古自治州', '昌都', 
                '阿勒泰', '玉树','玉树藏族自治州', '海南','海南藏族自治州', '黄南', '果洛', '克孜勒苏', '阿里', '海北', '海北藏族自治州','那曲', '三沙','伊犁哈萨克','伊犁哈萨克自治州','莱芜','克孜勒苏柯尔克孜','克孜勒苏柯尔克孜自治州','仙桃','临夏回族自治州','潜江','石河子','诸暨'
                ,'玉树藏族自治州','黄南藏族自治州','神农架林区','东方','临高县','澄迈县','果洛藏族自治州','乐东黎族自治县','峨眉山','昌江黎族自治县','定安县','文昌','白沙黎族自治县','屯昌县'
                ,'琼海','济源','万宁','琼中黎族苗族自治县','保亭黎族苗族自治县','五指山','图木舒克','阿拉尔','五家渠','兴城','北屯','河口','新北','双辽') then '5级'
            else '其他' 
            end as lbs_city_level,
			datediff(a.mdl_dte, to_date(b.event_tim)) as ddf_mdl_event_time,
            case when to_date(b.event_tim) >= add_months(a.mdl_dte,-1) then 1 else 0 end as m1_flg,
            case when to_date(b.event_tim) >= add_months(a.mdl_dte,-3) then 1 else 0 end as m3_flg,
            case when to_date(b.event_tim) >= add_months(a.mdl_dte,-6) then 1 else 0 end as m6_flg,
            case when hour(b.event_tim) between 0 and 3 then '0到3点采集'
                 when hour(b.event_tim) between 4 and 6 then '4到6点采集'
                 when hour(b.event_tim) between 7 and 12 then '7到12点采集'
                 when hour(b.event_tim) between 13 and 18 then '13到18点采集'
                 when hour(b.event_tim) between 19 and 23 then '19到23点采集'
                 else '其他时间段采集' end as collect_hor_flg

from(  
select  uid,
        date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
from ${dwa_risk}.dwa_risk_f_dz_model_data_base
) a 
left join 
(select uid,
        createdat,
        event_tim,
        altitude,
		longitude,
		latitude,
		lbscountry,
        lbs_province,
        lbs_city,
        row_number() over (partition by uid,event_date,event_hor order by event_tim) as rnk
from ( 
select  uid,
        ds,
        createdat,
		from_unixtime(cast(createdat/1000 as bigint)) as event_tim,
        substr(from_unixtime(cast(createdat/1000 as bigint)),1,10) as event_date,
        hour(from_unixtime(cast(createdat/1000 as bigint))) as event_hor,
        altitude,
		longitude,
		latitude,
		lbscountry,
		case when replace(replace(lbsprovince,'省',''),'市','') in ('澳门特别行政区', '澳門特別行政區') then '澳门'
             when replace(replace(lbsprovince,'省',''),'市','')='广西壮族自治区' then '广西'
             when replace(replace(lbsprovince,'省',''),'市','')='内蒙古自治区' then '内蒙古'
             when replace(replace(lbsprovince,'省',''),'市','')='宁夏回族自治区' then '宁夏'
             when replace(replace(lbsprovince,'省',''),'市','')='西藏自治区' then '西藏'
             when replace(replace(lbsprovince,'省',''),'市','')='香港特别行政区' then '香港'
             when replace(replace(lbsprovince,'省',''),'市','')='新疆维吾尔自治区' then '新疆'
             else replace(replace(lbsprovince,'省',''),'市','') end as lbs_province,
		replace(replace(lbscity,'市',''),'地区','') as lbs_city

from ${ods_pdw_loan}.ods_pdw_loan_log_data_collection_di
where date_add(to_date(ds, 'yyyymmdd'), 0) between add_months(date_add(to_date('${bizdate}' , 'yyyymmdd') , 1),-6) and date_add(to_date('${bizdate}' , 'yyyymmdd'),0)
and (coalesce(longitude ,'') <> '' or coalesce(latitude ,'') <> '')
and uid not like 'jxd%'
and coalesce(uid,'') <> ''
-- union all
-- select uid,
--         ds,
--         created_at as createdat,
-- 		created_at as event_tim,
--         substr(created_at,1,10) as event_date,
--         hour(created_at) as event_hor,
--         altitude,
-- 		longitude,
-- 		latitude,
-- 		lbs_country as lbscountry,
-- 		case when replace(replace(lbs_province,'省',''),'市','') in ('澳门特别行政区', '澳門特別行政區') then '澳门'
--              when replace(replace(lbs_province,'省',''),'市','')='广西壮族自治区' then '广西'
--              when replace(replace(lbs_province,'省',''),'市','')='内蒙古自治区' then '内蒙古'
--              when replace(replace(lbs_province,'省',''),'市','')='宁夏回族自治区' then '宁夏'
--              when replace(replace(lbs_province,'省',''),'市','')='西藏自治区' then '西藏'
--              when replace(replace(lbs_province,'省',''),'市','')='香港特别行政区' then '香港'
--              when replace(replace(lbs_province,'省',''),'市','')='新疆维吾尔自治区' then '新疆'
--              else replace(replace(lbs_province,'省',''),'市','') end as lbs_province,
-- 		replace(replace(lbs_city,'市',''),'地区','') as lbs_city
-- from ${ods_pdw_loan}.ods_pdw_loan_tidbxd_stats_device_info_log_di
-- where date_add(to_date(ds, 'yyyymmdd'), 0) >= add_months(date_add(to_date('${bizdate}' , 'yyyymmdd') , 1),-6)
-- and (coalesce(longitude ,'') <> '' or coalesce(latitude ,'') <> '')
-- and uid not like 'jxd%'
-- and coalesce(uid,'') <> ''
) bb 
) b 
on a.uid = b.uid and to_date(b.event_tim) between add_months(a.mdl_dte,-6) and date_add(a.mdl_dte,-1)
where rnk = 1
) main 
where coalesce(lbs_info,'') <> ''
) main2 
) main3 
group by uid,
         mdl_dte;
-- feature-copilot:node-end ordinal=0

-- feature-copilot:node-begin ordinal=1
-- table_name: dwa_risk_dz_model_final_28lbs_info_df
-- node_id: n_6067144881946951680
-- task_name: dwa_risk_dz_model_final_28lbs_info_df_back
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_28lbs_info_df.json
-- source_json_sha256: c1060934aa79a3b4b46608f690fe8682eedb786a96feadf295d3150829efecd9
-- upstream_table: ods_pdw_loan.ods_pdw_loan_log_data_collection_di
-- upstream_table: dwt.dwt_heavy_order_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 沈喜望
--创建日期: 2024-08-05 17:07:24
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_28lbs_info_df partition (ds = '${bizdate}')
select uid,
       mdl_dte,

       ---- 不同时间窗口内lbs采集与uniq采集数
	   count(case when ddf_mdl_event_time between 1 and 3 then lbs_info else null end) as d3_lbs_collect_cnt, 
       count(distinct case when ddf_mdl_event_time between 1 and 3 then lbs_info else null end) as d3_lbs_collect_uniq_cnt,
	   count(case when ddf_mdl_event_time between 1 and 7 then lbs_info else null end) as d7_lbs_collect_cnt, 
       count(distinct case when ddf_mdl_event_time between 1 and 7 then lbs_info else null end) as d7_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 then lbs_info else null end) as m1_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 then lbs_info else null end) as m1_lbs_collect_uniq_cnt,      
       count(case when m3_flg = 1 then lbs_info else null end) as m3_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 then lbs_info else null end) as m3_lbs_collect_uniq_cnt,      
       count(case when m6_flg = 1 then lbs_info else null end) as m6_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 then lbs_info else null end) as m6_lbs_collect_uniq_cnt, 

    --- 不同时间窗口内不同时间段采集与uniq采集数
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d3_00_03_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d3_00_03_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d3_04_06_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d3_04_06_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d3_07_12_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d3_07_12_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d3_13_18_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d3_13_18_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d3_19_23_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d3_19_23_lbs_collect_uniq_cnt,
     
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d7_00_03_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as d7_00_03_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d7_04_06_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as d7_04_06_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d7_07_12_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as d7_07_12_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d7_13_18_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as d7_13_18_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d7_19_23_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as d7_19_23_lbs_collect_uniq_cnt,

       count(case when m1_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m1_00_03_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m1_00_03_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m1_04_06_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m1_04_06_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m1_07_12_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m1_07_12_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m1_13_18_lbs_collect_cnt,
       count(distinct case when m1_flg = 1  and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m1_13_18_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m1_19_23_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m1_19_23_lbs_collect_uniq_cnt,

       count(case when m3_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m3_00_03_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m3_00_03_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m3_04_06_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m3_04_06_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m3_07_12_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m3_07_12_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m3_13_18_lbs_collect_cnt,
       count(distinct case when m3_flg = 1  and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m3_13_18_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m3_19_23_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m3_19_23_lbs_collect_uniq_cnt,

       count(case when m6_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m6_00_03_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '0到3点采集' then lbs_info else null end) as m6_00_03_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m6_04_06_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '4到6点采集' then lbs_info else null end) as m6_04_06_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m6_07_12_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '7到12点采集' then lbs_info else null end) as m6_07_12_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m6_13_18_lbs_collect_cnt,
       count(distinct case when m6_flg = 1  and collect_hor_flg = '13到18点采集' then lbs_info else null end) as m6_13_18_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m6_19_23_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and collect_hor_flg = '19到23点采集' then lbs_info else null end) as m6_19_23_lbs_collect_uniq_cnt,
    
       --- 不同时间窗口内不同地区采集与uniq采集数
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '01_华东' then lbs_info else null end) as d3_east_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '01_华东' then lbs_info else null end) as d3_east_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '02_西北' then lbs_info else null end) as d3_northwest_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '02_西北' then lbs_info else null end) as d3_northwest_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '03_华北' then lbs_info else null end) as d3_north_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '03_华北' then lbs_info else null end) as d3_north_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '04_华中' then lbs_info else null end) as d3_central_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '04_华中' then lbs_info else null end) as d3_central_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '05_东北' then lbs_info else null end) as d3_northeast_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '05_东北' then lbs_info else null end) as d3_northeast_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '06_华南' then lbs_info else null end) as d3_south_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '06_华南' then lbs_info else null end) as d3_south_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '07_其他' then lbs_info else null end) as d3_other_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_province_seg = '07_其他' then lbs_info else null end) as d3_other_lbs_collect_uniq_cnt,

       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '01_华东' then lbs_info else null end) as d7_east_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '01_华东' then lbs_info else null end) as d7_east_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '02_西北' then lbs_info else null end) as d7_northwest_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '02_西北' then lbs_info else null end) as d7_northwest_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '03_华北' then lbs_info else null end) as d7_north_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '03_华北' then lbs_info else null end) as d7_north_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '04_华中' then lbs_info else null end) as d7_central_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '04_华中' then lbs_info else null end) as d7_central_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '05_东北' then lbs_info else null end) as d7_northeast_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '05_东北' then lbs_info else null end) as d7_northeast_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '06_华南' then lbs_info else null end) as d7_south_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '06_华南' then lbs_info else null end) as d7_south_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '07_其他' then lbs_info else null end) as d7_other_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_province_seg = '07_其他' then lbs_info else null end) as d7_other_lbs_collect_uniq_cnt,

       count(case when m1_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m1_east_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m1_east_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m1_northwest_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m1_northwest_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m1_north_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m1_north_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m1_central_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m1_central_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m1_northeast_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m1_northeast_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m1_south_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m1_south_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m1_other_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m1_other_lbs_collect_uniq_cnt,

       count(case when m3_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m3_east_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m3_east_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m3_northwest_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m3_northwest_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m3_north_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m3_north_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m3_central_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m3_central_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m3_northeast_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m3_northeast_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m3_south_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m3_south_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m3_other_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m3_other_lbs_collect_uniq_cnt,

       count(case when m6_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m6_east_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '01_华东' then lbs_info else null end) as m6_east_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m6_northwest_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '02_西北' then lbs_info else null end) as m6_northwest_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m6_north_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '03_华北' then lbs_info else null end) as m6_north_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m6_central_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '04_华中' then lbs_info else null end) as m6_central_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m6_northeast_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '05_东北' then lbs_info else null end) as m6_northeast_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m6_south_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '06_华南' then lbs_info else null end) as m6_south_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m6_other_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_province_seg = '07_其他' then lbs_info else null end) as m6_other_lbs_collect_uniq_cnt,
    
       --- 不同时间窗口内不同等级城市采集与uniq采集数
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '0级' then lbs_info else null end) as d3_level0_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '0级' then lbs_info else null end) as d3_level0_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '1级' then lbs_info else null end) as d3_level1_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '1级' then lbs_info else null end) as d3_level1_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '2级' then lbs_info else null end) as d3_level2_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '2级' then lbs_info else null end) as d3_level2_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '3级' then lbs_info else null end) as d3_level3_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '3级' then lbs_info else null end) as d3_level3_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '4级' then lbs_info else null end) as d3_level4_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '4级' then lbs_info else null end) as d3_level4_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '5级' then lbs_info else null end) as d3_level5_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '5级' then lbs_info else null end) as d3_level5_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '其他' then lbs_info else null end) as d3_other_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 3 and lbs_city_level = '其他' then lbs_info else null end) as d3_other_city_lbs_collect_uniq_cnt,

       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '0级' then lbs_info else null end) as d7_level0_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '0级' then lbs_info else null end) as d7_level0_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '1级' then lbs_info else null end) as d7_level1_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '1级' then lbs_info else null end) as d7_level1_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '2级' then lbs_info else null end) as d7_level2_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '2级' then lbs_info else null end) as d7_level2_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '3级' then lbs_info else null end) as d7_level3_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '3级' then lbs_info else null end) as d7_level3_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '4级' then lbs_info else null end) as d7_level4_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '4级' then lbs_info else null end) as d7_level4_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '5级' then lbs_info else null end) as d7_level5_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '5级' then lbs_info else null end) as d7_level5_city_lbs_collect_uniq_cnt,
       count(case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '其他' then lbs_info else null end) as d7_other_city_lbs_collect_cnt,
       count(distinct case when ddf_mdl_event_time between 1 and 7 and lbs_city_level = '其他' then lbs_info else null end) as d7_other_city_lbs_collect_uniq_cnt,

       count(case when m1_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m1_level0_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m1_level0_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m1_level1_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m1_level1_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m1_level2_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m1_level2_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m1_level3_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m1_level3_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m1_level4_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m1_level4_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m1_level5_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m1_level5_city_lbs_collect_uniq_cnt,
       count(case when m1_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m1_other_city_lbs_collect_cnt,
       count(distinct case when m1_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m1_other_city_lbs_collect_uniq_cnt,

       count(case when m3_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m3_level0_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m3_level0_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m3_level1_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m3_level1_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m3_level2_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m3_level2_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m3_level3_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m3_level3_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m3_level4_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m3_level4_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m3_level5_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m3_level5_city_lbs_collect_uniq_cnt,
       count(case when m3_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m3_other_city_lbs_collect_cnt,
       count(distinct case when m3_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m3_other_city_lbs_collect_uniq_cnt,

       count(case when m6_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m6_level0_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '0级' then lbs_info else null end) as m6_level0_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m6_level1_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '1级' then lbs_info else null end) as m6_level1_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m6_level2_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '2级' then lbs_info else null end) as m6_level2_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m6_level3_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '3级' then lbs_info else null end) as m6_level3_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m6_level4_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '4级' then lbs_info else null end) as m6_level4_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m6_level5_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '5级' then lbs_info else null end) as m6_level5_city_lbs_collect_uniq_cnt,
       count(case when m6_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m6_other_city_lbs_collect_cnt,
       count(distinct case when m6_flg = 1 and lbs_city_level = '其他' then lbs_info else null end) as m6_other_city_lbs_collect_uniq_cnt,

       --- 不同时间窗口内lbs活动范围
       sum(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_sum,
       min(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_min,
       max(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_max,
       avg(case when m1_flg = 1 then distance_m1 else 0 end) as m1_lbs_collect_distance_avg,

       sum(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_sum,
       min(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_min,
       max(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_max,
       avg(case when m3_flg = 1 then distance_m3 else 0 end) as m3_lbs_collect_distance_avg,

       sum(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_sum,
       min(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_min,
       max(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_max,
       avg(case when m6_flg = 1 then distance_m6 else 0 end) as m6_lbs_collect_distance_avg

from (
select uid,
       mdl_dte,
       event_tim,
       longitude,
       latitude,
       lbs_info,
       lbs_province,
       lbs_city,
       lbs_province_seg,
       lbs_city_level,
       ddf_mdl_event_time,
       collect_hor_flg,
       m1_flg,
       m3_flg,
       m6_flg,
       rnk_m1,
       previous_longitude_m1,
       previous_latitude_m1,
       rnk_m3,
       previous_longitude_m3,
       previous_latitude_m3,
       rnk_m6,
       previous_longitude_m6,
       previous_latitude_m6,
       case when rnk_m1 =1 then 0 
            else acos(sin(radians(previous_latitude_m1)) * sin(radians(latitude)) + cos(radians(previous_latitude_m1)) * cos(radians(latitude)) * cos(radians(longitude - previous_longitude_m1))) * 6371 
            end as distance_m1,
       case when rnk_m3 =1 then 0 
            else acos(sin(radians(previous_latitude_m3)) * sin(radians(latitude)) + cos(radians(previous_latitude_m3)) * cos(radians(latitude)) * cos(radians(longitude - previous_longitude_m3))) * 6371 
            end as distance_m3,
      case when rnk_m6 =1 then 0 
            else acos(sin(radians(previous_latitude_m6)) * sin(radians(latitude)) + cos(radians(previous_latitude_m6)) * cos(radians(latitude)) * cos(radians(longitude - previous_longitude_m6))) * 6371 
            end as distance_m6

from (
select uid,
       mdl_dte,
       event_tim,
       longitude,
       latitude,
       lbs_info,
       lbs_province,
       lbs_city,
       lbs_province_seg,
       lbs_city_level,
       ddf_mdl_event_time,
       collect_hor_flg,
       m1_flg,
       m3_flg,
       m6_flg,
       row_number() over (partition by uid, mdl_dte, m1_flg order by event_tim) as rnk_m1,
       cast(LAG(longitude, 1, 0) over (partition by uid, mdl_dte, m1_flg order by event_tim asc) as double) as previous_longitude_m1,
       cast(LAG(latitude, 1, 0) over (partition by uid, mdl_dte, m1_flg order by event_tim asc) as double) as previous_latitude_m1,
       row_number() over (partition by uid, mdl_dte, m3_flg order by event_tim) as rnk_m3,
       cast(lag(longitude, 1, 0) over (partition by uid, mdl_dte, m3_flg order by event_tim asc) as double) as previous_longitude_m3,
       cast(lag(latitude, 1, 0) over (partition by uid, mdl_dte, m3_flg order by event_tim asc) as double) as previous_latitude_m3,
       row_number() over (partition by uid, mdl_dte, m6_flg order by event_tim) as rnk_m6,
       cast(lag(longitude, 1, 0) over (partition by uid, mdl_dte, m6_flg order by event_tim asc) as double) as previous_longitude_m6,
       cast(lag(latitude, 1, 0) over (partition by uid, mdl_dte, m6_flg order by event_tim asc) as double) as previous_latitude_m6
from(
select a.uid,
       a.mdl_dte,
       event_tim,
	   longitude,
	   latitude,
       concat_ws('_',regexp_extract(longitude ,'([0-9]*.[0-9][0-9][0-9])' ,1),regexp_extract(latitude ,'([0-9]*.[0-9][0-9][0-9])' ,1)) as lbs_info,
	   lbs_province,
	   lbs_city,
	   case when lbs_province in ('安徽','江苏','上海','浙江','Anhui','Jiangsu','Shanghai','Zhejiang') then '01_华东'
            when lbs_province in ('西藏','新疆','青海','内蒙古','宁夏','四川','Xizang','Xinjiang','Qinghai','Nei Monggol','Ningxia','Sichuan') then '02_西北'
            when lbs_province in ('山东','北京','河北','天津','Shandong','Beijing','Hebei','Tianjin') then '03_华北'
            when lbs_province in ('河南','重庆','甘肃','山西','湖南','湖北','云南','陕西','江西','Henan','Chongqing','Gansu','Shanxi','Hunan','Hubei','Yunnan','Shanxi','Jiangxi') then '04_华中'
            when lbs_province in ('黑龙江','吉林','辽宁','Heilongjiang','Jilin','Liaoning') then '05_东北'
            when lbs_province in ('台湾','香港','澳门','澳門','广西','贵州','广东','海南','福建','台北','台中','Taiwan','Hong Kong','Macao','Guangxi','Guizhou','Guangdong','Hainan','Fujian') then '06_华南'
            else '07_其他' end as lbs_province_seg,
	   case when lbs_city in ('北京','上海','广州','深圳') then '0级'
            when lbs_city in ('台中','台北','香港','香港特别行政区','成都','重庆','杭州','武汉','西安','天津','苏州','南京','郑州','长沙','东莞','沈阳','青岛','合肥','佛山') then '1级' 
            when lbs_city in ( '昆明','福州','无锡','厦门','哈尔滨','长春','南昌','济南','宁波','大连','贵阳','温州','石家庄',
                    '泉州','南宁','金华','常州','珠海','惠州','嘉兴','南通','中山','保定','兰州','台州','徐州','太原','绍兴','烟台','廊坊') then '2级' 
            when lbs_city in ('海口','汕头', '潍坊', '扬州', '洛阳', '乌鲁木齐', '临沂', '唐山', '镇江', '盐城', '湖州', '赣州', '漳州', '揭阳', '江门', '桂林', 
                '邯郸','泰州', '济宁', '呼和浩特', '咸阳', '芜湖', '三亚', '阜阳', '淮安','遵义', '银川', '衡阳', '上饶', '柳州', '淄博', '莆田',
                '绵阳','湛江', '商丘', '宜昌', '沧州', '连云港', '南阳','蚌埠', '驻马店', '滁州', '邢台', '潮州', '秦皇岛', '肇庆', '荆州', 
                '周口','马鞍山','清远','宿州', '威海', '九江', '新乡', '信阳', '襄阳', '岳阳', '安庆', '菏泽', '宜春', '黄冈', '泰安', '宿迁', 
                '株洲','宁德', '鞍山', '南充', '六安', '大庆', '舟山') then '3级' 
            when lbs_city in ('常德', '渭南湖','渭南','孝感', '丽水', '运城', '德州', '张家口', '鄂尔多斯', '阳江', '泸州', '丹东', '曲靖', '乐山', '许昌', 
                '湘潭', '晋中', '安阳', '齐齐哈尔', '北海', '宝鸡', '抚州', '景德镇', '延安', '三明', '抚顺','亳州', '日照', '西宁', '衢州', 
                '拉萨', '淮北', '焦作','平顶山', '滨州', '吉安', '濮阳', '眉山', '池州', '荆门', '铜仁', '长治', '衡水', '铜陵', '承德',
                '达州', '邵阳', '德阳', '龙岩', '南平', '淮南', '黄石', '营口', '东营', '吉林', '韶关', '枣庄', '包头', '怀化', '宣城', '临汾', 
                    '聊城', '梅州', '盘锦', '锦州', '榆林', '玉林', '十堰', '汕尾', '咸宁', '宜宾', '永州', '益阳', '黔南州','黔南','黔南布依族苗族自治州','黔东南','黔东南苗族侗族自治州','恩施', '恩施土家族苗族自治州',
                        '红河', '红河哈尼族彝族自治州','大理', '大理白族自治州','大同', '鄂州', '忻州', '吕梁', '黄山', '开封', '郴州', '茂名', '漯河', '葫芦岛', '河源', '娄底', '延边','延边朝鲜族自治州', '琼海','天门','陵水黎族自治县') then '4级'
            when lbs_city in ('汉中', '辽阳', '四平', '内江', '六盘水', '安顺', '新余', '牡丹江', '晋城', '自贡', '三门峡', '赤峰', '本溪', 
                '防城港', '铁岭', '随州', '广安', '广元', '天水', '遂宁', '萍乡', '西双版纳', '西双版纳傣族自治州','绥化', '鹤壁', '湘西', '湘西土家族苗族自治州','松原', '阜新', 
                '酒泉', '张家界', '黔西南','黔西南布依族苗族自治州', '保山', '昭通', '河池', '来宾', '玉溪', '梧州', '鹰潭', '钦州', '云浮', '佳木斯', 
                '克拉玛依', '呼伦贝尔', '贺州', '通化', '阳泉', '朝阳', '百色', '毕节', '贵港', '丽江', '安康', '通辽', '德宏', '德宏傣族景颇族自治州','朔州', 
                '伊犁', '文山', '文山壮族苗族自治州','楚雄','楚雄彝族自治州', '嘉峪关', '凉山', '凉山彝族自治州','资阳', '锡林郭勒盟','锡林郭勒', '雅安', '普洱', '崇左', '庆阳', '巴音郭楞（巴州）','巴音郭楞','巴音郭楞蒙古自治州', '阿拉善',
                '乌兰察布', '白山', '昌吉', '昌吉回族自治州','白城', '兴安盟','兴安', '定西', '喀什','喀什地区', '白银', '陇南', '巴彦淖尔', '巴中', '鸡西', '乌海', 
                '临沧', '海东', '张掖', '商洛', '黑河', '哈密', '吴忠', '攀枝花', '双鸭山', '阿克苏', '阿克苏地区','石嘴山', '阿拉善盟', 
                '海西','海西蒙古族藏族自治州', '平凉', '林芝', '固原', '武威', '儋州', '吐鲁番', '甘孜', '甘孜藏族自治州','辽源', '临夏', '铜川', '金昌', '鹤岗', '伊春', '铁力',
                '中卫', '怒江', '怒江傈僳族自治州','和田', '迪庆', '迪庆藏族自治州','甘南','甘南藏族自治州', '阿坝', '阿坝藏族羌族自治州','大兴安岭', '七台河', '山南', '日喀则', '塔城', '博尔塔拉','博尔塔拉蒙古自治州', '昌都', 
                '阿勒泰', '玉树','玉树藏族自治州', '海南','海南藏族自治州', '黄南', '果洛', '克孜勒苏', '阿里', '海北', '海北藏族自治州','那曲', '三沙','伊犁哈萨克','伊犁哈萨克自治州','莱芜','克孜勒苏柯尔克孜','克孜勒苏柯尔克孜自治州','仙桃','临夏回族自治州','潜江','石河子','诸暨'
                ,'玉树藏族自治州','黄南藏族自治州','神农架林区','东方','临高县','澄迈县','果洛藏族自治州','乐东黎族自治县','峨眉山','昌江黎族自治县','定安县','文昌','白沙黎族自治县','屯昌县'
                ,'琼海','济源','万宁','琼中黎族苗族自治县','保亭黎族苗族自治县','五指山','图木舒克','阿拉尔','五家渠','兴城','北屯','河口','新北','双辽') then '5级'
            else '其他' 
            end as lbs_city_level,
			datediff(a.mdl_dte, to_date(b.event_tim)) as ddf_mdl_event_time,
            case when to_date(b.event_tim) >= add_months(a.mdl_dte,-1) then 1 else 0 end as m1_flg,
            case when to_date(b.event_tim) >= add_months(a.mdl_dte,-3) then 1 else 0 end as m3_flg,
            case when to_date(b.event_tim) >= add_months(a.mdl_dte,-6) then 1 else 0 end as m6_flg,
            case when hour(b.event_tim) between 0 and 3 then '0到3点采集'
                 when hour(b.event_tim) between 4 and 6 then '4到6点采集'
                 when hour(b.event_tim) between 7 and 12 then '7到12点采集'
                 when hour(b.event_tim) between 13 and 18 then '13到18点采集'
                 when hour(b.event_tim) between 19 and 23 then '19到23点采集'
                 else '其他时间段采集' end as collect_hor_flg

from(  
select  uid,
        date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
from ${dwt}.dwt_heavy_order_df 
where ds = '${bizdate}'
and loan_success_flag = 1
group by uid
) a 
left join 
(select uid,
        createdat,
        event_tim,
        altitude,
		longitude,
		latitude,
		lbscountry,
        lbs_province,
        lbs_city,
        row_number() over (partition by uid,event_date,event_hor order by event_tim) as rnk
from ( 
select  uid,
        ds,
        createdat,
		from_unixtime(cast(createdat/1000 as bigint)) as event_tim,
        substr(from_unixtime(cast(createdat/1000 as bigint)),1,10) as event_date,
        hour(from_unixtime(cast(createdat/1000 as bigint))) as event_hor,
        altitude,
		longitude,
		latitude,
		lbscountry,
		case when replace(replace(lbsprovince,'省',''),'市','') in ('澳门特别行政区', '澳門特別行政區') then '澳门'
             when replace(replace(lbsprovince,'省',''),'市','')='广西壮族自治区' then '广西'
             when replace(replace(lbsprovince,'省',''),'市','')='内蒙古自治区' then '内蒙古'
             when replace(replace(lbsprovince,'省',''),'市','')='宁夏回族自治区' then '宁夏'
             when replace(replace(lbsprovince,'省',''),'市','')='西藏自治区' then '西藏'
             when replace(replace(lbsprovince,'省',''),'市','')='香港特别行政区' then '香港'
             when replace(replace(lbsprovince,'省',''),'市','')='新疆维吾尔自治区' then '新疆'
             else replace(replace(lbsprovince,'省',''),'市','') end as lbs_province,
		replace(replace(lbscity,'市',''),'地区','') as lbs_city

from ${ods_pdw_loan}.ods_pdw_loan_log_data_collection_di
where date_add(to_date(ds, 'yyyymmdd'), 0) between add_months(date_add(to_date('${bizdate}' , 'yyyymmdd') , 1),-6) and date_add(to_date('${bizdate}' , 'yyyymmdd'),0)
and (coalesce(longitude ,'') <> '' or coalesce(latitude ,'') <> '')
and uid not like 'jxd%'
and coalesce(uid,'') <> ''
-- union all
-- select uid,
--         ds,
--         created_at as createdat,
-- 		created_at as event_tim,
--         substr(created_at,1,10) as event_date,
--         hour(created_at) as event_hor,
--         altitude,
-- 		longitude,
-- 		latitude,
-- 		lbs_country as lbscountry,
-- 		case when replace(replace(lbs_province,'省',''),'市','') in ('澳门特别行政区', '澳門特別行政區') then '澳门'
--              when replace(replace(lbs_province,'省',''),'市','')='广西壮族自治区' then '广西'
--              when replace(replace(lbs_province,'省',''),'市','')='内蒙古自治区' then '内蒙古'
--              when replace(replace(lbs_province,'省',''),'市','')='宁夏回族自治区' then '宁夏'
--              when replace(replace(lbs_province,'省',''),'市','')='西藏自治区' then '西藏'
--              when replace(replace(lbs_province,'省',''),'市','')='香港特别行政区' then '香港'
--              when replace(replace(lbs_province,'省',''),'市','')='新疆维吾尔自治区' then '新疆'
--              else replace(replace(lbs_province,'省',''),'市','') end as lbs_province,
-- 		replace(replace(lbs_city,'市',''),'地区','') as lbs_city
-- from ${ods_pdw_loan}.ods_pdw_loan_tidbxd_stats_device_info_log_di
-- where date_add(to_date(ds, 'yyyymmdd'), 0) >= add_months(date_add(to_date('${bizdate}' , 'yyyymmdd') , 1),-6)
-- and (coalesce(longitude ,'') <> '' or coalesce(latitude ,'') <> '')
-- and uid not like 'jxd%'
-- and coalesce(uid,'') <> ''
) bb 
) b 
on a.uid = b.uid and to_date(b.event_tim) between add_months(a.mdl_dte,-6) and date_add(a.mdl_dte,-1)
where rnk = 1
) main 
where coalesce(lbs_info,'') <> ''
) main2 
) main3 
group by uid,
         mdl_dte;
-- feature-copilot:node-end ordinal=1
