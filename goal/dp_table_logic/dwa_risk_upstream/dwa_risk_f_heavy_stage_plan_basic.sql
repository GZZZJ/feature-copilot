-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_f_heavy_stage_plan_basic
-- node_id: n_3766261185560969216
-- task_name: dwa_risk_f_heavy_stage_plan_basic
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_upstream/dwa_risk_f_heavy_stage_plan_basic.json
-- source_json_sha256: 747dfed55a54ec1b3d4279a261c86b0d69cdfa255a1f6877404308d1c74bc46d
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwt.dwt_heavy_order_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_temp_stage_plan_all
--创建者: 颜弘彪
--创建日期: 2022-06-21 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

CREATE TABLE if not exists ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic(
uid string COMMENT '用户ID',
ord_no string COMMENT '订单号',
stg_pln_no string COMMENT '分期计划号码',
bsy_typ string COMMENT '业务类型：余额代偿-BALANCE_TRANSFER，白条-CREDIT_TRANSACTION',
stg_stt string COMMENT '分期计划状态:U-未到期、O-已逾期、C-已代偿、S-已还款、X-未到期还款、A-退货结清、R-已退汇、E-已售',
stg_typ int COMMENT '分期类型（3，6，12）',
stg_no int COMMENT '期数',
prc_amt decimal(18,6) COMMENT '实际应收本金',
rep_dte date COMMENT '到期日',
rep_tim timestamp COMMENT '还款时间',
ovd_stt string COMMENT '逾期状态',
ded_typ string COMMENT '扣款类型',
ctr_tim timestamp COMMENT '分期计划的创建时间'
)
COMMENT '风险重资产分期计划前置表';



INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
select  a.uid
        ,a.order_no
        ,a.stage_plan_no stg_pln_no
        ,a.original_biz_type bsy_typ
        ,a.original_stage_plan_status stg_stt --放款成功取<>'R'
        ,coalesce(b.init_total_stage,b.apply_total_stage) as stg_typ
        ,a.stage_no
        ,a.schedule_pay_principal prc_amt
        ,a.due_date rep_dte
        ,a.settlement_time rep_tim 
        ,a.current_overdue_status ovd_stt
        ,a.original_repay_type ded_typ
        ,a.create_time as crt_time
from cdmx.cdmx_fct_heavy_stage_plan_df a
left join 
dwt.dwt_heavy_order_df b
on a.order_no = b.order_no and b.ds='${bizdate}'
where a.ds = '${bizdate}'
-- feature-copilot:node-end ordinal=0
