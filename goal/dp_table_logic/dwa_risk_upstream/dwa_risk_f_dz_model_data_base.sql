-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_dz_model_data_base
-- node_id: n_3766275101255270400
-- task_name: dwa_risk_f_dz_model_data_base
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_upstream/dwa_risk_f_dz_model_data_base.json
-- source_json_sha256: 56b5ca0dbcc7b7a52f274dccbaf6c28472c50fb21be139f6ecd07efb1b49acad
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dmining_f_dz_model_data_base
--创建者: 颜弘彪
--创建日期: 2022-06-21 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_f_dz_model_data_base(
uid string COMMENT '用户ID',
mdl_dte date COMMENT '模型日期'
)
COMMENT '风险重资产订单前置表';


insert overwrite table ${dwa_risk}.dwa_risk_f_dz_model_data_base
select uid
        ,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic
where ord_stt_flg = 'success'
group by uid;
-- feature-copilot:node-end ordinal=0
