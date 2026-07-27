# ods_pdw_loan_dsrepayali_repayengine_repay_apply_stage_plan_item_di - 还款交易分期表

## 表信息
| 属性 | 值 |
|------|-----|
| 所属层级 | ODS |
| 项目 | ods_pdw_loan |
| 表类型 | 外部表 (ORC) |
| 分区字段 | ds |

## 数据粒度
一行 = 一笔还款申请中的一个分期计划明细项

## 核心字段
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| repay_apply_no | string | 还款申请编号 |
| stage_plan_no | string | 分期编号 |
| stage_no | int | 分期号 |
| stage_order_no | string | 订单号 |
| amount | int | 金额(单位待确认) |
| uid | string | 用户编号 |
| create_at | timestamp | 创建时间 |
| create_by | string | 创建人 |
| update_at | timestamp | 更新时间 |
| update_by | string | 更新人 |
| updated_at | timestamp | 更新时间(另一字段) |
| ds | string | 分区字段 |

## 加工逻辑
- 纯ODS贴源映射，所有字段直接透传
- 来源表：ods_loan.ods_loan_dsrepayali_repayengine_repay_apply_stage_plan_item_di
