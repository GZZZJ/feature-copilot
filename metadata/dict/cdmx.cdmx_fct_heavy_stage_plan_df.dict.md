## 一、表信息

| 属性 | 值 |
|------|-----|
| 表名称 | cdmx_fct_heavy_stage_plan_df |
| 中文名称 | 重资产分期计划记录（分期/期供计划明细） |
| 所属数据域 | 待补充（domain字段缺失） |
| 二级分类名称 | 待补充 |
| 三级分类名称 | 待补充 |
| 叶子节点名称 | 待补充 |
| 所属层级 | DWD（从LOCATION路径`dp-dwd`推断） |
| 所属项目 | cdmx |
| 创建者 | dataphin_su |
| 创建时间 | 2023-11-23 23:40:36 |
| 最后更新时间 | 2025-08-14 19:21:18 |

---

## 二、表描述

### 2.1 业务定义
该表用于沉淀“重资产贷款订单”的**分期（期供）计划**信息，包含每一期的到期日/宽限日、分期类型与状态、逾期信息、还款方式，以及应还/未还/优惠/调整/退货相关的金额拆分（本金、利息、担保费、罚息、复利、提前结清手续费、资产管理咨询费等）。用于贷后资产管理、逾期监控、对账及经营分析。

### 2.2 数据粒度
**一行 = 一个订单（order_no/bill_no）下的一个分期计划（stage_plan_no/term_id）的一期（stage/stage_no）在某日快照（ds）**。

### 2.3 更新频率
每日（任务调度：`crontype=DAILY`，`cronexpression=0 0 0 * * ?`；分区字段ds为业务日期）。

### 2.4 核心应用场景
- 贷后分期计划台账：按订单/用户/期次查询应还、未还、结清等信息  
- 逾期分析：当前逾期天数、历史最大逾期、M0-M7迁徙  
- 还款方式与状态分析：批扣/主动还款/线下补入账/退货等  
- 费用类拆分与核对：担保费、罚息、复利、提前结清手续费、AMC咨询费等  

### 2.5 其他
- 外部表：EXTERNAL = TRUE  
- 存储格式：ORC  
- Location：`oss://oss-cn-beijing-internal.aliyuncs.com/lattebank-bigdata-dp-dwd/dp_cdmx.db/cdmx_fct_heavy_stage_plan_df/`
- 分区：`ds`（dp日期分区字段）
- 生命周期：DDL中为`LIFECYCLE 36000`（早期脚本出现过30，现tableddl为36000）
- 表注释：`重资产分期计划记录(分期)[[wiki]][[http://wiki.caijj.net/pages/viewpage.action?pageId=297874600]]`

---

## 三、字段清单

### 3.1 主键与关联标识

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|----------|----------|
| 1 | stage_plan_no | 分期计划号 | string | `t0.term_id` | 核心系统期供计划唯一编号 | 与ODS核心分期计划表主键对应 |
| 2 | order_no | 订单号 | string | `t0.bill_no` | 重资产订单编号 | 与订单表`cdmx_fct_heavy_loan_order_df.order_no`关联 |
| 3 | uid | 用户编号 | string | `t0.uid` | 借款用户唯一编号 | 用户维度分析 |
| 4 | stage | 期次 | string | `t0.term_no` | 期次（字符型） | 与`stage_no`为同一含义不同类型 |
| 5 | stage_no | 期次,数值型 | bigint | `cast(t0.term_no as bigint)` | 期次（数值型） | 便于排序/计算 |

### 3.2 日期时间与计划关键节点

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|----------|----------|
| 1 | loan_date | 放款日期 | date | `t3.withdraw_date` | 订单进入放款阶段的日期 | 上游`t3`过滤`withdraw_date is not null` |
| 2 | due_date | 到期日 | date | `t0.pmt_due_date` | 该期到期还款日 | |
| 3 | grace_date | 宽限日 | date | `t0.grace_date` | 该期宽限期截止日 | |
| 4 | settlement_time | 结清时间 | timestamp | `t0.paid_out_time` | 分期计划结清时间 | 可能为空 |
| 5 | create_time | 创建时间 | timestamp | `t0.created_at` | 期供计划记录创建时间 | |
| 6 | update_time | 更新时间 | timestamp | `t0.updated_at` | 期供计划记录更新时间 | |
| 7 | batch_time | 跑批时间 | timestamp | `current_timestamp()` | ETL写入时间 | |

### 3.3 状态、类型、逾期与还款方式

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|----------|----------|
| 1 | stage_type | 分期类型 | string | `case when t0.term_type='D' then '溢缴款' ... else t0.term_type end` | 将期供类型代码翻译为中文 | 显示值为中文；原始代码见`original_stage_type` |
| 2 | stage_status | 分期状态 | string | `case when t1.handle_tag_type='SOLD' or t0.term_status='E' then '出让' ... else t0.term_status end` | 分期当前状态（中文/兜底代码） | SOLD打标或E时展示“出让” |
| 3 | stage_deal_type | 分期处理类型 | string | `case when t0.term_deal_type='S' then '停息停费' when t0.term_deal_type is null then '未停息停费' else t0.term_deal_type end` | 是否进入停息停费 | 注释：历史到达过则保持S |
| 4 | current_overdue_days | 当前逾期天数 | bigint | `case when t0.over_due_stage='M0' then 0 else t0.overdue_days end` | 当前逾期天数（M0强制为0） | 对齐M0口径 |
| 5 | history_max_overdue_days | 历史最大逾期天数 | bigint | `t0.overdue_days` | 历史最大逾期天数 | t0内对null做`coalesce` |
| 6 | current_overdue_status | 当前逾期状态 | string | `t0.over_due_stage` | 逾期桶位（M0-M7） | |
| 7 | history_max_overdue_status | 历史最大逾期状态 | string | `t0.hst_max_overdue_stage` | 历史最大逾期桶位（M0-M7） | |
| 8 | latest_repay_type | 最近一次还款类型 | string | `case when t0.deduct_type='AUTO_DEDUCT' then '批扣' ... when is null then '未操作过还款' else t0.deduct_type end` | 还款方式中文翻译 | 显示值为中文；原始代码见`original_repay_type` |
| 9 | original_stage_plan_status | 分期计划状态（原始） | string | `case when t1.handle_tag_type='SOLD' then 'E' else t0.term_status end` | 保留核心状态码，并对SOLD统一置E | 枚举见第5章 |
| 10 | original_repay_type | 还款方式（原始） | string | `t0.deduct_type` | 保留还款方式代码 | 枚举见第5章 |
| 11 | original_stage_type | 期供类型（原始） | string | `t0.term_type` | 保留期供类型代码 | 枚举见第5章 |
| 12 | original_biz_type | 原始业务类型 | string | `t5.original_biz_type` | 订单原始业务类型 | 来自订单事实表 |
| 13 | fund_code | 资方代码 | string | `t5.fund_code` | 资金方标识 | 例：MSXF/BOC/CIBCF等 |
| 14 | asset_plan_id | 资金计划ID | string | `t5.asset_plan_id` | 资方/资金计划维度标识 | |
| 15 | original_product_code | 产品代码 | string | `t5.original_product_code` | 产品标识 | 例：FLASH_PAY等 |
| 16 | sub_product_code | 子产品编号 | string | `t5.sub_product_code` | 子产品维度 | |

### 3.4 金额类字段（原始/优惠/应还/未还/返现/调整/退货/AMC）

> 说明：SQL中金额多为“分”单位字段除以100转为“元”。

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|----------|----------|
| 1 | original_loan_principal | 原始放款本金 | decimal(26,10) | `t0.orig_schd_prin/100` | 原始计划本金（元） | |
| 2 | original_loan_interest | 原始放款利息 | decimal(26,10) | `t0.orig_schd_int/100` | 原始计划利息（元） | |
| 3 | original_loan_guarantee_fee | 原始放款担保费 | decimal(26,10) | `t0.orig_schd_guar_fee/100` | 原始担保费（元） | |
| 4 | original_schedule_pay_default_fee | 原始应还违约金 | decimal(26,10) | `t0.orig_schd_late_fee/100` | 原始违约金（元） | |
| 5 | original_schedule_pay_penalty_interest | 原始应还罚息 | decimal(26,10) | `t0.orig_schd_pen/100` | 原始罚息（元） | |
| 6 | original_schedule_pay_compound_interest | 原始应还复利 | decimal(26,10) | `t0.orig_schd_comp/100` | 原始复利（元） | |
| 7 | original_schedule_pay_prepayment_fee | 原始应还提前还款手续费 | decimal(26,10) | `t0.orig_schd_pre_fee/100` | 原始提前还款手续费（元） | |
| 8 | original_schedule_pay_total_amount | 原始应还总金额 | decimal(26,10) | `t0.orig_schd_amt/100` | 原始总应收（元） | |
| 9 | discount_principal | 优惠本金 | decimal(26,10) | `t0.coup_prin/100` | 优惠减免本金（元） | |
| 10 | discount_interest | 优惠利息 | decimal(26,10) | `t0.coup_int/100` | 优惠减免利息（元） | |
| 11 | discount_guarantee_fee | 优惠担保费 | decimal(26,10) | `t0.coup_guar_fee/100` | 优惠减免担保费（元） | |
| 12 | discount_total_amount | 优惠总金额 | decimal(26,10) | `t0.coup_amt/100` | 总优惠金额（元） | |
| 13 | schedule_pay_principal | 应还本金 | decimal(26,10) | `t0.schd_total_prin/100` | 当期应还本金（元） | |
| 14 | schedule_pay_interest | 应还利息 | decimal(26,10) | `t0.schd_total_int/100` | 当期应还利息（元） | |
| 15 | schedule_pay_guarantee_fee | 应还担保费 | decimal(26,10) | `t0.schd_total_guar_fee/100` | 当期应还担保费（元） | |
| 16 | schedule_pay_default_fee | 应还违约金 | decimal(26,10) | `t0.schd_total_late_fee/100` | 当期应还违约金（元） | |
| 17 | schedule_pay_penalty_interest | 应还罚息 | decimal(26,10) | `t0.schd_total_pen/100` | 当期应还罚息（元） | |
| 18 | schedule_pay_compound_interest | 应还复利 | decimal(26,10) | `t0.schd_total_comp/100` | 当期应还复利（元） | |
| 19 | schedule_pay_prepayment_fee | 应还提前结清手续费 | decimal(26,10) | `t0.schd_total_pre_fee/100` | 当期应还提前结清手续费（元） | |
| 20 | schedule_pay_total_amount | 应还总金额 | decimal(26,10) | `t0.schd_total_amt/100` | 当期应还总金额（元） | SQL内修正口径见第4章 |
| 21 | unpaid_principal | 未还本金 | decimal(26,10) | `t0.unpaid_prin/100` | 未还本金（元） | |
| 22 | unpaid_interest | 未还利息 | decimal(26,10) | `t0.unpaid_int/100` | 未还利息（元） | |
| 23 | unpaid_guarantee_fee | 未还担保费 | decimal(26,10) | `t0.unpaid_guar_fee/100` | 未还担保费（元） | |
| 24 | unpaid_default_fee | 未还违约金 | decimal(26,10) | `t0.unpaid_late_fee/100` | 未还违约金（元） | |
| 25 | unpaid_penalty_interest | 未还罚息 | decimal(26,10) | `t0.unpaid_pen/100` | 未还罚息（元） | |
| 26 | unpaid_compound_interest | 未还复利 | decimal(26,10) | `t0.unpaid_comp/100` | 未还复利（元） | |
| 27 | unpaid_prepayment_fee | 未还提前结清手续费 | decimal(26,10) | `t0.unpaid_pre_fee/100` | 未还提前结清手续费（元） | |
| 28 | unpaid_total_amount | 未还总金额 | decimal(26,10) | `t0.unpaid_amt/100` | 未还总金额（元） | |
| 29 | schedule_rebate_total_amount | 应返现总金额 | decimal(26,10) | `t2.schd_total_rebate_amt/100` | 期供返现总额（元） | 来自期供扩展表`t2` |
| 30 | adjust_gurantee_amount | 担保费调整金额(单位:元) | decimal(26,10) | `t0.adj_guar_fee/100` | 担保费调整（元） | 字段名拼写为`gurantee`（与DDL一致） |
| 31 | adjust_interest | 利息调整金额(单位:元) | decimal(26,10) | `t0.adj_int/100` | 利息调整（元） | |
| 32 | refund_gurantee_fee | 当期退货担保费(单位:元) | decimal(26,10) | `t0.refund_guar_fee/100` | 当期退货冲减担保费（元） | |
| 33 | refund_interest | 当期退货利息(单位:元) | decimal(26,10) | `t0.refund_int/100` | 当期退货冲减利息（元） | |
| 34 | refund_principal | 当期退货本金(单位:元) | decimal(26,10) | `t0.refund_prin/100` | 当期退货冲减本金（元） | |
| 35 | return_deposit_bal | 退货溢缴款(单位:元) | decimal(26,10) | `t0.return_deposit_bal/100` | 退货导致的溢缴款余额（元） | |
| 36 | actual_schedule_pay_principal | 实际应还本金(单位:元 去除退货后) | decimal(26,10) | 见第4章case逻辑 | 退货后口径下的实际应还本金（元） | 包含多种异常数据修复分支 |
| 37 | original_loan_amc_fee | 原始资产管理咨询费(单位:元) | decimal(26,10) | `t0.orig_schd_amc_fee/100` | 原始AMC咨询费（元） | |
| 38 | adjust_amc_amount | 资产管理咨询费调整金额(单位:元) | decimal(26,10) | `t0.adj_amc_fee/100` | AMC咨询费调整（元） | |
| 39 | discount_amc_fee | 优惠资产管理咨询费(单位:元) | decimal(26,10) | `t0.coup_amc_fee/100` | AMC咨询费优惠（元） | |
| 40 | unpaid_amc_fee | 未还资产管理咨询费(单位:元) | decimal(26,10) | `t0.unpaid_amc_fee/100` | 未还AMC咨询费（元） | |
| 41 | schedule_pay_amc_fee | 应还资产管理咨询费(单位:元) | decimal(26,10) | `t0.schd_total_amc_fee/100` | 应还AMC咨询费（元） | tableddl含该字段 |

### 3.5 分区字段

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|----------|----------|
| 1 | ds | dp日期分区字段 | string | 写入分区：`partition(ds='${bizdate}')` | 数据日期快照 | 每日覆盖写入当日分区 |

### 3.6 关键字段说明

- **stage_status / original_stage_plan_status**：`stage_status`为面向分析展示的“中文/合并后状态”，其中当`t1.handle_tag_type='SOLD'`或`term_status='E'`会展示“出让”；`original_stage_plan_status`保留状态码并将SOLD统一置为`E`，用于标准化枚举分析。  
- **current_overdue_days**：当`current_overdue_status='M0'`时强制为0，其余取`overdue_days`，用于避免M0出现非0天数。  
- **schedule_pay_total_amount**：在`t0`子查询中若发现“总额 != 各费用合计”，则用`schd_total_amt - coup_amt`纠偏，否则用原总额；保障“应还总额”与优惠口径一致。  
- **actual_schedule_pay_principal**：用于“去除退货影响”的实际应还本金，含多分支修复逻辑（见第4章），属于口径敏感字段。  

---

## 四、数据处理逻辑

### 4.1 写入方式
- `insert overwrite` 按天覆盖写入：`cdmx_fct_heavy_stage_plan_df partition(ds='${bizdate}')`

### 4.2 上游来源（主表与关联）
- 主来源（t0）：`ods_pdw_loan.ods_pdw_loan_dsloankernelali_loancore_cls_term_df`（核心分期计划表，按ds取当天快照）
- 打标表（t1）：`ods_pdw_loan.ods_pdw_loan_dsloankernelali_loancore_cls_term_tag_df`（用于识别SOLD等标签）
- 期供扩展表（t2）：`ods_pdw_loan.ods_pdw_loan_dsloankernelali_loancore_cls_term_ext_df`（返现金额）
- 订单放款信息（t3）：`ods_pdw_loan.ods_pdw_loan_dsloankernelali_loancore_cls_loan_df`（withdraw_date；仅保留withdraw_date非空）
- 修复临时表（t4）：`ods_pdw_loan.ods_pdw_loanrefund_fee_temp`（固定ds=20230201，用于修复核心系统退手续费问题）
- 订单事实（t5）：`cdmx.cdmx_fct_heavy_loan_order_df`（补充biz_type、fund_code、asset_plan_id、产品等）

### 4.3 核心口径与计算规则

1) **类型/状态中文化**
- `stage_type`：对`term_type`进行代码翻译（D/J/L/P/Q），否则保留原值  
- `stage_status`：综合`t1.handle_tag_type`与`term_status`翻译为中文；若SOLD或E则统一为“出让”

2) **逾期天数修正**
- `current_overdue_days`：`M0 → 0`，否则取`overdue_days`
- `history_max_overdue_days`：取`overdue_days`（t0内已对null置0）

3) **金额单位统一**
- 大部分金额由“分”转换为“元”：字段值 `/100`

4) **应还总金额纠偏（在t0子查询内）**
- 若 `schd_total_amt <> (schd_total_prin+schd_total_int+schd_total_guar_fee+schd_total_amc_fee+schd_total_pre_fee+schd_total_late_fee+schd_total_pen+schd_total_comp)`  
  则 `schd_total_amt = schd_total_amt - coup_amt`  
  否则保持原`schd_total_amt`

5) **实际应还本金（去退货）修复逻辑**
```text
case
  when schd_total_prin = 0 then 0
  when schd_total_prin < refund_prin then schd_total_prin/100
  when return_deposit_bal > refund_prin
       then (schd_total_prin - refund_prin + return_deposit_bal - coalesce(t4.amount, refund_int))/100
  else (schd_total_prin - refund_prin)/100
end
```
- 用途：修复长亮手动更新缺失、迁移退手续费计划等异常场景

---

## 五、枚举值说明

### 5.1 original_stage_plan_status（分期计划状态码）
| 编码 | 名称 | 说明 |
|-----|------|------|
| U | 未到期 | 正常未到期 |
| O | 已逾期 | 已进入逾期 |
| C | 已代偿 | 已发生代偿 |
| S | 已还款 | 已结清/已还清该期 |
| X | 未到期还款 | 未到期提前还款（状态码X） |
| A | 退货结清 | 退货导致结清 |
| R | 已退汇 | 退汇状态 |
| E | 已售/出让 | 当`t1.handle_tag_type='SOLD'`时置为E |

### 5.2 original_repay_type（还款方式码）
| 编码 | 名称 | 说明 |
|-----|------|------|
| AUTO_DEDUCT | 批扣 | 系统自动扣款 |
| MANUAL_DEDUCT_ALL | 催收全额补扣 | 催收侧全额补扣 |
| MANUAL_PARTIAL_DEDUCT | 催收部分扣款 | 催收侧部分扣款 |
| MANUAL_REPAY | 主动还款 | 用户主动发起 |
| OFFLINE_REPAY | 缴款补入账 | 线下缴款后补入账 |
| REFUND | 退货 | 退货相关还款方式 |
| null | 未操作过还款 | 从未发生还款动作 |

### 5.3 original_stage_type（期供类型码）
| 编码 | 名称 | 说明 |
|-----|------|------|
| D | 溢缴款 | 溢缴相关期供 |
| J | 随借随还转出 | 随借随还资金转出 |
| L | 随借随还转入 | 随借随还资金转入 |
| P | 固定期限趸交 | 固定期限一次性趸交 |
| Q | 固定期限转入 | 固定期限转入 |

### 5.4 current_overdue_status / history_max_overdue_status
| 编码 | 名称 | 说明 |
|-----|------|------|
| M0-M7 | 逾期桶位 | 逾期阶段分层（具体规则待补充） |

---

## 六、依赖的临时表说明

### 临时表001
- **表名**：`ods_pdw_loanrefund_fee_temp`
- **用途**：修复核心系统“退手续费/退货相关”历史数据问题，用于计算`actual_schedule_pay_principal`的纠偏分支
- **数据来源**：dbank侧修复数据抽取到dp（脚本注释：`dbank.dbank_f_refund_fee_temp`）

---

## 七、应用场景以及查询示例(每个应用场景需1个查询示例)

> 说明：示例中项目名前缀按要求使用`cdmx`（不写`dp_`）。

### 7.1 场景1：查询某订单的分期计划台账（含应还/未还/状态）
```sql
SELECT
  ds,
  order_no,
  stage_no,
  due_date,
  stage_status,
  current_overdue_status,
  current_overdue_days,
  schedule_pay_total_amount,
  unpaid_total_amount
FROM cdmx.cdmx_fct_heavy_stage_plan_df
WHERE ds = '${bizdate}'
  AND order_no = '${order_no}'
ORDER BY stage_no;
```

### 7.2 场景2：按资方统计某日逾期金额与逾期分布
```sql
SELECT
  fund_code,
  current_overdue_status,
  COUNT(*) AS stage_cnt,
  SUM(unpaid_total_amount) AS unpaid_amt_sum
FROM cdmx.cdmx_fct_heavy_stage_plan_df
WHERE ds = '${bizdate}'
  AND current_overdue_status <> 'M0'
GROUP BY fund_code, current_overdue_status
ORDER BY fund_code, current_overdue_status;
```

### 7.3 场景3：分析退货影响后的“实际应还本金”
```sql
SELECT
  order_no,
  stage_no,
  schedule_pay_principal,
  refund_principal,
  return_deposit_bal,
  actual_schedule_pay_principal
FROM cdmx.cdmx_fct_heavy_stage_plan_df
WHERE ds = '${bizdate}'
  AND order_no = '${order_no}'
ORDER BY stage_no;
```

---

## 八、业务变更历史

| 变更时间 | 变更类型 | 变更内容 | 变更人 |
|---------|---------|---------|--------|
| 2025-02-17 | 新增字段 | 新增 `actual_schedule_pay_principal` | 待补充 |
| 2025-05-14 | 新增字段 | 新增 `original_stage_plan_status`、`original_repay_type`、`original_stage_type`、`adjust_interest`、`refund_gurantee_fee`、`refund_interest`、`refund_principal`、`return_deposit_bal` | 待补充 |
| 2025-05-19 | 新增字段 | 新增 `original_biz_type`、`fund_code`、`asset_plan_id`、`original_product_code`、`sub_product_code` | 待补充 |
| 2025-08-02 | 新增字段 | 新增 `original_loan_amc_fee`、`adjust_amc_amount`、`discount_amc_fee`、`unpaid_amc_fee` | 待补充 |
| 2025-08-04 | 新增字段 | 新增 `schedule_pay_amc_fee` | 待补充 |
| - | - | 初始版本 | - |

---

## 九、注意事项

1. **口径差异**：`stage_status`/`latest_repay_type`为中文化展示字段；如需稳定枚举分析，请使用`original_stage_plan_status`/`original_repay_type`/`original_stage_type`。  
2. **金额单位**：表内金额字段均为“元”，由上游“分”除以100得到。  
3. **actual_schedule_pay_principal**包含历史数据修复逻辑，跨期对账/指标口径需与业务确认后使用。  
4. **分区覆盖**：每日`insert overwrite`覆盖当日ds分区，取数需指定ds避免扫全表。  

---

## 十、相关表

- 上游ODS来源表：  
  - `ods_pdw_loan_dsloankernelali_loancore_cls_term_df`（核心分期计划）  
  - `ods_pdw_loan_dsloankernelali_loancore_cls_term_tag_df`（分期打标）  
  - `ods_pdw_loan_dsloankernelali_loancore_cls_term_ext_df`（期供扩展/返现）  
  - `ods_pdw_loan_dsloankernelali_loancore_cls_loan_df`（订单放款信息）  
  - `ods_pdw_loanrefund_fee_temp`（修复临时表）
- 同域关联表：  
  - `cdmx_fct_heavy_loan_order_df`（重资产放款记录表-订单粒度）