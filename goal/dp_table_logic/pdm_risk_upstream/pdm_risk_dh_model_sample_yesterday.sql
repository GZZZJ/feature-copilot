-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dh_model_sample_yesterday
-- node_id: n_5758020451973070848
-- task_name: dh_sample
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dh_model_sample_yesterday.json
-- source_json_sha256: 3df223e6ba4f13d6c891c8ea5eb4242f2d26d356ed86025692804ce39d6535fe
-- upstream_table: dwt.dwt_heavy_order_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 牛莲泽
--创建日期: 2024-04-23 14:06:56
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
insert overwrite table ${pdm_risk}.pdm_risk_dh_model_sample_yesterday partition(ds='${bizdate}')
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from dwt.dwt_heavy_order_df
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;
-- feature-copilot:node-end ordinal=0

-- feature-copilot:node-begin ordinal=1
-- table_name: pdm_risk_dh_model_sample_yesterday
-- node_id: n_4534445429673099264
-- task_name: pdm_risk_dh_model_sample_yesterday
-- owner_name: 海宜真
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dh_model_sample_yesterday.json
-- source_json_sha256: 3df223e6ba4f13d6c891c8ea5eb4242f2d26d356ed86025692804ce39d6535fe
-- upstream_table: dwt.dwt_heavy_order_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 章少平
--创建日期: 2023-03-08 09:59:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

create table if not exists ${pdm_risk}.pdm_risk_dh_model_sample_yesterday (
    uid string,
    mdl_dte date comment '模型日期'
) comment '在贷客户样本表' partitioned by (ds string)
;

insert overwrite table ${pdm_risk}.pdm_risk_dh_model_sample_yesterday partition(ds='${bizdate}')
select  uid
		,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from dwt.dwt_heavy_order_df 
where ds = '${bizdate}'
	and loan_success_flag = 1
group by uid 
;
-- feature-copilot:node-end ordinal=1
