-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dh_model_15ai_call_record
-- node_id: n_4324586833600184320
-- task_name: pdm_risk_dh_model_15ai_call_record_recall
-- owner_name: 曹薇1926
-- source_json: goal/dp_table_logic/pdm_risk_dh_model_15ai_call_record.json
-- source_json_sha256: d018ae4b6ac880aa5d31264d86f5d4aee15e3595c2f4704bc3f20d02331db584
-- upstream_table: pdm_risk.pdm_risk_dh_model_15ai_call_record_yesterday
-- upstream_table: pdm_risk.pdm_risk_dh_model_15ai_call_record_sample_yesterday
-- upstream_table: dwt.dwt_collection_call_record_detail_di
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: pdm_risk.pdm_risk_dh_model_15ai_call_record_tmp1

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 曹薇1926
--创建日期: 2022-12-27 17:36:01
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


----------------------------------
-- 01 创建表结构	
----------------------------------
CREATE TABLE if not exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record
(
	uid STRING ,
	mdl_dte DATE COMMENT '模型日期',
	ai_call_cnt BIGINT COMMENT '拨打次数',
	ai_answer_cnt BIGINT COMMENT '接通次数',
	ai_close_cnt BIGINT COMMENT '关机、空号、停机、无法接通、暂停服务、无法接通 次数',
	ai_busy_cnt BIGINT COMMENT '正在通话中、用户正忙 次数',
	ai_refuse_cnt BIGINT COMMENT '用户拒接 呼入限制 来电提醒 呼叫转移失败 次数',
	ai_tousu1_cnt BIGINT COMMENT '黑名单、投诉抱怨 次数',
	ai_wfjt_cnt BIGINT COMMENT '无法接通 次数',
	ai_wcnhk_cnt BIGINT COMMENT '未承诺还款 次数',
	ai_ptp_cnt BIGINT  COMMENT '承诺还款promise to pay 次数',
	ai_rtp_cnt BIGINT COMMENT '拒绝还款refuse to pay 次数',
	ai_alpa_cnt BIGINT,
	ai_tousu2_cnt BIGINT,
	ai_call_cnt_3d BIGINT,
	ai_answer_cnt_3d BIGINT,
	ai_close_cnt_3d BIGINT,
	ai_busy_cnt_3d BIGINT,
	ai_refuse_cnt_3d BIGINT,
	ai_tousu1_cnt_3d BIGINT,
	ai_wfjt_cnt_3d BIGINT,
	ai_wcnhk_cnt_3d BIGINT,
	ai_ptp_cnt_3d BIGINT,
	ai_rtp_cnt_3d BIGINT,
	ai_alpa_cnt_3d BIGINT,
	ai_tousu2_cnt_3d BIGINT,
	ai_call_cnt_7d BIGINT,
	ai_answer_cnt_7d BIGINT,
	ai_close_cnt_7d BIGINT,
	ai_busy_cnt_7d BIGINT,
	ai_refuse_cnt_7d BIGINT,
	ai_tousu1_cnt_7d BIGINT,
	ai_wfjt_cnt_7d BIGINT,
	ai_wcnhk_cnt_7d BIGINT,
	ai_ptp_cnt_7d BIGINT,
	ai_rtp_cnt_7d BIGINT,
	ai_alpa_cnt_7d BIGINT,
	ai_tousu2_cnt_7d BIGINT,
	ai_call_cnt_10d BIGINT,
	ai_answer_cnt_10d BIGINT,
	ai_close_cnt_10d BIGINT,
	ai_busy_cnt_10d BIGINT,
	ai_refuse_cnt_10d BIGINT,
	ai_tousu1_cnt_10d BIGINT,
	ai_wfjt_cnt_10d BIGINT,
	ai_wcnhk_cnt_10d BIGINT,
	ai_ptp_cnt_10d BIGINT,
	ai_rtp_cnt_10d BIGINT,
	ai_alpa_cnt_10d BIGINT,
	ai_tousu2_cnt_10d BIGINT,
	ai_call_cnt_15d BIGINT,
	ai_answer_cnt_15d BIGINT,
	ai_close_cnt_15d BIGINT,
	ai_busy_cnt_15d BIGINT,
	ai_refuse_cnt_15d BIGINT,
	ai_tousu1_cnt_15d BIGINT,
	ai_wfjt_cnt_15d BIGINT,
	ai_wcnhk_cnt_15d BIGINT,
	ai_ptp_cnt_15d BIGINT,
	ai_rtp_cnt_15d BIGINT,
	ai_alpa_cnt_15d BIGINT,
	ai_tousu2_cnt_15d BIGINT,
	ai_call_cnt_21d BIGINT,
	ai_answer_cnt_21d BIGINT,
	ai_close_cnt_21d BIGINT,
	ai_busy_cnt_21d BIGINT,
	ai_refuse_cnt_21d BIGINT,
	ai_tousu1_cnt_21d BIGINT,
	ai_wfjt_cnt_21d BIGINT,
	ai_wcnhk_cnt_21d BIGINT,
	ai_ptp_cnt_21d BIGINT,
	ai_rtp_cnt_21d BIGINT,
	ai_alpa_cnt_21d BIGINT,
	ai_tousu2_cnt_21d BIGINT,
	ai_call_cnt_30d BIGINT,
	ai_answer_cnt_30d BIGINT,
	ai_close_cnt_30d BIGINT,
	ai_busy_cnt_30d BIGINT,
	ai_refuse_cnt_30d BIGINT,
	ai_tousu1_cnt_30d BIGINT,
	ai_wfjt_cnt_30d BIGINT,
	ai_wcnhk_cnt_30d BIGINT,
	ai_ptp_cnt_30d BIGINT,
	ai_rtp_cnt_30d BIGINT,
	ai_alpa_cnt_30d BIGINT,
	ai_tousu2_cnt_30d BIGINT,
	ai_call_cnt_60d BIGINT,
	ai_answer_cnt_60d BIGINT,
	ai_close_cnt_60d BIGINT,
	ai_busy_cnt_60d BIGINT,
	ai_refuse_cnt_60d BIGINT,
	ai_tousu1_cnt_60d BIGINT,
	ai_wfjt_cnt_60d BIGINT,
	ai_wcnhk_cnt_60d BIGINT,
	ai_ptp_cnt_60d BIGINT,
	ai_rtp_cnt_60d BIGINT,
	ai_alpa_cnt_60d BIGINT,
	ai_tousu2_cnt_60d BIGINT,
	ai_call_cnt_90d BIGINT,
	ai_answer_cnt_90d BIGINT,
	ai_close_cnt_90d BIGINT,
	ai_busy_cnt_90d BIGINT,
	ai_refuse_cnt_90d BIGINT,
	ai_tousu1_cnt_90d BIGINT,
	ai_wfjt_cnt_90d BIGINT,
	ai_wcnhk_cnt_90d BIGINT,
	ai_ptp_cnt_90d BIGINT,
	ai_rtp_cnt_90d BIGINT,
	ai_alpa_cnt_90d BIGINT,
	ai_tousu2_cnt_90d BIGINT
) comment "贷后大宽表-15ai/ivr拨打记录" 
partitioned by (ds string comment '分区字段,格式yyyymmdd')
;





----------------------------------
-- 样本表
-- 逻辑来自${dwa_risk}.dwa_risk_f_dz_model_data_base，但是原表只能取昨天的数据，这里拿出来后可以方便修改ds, 回溯数据只需要把'${bizdate}'改为想要回溯的ds即可
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_sample_yesterday;
create table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_sample_yesterday as 
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from ${dwt}.dwt_heavy_order_df 
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;
-- 600w+, 但是到了最后统计ai拨打，每天也就60w uid

----------------------------------
-- ai 拨打长表

-- ads_risk.ads_risk_collection_ares_operator_call_record_deatil_di -- 增量表
-- call_mode = 1  -- 呼叫模式: 0-人工、1-AI
-- ringing_result_code -- 接听状态    0代表已接通，1振铃未接，2关机，3空号，4停机，5正在通话中，6用户拒接，7无法接通，8暂停服务，9用户正忙，10拨打方式不正确，11呼入限制，12来电提醒，13呼叫转移失败，14网络忙，15无人接听，16欠费，17无法接听，18改号，19线路故障，20稍后再拨，21忙音，22彩铃，23未识别的提示音，24静音，25未知的原因 ，26回铃音
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_tmp1;

create table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_tmp1 as
select ss.mdl_dte,
	datediff(ss.mdl_dte, t1.call_date) as observe_days, -- 观察天数
	 t1.*
from(select uid, mdl_dte
	from ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_sample_yesterday
	) ss 
left join(
	select call_id, 
			uid, 
			cust_no, 
			call_date, 
			is_work_day, 
			called_phone_social_relations, 
			call_mode, 
			ring_result, 
			create_time, 
			call_time, 
			answer_time, 
			end_time, 
			ring_duration, 
			talk_duration, 
			call_type_class, 
			call_type, 
			followup_phone_code, 
			followup_phone_code_name, 
			batch_time, 
			source_system, 
			ds 
	-- from ads_risk.ads_risk_collection_ares_operator_call_record_deatil_di  -- pdm不能依赖ads
	from dwt.dwt_collection_call_record_detail_di
	where ds between to_char(date_add(to_date('${bizdate}','yyyymmdd'),-90),'yyyymmdd') and '${bizdate}'  -- 90天缓存 
	    and uid is not null
	    and call_time is not null 
	    and call_mode = 1  -- 呼叫模式: 0-人工、1-AI
	) t1 
on ss.uid = t1.uid
where ss.mdl_dte >= t1.call_date 
;

----------------------------------
-- ai 拨打宽表
----------------------------------
-- ringing_result_code -- 接听状态    0代表已接通，1振铃未接，2关机，3空号，4停机，5正在通话中，6用户拒接，7无法接通，
-- 8暂停服务，9用户正忙，10拨打方式不正确，11呼入限制，12来电提醒，13呼叫转移失败，14网络忙，15无人接听，16欠费，17无法接听，
-- 18改号，19线路故障，20稍后再拨，21忙音，22彩铃，23未识别的提示音，24静音，25未知的原因 ，26回铃音
-- followup_phone_code	_c1
-- WFJT	6575586  无法接通
-- WCNHK	1270307 未承诺还款
-- PTP	346460 承诺还款
-- RTP	52404 拒绝还款
-- ALPA	62477 声称已还款
-- TS	995 投诉

drop table if exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_yesterday;

create table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_yesterday as 
select uid,
	mdl_dte,
	count(call_time) as ai_call_cnt,
	sum(case when talk_duration > 0 then 1 else 0 end) as ai_answer_cnt,
	sum(case when ring_result in ('3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt,
	sum(case when ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt,
	sum(case when ring_result in ('2','关机', '6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt,
	sum(case when ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt,

	sum(case when followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt,
	sum(case when followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt,
	sum(case when followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt,
	sum(case when followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt,
	sum(case when followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt,	
	sum(case when followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_tousu2_cnt,	

	sum(case when observe_days between 1 and 3 then 1 else 0 end) as ai_call_cnt_3d,
	sum(case when observe_days between 1 and 3 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_3d,

	sum(case when observe_days between 1 and 3 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_3d,	
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_3d,


	sum(case when observe_days between 1 and 7 then 1 else 0 end) as ai_call_cnt_7d,
	sum(case when observe_days between 1 and 7 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_7d,

	sum(case when observe_days between 1 and 7 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_7d,	
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_7d,


	sum(case when observe_days between 1 and 10 then 1 else 0 end) as ai_call_cnt_10d,
	sum(case when observe_days between 1 and 10 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_10d,

	sum(case when observe_days between 1 and 10 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_10d,	
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_10d,


	sum(case when observe_days between 1 and 15 then 1 else 0 end) as ai_call_cnt_15d,
	sum(case when observe_days between 1 and 15 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_15d,

	sum(case when observe_days between 1 and 15 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_15d,	
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_15d,


	sum(case when observe_days between 1 and 21 then 1 else 0 end) as ai_call_cnt_21d,
	sum(case when observe_days between 1 and 21 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_21d,

	sum(case when observe_days between 1 and 21 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_21d,	
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_21d,


	sum(case when observe_days between 1 and 30 then 1 else 0 end) as ai_call_cnt_30d,
	sum(case when observe_days between 1 and 30 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_30d,

	sum(case when observe_days between 1 and 30 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_30d,	
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_30d,


	sum(case when observe_days between 1 and 60 then 1 else 0 end) as ai_call_cnt_60d,
	sum(case when observe_days between 1 and 60 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_60d,

	sum(case when observe_days between 1 and 60 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_60d,	
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_60d,


	sum(case when observe_days between 1 and 90 then 1 else 0 end) as ai_call_cnt_90d,
	sum(case when observe_days between 1 and 90 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_90d,

	sum(case when observe_days between 1 and 90 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_90d,	
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_90d

from ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_tmp1
group by uid, mdl_dte
;


----------------------------------
-- 03 插入分区表
----------------------------------

insert overwrite table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record partition(ds='${bizdate}') 
select * from ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_yesterday
;
-- feature-copilot:node-end ordinal=0

-- feature-copilot:node-begin ordinal=1
-- table_name: pdm_risk_dh_model_15ai_call_record
-- node_id: n_4309883030241542144
-- task_name: pdm_risk_dh_model_15ai_call_record
-- owner_name: 曹薇1926
-- source_json: goal/dp_table_logic/pdm_risk_dh_model_15ai_call_record.json
-- source_json_sha256: d018ae4b6ac880aa5d31264d86f5d4aee15e3595c2f4704bc3f20d02331db584
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: pdm_risk.pdm_risk_dh_model_15ai_call_record_yesterday
-- upstream_table: pdm_risk.pdm_risk_dh_model_15ai_call_record_sample_yesterday
-- upstream_table: dwt.dwt_collection_call_record_detail_di
-- upstream_table: pdm_risk.pdm_risk_dh_model_15ai_call_record_tmp1

----------------------------------
-- 01 创建表结构	
----------------------------------
CREATE TABLE if not exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record
(
	uid STRING ,
	mdl_dte DATE COMMENT '模型日期',
	ai_call_cnt BIGINT COMMENT '拨打次数',
	ai_answer_cnt BIGINT COMMENT '接通次数',
	ai_close_cnt BIGINT COMMENT '关机、空号、停机、无法接通、暂停服务、无法接通 次数',
	ai_busy_cnt BIGINT COMMENT '正在通话中、用户正忙 次数',
	ai_refuse_cnt BIGINT COMMENT '用户拒接 呼入限制 来电提醒 呼叫转移失败 次数',
	ai_tousu1_cnt BIGINT COMMENT '黑名单、投诉抱怨 次数',
	ai_wfjt_cnt BIGINT COMMENT '无法接通 次数',
	ai_wcnhk_cnt BIGINT COMMENT '未承诺还款 次数',
	ai_ptp_cnt BIGINT  COMMENT '承诺还款promise to pay 次数',
	ai_rtp_cnt BIGINT COMMENT '拒绝还款refuse to pay 次数',
	ai_alpa_cnt BIGINT,
	ai_tousu2_cnt BIGINT,
	ai_call_cnt_3d BIGINT,
	ai_answer_cnt_3d BIGINT,
	ai_close_cnt_3d BIGINT,
	ai_busy_cnt_3d BIGINT,
	ai_refuse_cnt_3d BIGINT,
	ai_tousu1_cnt_3d BIGINT,
	ai_wfjt_cnt_3d BIGINT,
	ai_wcnhk_cnt_3d BIGINT,
	ai_ptp_cnt_3d BIGINT,
	ai_rtp_cnt_3d BIGINT,
	ai_alpa_cnt_3d BIGINT,
	ai_tousu2_cnt_3d BIGINT,
	ai_call_cnt_7d BIGINT,
	ai_answer_cnt_7d BIGINT,
	ai_close_cnt_7d BIGINT,
	ai_busy_cnt_7d BIGINT,
	ai_refuse_cnt_7d BIGINT,
	ai_tousu1_cnt_7d BIGINT,
	ai_wfjt_cnt_7d BIGINT,
	ai_wcnhk_cnt_7d BIGINT,
	ai_ptp_cnt_7d BIGINT,
	ai_rtp_cnt_7d BIGINT,
	ai_alpa_cnt_7d BIGINT,
	ai_tousu2_cnt_7d BIGINT,
	ai_call_cnt_10d BIGINT,
	ai_answer_cnt_10d BIGINT,
	ai_close_cnt_10d BIGINT,
	ai_busy_cnt_10d BIGINT,
	ai_refuse_cnt_10d BIGINT,
	ai_tousu1_cnt_10d BIGINT,
	ai_wfjt_cnt_10d BIGINT,
	ai_wcnhk_cnt_10d BIGINT,
	ai_ptp_cnt_10d BIGINT,
	ai_rtp_cnt_10d BIGINT,
	ai_alpa_cnt_10d BIGINT,
	ai_tousu2_cnt_10d BIGINT,
	ai_call_cnt_15d BIGINT,
	ai_answer_cnt_15d BIGINT,
	ai_close_cnt_15d BIGINT,
	ai_busy_cnt_15d BIGINT,
	ai_refuse_cnt_15d BIGINT,
	ai_tousu1_cnt_15d BIGINT,
	ai_wfjt_cnt_15d BIGINT,
	ai_wcnhk_cnt_15d BIGINT,
	ai_ptp_cnt_15d BIGINT,
	ai_rtp_cnt_15d BIGINT,
	ai_alpa_cnt_15d BIGINT,
	ai_tousu2_cnt_15d BIGINT,
	ai_call_cnt_21d BIGINT,
	ai_answer_cnt_21d BIGINT,
	ai_close_cnt_21d BIGINT,
	ai_busy_cnt_21d BIGINT,
	ai_refuse_cnt_21d BIGINT,
	ai_tousu1_cnt_21d BIGINT,
	ai_wfjt_cnt_21d BIGINT,
	ai_wcnhk_cnt_21d BIGINT,
	ai_ptp_cnt_21d BIGINT,
	ai_rtp_cnt_21d BIGINT,
	ai_alpa_cnt_21d BIGINT,
	ai_tousu2_cnt_21d BIGINT,
	ai_call_cnt_30d BIGINT,
	ai_answer_cnt_30d BIGINT,
	ai_close_cnt_30d BIGINT,
	ai_busy_cnt_30d BIGINT,
	ai_refuse_cnt_30d BIGINT,
	ai_tousu1_cnt_30d BIGINT,
	ai_wfjt_cnt_30d BIGINT,
	ai_wcnhk_cnt_30d BIGINT,
	ai_ptp_cnt_30d BIGINT,
	ai_rtp_cnt_30d BIGINT,
	ai_alpa_cnt_30d BIGINT,
	ai_tousu2_cnt_30d BIGINT,
	ai_call_cnt_60d BIGINT,
	ai_answer_cnt_60d BIGINT,
	ai_close_cnt_60d BIGINT,
	ai_busy_cnt_60d BIGINT,
	ai_refuse_cnt_60d BIGINT,
	ai_tousu1_cnt_60d BIGINT,
	ai_wfjt_cnt_60d BIGINT,
	ai_wcnhk_cnt_60d BIGINT,
	ai_ptp_cnt_60d BIGINT,
	ai_rtp_cnt_60d BIGINT,
	ai_alpa_cnt_60d BIGINT,
	ai_tousu2_cnt_60d BIGINT,
	ai_call_cnt_90d BIGINT,
	ai_answer_cnt_90d BIGINT,
	ai_close_cnt_90d BIGINT,
	ai_busy_cnt_90d BIGINT,
	ai_refuse_cnt_90d BIGINT,
	ai_tousu1_cnt_90d BIGINT,
	ai_wfjt_cnt_90d BIGINT,
	ai_wcnhk_cnt_90d BIGINT,
	ai_ptp_cnt_90d BIGINT,
	ai_rtp_cnt_90d BIGINT,
	ai_alpa_cnt_90d BIGINT,
	ai_tousu2_cnt_90d BIGINT
) comment "贷后大宽表-15ai/ivr拨打记录" 
partitioned by (ds string comment '分区字段,格式yyyymmdd')
;





----------------------------------
-- 样本表
-- 逻辑来自${dwa_risk}.dwa_risk_f_dz_model_data_base，但是原表只能取昨天的数据，这里拿出来后可以方便修改ds, 回溯数据只需要把'${bizdate}'改为想要回溯的ds即可
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_sample_yesterday;
create table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_sample_yesterday as 
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from ${dwt}.dwt_heavy_order_df 
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;
-- 600w+, 但是到了最后统计ai拨打，每天也就60w uid

----------------------------------
-- ai 拨打长表

-- ads_risk.ads_risk_collection_ares_operator_call_record_deatil_di -- 增量表
-- call_mode = 1  -- 呼叫模式: 0-人工、1-AI
-- ringing_result_code -- 接听状态    0代表已接通，1振铃未接，2关机，3空号，4停机，5正在通话中，6用户拒接，7无法接通，8暂停服务，9用户正忙，10拨打方式不正确，11呼入限制，12来电提醒，13呼叫转移失败，14网络忙，15无人接听，16欠费，17无法接听，18改号，19线路故障，20稍后再拨，21忙音，22彩铃，23未识别的提示音，24静音，25未知的原因 ，26回铃音
----------------------------------
drop table if exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_tmp1;

create table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_tmp1 as
select ss.mdl_dte,
	datediff(ss.mdl_dte, t1.call_date) as observe_days, -- 观察天数
	 t1.*
from(select uid, mdl_dte
	from ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_sample_yesterday
	) ss 
left join(
	select call_id, 
			uid, 
			cust_no, 
			call_date, 
			is_work_day, 
			called_phone_social_relations, 
			call_mode, 
			ring_result, 
			create_time, 
			call_time, 
			answer_time, 
			end_time, 
			ring_duration, 
			talk_duration, 
			call_type_class, 
			call_type, 
			followup_phone_code, 
			followup_phone_code_name, 
			batch_time, 
			source_system, 
			ds 
	-- from ads_risk.ads_risk_collection_ares_operator_call_record_deatil_di  -- pdm不能依赖ads
	from dwt.dwt_collection_call_record_detail_di
	where ds between to_char(date_add(to_date('${bizdate}','yyyymmdd'),-90),'yyyymmdd') and '${bizdate}'  -- 90天缓存 
	    and uid is not null
	    and call_time is not null 
	    and call_mode = 1  -- 呼叫模式: 0-人工、1-AI
	) t1 
on ss.uid = t1.uid
where ss.mdl_dte >= t1.call_date 
;

----------------------------------
-- ai 拨打宽表
----------------------------------
-- ringing_result_code -- 接听状态    0代表已接通，1振铃未接，2关机，3空号，4停机，5正在通话中，6用户拒接，7无法接通，
-- 8暂停服务，9用户正忙，10拨打方式不正确，11呼入限制，12来电提醒，13呼叫转移失败，14网络忙，15无人接听，16欠费，17无法接听，
-- 18改号，19线路故障，20稍后再拨，21忙音，22彩铃，23未识别的提示音，24静音，25未知的原因 ，26回铃音
-- followup_phone_code	_c1
-- WFJT	6575586  无法接通
-- WCNHK	1270307 未承诺还款
-- PTP	346460 承诺还款
-- RTP	52404 拒绝还款
-- ALPA	62477 声称已还款
-- TS	995 投诉

drop table if exists ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_yesterday;

create table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_yesterday as 
select uid,
	mdl_dte,
	count(call_time) as ai_call_cnt,
	sum(case when talk_duration > 0 then 1 else 0 end) as ai_answer_cnt,
	sum(case when ring_result in ('3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt,
	sum(case when ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt,
	sum(case when ring_result in ('2','关机', '6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt,
	sum(case when ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt,

	sum(case when followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt,
	sum(case when followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt,
	sum(case when followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt,
	sum(case when followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt,
	sum(case when followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt,	
	sum(case when followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_tousu2_cnt,	

	sum(case when observe_days between 1 and 3 then 1 else 0 end) as ai_call_cnt_3d,
	sum(case when observe_days between 1 and 3 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_3d,
	sum(case when observe_days between 1 and 3 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_3d,

	sum(case when observe_days between 1 and 3 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_3d,
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_3d,	
	sum(case when observe_days between 1 and 3 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_3d,


	sum(case when observe_days between 1 and 7 then 1 else 0 end) as ai_call_cnt_7d,
	sum(case when observe_days between 1 and 7 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_7d,
	sum(case when observe_days between 1 and 7 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_7d,

	sum(case when observe_days between 1 and 7 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_7d,
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_7d,	
	sum(case when observe_days between 1 and 7 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_7d,


	sum(case when observe_days between 1 and 10 then 1 else 0 end) as ai_call_cnt_10d,
	sum(case when observe_days between 1 and 10 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_10d,
	sum(case when observe_days between 1 and 10 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_10d,

	sum(case when observe_days between 1 and 10 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_10d,
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_10d,	
	sum(case when observe_days between 1 and 10 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_10d,


	sum(case when observe_days between 1 and 15 then 1 else 0 end) as ai_call_cnt_15d,
	sum(case when observe_days between 1 and 15 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_15d,
	sum(case when observe_days between 1 and 15 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_15d,

	sum(case when observe_days between 1 and 15 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_15d,
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_15d,	
	sum(case when observe_days between 1 and 15 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_15d,


	sum(case when observe_days between 1 and 21 then 1 else 0 end) as ai_call_cnt_21d,
	sum(case when observe_days between 1 and 21 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_21d,
	sum(case when observe_days between 1 and 21 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_21d,

	sum(case when observe_days between 1 and 21 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_21d,
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_21d,	
	sum(case when observe_days between 1 and 21 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_21d,


	sum(case when observe_days between 1 and 30 then 1 else 0 end) as ai_call_cnt_30d,
	sum(case when observe_days between 1 and 30 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_30d,
	sum(case when observe_days between 1 and 30 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_30d,

	sum(case when observe_days between 1 and 30 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_30d,
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_30d,	
	sum(case when observe_days between 1 and 30 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_30d,


	sum(case when observe_days between 1 and 60 then 1 else 0 end) as ai_call_cnt_60d,
	sum(case when observe_days between 1 and 60 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_60d,
	sum(case when observe_days between 1 and 60 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_60d,

	sum(case when observe_days between 1 and 60 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_60d,
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_60d,	
	sum(case when observe_days between 1 and 60 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_60d,


	sum(case when observe_days between 1 and 90 then 1 else 0 end) as ai_call_cnt_90d,
	sum(case when observe_days between 1 and 90 and talk_duration > 0 then 1 else 0 end) as ai_answer_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('2','关机','3','空号','4','停机','7','无法接通','8','暂停服务','17','无法接通') then 1 else 0 end) as ai_close_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('5','正在通话中','9','用户正忙') then 1 else 0 end) as ai_busy_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('6','用户拒接','11','呼入限制','12','来电提醒','13','呼叫转移失败') then 1 else 0 end) as ai_refuse_cnt_90d,
	sum(case when observe_days between 1 and 90 and ring_result in ('黑名单','投诉抱怨') then 1 else 0 end) as ai_tousu1_cnt_90d,

	sum(case when observe_days between 1 and 90 and followup_phone_code = 'WFJT' then 1 else 0 end ) as ai_wfjt_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'WCNHK' then 1 else 0 end ) as ai_wcnhk_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'PTP' then 1 else 0 end ) as ai_ptp_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'RTP' then 1 else 0 end ) as ai_rtp_cnt_90d,
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'ALPA' then 1 else 0 end ) as ai_alpa_cnt_90d,	
	sum(case when observe_days between 1 and 90 and followup_phone_code = 'TS' then 1 else 0 end ) as ai_tousu2_cnt_90d

from ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_tmp1
group by uid, mdl_dte
;


----------------------------------
-- 03 插入分区表
----------------------------------

insert overwrite table ${pdm_risk}.pdm_risk_dh_model_15ai_call_record partition(ds='${bizdate}') 
select * from ${pdm_risk}.pdm_risk_dh_model_15ai_call_record_yesterday
;
-- feature-copilot:node-end ordinal=1
