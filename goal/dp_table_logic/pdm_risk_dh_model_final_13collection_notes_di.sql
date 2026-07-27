-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dh_model_final_13collection_notes_di
-- node_id: n_3934880880049324032
-- task_name: pdm_risk_dh_model_final_13collection_notes_di
-- owner_name: 海宜真
-- source_json: goal/dp_table_logic/pdm_risk_dh_model_final_13collection_notes_di.json
-- source_json_sha256: 7fdb8e4a89b4782ee5a59b48a45d070afc53a0bfd294fa916065020b24851162
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_case_followup_record_df
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dwd_dsaresali_ares_plc_case_info_df
-- upstream_table: pdm_risk.pdm_risk_dh_model_final_13collection_notes_di_sample_yesterday
-- upstream_table: pdm_risk.dh_model_final_13collection_notes_tmp
-- upstream_table: dwt.dwt_heavy_order_df

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
create table if not exists ${pdm_risk}.pdm_risk_dh_model_final_13collection_notes_di (
   uid string
  ,mdl_dte date comment '模型日期'
  ,tot_cnt_7d int comment '近7日拨打次数'
  ,wflx_cnt_7d int comment '近7日拨打-接电无声/异常挂断/忙碌/语音留言次数'
  ,sfgt_cnt_7d int comment '近7日拨打-无法沟通/拒绝转告次数'
  ,gjkh_cnt_7d int comment '近7日拨打-关机/停机/空号次数'
  ,ptp_cnt_7d int comment '近7日拨打-承诺还款/三方代偿/协商还款次数'
  ,zjkn_cnt_7d int comment '近7日拨打-资金困难/拒绝还款次数'
  ,self_cnt_7d int comment '近7日拨打本人次数'
  ,family_cnt_7d int comment '近7日拨打家人次数'
  ,friend_cnt_7d int comment '近7日拨打朋友次数'
  ,follow_cnt_7d int comment '近7日承诺还款次数'
  ,follow_amount_7d float comment '近7日承诺还款金额'
  ,tot_cnt_15d int comment '近15日拨打次数'
  ,wflx_cnt_15d int comment '近15日拨打-接电无声/异常挂断/忙碌/语音留言次数'
  ,sfgt_cnt_15d int comment '近15日拨打-无法沟通/拒绝转告次数'
  ,gjkh_cnt_15d int comment '近15日拨打-关机/停机/空号次数'
  ,ptp_cnt_15d int comment '近15日拨打-承诺还款/三方代偿/协商还款次数'
  ,zjkn_cnt_15d int comment '近15日拨打-资金困难/拒绝还款次数'
  ,self_cnt_15d int comment '近15日拨打本人次数'
  ,family_cnt_15d int comment '近15日拨打家人次数'
  ,friend_cnt_15d int comment '近15日拨打朋友次数'
  ,follow_cnt_15d int comment '近15日承诺还款次数'
  ,follow_amount_15d int comment '近15日承诺还款金额'
  ,tot_cnt_30d int comment '近30日拨打次数'
  ,wflx_cnt_30d int comment '近30日拨打-接电无声/异常挂断/忙碌/语音留言次数'
  ,sfgt_cnt_30d int comment '近30日拨打-无法沟通/拒绝转告次数'
  ,gjkh_cnt_30d int comment '近30日拨打-关机/停机/空号次数'
  ,ptp_cnt_30d int comment '近30日拨打-承诺还款/三方代偿/协商还款次数'
  ,zjkn_cnt_30d int comment '近30日拨打-资金困难/拒绝还款次数'
  ,self_cnt_30d int comment '近30日拨打本人次数'
  ,family_cnt_30d int comment '近30日拨打家人次数'
  ,friend_cnt_30d int comment '近30日拨打朋友次数'
  ,follow_cnt_30d int comment '近30日承诺还款次数'
  ,follow_amount_30d int comment '近30日承诺还款金额'
  ,tot_cnt_60d int comment '近60日拨打次数'
  ,wflx_cnt_60d int comment '近60日拨打-接电无声/异常挂断/忙碌/语音留言次数'
  ,sfgt_cnt_60d int comment '近60日拨打-无法沟通/拒绝转告次数'
  ,gjkh_cnt_60d int comment '近60日拨打-关机/停机/空号次数'
  ,ptp_cnt_60d int comment '近60日拨打-承诺还款/三方代偿/协商还款次数'
  ,zjkn_cnt_60d int comment '近60日拨打-资金困难/拒绝还款次数'
  ,self_cnt_60d int comment '近60日拨打本人次数'
  ,family_cnt_60d int comment '近60日拨打家人次数'
  ,friend_cnt_60d int comment '近60日拨打朋友次数'
  ,follow_cnt_60d int comment '近60日承诺还款次数'
  ,follow_amount_60d int comment '近60日承诺还款金额'
  ,tot_cnt_90d int comment '近90日拨打次数'
  ,wflx_cnt_90d int comment '近90日拨打-接电无声/异常挂断/忙碌/语音留言次数'
  ,sfgt_cnt_90d int comment '近90日拨打-无法沟通/拒绝转告次数'
  ,gjkh_cnt_90d int comment '近90日拨打-关机/停机/空号次数'
  ,ptp_cnt_90d int comment '近90日拨打-承诺还款/三方代偿/协商还款次数'
  ,zjkn_cnt_90d int comment '近90日拨打-资金困难/拒绝还款次数'
  ,self_cnt_90d int comment '近90日拨打本人次数'
  ,family_cnt_90d int comment '近90日拨打家人次数'
  ,friend_cnt_90d int comment '近90日拨打朋友次数'
  ,follow_cnt_90d int comment '近90日承诺还款次数'
  ,follow_amount_90d int comment '近90日承诺还款金额'
  ,wflx_cnt_ratio_7d float comment '近7日拨打-接电无声/异常挂断/忙碌/语音留言次数占比'
  ,sfgt_cnt_ratio_7d float comment '近7日拨打-无法沟通/拒绝转告次数占比'
  ,gjkh_cnt_ratio_7d float comment '近7日拨打-关机/停机/空号次数占比'
  ,ptp_cnt_ratio_7d float comment '近7日拨打-承诺还款/三方代偿/协商还款次数占比'
  ,zjkn_cnt_ratio_7d float comment '近7日拨打-资金困难/拒绝还款次数占比'
  ,self_cnt_ratio_7d float comment '近7日拨打本人次数占比'
  ,family_cnt_ratio_7d float comment '近7日拨打家人次数占比'
  ,friend_cnt_ratio_7d float comment '近7日拨打朋友次数占比'
  ,follow_cnt_ratio_7d float comment '近7日承诺还款次数占比'
  ,wflx_cnt_ratio_15d float comment '近15日拨打-接电无声/异常挂断/忙碌/语音留言次数占比'
  ,sfgt_cnt_ratio_15d float comment '近15日拨打-无法沟通/拒绝转告次数占比'
  ,gjkh_cnt_ratio_15d float comment '近15日拨打-关机/停机/空号次数占比'
  ,ptp_cnt_ratio_15d float comment '近15日拨打-承诺还款/三方代偿/协商还款次数占比'
  ,zjkn_cnt_ratio_15d float comment '近15日拨打-资金困难/拒绝还款次数占比'
  ,self_cnt_ratio_15d float comment '近15日拨打本人次数占比'
  ,family_cnt_ratio_15d float comment '近15日拨打家人次数占比'
  ,friend_cnt_ratio_15d float comment '近15日拨打朋友次数占比'
  ,follow_cnt_ratio_15d float comment '近15日承诺还款次数占比'
  ,wflx_cnt_ratio_30d float comment '近30日拨打-接电无声/异常挂断/忙碌/语音留言次数占比'
  ,sfgt_cnt_ratio_30d float comment '近30日拨打-无法沟通/拒绝转告次数占比'
  ,gjkh_cnt_ratio_30d float comment '近30日拨打-关机/停机/空号次数占比'
  ,ptp_cnt_ratio_30d float comment '近30日拨打-承诺还款/三方代偿/协商还款次数占比'
  ,zjkn_cnt_ratio_30d float comment '近30日拨打-资金困难/拒绝还款次数占比'
  ,self_cnt_ratio_30d float comment '近30日拨打本人次数占比'
  ,family_cnt_ratio_30d float comment '近30日拨打家人次数占比'
  ,friend_cnt_ratio_30d float comment '近30日拨打朋友次数占比'
  ,follow_cnt_ratio_30d float comment '近30日承诺还款次数占比'
  ,wflx_cnt_ratio_60d float comment '近60日拨打-接电无声/异常挂断/忙碌/语音留言次数占比'
  ,sfgt_cnt_ratio_60d float comment '近60日拨打-无法沟通/拒绝转告次数占比'
  ,gjkh_cnt_ratio_60d float comment '近60日拨打-关机/停机/空号次数占比'
  ,ptp_cnt_ratio_60d float comment '近60日拨打-承诺还款/三方代偿/协商还款次数占比'
  ,zjkn_cnt_ratio_60d float comment '近60日拨打-资金困难/拒绝还款次数占比'
  ,self_cnt_ratio_60d float comment '近60日拨打本人次数占比'
  ,family_cnt_ratio_60d float comment '近60日拨打家人次数占比'
  ,friend_cnt_ratio_60d float comment '近60日拨打朋友次数占比'
  ,follow_cnt_ratio_60d float comment '近60日承诺还款次数占比'
  ,wflx_cnt_ratio_90d float comment '近90日拨打-接电无声/异常挂断/忙碌/语音留言次数占比'
  ,sfgt_cnt_ratio_90d float comment '近90日拨打-无法沟通/拒绝转告次数占比'
  ,gjkh_cnt_ratio_90d float comment '近90日拨打-关机/停机/空号次数占比'
  ,ptp_cnt_ratio_90d float comment '近90日拨打-承诺还款/三方代偿/协商还款次数占比'
  ,zjkn_cnt_ratio_90d float comment '近90日拨打-资金困难/拒绝还款次数占比'
  ,self_cnt_ratio_90d float comment '近90日拨打本人次数占比'
  ,family_cnt_ratio_90d float comment '近90日拨打家人次数占比'
  ,friend_cnt_ratio_90d float comment '近90日拨打朋友次数占比'
  ,follow_cnt_ratio_90d float comment '近90日承诺还款次数占比'
) comment "贷后大宽表-13催记" partitioned by (ds string comment '分区字段,格式yyyymmdd')
;

----------------------------------
-- 样本表
-- 逻辑来自${dwa_risk}.dwa_risk_f_dz_model_data_base，但是原表只能取昨天的数据，这里拿出来后可以方便修改ds, 回溯数据只需要把'${bizdate}'改为想要回溯的ds即可
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_final_13collection_notes_di_sample_yesterday;
create table ${pdm_risk}.pdm_risk_dh_model_final_13collection_notes_di_sample_yesterday as 
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from ${dwt}.dwt_heavy_order_df 
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;



----------------------------------
-- 02 增量数据
----------------------------------
drop table if exists ${pdm_risk}.dh_model_final_13collection_notes_tmp; 
create table ${pdm_risk}.dh_model_final_13collection_notes_tmp as 
select 
  n.*, wflx_cnt_7d / tot_cnt_7d as wflx_cnt_ratio_7d,
       sfgt_cnt_7d / tot_cnt_7d as sfgt_cnt_ratio_7d,
       gjkh_cnt_7d / tot_cnt_7d as gjkh_cnt_ratio_7d,
       ptp_cnt_7d / tot_cnt_7d as ptp_cnt_ratio_7d,
       zjkn_cnt_7d / tot_cnt_7d as zjkn_cnt_ratio_7d,
       self_cnt_7d / tot_cnt_7d as self_cnt_ratio_7d,
       family_cnt_7d / tot_cnt_7d as family_cnt_ratio_7d,
       friend_cnt_7d / tot_cnt_7d as friend_cnt_ratio_7d,
       follow_cnt_7d / tot_cnt_7d as follow_cnt_ratio_7d,
       wflx_cnt_15d / tot_cnt_15d as wflx_cnt_ratio_15d,
       sfgt_cnt_15d / tot_cnt_15d as sfgt_cnt_ratio_15d,
       gjkh_cnt_15d / tot_cnt_15d as gjkh_cnt_ratio_15d,
       ptp_cnt_15d / tot_cnt_15d as ptp_cnt_ratio_15d,
       zjkn_cnt_15d / tot_cnt_15d as zjkn_cnt_ratio_15d,
       self_cnt_15d / tot_cnt_15d as self_cnt_ratio_15d,
       family_cnt_15d / tot_cnt_15d as family_cnt_ratio_15d,
       friend_cnt_15d / tot_cnt_15d as friend_cnt_ratio_15d,
       follow_cnt_15d / tot_cnt_15d as follow_cnt_ratio_15d,
       wflx_cnt_30d / tot_cnt_30d as wflx_cnt_ratio_30d,
       sfgt_cnt_30d / tot_cnt_30d as sfgt_cnt_ratio_30d,
       gjkh_cnt_30d / tot_cnt_30d as gjkh_cnt_ratio_30d,
       ptp_cnt_30d / tot_cnt_30d as ptp_cnt_ratio_30d,
       zjkn_cnt_30d / tot_cnt_30d as zjkn_cnt_ratio_30d,
       self_cnt_30d / tot_cnt_30d as self_cnt_ratio_30d,
       family_cnt_30d / tot_cnt_30d as family_cnt_ratio_30d,
       friend_cnt_30d / tot_cnt_30d as friend_cnt_ratio_30d,
       follow_cnt_30d / tot_cnt_30d as follow_cnt_ratio_30d,
       wflx_cnt_60d / tot_cnt_60d as wflx_cnt_ratio_60d,
       sfgt_cnt_60d / tot_cnt_60d as sfgt_cnt_ratio_60d,
       gjkh_cnt_60d / tot_cnt_60d as gjkh_cnt_ratio_60d,
       ptp_cnt_60d / tot_cnt_60d as ptp_cnt_ratio_60d,
       zjkn_cnt_60d / tot_cnt_60d as zjkn_cnt_ratio_60d,
       self_cnt_60d / tot_cnt_60d as self_cnt_ratio_60d,
       family_cnt_60d / tot_cnt_60d as family_cnt_ratio_60d,
       friend_cnt_60d / tot_cnt_60d as friend_cnt_ratio_60d,
       follow_cnt_60d / tot_cnt_60d as follow_cnt_ratio_60d,
       wflx_cnt_90d / tot_cnt_90d as wflx_cnt_ratio_90d,
       sfgt_cnt_90d / tot_cnt_90d as sfgt_cnt_ratio_90d,
       gjkh_cnt_90d / tot_cnt_90d as gjkh_cnt_ratio_90d,
       ptp_cnt_90d / tot_cnt_90d as ptp_cnt_ratio_90d,
       zjkn_cnt_90d / tot_cnt_90d as zjkn_cnt_ratio_90d,
       self_cnt_90d / tot_cnt_90d as self_cnt_ratio_90d,
       family_cnt_90d / tot_cnt_90d as family_cnt_ratio_90d,
       friend_cnt_90d / tot_cnt_90d as friend_cnt_ratio_90d,
       follow_cnt_90d / tot_cnt_90d as follow_cnt_ratio_90d
from 
  (
select 
      model_data.uid, model_data.mdl_dte, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt)) between 1 and 7 then coalesce(tot_cnt, 0) else 0 end ) as tot_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt)) between 1 and 7 then coalesce(wflx_cnt, 0) else 0 end) as wflx_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt)) between 1 and 7 then coalesce(sfgt_cnt, 0) else 0 end) as sfgt_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt)) between 1 and 7 then coalesce(gjkh_cnt, 0) else 0 end) as gjkh_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt)) between 1 and 7 then coalesce(ptp_cnt, 0) else 0 end) as ptp_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 7 then coalesce(zjkn_cnt, 0) else 0 end) as zjkn_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 7 then coalesce(self_cnt, 0) else 0 end) as self_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 7 then coalesce(family_cnt, 0) else 0 end) as family_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 7 then coalesce(friend_cnt, 0) else 0 end) as friend_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 7 then coalesce(follow_cnt, 0) else 0 end) as follow_cnt_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 7 then coalesce(follow_amount, 0) else 0 end) as follow_amount_7d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(tot_cnt, 0) else 0 end) as tot_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(wflx_cnt, 0) else 0 end) as wflx_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(sfgt_cnt, 0) else 0 end) as sfgt_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(gjkh_cnt, 0) else 0 end) as gjkh_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(ptp_cnt, 0) else 0 end) as ptp_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(zjkn_cnt, 0) else 0 end) as zjkn_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(self_cnt, 0) else 0 end) as self_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(family_cnt, 0) else 0 end) as family_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(friend_cnt, 0) else 0 end) as friend_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(follow_cnt, 0) else 0 end) as follow_cnt_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 15 then coalesce(follow_amount, 0) else 0 end) as follow_amount_15d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(tot_cnt, 0) else 0 end) as tot_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(wflx_cnt, 0) else 0 end) as wflx_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(sfgt_cnt, 0) else 0 end) as sfgt_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(gjkh_cnt, 0) else 0 end) as gjkh_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(ptp_cnt, 0) else 0 end) as ptp_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(zjkn_cnt, 0) else 0 end) as zjkn_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(self_cnt, 0) else 0 end) as self_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(family_cnt, 0) else 0 end) as family_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(friend_cnt, 0) else 0 end) as friend_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(follow_cnt, 0) else 0 end) as follow_cnt_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 30 then coalesce(follow_amount, 0) else 0 end) as follow_amount_30d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(tot_cnt, 0) else 0 end) as tot_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(wflx_cnt, 0) else 0 end) as wflx_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(sfgt_cnt, 0) else 0 end) as sfgt_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(gjkh_cnt, 0) else 0 end) as gjkh_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(ptp_cnt, 0) else 0 end) as ptp_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(zjkn_cnt, 0) else 0 end) as zjkn_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(self_cnt, 0) else 0 end) as self_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(family_cnt, 0) else 0 end) as family_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(friend_cnt, 0) else 0 end) as friend_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(follow_cnt, 0) else 0 end) as follow_cnt_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 60 then coalesce(follow_amount, 0) else 0 end) as follow_amount_60d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(tot_cnt, 0) else 0 end) as tot_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(wflx_cnt, 0) else 0 end) as wflx_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(sfgt_cnt, 0) else 0 end) as sfgt_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(gjkh_cnt, 0) else 0 end) as gjkh_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(ptp_cnt, 0) else 0 end) as ptp_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(zjkn_cnt, 0) else 0 end) as zjkn_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(self_cnt, 0) else 0 end) as self_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(family_cnt, 0) else 0 end) as family_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(friend_cnt, 0) else 0 end) as friend_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(follow_cnt, 0) else 0 end) as follow_cnt_90d, 
      sum(case when datediff(model_data.mdl_dte, date(notes_info.notes_dt) ) between 1  and 90 then coalesce(follow_amount, 0) else 0 end) as follow_amount_90d 
    from 
      (select uid, mdl_dte from ${pdm_risk}.pdm_risk_dh_model_final_13collection_notes_di_sample_yesterday) model_data 
    left join (
        select 
          clt.uid, 
          flw.notes_dt, 
          tot_cnt, 
          wflx_cnt, 
          sfgt_cnt, 
          gjkh_cnt, 
          ptp_cnt, 
          zjkn_cnt, 
          self_cnt, 
          family_cnt, 
          friend_cnt, 
          follow_cnt, 
          follow_amount 
        from 
          (
            select 
              case_number, 
              to_date(operator_time) notes_dt, 
              count(1) as tot_cnt, 
              count(case when phone_code in ('YJJD', 'YCGD', 'LMS', 'NOAS', 'BUSY', 'YYLY') then case_number end
              ) wflx_cnt, 
              count(case when phone_code in ('FRRS', 'JJZG') then case_number end) sfgt_cnt, 
              count(case when phone_code in ('OFF', 'LOOO', 'STOP') then case_number end) gjkh_cnt, 
              count(case when phone_code in ('PTP', 'OPTP', 'ALPA', 'CHAT') then case_number end) ptp_cnt, 
              count(case when phone_code in ('CDLT', 'RTP', 'OUGT', 'DISP') then case_number end) zjkn_cnt, 
              count(case when relation_ship in ('本人', '客户本人') then relation_ship end) self_cnt, 
              count(case when relation_ship in ('家人', '配偶', '母亲', '父亲', '夫妻', '父母', '兄弟姐妹', '哥哥', 
              '妈妈', '亲密联系人') then relation_ship end) family_cnt, 
              count(case when relation_ship in ('朋友', '其他', '同事', '一般联系人') then relation_ship end)
               friend_cnt, 
              count(case when follow_amount > 0 then 1 else null end) follow_cnt, 
              avg(case when follow_amount > 0 then follow_amount else 0 end) follow_amount 
            from 
              ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_case_followup_record_df 
            where 
              ds = '${bizdate}' and to_date(operator_time) between to_date(add_months(to_date('${bizdate}', 'yyyymmdd'), -4), 'yyyy-mm-dd') and to_date('${bizdate}', 'yyyymmdd') and case_number is not null 
              and phone_code in ('YJJD', 'YCGD', 'OUGT', 'FRRS', 'JJZG', 'DISP', 'NOAS', 'OFF', 'LOOO', 'STOP', 
                'BUSY', 'LMS', 'YYLY', 'CDLT', 'CHAT', 'RTP', 'PTP', 'OPTP', 'ALPA') 
            group by case_number, operator_time
          ) flw 
          left join (select case_number, uid from 
              ods_pdw_loan.ods_pdw_loan_dwd_dsaresali_ares_plc_case_info_df 
            where ds = '${bizdate}' 
            group by case_number, uid
          ) clt on flw.case_number = clt.case_number
      ) notes_info on model_data.uid = notes_info.uid 
    group by 
      model_data.uid, 
      model_data.mdl_dte
  ) n
;

----------------------------------
-- 03 插入分区表
----------------------------------

insert overwrite table ${pdm_risk}.pdm_risk_dh_model_final_13collection_notes_di partition(ds='${bizdate}') 
select uid
      ,mdl_dte
      ,tot_cnt_7d
      ,wflx_cnt_7d
      ,sfgt_cnt_7d
      ,gjkh_cnt_7d
      ,ptp_cnt_7d
      ,zjkn_cnt_7d
      ,self_cnt_7d
      ,family_cnt_7d
      ,friend_cnt_7d
      ,follow_cnt_7d
      ,follow_amount_7d
      ,tot_cnt_15d
      ,wflx_cnt_15d
      ,sfgt_cnt_15d
      ,gjkh_cnt_15d
      ,ptp_cnt_15d
      ,zjkn_cnt_15d
      ,self_cnt_15d
      ,family_cnt_15d
      ,friend_cnt_15d
      ,follow_cnt_15d
      ,follow_amount_15d
      ,tot_cnt_30d
      ,wflx_cnt_30d
      ,sfgt_cnt_30d
      ,gjkh_cnt_30d
      ,ptp_cnt_30d
      ,zjkn_cnt_30d
      ,self_cnt_30d
      ,family_cnt_30d
      ,friend_cnt_30d
      ,follow_cnt_30d
      ,follow_amount_30d
      ,tot_cnt_60d
      ,wflx_cnt_60d
      ,sfgt_cnt_60d
      ,gjkh_cnt_60d
      ,ptp_cnt_60d
      ,zjkn_cnt_60d
      ,self_cnt_60d
      ,family_cnt_60d
      ,friend_cnt_60d
      ,follow_cnt_60d
      ,follow_amount_60d
      ,tot_cnt_90d
      ,wflx_cnt_90d
      ,sfgt_cnt_90d
      ,gjkh_cnt_90d
      ,ptp_cnt_90d
      ,zjkn_cnt_90d
      ,self_cnt_90d
      ,family_cnt_90d
      ,friend_cnt_90d
      ,follow_cnt_90d
      ,follow_amount_90d
      ,wflx_cnt_ratio_7d
      ,sfgt_cnt_ratio_7d
      ,gjkh_cnt_ratio_7d
      ,ptp_cnt_ratio_7d
      ,zjkn_cnt_ratio_7d
      ,self_cnt_ratio_7d
      ,family_cnt_ratio_7d
      ,friend_cnt_ratio_7d
      ,follow_cnt_ratio_7d
      ,wflx_cnt_ratio_15d
      ,sfgt_cnt_ratio_15d
      ,gjkh_cnt_ratio_15d
      ,ptp_cnt_ratio_15d
      ,zjkn_cnt_ratio_15d
      ,self_cnt_ratio_15d
      ,family_cnt_ratio_15d
      ,friend_cnt_ratio_15d
      ,follow_cnt_ratio_15d
      ,wflx_cnt_ratio_30d
      ,sfgt_cnt_ratio_30d
      ,gjkh_cnt_ratio_30d
      ,ptp_cnt_ratio_30d
      ,zjkn_cnt_ratio_30d
      ,self_cnt_ratio_30d
      ,family_cnt_ratio_30d
      ,friend_cnt_ratio_30d
      ,follow_cnt_ratio_30d
      ,wflx_cnt_ratio_60d
      ,sfgt_cnt_ratio_60d
      ,gjkh_cnt_ratio_60d
      ,ptp_cnt_ratio_60d
      ,zjkn_cnt_ratio_60d
      ,self_cnt_ratio_60d
      ,family_cnt_ratio_60d
      ,friend_cnt_ratio_60d
      ,follow_cnt_ratio_60d
      ,wflx_cnt_ratio_90d
      ,sfgt_cnt_ratio_90d
      ,gjkh_cnt_ratio_90d
      ,ptp_cnt_ratio_90d
      ,zjkn_cnt_ratio_90d
      ,self_cnt_ratio_90d
      ,family_cnt_ratio_90d
      ,friend_cnt_ratio_90d
      ,follow_cnt_ratio_90d
from ${pdm_risk}.dh_model_final_13collection_notes_tmp
;
-- feature-copilot:node-end ordinal=0
