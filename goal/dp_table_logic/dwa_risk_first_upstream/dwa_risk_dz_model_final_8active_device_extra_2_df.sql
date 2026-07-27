-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_8active_device_extra_2_df
-- node_id: n_3792361323862360064
-- task_name: dwa_risk_dz_model_final_8active_device_extra_2_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_8active_device_extra_2_df.json
-- source_json_sha256: 5eb7fdb2e1bfedd308143b7c6bae0b884537dcdb9578c0f20d4fa555310f7649
-- upstream_table: dwa_risk.dwa_risk_f_active_device_detail

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应 ${pdm_risk}.pdm_risk_dz_model_final_8active_device_extra_2_df
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- 20221121 字段类型修复
-- alter table ${dwa_risk}.dwa_risk_dz_model_final_8active_device_extra_2_df change column dvc_avg_ddf_log_90 dvc_avg_ddf_log_90_disable int comment '最近90天平均登录次数(废弃)';  --字段类型有误，废弃该字段
-- alter table ${dwa_risk}.dwa_risk_dz_model_final_8active_device_extra_2_df add columns(dvc_avg_ddf_log_90 double comment '最近90天平均登录次数');


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_8active_device_extra_2_df partition (ds='${bizdate}')
select uid
        ,mdl_dte
-- features range start --
--        ,count(distinct mid_dvc_cnt_log_dte_7) as dvc_cnt_log_dte_7
--        ,count(distinct mid_dvc_cnt_log_dte_30) as dvc_cnt_log_dte_30
--        ,count(distinct mid_dvc_cnt_log_dte_90) as dvc_cnt_log_dte_90

       -- ,round(count(case when lst_app_str_dte>= date_add('评分日',-90) then 1 else NULL end)/90,6)  as dvc_avg_ddf_log_90
       -- ,count(case when lst_app_str_dte>= date_add('评分日',-1) then 1 else NULL end)  as his_1d_app_str_ctn_v2
       -- ,count(case when lst_app_str_dte>= date_add('评分日',-3) then 1 else NULL end)  as his_3d_app_str_ctn_v2
       -- ,count(case when lst_app_str_dte>= date_add('评分日',-7) then 1 else NULL end)  as his_7d_app_str_ctn_v2
       -- ,count(case when lst_app_str_dte>= date_add('评分日',-30) then 1 else NULL end)  as his_30d_app_str_ctn_v2
       
       ,null  as dvc_avg_ddf_log_90_disable
       ,count(case when ddf_mdl_lst_app_str_dte=1 then 1 else NULL end)  as his_1d_app_str_ctn_v2
       ,count(case when ddf_mdl_lst_app_str_dte between 1 and 3 then 1 else NULL end)  as his_3d_app_str_ctn_v2
       ,count(case when ddf_mdl_lst_app_str_dte between 1 and 7 then 1 else NULL end)  as his_7d_app_str_ctn_v2
       ,count(case when ddf_mdl_lst_app_str_dte between 1 and 30 then 1 else NULL end)  as his_30d_app_str_ctn_v2

       ,count(mid_dvc_num_log_mid_ngt_90) as dvc_num_log_mid_ngt_90
       ,count(distinct mid_dvc_cnt_cjj_7) as dvc_cnt_cjj_7
       ,count(distinct mid_dvc_cnt_cjj_30) as dvc_cnt_cjj_30
       ,count(distinct mid_dvc_cnt_cjj_90) as dvc_cnt_cjj_90
       ,round(count(case when ddf_mdl_lst_app_str_dte between 1 and 90 then 1 else NULL end)/90,6)  as dvc_avg_ddf_log_90
       
-- features range end --
from (select uid
              ,mdl_dte
             --,cjj_id
      -- features range start --
             ,case when ddf_mdl_lst_app_str_dte between 1 and 7 then lst_app_str_dte else NULL end as mid_dvc_cnt_log_dte_7
             ,case when ddf_mdl_lst_app_str_dte between 1 and 30 then lst_app_str_dte else NULL end as mid_dvc_cnt_log_dte_30
             ,case when ddf_mdl_lst_app_str_dte between 1 and 90 then lst_app_str_dte else NULL end as mid_dvc_cnt_log_dte_90
             ,lst_app_str_dte
             ,lst_app_str_tim
             -- ,datediff('评分日',lst_app_str_tim) as mid_crt_app_str_ddf
             ,ddf_mdl_lst_app_str_dte
             ,case when ddf_mdl_lst_app_str_dte between 1 and 90 and hour(lst_app_str_tim) between 2 and 5 then 1 else NULL end as mid_dvc_num_log_mid_ngt_90
             ,case when ddf_mdl_lst_app_str_dte between 1 and 7 then cjj_id else NULL end as mid_dvc_cnt_cjj_7
             ,case when ddf_mdl_lst_app_str_dte between 1 and 30 then cjj_id else NULL end as mid_dvc_cnt_cjj_30
             ,case when ddf_mdl_lst_app_str_dte between 1 and 90 then cjj_id else NULL end as mid_dvc_cnt_cjj_90
             ,case when ddf_mdl_lst_app_str_dte between 1 and 90 then datediff(lst_app_str_dte,lag(lst_app_str_dte,1) over(partition by uid order by lst_app_str_dte asc)) else NULL end as mid_dvc_ddf_log_90
          
      -- features range end --
      from    (select uid
                      ,mdl_dte
                      ,cjj_id
                      ,lst_app_str_dte
                      ,ddf_mdl_lst_app_str_dte
                      ,concat(substr(lst_app_str_tim,1,16),':00') as lst_app_str_tim
              from ${dwa_risk}.dwa_risk_f_active_device_detail
              group by uid
                      ,mdl_dte
                      ,cjj_id
                      ,lst_app_str_dte
                      ,ddf_mdl_lst_app_str_dte
                      ,concat(substr(lst_app_str_tim,1,16),':00')
               ) temp  -- 修改：江德浩 切换表，原中间表会有一次登陆多条记录的系统误差，现在统一改为一分钟内的登陆算一次 现表default.default_tscore_x2_device_mid_t1 原表：default.default_tscore_x_device_mid_t1
      where cast(lst_app_str_tim as timestamp) <= cast(to_date(mdl_dte) as timestamp)
      ) as a
group by uid
        ,mdl_dte;
-- feature-copilot:node-end ordinal=0
