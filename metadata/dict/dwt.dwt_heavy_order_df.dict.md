# dwt_heavy_order_df - 重资产订单粒度宽表

## 表信息
| 属性 | 值 |
|------|-----|
| 数据域 | 经营域 |
| 层级 | DWT |
| 项目 | dwt |
| 表类型 | PHYSICAL_VIEW (逻辑视图) |
| 创建者 | 王廷棒 |

## 数据粒度
一行 = 一个业务日期(ds)下的一笔订单(order_no)的订单全生命周期宽表快照

## 核心字段 (96列)
- 订单标识: order_no, uid, business_type, product_code, account_no
- 申请放款: apply_amount, apply_time, loan_principal_amount, loan_date, loan_success_flag
- 订单状态: order_status, settle_up_date, order_due_date, is_prerepayment
- 利率收益: order_interest_rate_actual, customer_interest_rate, risk_pricing, year_income
- 还款逾期: unpaid_principal, unpaid_total_amount, current_overdue_days/status, history_max_overdue_status
- 首复借: is_first_loan_by_success_order, first_reloan_flag_ot, first_reloan_flag_level2_ot
- 优惠权益: coupon_id, coupon_type, is_used_equity, equity_value
- 风控额度: pre/post_risk_admit_limit_by_trade, pre/post_risk_available_limit_by_trade

## 加工逻辑
基础宽表 dwt_heavy_order_info_df_basic LEFT JOIN 还款宽表 dwt_heavy_order_info_df_repay ON order_no + ds

## 枚举值
- business_type: CASH/BALANCE_TRANSFER/FUN_PAY/HUGE_LOAN
- order_status: N-正常/O-已逾期/T-已终止/S-已结清/E-资金已出让/A-退货结清/R-撤单退汇
- coupon_type: INTEREST/INTEREST_FREE/CASH/INTEREST_OFF/FIXED_FEE_RATE_COUPON