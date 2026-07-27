-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_order_info_basic
-- node_id: n_3766257371630010368
-- task_name: dwa_risk_f_heavy_order_info_basic
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_upstream/dwa_risk_f_heavy_order_info_basic.json
-- source_json_sha256: 63a71a61a48ce33114052f2000168a497001f7ec2034a977e865eb1ecc3590f8
-- upstream_table: dwt.dwt_heavy_order_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_temp_order_all
--创建者: 颜弘彪
--创建日期: 2022-06-21 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

CREATE TABLE if not exists ${dwa_risk}.dwa_risk_f_heavy_order_info_basic(
uid string COMMENT '用户ID',
ord_no string COMMENT '订单号',
bsy_typ string COMMENT '业务类型',
ord_stt string COMMENT '订单状态',
ord_stt_flg string COMMENT '订单状态标示：success-成功、fail-失败、else-其他',
prc_amt decimal(18,6) COMMENT '借款本金',
stg_num int COMMENT '分期数',
crt_tim timestamp COMMENT '创建时间',
fst_its_dte date COMMENT '起息日')
COMMENT '风险重资产订单前置表';



INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_heavy_order_info_basic
select  uid
        ,order_no
        ,business_type bsy_typ 
        ,coalesce(order_status,apply_status) ord_stt
        ,case when loan_success_flag = 1 then 'success'
              when apply_status in ('LEND_FAIL', 'LOAN_DENIED')  then 'fail'
              when order_status ='R'  then 'fail'
         else 'else' 
         end ord_stt_flg
        ,coalesce(loan_principal_amount,apply_amount) as prc_amt 
        ,coalesce(init_total_stage,apply_total_stage) stg_num
        ,apply_record_crt_time crt_tim
        ,coalesce(loan_date,date(apply_record_crt_time)) as loan_date 
from dwt.dwt_heavy_order_df
where ds = '${bizdate}'
-- feature-copilot:node-end ordinal=0
