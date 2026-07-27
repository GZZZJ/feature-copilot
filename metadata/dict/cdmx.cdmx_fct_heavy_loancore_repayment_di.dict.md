# cdmx_fct_heavy_loancore_repayment_di - 重资产还款流水记录

## 表信息
| 属性 | 值 |
|------|-----|
| 层级 | DWD |
| 项目 | cdmx |
| 表类型 | 外部表ORC |
| 分区 | ds (从create_time格式化) |
| 生命周期 | 3600天 |

## 数据粒度
一行 = 一笔还款调整流水(repay_serial_no=adjust_id)，按ds日分区

## 核心字段
- repay_serial_no: 还款流水号 (LoanCore adjust_id)
- uid, order_no, stage_plan_no, stage, fund_code, asset_plan_id
- due_date: 到期日 (来自cls_term_df)
- repay_channel: 还款渠道
- repay_time: 还款时间 (crt_time)
- repay_amount: 还款金额 = 各费用项求和 (可能为负)
- 费用拆分: repay_principal, repay_interest, repay_guarantee_fee, repay_late_fee, repay_interest_fee(罚息), repay_compound_interest, repay_over_payment, advance_repay_fee, repay_amc_fee
- repay_type: REPAY/REPAY_REVERSE/REFUND/ADJUST
- repay_mode: 还款途径 (AUTO_DEDUCT/MANUAL_REPAY/MANUAL_DEDUCT/AO_OFFLINE/OUTER_OFFLINE)
- biz_type, biz_type_code: 业务类型
- repay_card_no_sha256: 还款卡号加密

## 加工逻辑
来源: LoanCore cls_term_log_df (adjust_type分类union all) + 订单补全 + 期供补全 + 扣款账单关联
金额: 分→元(/100), REPAY/REPAY_REVERSE用后值-前值增量, REFUND/ADJUST用调整字段
特殊: ds=to_char(create_time,'yyyymmdd')