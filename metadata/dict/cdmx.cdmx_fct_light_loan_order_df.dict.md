# cdmx_fct_light_loan_order_df - 轻资产放款记录订单事实表

## 表信息
| 属性 | 值 |
|------|-----|
| 所属数据域 | 经营域 |
| 所属层级 | DWD |
| 项目 | cdmx |
| 创建者 | dataphin_su |
| 表类型 | 外部表 (ORC) |
| 分区字段 | ds, fund_code |
| 生命周期 | 800天 |

## 数据粒度
一行 = ds + fund_code + order_no 的轻资产放款订单记录

## 核心字段
| 字段 | 类型 | 说明 |
|------|------|------|
| order_no | string | 订单号 |
| uid | string | 用户编号 |
| fund_code | string | 资方代码 |
| fund_name | string | 资方名称 |
| biz_type | string | 业务类型(现金贷/余额代偿/中原导流/中原无缝) |
| loan_principal | decimal | 放款本金(元) |
| fund_loan_date | date | 资方放款日期 |
| annual_ir | decimal | 年化利率(百分制) |
| annual_ir_rate | decimal | 年化利率(小数) |
| cost_per_sales | decimal | CPS结算比例 |
| light_order_status | string | 轻资产订单状态 |
| light_fund_order_status | string | 轻资产资方订单状态 |
| is_loan_success_flag | string | 是否成功放款(成功/未成功) |
| loan_success_flag | string | 是否成功放款(1/0) |
| first_reloan_flag_by_uid | string | 用户全资方首复借 |
| first_reloan_flag_by_fund | string | 用户按资方首复借 |
| fund_first_reloan_flag | string | 资方侧首复借(0-首借,1-复借) |
| fund_first_credit_flag | string | 资方侧首次授信(0-新户,1-老户) |
| is_used_equity | string | 是否使用权益(1/0) |
| is_used_amc | string | 是否使用AMC(1/0) |
| loan_success_sort_asc | bigint | 成功放款顺序 |

## 核心加工逻辑
- 主来源：dwd.dwd_fct_b_lgt_loan_ord_df
- 关联资方维表 cdmx.cdmx_dim_fund_df 获取 fund_name
- 权益/AMC解析：优先万达侧，其次通用资方账户侧
- CPS计算：依赖资方名称、放款日期、首复借、年化利率、权益/AMC等多条件

## 枚举值
### biz_type
| 编码 | 名称 |
|-----|------|
| CASH | 现金贷 |
| BALANCE_TRANSFER | 余额代偿 |
| ZYCFC_DL | 中原导流 |
| ZYCFC_WF | 中原无缝 |

### light_order_status
| 编码 | 名称 |
|-----|------|
| PAY_OFF | 结清 |
| LENDING | 放款成功 |
| UNKNOWN | 放款中 |
| EXCEED | 逾期 |
| FAILED/LEND_FAIL | 放款失败 |
