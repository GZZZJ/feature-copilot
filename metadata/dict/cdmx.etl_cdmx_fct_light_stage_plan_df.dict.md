# etl_cdmx_fct_light_stage_plan_df - 轻资产分期计划记录

## 表信息
| 属性 | 值 |
|------|-----|
| 层级 | DWD |
| 项目 | cdmx |
| 创建者 | 王廷棒 |
| 表类型 | 外部表ORC |
| 分区 | ds |
| 生命周期 | 30天 |

## 数据粒度
一行 = 一笔分期计划(stage_plan_no)在某一天(ds)的最新状态快照(repay_plan优先于stage_plan)

## 核心字段
- stage_plan_no: 分期计划号
- order_no: 订单号
- uid: 用户编号
- fund_code: 资方代码
- stage_no: 期号
- stage_status: 分期状态(LENDING-在借/PAY_OFF-结清/OTHER)
- is_due: 是否到期(Y/N)
- due_date: 到期日
- settlement_time: 结清时间
- current_overdue_days: 当前逾期天数(+1口径)
- current_overdue_status: 当前逾期状态(M0~M7)
- history_max_overdue_days/status: 历史最大逾期
- schedule_pay_*: 应还金额系列(本金/利息/保费/手续费/罚息/违约金/减免)
- unpaid_*: 未还金额系列
- actual_pay_*: 实还金额系列
- data_source: repay_plan / stage_plan

## 逾期M0~M7映射
| 天数 | 状态 |
|------|------|
| <=0 | M0 |
| 1-30 | M1 |
| 31-60 | M2 |
| 61-90 | M3 |
| 91-120 | M4 |
| 121-150 | M5 |
| 151-180 | M6 |
| >180 | M7 |

## 加工逻辑
repay_plan(优先) + stage_plan(兜底) union all → row_number去重取flag=1
特殊规则: PPDAIFUND+结清订单 → unpaid_principal置0
