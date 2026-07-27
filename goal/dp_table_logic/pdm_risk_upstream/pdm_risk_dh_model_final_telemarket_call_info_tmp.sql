-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dh_model_final_telemarket_call_info_tmp
-- node_id: n_4513798559808552960
-- task_name: pdm_risk_dh_model_final_telemarket_call_info_features_di
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dh_model_final_telemarket_call_info_tmp.json
-- source_json_sha256: feb477020537e0fd016c27ae7b503624728d28204228ed913a047aaf0fca01f5
-- upstream_table: pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_sample_di_tmp
-- upstream_table: pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_tmp
-- upstream_table: ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_tag_his
-- upstream_table: ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_event_his
-- upstream_table: ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_elitewo3task_his
-- upstream_table: ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_objective_his
-- upstream_table: pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp
-- upstream_table: dwt.dwt_heavy_order_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 牛莲泽
--创建日期: 2023-02-28 21:26:07
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- create table if not exists ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_features_di ( 
-- uid  string  comment '用户id',
-- mdl_dte  date  comment '模型日期',
-- call_avg_con_tim_15d  float  comment  '近15天接通时长 单位s的均值',
-- call_time_since_last_callstarttime_15d  float  comment  '近15天电话接通时间的距今时长(秒)',
-- call_max_con_tim_hanguptype_sales_30d  float  comment  '近30天挂断类型 1用户挂断 2坐席挂断为sales时接通时长 单位s的最大值',
-- call_time_since_last_callstarttime_is_connect_connect_30d  float  comment  '近30天是否接通 1接通 0未接通为connect时电话接通时间的距今时长(秒)',
-- call_avg_con_tim_is_connect_connect_30d  float  comment  '近30天是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_time_since_last_callstarttime_is_connect_connect_60d  float  comment  '近60天是否接通 1接通 0未接通为connect时电话接通时间的距今时长(秒)',
-- call_avg_con_tim_is_connect_connect_60d  float  comment  '近60天是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_sum_con_tim_is_connect_unconnect_7d  float  comment  '近7天是否接通 1接通 0未接通为unconnect时接通时长 单位s的总和',
-- call_time_since_last_callstarttime_90d  float  comment  '近90天电话接通时间的距今时长(秒)',
-- call_max_con_tim_hanguptype_sales_90d  float  comment  '近90天挂断类型 1用户挂断 2坐席挂断为sales时接通时长 单位s的最大值',
-- call_sum_con_tim_90d  float  comment  '近90天接通时长 单位s的总和',
-- call_avg_con_tim_is_connect_connect_90d  float  comment  '近90天是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_percent_true_hanguptype1_sales_90d  float  comment  '近90天hanguptype1_sales的占比',
-- call_time_since_last_callstarttime_30d  float  comment  '近30天电话接通时间的距今时长(秒)',
-- call_sum_con_tim_scene_dongzhi_is_connect_connect_30d  float  comment  '近30天电销场景为dongzhi且是否接通 1接通 0未接通为connect时接通时长 单位s的总和',
-- call_avg_con_tim_30d  float  comment  '近30天接通时长 单位s的均值',
-- call_time_since_last_callstarttime_60d  float  comment  '近60天电话接通时间的距今时长(秒)',
-- call_avg_con_tim_scene_dongzhi_is_connect_connect_60d  float  comment  '近60天电销场景为dongzhi且是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_avg_con_tim_scene_dongzhi_hanguptype_sales_90d  float  comment  '近90天电销场景为dongzhi且挂断类型 1用户挂断 2坐席挂断为sales时接通时长 单位s的均值',
-- call_avg_con_tim_scene_dongzhi_is_connect_connect_90d  float  comment  '近90天电销场景为dongzhi且是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_max_con_tim_scene_dongzhi_is_connect_unconnect_90d  float  comment  '近90天电销场景为dongzhi且是否接通 1接通 0未接通为unconnect时接通时长 单位s的最大值',
-- call_avg_con_tim_hanguptype_customer_is_connect_connect_30d  float  comment  '近30天挂断类型 1用户挂断 2坐席挂断为customer且是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_time_since_last_callstarttime_hanguptype_customer_is_connect_connect_30d  float  comment  '近30天挂断类型 1用户挂断 2坐席挂断为customer且是否接通 1接通 0未接通为connect时电话接通时间的距今时长(秒)',
-- call_avg_con_tim_hanguptype_customer_is_connect_connect_60d  float  comment  '近60天挂断类型 1用户挂断 2坐席挂断为customer且是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_max_con_tim_hanguptype_sales_is_connect_connect_90d  float  comment  '近90天挂断类型 1用户挂断 2坐席挂断为sales且是否接通 1接通 0未接通为connect时接通时长 单位s的最大值',
-- call_avg_con_tim_hanguptype_customer_is_connect_connect_90d  float  comment  '近90天挂断类型 1用户挂断 2坐席挂断为customer且是否接通 1接通 0未接通为connect时接通时长 单位s的均值',
-- call_sum_con_tim_hanguptype_customer_is_connect_connect_90d  float  comment  '近90天挂断类型 1用户挂断 2坐席挂断为customer且是否接通 1接通 0未接通为connect时接通时长 单位s的总和',
-- call_avg_con_tim_scene_dongzhi_hanguptype_sales_is_connect_unconnect_90d  float  comment  '近90天电销场景为dongzhi且挂断类型 1用户挂断 2坐席挂断为sales且是否接通 1接通 0未接通为unconnect时接通时长 单位s的均值',
-- call_max_con_tim_30d  float  comment  '近30天接通时长 单位s的最大值',
-- call_max_con_tim_60d  float  comment  '近60天接通时长 单位s的最大值',
-- call_avg_con_tim_90d  float  comment  '近90天接通时长 单位s的均值'
-- )  comment '电销uid维度拨打记录特征宽表变量'  
-- partitioned by (ds string);


----------------------------------
-- 01 样本表
-- 逻辑来自${dwa_risk}.dwa_risk_f_dz_model_data_base，但是原表只能取昨天的数据，这里拿出来后可以方便修改ds, 回溯数据只需要把'${bizdate}'改为想要回溯的ds即可
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_sample_di_tmp;
create table ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_sample_di_tmp as 
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from ${dwt}.dwt_heavy_order_df 
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;


----------------------------------
-- 02 通话记录底表
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_tmp;
create table ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_tmp as
select c.uid,
       to_date(b.caseoverduetime) as task_due_date,
       b.workorderid as task_id,
       b.objective_guid,
       a.customer_guid,
       d.firstid as fir_id,
       d.secondid as sec_id,
       b.tag_id,
       d.tagname as tag_name,
       case when substr(d.tagname,1,3)='UN_' then 'dongzhi'
            when substr(d.tagname,1,3)='FL_' then 'shoudeng'
            when substr(d.tagname,1,3)='AS_' then 'shenwan'
            when substr(d.tagname,1,3)='UNQ' then 'qingzichan' end as scene,
       a.ani,
       case when a.hanguptype=1 then 'customer'
		    when a.hanguptype=2 then 'sales'
		    else 'other' end as hanguptype,
       case when a.callestablished=1 then 'connect'
            when a.callestablished=0 then 'unconnect'
            else 'other' end as is_connect,
       to_date(a.callstarttime) as callstarttime,
	  datediff(a.callendtime,a.callstarttime,'ss') as con_tim
from(
    select objective_guid,customer_guid,ani,hanguptype,callestablished,callstarttime,callendtime
    from ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_event_his  -- 通话记录表
    ) a
left join (
            select workorderid,objective_guid,customer_guid,tag_id,caseoverduetime
            from ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_objective_his -- workorderid案件编号 tag_id案件标签id activetag 活动标签id(空值较多)
            group by workorderid,objective_guid,customer_guid,tag_id,caseoverduetime
            ) b
on a.objective_guid = b.objective_guid 
left join (
        select uid,customer_guid
        from ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_elitewo3task_his -- uid用户id casetag案件标签id activetag 活动标签id(空值较多)
        group by uid,customer_guid
) c
on b.customer_guid=c.customer_guid
left join(
        select firstid,secondid,tagname,id
        from ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_tag_his -- firstid 一级标签id; secondid 二级标签id; id 案件标签id tagname 案件标签名称
        group by firstid,secondid,tagname,id
) d
on b.tag_id=d.id
where c.uid is not null
group by c.uid,to_date(b.caseoverduetime), 
       b.workorderid,b.objective_guid,
       a.customer_guid,d.firstid,d.secondid,b.tag_id,
       d.tagname,
       case when substr(d.tagname,1,3)='UN_' then 'dongzhi'
            when substr(d.tagname,1,3)='FL_' then 'shoudeng'
            when substr(d.tagname,1,3)='AS_' then 'shenwan'
            when substr(d.tagname,1,3)='UNQ' then 'qingzichan' end,
       a.ani,
       case when a.hanguptype=1 then 'customer'
		    when a.hanguptype=2 then 'sales'
		    else 'other' end,
       case when a.callestablished=1 then 'connect'
            when a.callestablished=0 then 'unconnect'
            else 'other' end,
       to_date(a.callstarttime),
	  datediff(a.callendtime,a.callstarttime,'ss')
;


----------------------------------
-- 03 增量数据
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp; 
create table ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp as 
select smp_dt.uid, smp_dt.mdl_dte,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 15,atom_dt.con_tim,null)) as call_avg_con_tim_15d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 15,atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_15d,
	max(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30 and hanguptype='sales',atom_dt.con_tim,null)) as call_max_con_tim_hanguptype_sales_30d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30 and is_connect='connect',atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_is_connect_connect_30d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30 and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_is_connect_connect_30d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 60 and is_connect='connect',atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_is_connect_connect_60d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 60 and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_is_connect_connect_60d,
	sum(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 7 and is_connect='unconnect',atom_dt.con_tim,null)) as call_sum_con_tim_is_connect_unconnect_7d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90,atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_90d,
	max(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and hanguptype='sales',atom_dt.con_tim,null)) as call_max_con_tim_hanguptype_sales_90d,
	sum(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90,atom_dt.con_tim,null)) as call_sum_con_tim_90d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_is_connect_connect_90d,
	count(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and hanguptype = 'sales',1,null)) / count(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90) as call_percent_true_hanguptype1_sales_90d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30,atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_30d,
	sum(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30 and scene='dongzhi' and is_connect='connect',atom_dt.con_tim,null)) as call_sum_con_tim_scene_dongzhi_is_connect_connect_30d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30,atom_dt.con_tim,null)) as call_avg_con_tim_30d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 60,atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_60d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 60 and scene='dongzhi' and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_scene_dongzhi_is_connect_connect_60d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and scene='dongzhi' and hanguptype='sales',atom_dt.con_tim,null)) as call_avg_con_tim_scene_dongzhi_hanguptype_sales_90d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and scene='dongzhi' and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_scene_dongzhi_is_connect_connect_90d,
	max(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and scene='dongzhi' and is_connect='unconnect',atom_dt.con_tim,null)) as call_max_con_tim_scene_dongzhi_is_connect_unconnect_90d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30 and hanguptype='customer' and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_hanguptype_customer_is_connect_connect_30d,
	min(datediff(smp_dt.mdl_dte, (if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30 and hanguptype='customer' and is_connect='connect',atom_dt.callstarttime,null)))) as call_time_since_last_callstarttime_hanguptype_customer_is_connect_connect_30d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 60 and hanguptype='customer' and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_hanguptype_customer_is_connect_connect_60d,
	max(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and hanguptype='sales' and is_connect='connect',atom_dt.con_tim,null)) as call_max_con_tim_hanguptype_sales_is_connect_connect_90d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and hanguptype='customer' and is_connect='connect',atom_dt.con_tim,null)) as call_avg_con_tim_hanguptype_customer_is_connect_connect_90d,
	sum(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and hanguptype='customer' and is_connect='connect',atom_dt.con_tim,null)) as call_sum_con_tim_hanguptype_customer_is_connect_connect_90d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90 and scene='dongzhi' and hanguptype='sales' and is_connect='unconnect',atom_dt.con_tim,null)) as call_avg_con_tim_scene_dongzhi_hanguptype_sales_is_connect_unconnect_90d,
	max(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 30,atom_dt.con_tim,null)) as call_max_con_tim_30d,
	max(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 60,atom_dt.con_tim,null)) as call_max_con_tim_60d,
	avg(if(datediff(to_date(smp_dt.mdl_dte), to_date(atom_dt.callstarttime)) <= 90,atom_dt.con_tim,null)) as call_avg_con_tim_90d
 
 from ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_sample_di_tmp smp_dt
 left join ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_tmp atom_dt
 on smp_dt.uid=atom_dt.uid and smp_dt.mdl_dte > atom_dt.callstarttime
 
 group by smp_dt.uid,smp_dt.mdl_dte;

-- select * from pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp limit 200;

-------------------------
-- 04 插入分区表
-------------------------
insert overwrite table ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_features_di partition(ds='${bizdate}') 
select
uid,
mdl_dte,
call_avg_con_tim_15d,
call_time_since_last_callstarttime_15d,
call_max_con_tim_hanguptype_sales_30d,
call_time_since_last_callstarttime_is_connect_connect_30d,
call_avg_con_tim_is_connect_connect_30d,
call_time_since_last_callstarttime_is_connect_connect_60d,
call_avg_con_tim_is_connect_connect_60d,
call_sum_con_tim_is_connect_unconnect_7d,
call_time_since_last_callstarttime_90d,
call_max_con_tim_hanguptype_sales_90d,
call_sum_con_tim_90d,
call_avg_con_tim_is_connect_connect_90d,
call_percent_true_hanguptype1_sales_90d,
call_time_since_last_callstarttime_30d,
call_sum_con_tim_scene_dongzhi_is_connect_connect_30d,
call_avg_con_tim_30d,
call_time_since_last_callstarttime_60d,
call_avg_con_tim_scene_dongzhi_is_connect_connect_60d,
call_avg_con_tim_scene_dongzhi_hanguptype_sales_90d,
call_avg_con_tim_scene_dongzhi_is_connect_connect_90d,
call_max_con_tim_scene_dongzhi_is_connect_unconnect_90d,
call_avg_con_tim_hanguptype_customer_is_connect_connect_30d,
call_time_since_last_callstarttime_hanguptype_customer_is_connect_connect_30d,
call_avg_con_tim_hanguptype_customer_is_connect_connect_60d,
call_max_con_tim_hanguptype_sales_is_connect_connect_90d,
call_avg_con_tim_hanguptype_customer_is_connect_connect_90d,
call_sum_con_tim_hanguptype_customer_is_connect_connect_90d,
call_avg_con_tim_scene_dongzhi_hanguptype_sales_is_connect_unconnect_90d,
call_max_con_tim_30d,
call_max_con_tim_60d,
call_avg_con_tim_90d
from ${pdm_risk}.pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp
;
--select * from pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_features_di where ds='20230101' limit 100
-- feature-copilot:node-end ordinal=0
