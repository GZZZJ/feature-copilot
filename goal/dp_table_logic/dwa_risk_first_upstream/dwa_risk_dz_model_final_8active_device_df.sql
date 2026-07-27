-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_8active_device_df
-- node_id: n_3789827224438243328
-- task_name: dwa_risk_dz_model_final_8active_device_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_8active_device_df.json
-- source_json_sha256: 15e30f5fa45d71a88a4c63fb07da6c191875cb728fd7950dc7737a84161186c6
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: cdmx.cdmx_fct_user_uid_device_relation_df
-- upstream_table: cdmx.cdmx_dim_device_df
-- upstream_table: dwa_risk.dwa_risk_8active_device_tmp01

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的 ${pdm_risk}.pdm_risk_dz_model_final_8active_device_df
--创建者: 颜弘彪
--创建日期: 2022-06-29 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_8active_device_df(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
act_dvc_os_typ_1d  int  comment '最近1天活跃设备类型数量',
act_dvc_os_typ_7d  int  comment '最近7天活跃设备类型数量',
act_dvc_os_typ_14d  int  comment '最近14天活跃设备类型数量',
act_dvc_os_typ_30d  int  comment '最近30天活跃设备类型数量',
act_dvc_os_typ_90d  int  comment '最近90天活跃设备类型数量',
act_dvc_1d  int  comment '最近1天活跃设备数量',
act_dvc_7d  int  comment '最近7天活跃设备数量',
act_dvc_14d  int  comment '最近14天活跃设备数量',
act_dvc_30d  int  comment '最近30天活跃设备数量',
act_dvc_90d  int  comment '最近90天活跃设备数量'
) comment "用户设备活跃信息表" 
partitioned by (ds string comment '分区字段,格式yyyymmdd')
;


drop table if exists ${dwa_risk}.dwa_risk_8active_device_tmp01;
create table if not exists ${dwa_risk}.dwa_risk_8active_device_tmp01 as 
select model_data.uid
        ,model_data.mdl_dte
        ,cjj_id_info.cjj_id
        ,cjj_id_info.app_ver
        ,cjj_id_info.os_typ
        ,cjj_id_info.brd_nam
        ,cjj_id_info.atv_tim
        ,cjj_id_info.atv_dte

        ,datediff(model_data.mdl_dte,cjj_id_info.atv_dte) as ddf_mdl_atv_dte  --设备激活时间距评分日的间隔（天）

from    ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
        --uid对应的激活设备
        left join
        (select uid
                ,cjj_id
        from cdmx.cdmx_fct_user_uid_device_relation_df 
        -- update by huangchao,20241105,旧公共层替换成cdmx
        -- ${ld_loan}.fct_user_uid_device_relation_df
        where ds='\${bizdate}' and 
        to_date(crt_time) between add_months(date_add(to_date('\${bizdate}', 'yyyymmdd'), 0), -4) and date_add(to_date('\${bizdate}', 'yyyymmdd'), 0)  -- 优化成传入最大最小评分日，减少计算量
        ) uid_cjj_id on model_data.uid=uid_cjj_id.uid
        --激活设备的信息
        left join
        (select cjj_id
                ,app_version as app_ver  --app版本
                ,case when os_type = '安卓系统' then 'ANDROID'
                     when os_type = '苹果系统' then 'IOS'
                     else '未知'
                end as os_typ  --操作系统,a-安卓,i-iOS
                ,original_device_brand as brd_nam --品牌
                ,create_time as atv_tim
                ,date(create_time) as atv_dte --激活时间，即设备每次的使用时间
        from ${cdmx}.cdmx_dim_device_df
        where ds='\${bizdate}' -- TODO：待优化成传入最大评分日和最小评分日
        ) cjj_id_info on uid_cjj_id.cjj_id = cjj_id_info.cjj_id
where atv_tim<date(model_data.mdl_dte)  --去除穿越的记录
        and datediff(model_data.mdl_dte,cjj_id_info.atv_dte)<=90 
;

------------------【特征计算结果表】--------------------

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_8active_device_df partition(ds='\${bizdate}')
select model_data.uid
        ,model_data.mdl_dte
-- features range start --
        ,coalesce(device.act_dvc_os_typ_1d,0) as act_dvc_os_typ_1d
        ,coalesce(device.act_dvc_os_typ_7d,0) as act_dvc_os_typ_7d
        ,coalesce(device.act_dvc_os_typ_14d,0) as act_dvc_os_typ_14d
        ,coalesce(device.act_dvc_os_typ_30d,0) as act_dvc_os_typ_30d
        ,coalesce(device.act_dvc_os_typ_90d,0) as act_dvc_os_typ_90d
        ,coalesce(device.act_dvc_1d,0) as act_dvc_1d
        ,coalesce(device.act_dvc_7d,0) as act_dvc_7d
        ,coalesce(device.act_dvc_14d,0) as act_dvc_14d
        ,coalesce(device.act_dvc_30d,0) as act_dvc_30d
        ,coalesce(device.act_dvc_90d,0) as act_dvc_90d
-- features range end --
from  ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join
(select uid
        ,mdl_dte
-- features range start --
        ----------------------------------------------------------
        --/*8.4.2 设备更换历史*/
        ----------------------------------------------------------
        --最近激活的操作系统数
        ,count(distinct case when ddf_mdl_atv_dte=1 then os_typ else null end) as act_dvc_os_typ_1d
        ,count(distinct case when ddf_mdl_atv_dte between 1 and 7 then os_typ else null end) as act_dvc_os_typ_7d
        ,count(distinct case when ddf_mdl_atv_dte between 1 and 14 then os_typ else null end) as act_dvc_os_typ_14d
        ,count(distinct case when ddf_mdl_atv_dte between 1 and 30 then os_typ else null end) as act_dvc_os_typ_30d
        ,count(distinct case when ddf_mdl_atv_dte between 1 and 90 then os_typ else null end) as act_dvc_os_typ_90d
        --最近激活的设备数
        ,count(case when ddf_mdl_atv_dte=1 then cjj_id else null end) as act_dvc_1d
        ,count(case when ddf_mdl_atv_dte between 1 and 7 then cjj_id else null end) as act_dvc_7d
        ,count(case when ddf_mdl_atv_dte between 1 and 14 then cjj_id else null end) as act_dvc_14d
        ,count(case when ddf_mdl_atv_dte between 1 and 30 then cjj_id else null end) as act_dvc_30d
        ,count(case when ddf_mdl_atv_dte between 1 and 90 then cjj_id else null end) as act_dvc_90d

        --最新使用设备首次启用时间距评分日间隔（天）
        ,min(ddf_mdl_atv_dte) as min_ddf_mdl_atv_dte

from ${dwa_risk}.dwa_risk_8active_device_tmp01
group by uid
        ,mdl_dte
)device on model_data.uid=device.uid ;
-- feature-copilot:node-end ordinal=0
