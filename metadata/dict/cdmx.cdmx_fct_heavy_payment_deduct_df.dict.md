# cdmx_fct_heavy_payment_deduct_df - 重资产数禾支付扣款明细表

## 表信息
| 属性 | 值 |
|------|-----|
| 数据域 | 交易域 |
| 层级 | DWT |
| 项目 | cdmx |
| 创建者 | 郭卫勇 |
| 表类型 | 内部表ALIORC |
| 分区 | ds |
| 生命周期 | 3天 |

## 数据粒度
一行 = 一笔扣款交易流水 (trans_serial)

## 核心字段
- trans_serial: 交易流水主键
- deduct_bill_no: 还款单号
- uid: 用户标识
- deduct_card_no_sha256: 扣款卡号加密
- deduct_bank: 扣款银行
- amount: 扣款金额(元, 上游分→元/100)
- third_pay_fee: 第三方支付费用(元)
- refund_amount: 退货金额(元)
- trans_result: 交易结果 (SUCCESS/FAILED/UNKNOWN)
- initiative_flag: 主动还款标识 (1-主动/0-被动)
- third_party_channel: 第三方支付渠道
- repay_mode: 还款途径
- fund_code: 资方代码
- merch_id, third_party_serial: 商户/第三方流水号

## 加工逻辑
主来源: 支付交易日志 (trans_type=USER_PAY, third_party_channel!=HFPAY)
+ BOSC银行网关历史数据 (sub_trans_type=BANK_DEDUCT)
+ 主动还款识别: repay_way=MANUAL_REPAY → initiative_flag=1
退款: 按merch_serial聚合refund_amount关联