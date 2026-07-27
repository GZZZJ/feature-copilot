## 一、表信息

| 属性 | 值 |
|------|-----|
| 表名称 | cdmx_dim_credit_account_df |
| 中文名称 | 信贷账户维表 |
| 所属数据域 | 待补充 |
| 二级分类名称 | 待补充 |
| 三级分类名称 | 待补充 |
| 叶子节点名称 | 待补充 |
| 所属层级 | DWD |
| 所属项目 | cdmx |
| 创建者 | 蔡杰斐 |
| 创建时间 | 2024-11-07 14:45:24 |
| 最后更新时间 | 2026-07-13 13:36:44 |

---

## 二、表描述

### 2.1 业务定义

`cdmx_dim_credit_account_df` 是信贷账户维度表，用于沉淀信贷额度户的账户基础信息、账户状态、账户资产类型、授信额度、可用额度、临时额度、固定额度、对客展示额度以及首次授信额度等信息。

该表以信贷账户为核心对象，整合账户系统、风险账户系统、额度余额宽表、额度流水日志等多方数据，形成面向信贷账户分析、额度监控、风险策略回溯、账户生命周期管理的统一维度视图。

表注释：信贷账户维表  
业务文档：<http://wiki.caijj.net/pages/viewpage.action?pageId=296022823>

### 2.2 数据粒度

一行数据表示某个统计日期 `ds` 下的一个信贷额度账户快照。

1. 主业务粒度：`ds + account_id`
2. 辅助业务标识：`account_no`
3. 用户维度关联字段：`uid`
4. 数据限定条件：仅保留 `account_type = '2001'` 的额度户

### 2.3 更新频率

每日更新。

1. 调度类型：DAILY
2. 调度表达式：`0 5 0 * * ?`
3. 分区字段：`ds`
4. 分区写入方式：`insert overwrite table ... partition (ds = '${bizdate}')`

### 2.4 核心应用场景

1. 信贷账户基础信息查询
2. 信贷账户有效性、资产类型、业务类型分析
3. 风控授信额度、客户授信额度、可用额度监控
4. 临时额度、固定额度、对客展示额度分析
5. 新开账户首次授信额度及授信当日最大额度回溯
6. 用户级账户风险分组、初始费率等级、逾期状态分析

### 2.5 其他

| 属性 | 值 |
|------|-----|
| 表类型 | 外部表 |
| 是否视图 | 否 |
| 存储格式 | ORC |
| 分区字段 | ds |
| 分区说明 | dp日期分区字段，通常为 `yyyymmdd` |
| Location | `oss://oss-cn-beijing-internal.aliyuncs.com/lattebank-bigdata-dp-dwd/dp_cdmx.db/cdmx_dim_credit_account_df/` |
| 生命周期 | 3600 |
| TBLPROPERTIES.EXTERNAL | TRUE |
| TBLPROPERTIES.comment | 信贷账户维表[[wiki]][[http://wiki.caijj.net/pages/viewpage.action?pageId=296022823]] |
| TBLPROPERTIES.last_column_modified_time | 1738911486 |
| 任务状态 | NORMAL |
| 任务Owner | dataphin_su |
| 最近修改人 | libing |
| SQL参数 | `${cdmx}`、`${ods_pdw_loan}`、`${dwd}`、`${bizdate}` |
| 特别说明 | 任务SQL中建表生命周期为 30，但当前表DDL中生命周期为 3600，应以线上DDL为准，建议后续治理时统一口径。 |

---

## 三、字段清单

### 3.1 账户标识与用户信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|------|
| 1 | account_no | 账户编号 | STRING | 来源于 `ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_df.account_no` | 信贷账户业务编号 | 可用于关联风险账户表中的 `account_no` |
| 2 | account_id | 账户id | STRING | 来源于 `ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_df.account_id` | 账户系统内部唯一账户标识 | 主要关联键，关联额度余额表、额度流水表 |
| 3 | uid | 用户编号 | STRING | 来源于 `ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_df.uid` | 用户唯一编号 | 可用于用户级账户聚合分析 |

### 3.2 账户类型、状态与风险属性

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|------|
| 1 | credit_account_biz_type | 信贷账户业务类型 | STRING | 来源于 `a.business_type` | 标识账户所属业务类型 | 具体枚举待补充 |
| 2 | credit_account_asset_type | 信贷账户资产类型 | STRING | 由 `a.assets_type` 转义：`HEAVY`→`重资产账户`，`LIGHT`→`轻资产账户`，其他→`未知` | 用于区分账户资产模式 | SQL注释说明：HEAVY-重资产账户、LIGHT-轻资产账户、UNKNOWN-未知 |
| 3 | account_type_code | 账户类型code | STRING | 来源于 `a.account_type` | 账户类型编码 | 当前任务过滤 `a.account_type = '2001'`，即额度户 |
| 4 | account_channel | 账户渠道 | STRING | 来源于 `a.channel` | 账户开通或归属渠道 | 具体渠道枚举待补充 |
| 5 | user_group | 风险账户用户分组 | STRING | 来源于风险账户表子查询 `c.user_group` | 风险侧用户分组 | 来源表按 `account_no` 关联 |
| 6 | init_user_level | 初始用户费率等级 | STRING | 来源于风险账户表子查询 `c.init_user_level` | 初始授信或风控侧用户等级 | 可用于费率、风险层级分析 |
| 7 | is_valid_flag | 是否有效标志 | STRING | 由 `a.activated_status` 转义：`ACTIVE`→`有效`，`INACTIVE`→`无效` | 标识账户当前是否有效 | 其他状态未显式处理，可能为空 |
| 8 | exceed_status | 逾期状态 | STRING | 来源于风险账户表子查询 `c.exceed_status` | 标识账户风险逾期状态 | 具体枚举待补充 |

### 3.3 账户生命周期与时间信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|------|
| 1 | account_open_time | 账户开通时间 | TIMESTAMP | 来源于 `a.created_at` | 账户开户时间，SQL注释说明即授信时间 | 可用于新开账户、授信时间分析 |
| 2 | expire_time | 账户额度失效时间 | TIMESTAMP | 来源于 `a.expired_at` | 账户额度失效时间 | 用于账户有效期判断 |
| 3 | update_time | 更新时间 | TIMESTAMP | 来源于 `b.log_at` | 账户额度余额最近更新时间 | 来源于最新账户余额宽表 |
| 4 | temp_limit_start_time | 临时账户可用额度开始时间 | TIMESTAMP | 来源于额度表子查询 `d.effective_date`，即 `temp_activated_at` | 临时额度生效时间 | 来源于风险额度表 |
| 5 | temp_limit_end_time | 临时账户可用额度结束时间 | TIMESTAMP | 来源于额度表子查询 `d.expire_date`，即 `temp_expired_at` | 临时额度失效时间 | 来源于风险额度表 |
| 6 | ds | dp日期分区字段 | STRING | 写入分区 `partition (ds = '${bizdate}')` | 数据快照日期 | 分区字段，格式通常为 `yyyymmdd` |

### 3.4 授信额度与可用额度信息

| 序号 | 英文字段名 | 中文名称 | 数据类型 | 取值逻辑 | 业务逻辑 | 特别说明 |
|------|-----------|---------|---------|---------|------|------|
| 1 | latest_risk_credit_limit | 最新风控授信额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.risk_credit_limit` | 当前最新风控授信总额度 | 单位：元 |
| 2 | latest_risk_available_limit | 最新风控可用额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.risk_available_limit` | 当前最新风控可用额度 | 单位：元 |
| 3 | latest_cust_credit_limit | 最新客户授信额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.cust_credit_limit` | 当前最新客户侧授信总额度 | 单位：元 |
| 4 | latest_cust_available_limit | 最新客户可用额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.cust_available_limit` | 当前最新客户侧可用额度 | 单位：元 |
| 5 | latest_temp_risk_credit_limit | 最新临时风控授信额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.temp_risk_credit_limit` | 当前最新临时风控授信额度 | 单位：元 |
| 6 | latest_temp_risk_available_limit | 最新临时风控可用额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.temp_risk_available_limit` | 当前最新临时风控可用额度 | 单位：元 |
| 7 | latest_fix_risk_credit_limit | 最新固定风控授信额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.fix_risk_credit_limit` | 当前最新固定风控授信额度 | 单位：元 |
| 8 | latest_fix_risk_available_limit | 最新固定风控可用额度 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.fix_risk_available_limit` | 当前最新固定风控可用额度 | 单位：元 |
| 9 | visible_customer_admit_limit | 对客授信额度-展示 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.visible_customer_admit_limit` | 面向客户展示的授信额度 | 单位：元 |
| 10 | visible_customer_available_limit | 对客可用额度-展示 | DECIMAL(26,10) | 来源于 `dwd.dwd_fct_account_balance_df.visible_customer_available_limit` | 面向客户展示的可用额度 | 单位：元 |
| 11 | first_risk_credit_limit | 首次风控授信额度 | DECIMAL(26,10) | `coalesce(f.first_risk_credit_limit, g.post_value)` | 优先沿用昨日分区首次授信额度；若为空，则取新开账户额度流水中首次授信额度 | 单位：元；日志中 `risk_limit_acl_post / 100` 转元 |
| 12 | credit_day_max_credit_limit | 授信当日最大授信额度 | DECIMAL(26,10) | `coalesce(f.credit_day_max_credit_limit, h.credit_day_max_credit_limit)` | 优先沿用昨日分区值；若为空，则计算授信当日额度流水最大授信额度 | 单位：元；用于授信当天额度峰值分析 |

### 3.5 关键字段说明

1. **account_id**：账户系统内部唯一账户ID，是本表最核心的账户标识，主要用于关联账户余额表、额度流水表、风险额度表等。
2. **account_no**：信贷账户编号，用于与风险账户表按账户编号维度关联，补充风险用户分组、初始用户等级、逾期状态等信息。
3. **account_type_code**：账户类型编码，当前任务仅保留 `2001`，SQL注释说明 `2001` 表示额度户。
4. **credit_account_asset_type**：由账户来源表中的资产类型编码转换得到，`HEAVY` 表示重资产账户，`LIGHT` 表示轻资产账户，其他值统一映射为 `未知`。
5. **is_valid_flag**：由账户激活状态转换得到，`ACTIVE` 表示有效，`INACTIVE` 表示无效；未覆盖的状态会产生空值。
6. **latest_risk_credit_limit**：账户当前最新风控授信额度，来自账户最新额度宽表，是风控侧额度管理的核心指标。
7. **latest_risk_available_limit**：账户当前最新风控可用额度，可用于监控用户剩余可用风控额度。
8. **visible_customer_admit_limit**：对客展示授信额度，可能与风控内部授信额度存在差异，适用于前端展示口径分析。
9. **first_risk_credit_limit**：首次风控授信额度，通过昨日分区继承与当日新开账户额度流水补充两种方式生成。
10. **credit_day_max_credit_limit**：授信当日最大授信额度，用于观察账户授信当天额度变化及最大授信结果。

---

## 四、数据处理逻辑

### 4.1 分区写入逻辑

任务每日按业务日期 `${bizdate}` 覆盖写入目标表对应分区：

```sql
insert overwrite table cdmx.cdmx_dim_credit_account_df partition (ds = '${bizdate}')
...
```

### 4.2 主表取数规则

以账户系统账户表作为主表：

```sql
from ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_df a
where a.ds = '${bizdate}'
  and a.account_type = '2001'
```

取数规则如下：

1. 仅取业务日期 `${bizdate}` 当天分区数据。
2. 仅保留 `account_type = '2001'` 的账户。
3. SQL注释说明 `2001` 表示额度户。
4. 主表提供账户编号、账户ID、用户编号、业务类型、账户渠道、开户时间、额度失效时间、账户状态等基础信息。

### 4.3 最新额度信息补充逻辑

通过账户ID关联最新账户余额宽表：

```sql
left join dwd.dwd_fct_account_balance_df b
  on a.account_id = b.account_id
 and b.ds = '${bizdate}'
```

补充字段包括：

1. 最新风控授信额度
2. 最新风控可用额度
3. 最新客户授信额度
4. 最新客户可用额度
5. 最新临时风控授信额度
6. 最新临时风控可用额度
7. 最新固定风控授信额度
8. 最新固定风控可用额度
9. 对客展示授信额度
10. 对客展示可用额度
11. 账户额度更新时间

### 4.4 风险账户信息补充逻辑

通过 `account_no` 关联风险账户表当日分区：

```sql
left join (
    select
        account_no,
        user_group,
        init_user_level,
        exceed_status
    from ods_pdw_loan.ods_pdw_loan_dsriskbizali_riskaccountengine_risk_account_df
    where ds = '${bizdate}'
) c
on a.account_no = c.account_no
```

补充字段包括：

1. 风险账户用户分组 `user_group`
2. 初始用户费率等级 `init_user_level`
3. 逾期状态 `exceed_status`

### 4.5 临时额度生效时间补充逻辑

通过账户ID关联风险额度表：

```sql
left join (
    select
        node_id as account_id,
        temp_activated_at as effective_date,
        temp_expired_at as expire_date
    from ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_risk_limit_df
    where ds = '${bizdate}'
) d
on a.account_id = d.account_id
```

补充字段包括：

1. 临时账户可用额度开始时间 `temp_limit_start_time`
2. 临时账户可用额度结束时间 `temp_limit_end_time`

### 4.6 首次授信额度继承与计算逻辑

首次风控授信额度字段：

```sql
coalesce(f.first_risk_credit_limit, g.post_value) as first_risk_credit_limit
```

处理逻辑：

1. 优先从目标表昨日分区 `f` 中继承 `first_risk_credit_limit`。
2. 若昨日分区无值，则从当日新开账户额度流水子查询 `g` 中取首次额度。
3. 子查询 `g` 取数来源为额度流水日志表 `ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_balance_acl_log_di`。
4. 日志过滤条件：
   1. `type = 'RISK'`
   2. `event_type = 'LIMIT_OPEN'`
   3. 日志分区范围为 `${bizdate}` 至 `${bizdate}+1`
   4. `to_date(created_at) >= to_date('${bizdate}')`
5. 金额转换逻辑：`risk_limit_acl_post / 100`
6. 同账户按 `created_at, id` 升序取第一条：
   ```sql
   row_number() over(partition by account_id order by created_at, id) as rn
   ```
7. 关联条件要求账户开户日期等于日志创建日期：
   ```sql
   to_date(a.created_at) = to_date(g.created_at)
   ```

### 4.7 授信当日最大授信额度计算逻辑

授信当日最大授信额度字段：

```sql
coalesce(f.credit_day_max_credit_limit, h.credit_day_max_credit_limit) as credit_day_max_credit_limit
```

处理逻辑：

1. 优先从目标表昨日分区 `f` 中继承 `credit_day_max_credit_limit`。
2. 若昨日分区无值，则从子查询 `h` 中计算账户授信当日最大授信额度。
3. 子查询 `h` 数据由两部分 `union all` 组成：
   1. 新额度流水表：`ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_balance_acl_log_di`
   2. 历史账户日志表：`ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_log_df`
4. 新额度流水表过滤条件：
   1. `ds = '${bizdate}'`
   2. `type = 'RISK'`
   3. `date(created_at) = date(to_date('${bizdate}', 'yyyymmdd'))`
   4. 金额口径：`risk_limit_acl_post / 100`
5. 历史账户日志表过滤条件：
   1. `ds = '${bizdate}'`
   2. `log_type = 'RISK_CREDIT_ACL'`
   3. `date(created_at) = date(to_date('${bizdate}', 'yyyymmdd'))`
   4. 金额口径：`if(post_value = '', null, post_value / 100)`
6. 聚合逻辑：
   ```sql
   max(post_value) as credit_day_max_credit_limit
   ```
7. 关联条件：
   ```sql
   a.account_id = h.account_id
   and date(a.created_at) = h.crt_date
   ```

### 4.8 枚举转换逻辑

1. 账户资产类型转换：
   ```sql
   case
     when a.assets_type = 'HEAVY' then '重资产账户'
     when a.assets_type = 'LIGHT' then '轻资产账户'
     else '未知'
   end
   ```
2. 账户有效状态转换：
   ```sql
   case
     when a.activated_status = 'ACTIVE' then '有效'
     when a.activated_status = 'INACTIVE' then '无效'
   end
   ```

---

## 五、枚举值说明

### 5.1 credit_account_asset_type 信贷账户资产类型

| 编码 | 名称 | 说明 |
|-----|------|------|
| HEAVY | 重资产账户 | 来源字段 `a.assets_type = 'HEAVY'` |
| LIGHT | 轻资产账户 | 来源字段 `a.assets_type = 'LIGHT'` |
| 其他 | 未知 | 非 HEAVY、LIGHT 的其他取值统一映射为未知 |

### 5.2 is_valid_flag 是否有效标志

| 编码 | 名称 | 说明 |
|-----|------|------|
| ACTIVE | 有效 | 来源字段 `a.activated_status = 'ACTIVE'` |
| INACTIVE | 无效 | 来源字段 `a.activated_status = 'INACTIVE'` |

### 5.3 account_type_code 账户类型code

| 编码 | 名称 | 说明 |
|-----|------|------|
| 2001 | 额度户 | SQL中通过 `a.account_type = '2001'` 过滤，仅保留额度户 |

### 5.4 额度流水相关枚举值

| 字段 | 编码 | 名称 | 说明 |
|------|-----|------|------|
| type | RISK | 风控额度 | 用于额度流水日志过滤，表示风控额度类型 |
| event_type | LIMIT_OPEN | 开户额度事件 | 用于识别新开账户首次授信额度流水 |
| log_type | RISK_CREDIT_ACL | 风控授信额度日志 | 历史账户日志表中用于识别风控授信额度变更日志 |

### 5.5 其他字段枚举值

| 字段 | 编码 | 名称 | 说明 |
|------|-----|------|------|
| credit_account_biz_type | 待补充 | 待补充 | 来源于 `a.business_type`，SQL未提供明确枚举 |
| account_channel | 待补充 | 待补充 | 来源于 `a.channel`，SQL未提供明确枚举 |
| user_group | 待补充 | 待补充 | 来源于风险账户表，SQL未提供明确枚举 |
| init_user_level | 待补充 | 待补充 | 来源于风险账户表，SQL未提供明确枚举 |
| exceed_status | 待补充 | 待补充 | 来源于风险账户表，SQL未提供明确枚举 |

---

## 六、依赖的临时表说明

### 临时表001

1. **表名**：内联子查询 `c`
2. **用途**：提取风险账户用户分组、初始用户费率等级、逾期状态。
3. **数据来源**：`ods_pdw_loan.ods_pdw_loan_dsriskbizali_riskaccountengine_risk_account_df`
4. **关联方式**：按 `account_no` 关联主账户表。

### 临时表002

1. **表名**：内联子查询 `d`
2. **用途**：提取账户临时额度生效时间和失效时间。
3. **数据来源**：`ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_risk_limit_df`
4. **关联方式**：按 `account_id` 关联主账户表。

### 临时表003

1. **表名**：内联子查询 `g`
2. **用途**：计算每日新开账户对应的首次风控授信额度。
3. **数据来源**：`ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_balance_acl_log_di`
4. **核心逻辑**：按账户取 `type = 'RISK'` 且 `event_type = 'LIMIT_OPEN'` 的首条额度流水，金额为 `risk_limit_acl_post / 100`。

### 临时表004

1. **表名**：内联子查询 `h`
2. **用途**：计算授信当日最大授信额度。
3. **数据来源**：
   1. `ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_balance_acl_log_di`
   2. `ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_log_df`
4. **核心逻辑**：合并新旧额度日志后，按 `account_id + 授信日期` 聚合取 `max(post_value)`。

### 临时表005

1. **表名**：自关联昨日分区 `f`
2. **用途**：继承历史已计算出的首次风控授信额度和授信当日最大授信额度。
3. **数据来源**：`cdmx.cdmx_dim_credit_account_df`
4. **关联条件**：`a.account_id = f.account_id` 且 `f.ds = ${bizdate} - 1`

---

## 七、应用场景以及查询示例

### 7.1 查询指定日期有效额度户的账户额度概览

```sql
select
    account_id,
    account_no,
    uid,
    credit_account_biz_type,
    credit_account_asset_type,
    latest_risk_credit_limit,
    latest_risk_available_limit,
    latest_cust_credit_limit,
    latest_cust_available_limit,
    visible_customer_admit_limit,
    visible_customer_available_limit
from cdmx.cdmx_dim_credit_account_df
where ds = '20260713'
  and is_valid_flag = '有效'
;
```

### 7.2 统计不同资产类型账户的授信额度分布

```sql
select
    credit_account_asset_type,
    count(distinct account_id) as account_cnt,
    sum(latest_risk_credit_limit) as total_risk_credit_limit,
    avg(latest_risk_credit_limit) as avg_risk_credit_limit,
    sum(latest_risk_available_limit) as total_risk_available_limit
from cdmx.cdmx_dim_credit_account_df
where ds = '20260713'
group by credit_account_asset_type
order by total_risk_credit_limit desc
;
```

### 7.3 分析当日新开账户的首次授信额度

```sql
select
    account_id,
    account_no,
    uid,
    account_open_time,
    first_risk_credit_limit,
    credit_day_max_credit_limit,
    credit_account_asset_type,
    account_channel
from cdmx.cdmx_dim_credit_account_df
where ds = '20260713'
  and to_char(account_open_time, 'yyyymmdd') = ds
order by first_risk_credit_limit desc
limit 100
;
```

### 7.4 查询存在临时额度的账户明细

```sql
select
    account_id,
    account_no,
    uid,
    latest_temp_risk_credit_limit,
    latest_temp_risk_available_limit,
    temp_limit_start_time,
    temp_limit_end_time,
    latest_fix_risk_credit_limit,
    latest_fix_risk_available_limit
from cdmx.cdmx_dim_credit_account_df
where ds = '20260713'
  and latest_temp_risk_credit_limit > 0
order by latest_temp_risk_credit_limit desc
limit 100
;
```

### 7.5 按风险用户分组统计账户逾期与额度情况

```sql
select
    user_group,
    exceed_status,
    count(distinct account_id) as account_cnt,
    count(distinct uid) as user_cnt,
    sum(latest_risk_credit_limit) as total_risk_credit_limit,
    sum(latest_risk_available_limit) as total_risk_available_limit
from cdmx.cdmx_dim_credit_account_df
where ds = '20260713'
group by
    user_group,
    exceed_status
order by account_cnt desc
;
```

---

## 八、业务变更历史

| 变更时间 | 变更类型 | 变更内容 | 变更人 |
|---------|---------|---------|--------|
| 2024-11-07 | 初始建表 | 创建信贷账户维表，沉淀账户编号、业务类型、用户编号、账户资产类型、账户开通时间、有效标志、最新授信额度等信息 | 蔡杰斐 |
| 2024-11-07 | 字段新增 | 增加临时风控授信额度、临时风控可用额度、固定风控授信额度、固定风控可用额度字段 | 待补充 |
| 2025-02-07 | 字段新增 | 新增账户ID、账户类型、账户渠道、风险账户用户分组、初始用户费率等级、逾期状态、额度失效时间、更新时间、对客展示额度、临时额度起止时间、首次授信额度、授信当日最大授信额度等字段 | 待补充 |
| 2026-06-17 | 逻辑变更 | 额度系统重构，首次授信额度及授信当日最大额度取数逻辑由旧日志表迁移至新额度流水表 `balance_acl_log_di`，并保留历史账户日志补充逻辑 | 待补充 |
| 2026-07-13 | 任务修改 | 任务最近修改，修改人 `libing`，具体变更内容待补充 | libing |

---

## 九、注意事项

1. 本表为每日快照分区表，查询时必须指定 `ds` 分区，避免全表扫描。
2. 当前任务仅保留 `account_type = '2001'` 的额度户，不包含其他账户类型。
3. `first_risk_credit_limit` 和 `credit_day_max_credit_limit` 优先从昨日分区继承，若历史分区缺失可能影响连续性。
4. 金额类字段统一为 `DECIMAL(26,10)`，业务口径为元；部分日志来源字段通过 `/ 100` 从分转换为元。
5. `is_valid_flag` 仅处理 `ACTIVE` 和 `INACTIVE`，如果源表出现其他状态，目标字段可能为空。
6. `credit_account_asset_type` 对非 `HEAVY`、`LIGHT` 的源值统一映射为 `未知`。
7. `visible_customer_admit_limit`、`visible_customer_available_limit` 是对客展示口径，可能与风控内部额度存在差异。
8. `temp_limit_start_time`、`temp_limit_end_time` 来源于风险额度表中的临时额度时间，若账户无临时额度则可能为空。
9. 当前表DDL生命周期为 3600，但任务SQL中建表语句生命周期为 30，存在元数据口径不一致，建议以生产DDL为准。
10. 表为外部表，数据存储在 OSS 路径，进行表删除、重建、迁移等操作时需注意外部数据文件影响。

---

## 十、相关表

| 表名 | 关系类型 | 用途 |
|------|----------|------|
| `ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_df` | 主来源表 | 提供账户基础信息、账户编号、账户ID、用户编号、业务类型、渠道、账户状态、开户时间、失效时间等 |
| `dwd.dwd_fct_account_balance_df` | 上游来源表 | 提供账户最新风控额度、客户额度、可用额度、临时额度、固定额度、对客展示额度等 |
| `ods_pdw_loan.ods_pdw_loan_dsriskbizali_riskaccountengine_risk_account_df` | 上游来源表 | 提供风险账户用户分组、初始用户费率等级、逾期状态等 |
| `ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_risk_limit_df` | 上游来源表 | 提供临时额度生效时间和失效时间 |
| `ods_pdw_loan.ods_pdw_loan_dsriskaccountengine_riskaccountengine_balance_acl_log_di` | 上游来源表 | 提供额度系统重构后的风控额度流水，用于计算首次授信额度和授信当日最大额度 |
| `ods_pdw_loan.ods_pdw_loan_dsaccountbalanceali_accountbalance_account_log_df` | 上游来源表 | 提供历史账户额度日志，用于补充授信当日最大额度计算 |
| `cdmx.cdmx_dim_credit_account_df` | 自依赖表 | 关联昨日分区，继承首次授信额度和授信当日最大授信额度 |