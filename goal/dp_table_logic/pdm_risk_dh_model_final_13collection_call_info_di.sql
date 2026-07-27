-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dh_model_final_13collection_call_info_di
-- node_id: n_3934879917976649728
-- task_name: pdm_risk_dh_model_final_13collection_call_info_di
-- owner_name: 海宜真
-- source_json: goal/dp_table_logic/pdm_risk_dh_model_final_13collection_call_info_di.json
-- source_json_sha256: 51525c8eb50ca4415e96b1c4dd5180142e8db79223d9107752b8bca1d4d014eb
-- upstream_table: pdm_risk.dh_model_final_13collection_call_info_tmp
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: pdm_risk.pdm_risk_dh_model_final_13collection_call_info_di_sample_yesterday
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_case_info_df
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_call_record_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 章少平
--创建日期: 2022-08-17 16:18:57
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

----------------------------------
-- 01 创建表结构
----------------------------------
create table if not exists ${pdm_risk}.pdm_risk_dh_model_final_13collection_call_info_di (
   uid string
  ,mdl_dte date comment '模型日期'
  ,col_cal_ring_7d_own float comment '近7日拨打本人响铃时长'
  ,col_cal_talk_7d_own float comment '近7日拨打本人接听时长'
  ,col_cal_cnt_7d_own float comment '近7日拨打本人次数-语音表'
  ,col_cal_ring_7d_ctt float comment '近7日拨打他人响铃时长'
  ,col_cal_talk_7d_ctt float comment '近7日拨打他人接听时长'
  ,col_cal_cnt_7d_ctt float comment '近7日拨打他人次数-语音表'
  ,col_cal_eff_cnt_7d_own float comment '近7日拨打本人有效次数'
  ,col_cal_eff_cnt_7d_ctt float comment '近7日拨打他人有效次数'
  ,col_cal_ring_15d_own float comment '近15日拨打本人响铃时长'
  ,col_cal_talk_15d_own float comment '近15日拨打本人接听时长'
  ,col_cal_cnt_15d_own float comment '近15日拨打本人次数-语音表'
  ,col_cal_ring_15d_ctt float comment '近15日拨打他人响铃时长'
  ,col_cal_talk_15d_ctt float comment '近15日拨打他人接听时长'
  ,col_cal_cnt_15d_ctt float comment '近15日拨打他人次数-语音表'
  ,col_cal_eff_cnt_15d_own float comment '近15日拨打本人有效次数'
  ,col_cal_eff_cnt_15d_ctt float comment '近15日拨打他人有效次数'
  ,col_cal_ring_30d_own float comment '近30日拨打本人响铃时长'
  ,col_cal_talk_30d_own float comment '近30日拨打本人接听时长'
  ,col_cal_cnt_30d_own float comment '近30日拨打本人次数-语音表'
  ,col_cal_ring_30d_ctt float comment '近30日拨打他人响铃时长'
  ,col_cal_talk_30d_ctt float comment '近30日拨打他人接听时长'
  ,col_cal_cnt_30d_ctt float comment '近30日拨打他人次数-语音表'
  ,col_cal_eff_cnt_30d_own float comment '近30日拨打本人有效次数'
  ,col_cal_eff_cnt_30d_ctt float comment '近30日拨打他人有效次数'
  ,col_cal_ring_60d_own float comment '近60日拨打本人响铃时长'
  ,col_cal_talk_60d_own float comment '近60日拨打本人接听时长'
  ,col_cal_cnt_60d_own float comment '近60日拨打本人次数-语音表'
  ,col_cal_ring_60d_ctt float comment '近60日拨打他人响铃时长'
  ,col_cal_talk_60d_ctt float comment '近60日拨打他人接听时长'
  ,col_cal_cnt_60d_ctt float comment '近60日拨打他人次数-语音表'
  ,col_cal_eff_cnt_60d_own float comment '近60日拨打本人有效次数'
  ,col_cal_eff_cnt_60d_ctt float comment '近60日拨打他人有效次数'
  ,col_cal_ring_90d_own float comment '近90日拨打本人响铃时长'
  ,col_cal_talk_90d_own float comment '近90日拨打本人接听时长'
  ,col_cal_cnt_90d_own float comment '近90日拨打本人次数-语音表'
  ,col_cal_ring_90d_ctt float comment '近90日拨打他人响铃时长'
  ,col_cal_talk_90d_ctt float comment '近90日拨打他人接听时长'
  ,col_cal_cnt_90d_ctt float comment '近90日拨打他人次数-语音表'
  ,col_cal_eff_cnt_90d_own float comment '近90日拨打本人有效次数'
  ,col_cal_eff_cnt_90d_ctt float comment '近90日拨打他人有效次数'
  ,col_cal_eff_cnt_ratio_7d_own float comment '近7日拨打本人有效次数占比'
  ,col_cal_eff_cnt_ratio_7d_ctt float comment '近7日拨打他人有效次数占比'
  ,col_cal_eff_cnt_ratio_15d_own float comment '近15日拨打本人有效次数占比'
  ,col_cal_eff_cnt_ratio_15d_ctt float comment '近15日拨打他人有效次数占比'
  ,col_cal_eff_cnt_ratio_30d_own float comment '近30日拨打本人有效次数占比'
  ,col_cal_eff_cnt_ratio_30d_ctt float comment '近30日拨打他人有效次数占比'
  ,col_cal_eff_cnt_ratio_60d_own float comment '近60日拨打本人有效次数占比'
  ,col_cal_eff_cnt_ratio_60d_ctt float comment '近60日拨打他人有效次数占比'
  ,col_cal_eff_cnt_ratio_90d_own float comment '近90日拨打本人有效次数占比'
  ,col_cal_eff_cnt_ratio_90d_ctt float comment '近90日拨打他人有效次数占比'
) comment "贷后大宽表-13催收语音" partitioned by (ds string comment '分区字段,格式yyyymmdd')
;

----------------------------------
-- 样本表
-- 逻辑来自${dwa_risk}.dwa_risk_f_dz_model_data_base，但是原表只能取昨天的数据，这里拿出来后可以方便修改ds, 回溯数据只需要把'${bizdate}'改为想要回溯的ds即可
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_final_13collection_call_info_di_sample_yesterday;
create table ${pdm_risk}.pdm_risk_dh_model_final_13collection_call_info_di_sample_yesterday as 
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from dwt.dwt_heavy_order_df 
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;

----------------------------------
-- 02 增量数据
----------------------------------
drop table if exists ${pdm_risk}.dh_model_final_13collection_call_info_tmp; 
create table ${pdm_risk}.dh_model_final_13collection_call_info_tmp as 
select 
  n.*, 
  col_cal_eff_cnt_7d_own / col_cal_cnt_7d_own as col_cal_eff_cnt_ratio_7d_own, 
  col_cal_eff_cnt_7d_ctt / col_cal_cnt_7d_ctt as col_cal_eff_cnt_ratio_7d_ctt, 
  col_cal_eff_cnt_15d_own / col_cal_cnt_15d_own as col_cal_eff_cnt_ratio_15d_own, 
  col_cal_eff_cnt_15d_ctt / col_cal_cnt_7d_ctt as col_cal_eff_cnt_ratio_15d_ctt, 
  col_cal_eff_cnt_30d_own / col_cal_cnt_30d_own as col_cal_eff_cnt_ratio_30d_own, 
  col_cal_eff_cnt_30d_ctt / col_cal_cnt_7d_ctt as col_cal_eff_cnt_ratio_30d_ctt, 
  col_cal_eff_cnt_60d_own / col_cal_cnt_60d_own as col_cal_eff_cnt_ratio_60d_own, 
  col_cal_eff_cnt_60d_ctt / col_cal_cnt_60d_ctt as col_cal_eff_cnt_ratio_60d_ctt, 
  col_cal_eff_cnt_90d_own / col_cal_cnt_90d_own as col_cal_eff_cnt_ratio_90d_own,
  col_cal_eff_cnt_90d_ctt / col_cal_cnt_90d_ctt as col_cal_eff_cnt_ratio_90d_ctt 
from 
  (
    select 
   model_data.uid, 
   model_data.mdl_dte, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_7d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_7d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_7d_own, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_7d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_7d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_7d_ctt, 
   sum(case when ctt_rlt = 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_7d_own, 
   sum(case when ctt_rlt <> 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 7 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_7d_ctt, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_15d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_15d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_15d_own, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_15d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_15d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_15d_ctt, 
   sum(case when ctt_rlt = 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_15d_own, 
   sum(case when ctt_rlt <> 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 15 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_15d_ctt, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_30d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_30d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_30d_own, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_30d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_30d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_30d_ctt, 
   sum(case when ctt_rlt = 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_30d_own, 
   sum(case when ctt_rlt <> 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 30 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_30d_ctt, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_60d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_60d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_60d_own, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_60d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_60d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_60d_ctt, 
   sum(case when ctt_rlt = 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_60d_own, 
   sum(case when ctt_rlt <> 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 60 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_60d_ctt, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_90d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_90d_own, 
   sum(case when ctt_rlt = 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_90d_own, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(ring_length, 0) else 0 end
   ) as col_cal_ring_90d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(talk_length, 0) else 0 end
   ) as col_cal_talk_90d_ctt, 
   sum(case when ctt_rlt <> 'SELF' and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_cnt_90d_ctt, 
   sum(case when ctt_rlt = 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_90d_own, 
   sum(case when ctt_rlt <> 'SELF' and talk_length > 0 and datediff(model_data.mdl_dte, date(call_info.crt_tim)) between 1 and 90 then coalesce(call_cnt, 0) else 0 end
   ) as col_cal_eff_cnt_90d_ctt 
    from (select uid, mdl_dte from ${pdm_risk}.pdm_risk_dh_model_final_13collection_call_info_di_sample_yesterday) model_data 
    left join (select  clt.uid, crt_tim, ctt_rlt, call_cnt, ring_length, talk_length 
    from (select case_number, date(call_time) crt_tim, 
                 case when phone_type like '%本人%' then 'SELF' else 'THIRD' end as ctt_rlt,  
                 count(call_id) call_cnt,  
                 sum(ring_length) ring_length,  
                 sum(talk_length) talk_length  
    from ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_call_record_df 
    where ds = '${bizdate}'  and call_time is not null and ring_length is not null and call_type in (3, 5, 7, 8, 9) and 
    to_date(call_time) between to_date(add_months(to_date('${bizdate}', 'yyyymmdd'),-4),'yyyy-mm-dd') and to_date('${bizdate}', 'yyyymmdd')  
    group by case_number, call_time, phone_type) call 
    left join (select case_number, uid from ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_case_info_df  
    where ds = '${bizdate}'  
    group by  case_number, uid) clt 
    on call.case_number = clt.case_number
   ) call_info on model_data.uid = call_info.uid 
    group by model_data.uid, model_data.mdl_dte
  ) n
;

----------------------------------
-- 03 插入分区表
----------------------------------

insert overwrite table ${pdm_risk}.pdm_risk_dh_model_final_13collection_call_info_di partition(ds='${bizdate}') 
select uid
      ,mdl_dte
      ,col_cal_ring_7d_own
      ,col_cal_talk_7d_own
      ,col_cal_cnt_7d_own
      ,col_cal_ring_7d_ctt
      ,col_cal_talk_7d_ctt
      ,col_cal_cnt_7d_ctt
      ,col_cal_eff_cnt_7d_own
      ,col_cal_eff_cnt_7d_ctt
      ,col_cal_ring_15d_own
      ,col_cal_talk_15d_own
      ,col_cal_cnt_15d_own
      ,col_cal_ring_15d_ctt
      ,col_cal_talk_15d_ctt
      ,col_cal_cnt_15d_ctt
      ,col_cal_eff_cnt_15d_own
      ,col_cal_eff_cnt_15d_ctt
      ,col_cal_ring_30d_own
      ,col_cal_talk_30d_own
      ,col_cal_cnt_30d_own
      ,col_cal_ring_30d_ctt
      ,col_cal_talk_30d_ctt
      ,col_cal_cnt_30d_ctt
      ,col_cal_eff_cnt_30d_own
      ,col_cal_eff_cnt_30d_ctt
      ,col_cal_ring_60d_own
      ,col_cal_talk_60d_own
      ,col_cal_cnt_60d_own
      ,col_cal_ring_60d_ctt
      ,col_cal_talk_60d_ctt
      ,col_cal_cnt_60d_ctt
      ,col_cal_eff_cnt_60d_own
      ,col_cal_eff_cnt_60d_ctt
      ,col_cal_ring_90d_own
      ,col_cal_talk_90d_own
      ,col_cal_cnt_90d_own
      ,col_cal_ring_90d_ctt
      ,col_cal_talk_90d_ctt
      ,col_cal_cnt_90d_ctt
      ,col_cal_eff_cnt_90d_own
      ,col_cal_eff_cnt_90d_ctt
      ,col_cal_eff_cnt_ratio_7d_own
      ,col_cal_eff_cnt_ratio_7d_ctt
      ,col_cal_eff_cnt_ratio_15d_own
      ,col_cal_eff_cnt_ratio_15d_ctt
      ,col_cal_eff_cnt_ratio_30d_own
      ,col_cal_eff_cnt_ratio_30d_ctt
      ,col_cal_eff_cnt_ratio_60d_own
      ,col_cal_eff_cnt_ratio_60d_ctt
      ,col_cal_eff_cnt_ratio_90d_own
      ,col_cal_eff_cnt_ratio_90d_ctt
from ${pdm_risk}.dh_model_final_13collection_call_info_tmp
;
-- feature-copilot:node-end ordinal=0
