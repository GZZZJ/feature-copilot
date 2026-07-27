# ods_pdw_loan_dsrepayali_repayengine_repay_apply_df - 还款申请交易明细表

## 表信息
| 属性 | 值 |
|------|-----|
| 层级 | ODS |
| 项目 | ods_pdw_loan |
| 表类型 | PHYSICAL_VIEW (外部表ORC) |
| 分区 | ds |

## 数据粒度
一行 = 一笔还款申请记录

## 核心字段
- uid: 用户标识
- repay_apply_no: 申请编号(唯一)
- biz_serial: 业务流水号(外部传入,唯一)
- repay_type: 还款类型(订单维度)
- repay_amount/repay_success_amount/repay_failure_amount: 金额三元组(单位待确认)
- repay_status: 处理状态
- status_desc: 状态描述(失败原因)
- repay_way: 还款途径
- asset_type: 资产类型(从ext_field JSON解析)
- batch_flag: 批扣标签(从ext_field JSON解析)
- bill_repay_submit_type: 账单还款提交类型(从ext_field JSON解析)

## 加工逻辑
- ODS贴源投影 + ext_field JSON解析补充 asset_type/batch_flag/bill_repay_submit_type
- 来源: ods_loan.ods_loan_dsrepayali_repayengine_repay_apply_df
