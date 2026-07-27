## 一、表信息

| 属性 | 值 |
|------|-----|
| 表名称 | ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df |
| 中文名称 | 闪付交易订单表脱敏明细 |
| 所属层级 | ODS |
| 所属项目 | ods_pdw_loan |
| 创建者 | 待补充 |
| 创建时间 | 待补充 |
| 任务最后更新时间 | 待补充 |

---

## 二、表描述

### 2.1 业务定义
该表用于存储闪付交易订单的ODS层原始明细数据，来源于 `ods_loan.ods_loan_dstradeali_debitaccountengine_trans_journal_df`。  
从现有SQL可见，该表主要对来源表字段进行直接映射，并对敏感字段 `card_no` 进行了 SHA2-256 脱敏处理后输出为字段 `_c31`，用于保留卡号关联分析能力的同时降低敏感信息泄露风险。

从字段内容判断，该表记录了闪付交易全生命周期信息，包括：
- 交易基础标识
- 商户及订单信息
- 金额信息
- 交易状态与状态描述
- 支付渠道与支付机构信息
- 申请完成时间、对账日期等时点信息

该表属于支付/交易域的原始明细数据表，适用于对账、问题排查、交易链路分析及下游明细加工。

### 2.2 数据粒度
一行代表一笔闪付交易订单流水记录，粒度为**交易流水级明细**。  
通常可通过 `id`、`trans_no`、`fund_order_no`、`merch_serial` 等字段辅助识别唯一交易记录，其中 `fund_order_no` 备注为交易唯一标识、对账基础字段，是重要业务唯一键候选。

### 2.3 更新频率
推断为**每日分区增量更新**。  
依据：
- 表名后缀 `_df` 常见于日频明细表；
- 分区字段为 `ds`；
- ODS层通常按天同步原始业务数据。

### 2.4 核心应用场景
- 闪付交易订单原始明细留存
- 交易对账与异常排查
- 交易状态流转分析
- 商户/渠道交易统计明细支撑
- 下游DWD/DWS层支付交易主题建模
- 脱敏卡号关联分析

### 2.5 其他
- **表类型**：外部表（来源表DDL可见 `EXTERNAL`='TRUE'）
- **存储格式**：ORC
- **分区字段**：`ds`
- **存储地址**：`oss://lattebank-bigdata-dp-ods/dp_ods_loan.db/ods_loan_dstradeali_debitaccountengine_trans_journal_df/`
- **来源项目名称规范化**：原SQL中来源表为 `dp_ods_loan_prod.ods_loan_dstradeali_debitaccountengine_trans_journal_df`，按规则标准化后应记为 `ods_loan.ods_loan_dstradeali_debitaccountengine_trans_journal_df`
- **表注释**：闪付交易订单表
- **数据特点**：宽表型交易明细，包含订单、渠道、金额、状态、时间、商户等多类属性
- **脱敏处理**：`card_no` 未直接保留，改为 `sha2(card_no,256)` 输出

---

## 三、字段清单

### 3.1 基础审计与主键信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|
| 1 | id | 主键id | BIGINT | 来源表原样同步 | 记录主键标识 |
| 2 | created_at | 创建时间 | TIMESTAMP | 来源表原样同步 | 记录数据创建时间 |
| 3 | created_by | 创建人 | STRING | 来源表原样同步 | 记录创建人 |
| 4 | updated_at | 更新时间 | TIMESTAMP | 来源表原样同步 | 记录最后更新时间 |
| 5 | updated_by | 更新人 | STRING | 来源表原样同步 | 记录更新人 |
| 6 | edition | 版本号 | INT | 来源表原样同步 | 用于乐观锁控制 |
| 7 | uid | uid | STRING | 来源表原样同步 | 用户或业务主体标识，具体口径待补充 |
| 8 | ds | ds分区 | STRING | 来源表原样同步 | 分区字段，通常为数据日期 |

### 3.2 交易标识与订单流水信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|
| 1 | trans_no | 交易流水编号 | STRING | 来源表原样同步 | 取值规则参见百信对响应流水号要求 |
| 2 | merch_serial | 商户流水号 | STRING | 来源表原样同步 | 商户侧交易流水 |
| 3 | origin_merch_serial | 原始流水号 | STRING | 来源表原样同步 | 逆向流程时不可为空 |
| 4 | order_no | tradeorder订单号 | STRING | 来源表原样同步 | 业务订单标识 |
| 5 | fund_order_no | 资金订单号 | STRING | 来源表原样同步 | 交易唯一标识，对账基础字段 |
| 6 | voucher_no | 付款凭证号 | STRING | 来源表原样同步 | 支付凭证标识 |

### 3.3 交易金额与交易类型信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|
| 1 | amount | 交易金额（分） | INT | 来源表原样同步 | 单位分 |
| 2 | trade_amount | 交易金额（元） | DOUBLE | 来源表原样同步 | 单位元，保留两位小数 |
| 3 | refund_coupon_amount | 退款优惠金额 | INT | 来源表原样同步 | 单位分 |
| 4 | trans_type | 交易类型 | STRING | 来源表原样同步 | 表示交易、撤销、冲正、退款等类型 |

### 3.4 交易状态与过程时点信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|
| 1 | trans_status | 交易状态 | STRING | 来源表原样同步 | 当前交易处理状态 |
| 2 | pre_trans_status | 订单完成前状态 | STRING | 来源表原样同步 | 订单完成之前的状态 |
| 3 | status_desc | 状态描述 | STRING | 来源表原样同步 | 一般记录失败原因或状态说明 |
| 4 | trade_date | 交易日期 | STRING | 来源表原样同步 | 业务交易日期 |
| 5 | trade_time | 交易时间 | STRING | 来源表原样同步 | 业务交易时间 |
| 6 | check_date | 对账日期 | STRING | 来源表原样同步 | 对账使用日期 |
| 7 | flow_time | 统计耗时 | STRING | 来源表原样同步 | 百信消费至消费通知耗时，单位秒 |
| 8 | apply_finish_at | 申请交易完成时间 | TIMESTAMP | 来源表原样同步 | 交易申请完成时间点 |

### 3.5 商户、商品、渠道与机构信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|
| 1 | merchant_id | 商户号 | STRING | 来源表原样同步 | 商户唯一标识 |
| 2 | merchant_name | 商户名称 | STRING | 来源表原样同步 | 商户名称描述 |
| 3 | goods_name | 商品名称 | STRING | 来源表原样同步 | 商品名称 |
| 4 | channel_type | 渠道类型 | STRING | 来源表原样同步 | 表示银联/网联及具体支付渠道 |
| 5 | institution_id | 支付机构号 | STRING | 来源表原样同步 | 支付机构标识 |
| 6 | bank | 来源银行 | STRING | 来源表原样同步 | 闪付交易订单来源银行 |

### 3.6 敏感信息脱敏字段

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|
| 1 | _c31 | 卡号脱敏摘要值 | STRING | 由 `sha2(card_no, 256)` 计算生成 | 原字段 `card_no` 经SHA2-256脱敏后输出，无法反解 |

### 3.7 关键字段说明

- **fund_order_no**：资金订单号，来源DDL明确说明为交易唯一标识，并以此为对账基础。下游进行对账分析、异常重复排查时建议优先使用该字段。
- **trans_no**：交易流水编号，通常是支付链路中的核心流水号，可用于串联支付系统中的上下游日志。
- **merch_serial**：商户流水号，适合与商户侧订单数据进行交叉核验。
- **origin_merch_serial**：原始流水号，尤其在撤销、冲正、退款等逆向交易中用于追溯原交易。
- **trans_type**：交易类型字段，决定交易业务语义，是区分消费、撤销、冲正、退款的关键字段。
- **trans_status**：交易当前状态，用于判断订单是否成功、处理中或失败。
- **pre_trans_status**：订单完成前状态，可辅助分析交易状态迁移过程。
- **channel_type**：支付渠道类型，既可区分清算网络，也可区分具体支付渠道。
- **_c31**：卡号脱敏摘要值，用于在不暴露卡号明文的前提下进行同卡聚合分析、风险识别和交易关联。

---

## 四、数据处理逻辑

### 4.1 SQL取数逻辑
当前获取到的表定义本质为一段直接映射SELECT逻辑：

```sql
SELECT
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.id,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.created_at,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.created_by,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.updated_at,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.updated_by,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.edition,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.uid,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.trans_no,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.merch_serial,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.origin_merch_serial,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.amount,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.trans_type,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.trans_status,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.status_desc,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.order_no,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.fund_order_no,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.trade_date,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.trade_time,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.check_date,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.trade_amount,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.merchant_id,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.merchant_name,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.goods_name,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.channel_type,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.institution_id,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.voucher_no,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.flow_time,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.refund_coupon_amount,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.bank,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.apply_finish_at,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.pre_trans_status,
    sha2(ods_loan_dstradeali_debitaccountengine_trans_journal_df.card_no, 256) AS `_c31`,
    ods_loan_dstradeali_debitaccountengine_trans_journal_df.ds
FROM ods_loan.ods_loan_dstradeali_debitaccountengine_trans_journal_df ods_loan_dstradeali_debitaccountengine_trans_journal_df;
```

### 4.2 处理规则说明
1. **字段映射方式**  
   除 `card_no` 外，绝大部分字段均为来源表字段直接透传，无复杂清洗或业务派生。

2. **脱敏规则**  
   - 来源字段：`card_no`
   - 目标字段：`_c31`
   - 转换逻辑：`sha2(card_no, 256)`
   - 目的：保护二类户卡号敏感信息，同时支持基于哈希值的关联分析。

3. **分区策略**  
   - 分区字段：`ds`
   - 推测按日装载，便于ODS层增量抽取及下游按日消费。

4. **数据保真性**  
   该表属于ODS层，重点体现“贴源、少加工、轻转换”的设计原则。

5. **任务元数据情况**  
   当前 `nodecontent`、创建者、修改者、时间等任务元数据均未提供，因此无法补充更详细的调度SQL、任务责任人及调度配置。

---

##五、 枚举值说明

###5.1 trans_type 交易类型枚举值

| 编码 | 名称 | 说明 |
|-----|------|------|
| TRANS | 交易 | 正向交易 |
| TRANS_CANCEL | 交易撤销 | 对原交易进行撤销 |
| TRANS_REVERSE | 交易冲正 | 对原交易进行冲正处理 |
| TRANS_REFUND | 交易退款 | 对原交易进行退款 |

###5.2 trans_status 交易状态枚举值

| 编码 | 名称 | 说明 |
|-----|------|------|
| INIT | 初始化 | 交易初始状态 |
| PROCESSING | 处理中 | 交易处理中，尚未最终完成 |
| SUCCESS | 成功 | 交易处理成功 |
| FAILURE | 失败 | 交易处理失败 |

###5.3 channel_type / bank / pre_trans_status 其他字段枚举值

| 编码 | 名称 | 说明 |
|-----|------|------|
| QR | 二维码交易 | 银联渠道二维码交易 |
| NOQR | 非二维码交易 | 银联渠道非二维码交易 |
| WECHAT | 微信 | 网联渠道微信支付 |
| ALIPAY | 支付宝 | 网联渠道支付宝支付 |
| BAIDU | 百度 | 网联渠道百度支付 |
| JD | 京东 | 网联渠道京东支付 |
| OTHER | 其他渠道 | 其他支付渠道 |
| YLBANK | 银联银行来源 | 闪付交易订单来源银行之一 |
| BXBANK | 百信银行来源 | 闪付交易订单来源银行之一 |
| SUCCESS | 成功 | `pre_trans_status` 订单完成前状态之一 |
| FAILURE | 失败 | `pre_trans_status` 订单完成前状态之一 |

---

##六、 依赖的临时表说明

当前未解析到临时表或中间视图定义。

### 临时表001
- **表名**：待补充
- **用途**：当前元数据未提供
- **数据来源**：待补充

---

##七、 应用场景以及查询示例(每个应用场景需1个查询示例)

### 7.1 场景1：按日统计闪付交易成功笔数与金额
```sql
SELECT
    ds,
    trans_type,
    trans_status,
    COUNT(1) AS trans_cnt,
    SUM(trade_amount) AS total_trade_amount
FROM ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df
WHERE ds = '20250101'
GROUP BY
    ds,
    trans_type,
    trans_status
ORDER BY
    trans_type,
    trans_status;
```

### 7.2 场景2：查询失败交易并定位失败原因
```sql
SELECT
    fund_order_no,
    trans_no,
    merch_serial,
    merchant_id,
    merchant_name,
    trans_type,
    trans_status,
    status_desc,
    trade_amount,
    trade_date,
    trade_time
FROM ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df
WHERE ds = '20250101'
  AND trans_status = 'FAILURE'
LIMIT 100;
```

### 7.3 场景3：按渠道分析交易表现
```sql
SELECT
    channel_type,
    COUNT(1) AS order_cnt,
    SUM(trade_amount) AS total_amount,
    SUM(CASE WHEN trans_status = 'SUCCESS' THEN 1 ELSE 0 END) AS success_cnt
FROM ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df
WHERE ds BETWEEN '20250101' AND '20250131'
GROUP BY channel_type
ORDER BY total_amount DESC;
```

### 7.4 场景4：基于脱敏卡号分析同卡交易聚合
```sql
SELECT
    _c31 AS card_hash,
    COUNT(1) AS trans_cnt,
    SUM(trade_amount) AS total_trade_amount,
    COUNT(DISTINCT merchant_id) AS merchant_cnt
FROM ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df
WHERE ds BETWEEN '20250101' AND '20250131'
GROUP BY _c31
HAVING COUNT(1) > 10;
```

---

## 八、业务变更历史

| 变更时间 | 变更类型 | 变更内容 | 变更人 |
|---------|---------|---------|--------|
| - | - | 初始版本 | - |

## 九、注意事项

1. 该表属于ODS层原始明细表，分析使用时需注意字段口径以源系统定义为准。
2. `card_no` 未直接输出，使用 `_c31` 作为脱敏后的哈希值，不能反推出原始卡号。
3. `amount` 与 `trade_amount` 单位不同：
   - `amount` 单位为分
   - `trade_amount` 单位为元  
   使用时需统一金额口径。
4. `fund_order_no` 是重要对账字段，建议在对账分析中优先使用。
5. `origin_merch_serial` 在逆向流程场景下尤为关键，若为空可能影响退款、冲正链路追溯。
6. `trans_status` 与 `pre_trans_status` 含义不同：
   - `trans_status` 表示当前/最终交易状态
   - `pre_trans_status` 表示订单完成之前状态
7. 当前缺少任务SQL和调度元数据，无法确认是否存在过滤条件、分区覆盖策略、延迟补数策略等，正式使用前建议补充任务定义核验。
8. 表名虽然带 `ods_pdw_loan` 项目前缀，但来源实际为 `ods_loan` 项目下ODS表的脱敏映射结果。

## 十、相关上游表

- `ods_loan.ods_loan_dstradeali_debitaccountengine_trans_journal_df`

如需，我还可以继续把这份数据字典再补充成：
1. **更正式的企业级版本（适合直接贴到Confluence）**
2. **补齐“字段中文名标准化”版本**
3. **输出为可复制到Excel的字段明细表**