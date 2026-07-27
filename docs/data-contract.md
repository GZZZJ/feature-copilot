# 数据契约

所有源文件为 UTF-8 CSV、首行为表头、日期采用 ISO-8601（日期或带时区时间）。多值字段统一使用 `|` 分隔，值内不得包含未转义的 `|`。

## 核心文件

|文件|主键|关系|
|---|---|---|
|`features.csv`|`feature_id`|`source_table` 对应 `tables.table_name`；`feature_name + version` 唯一|
|`tables.csv`|`table_id`|表名可被 fixture feature 引用|
|`performance.csv`|`record_id`|`feature_id` 必须存在|
|`availability.csv`|`record_id`|`feature_id` 必须存在|

`features.csv` 的必填列为：`feature_id, feature_name, cn_meaning, technical_definition, formula, source_table, category, owner_team, applicable_scene, population, sample_scope, grain, time_window, stat_method, derive_type, logic_ref, status, version, synced_at, definition_source, definition_confidence`。

受控枚举：

- `status`: `active`, `deprecated`, `draft`
- `definition_source`: `sql`, `python`, `dictionary`, `manual_confirmed`, `name_inference`
- `definition_confidence`: `verified`, `reviewed`, `unverified`
- `availability_status`: `available`, `unavailable`, `conditional`, `unknown`

正式定义（`definition_source != name_inference`）必须有 `definition_confidence` 为 `verified` 或 `reviewed`，且有 `logic_ref` 或 `definition_source=manual_confirmed`。名称推测只能是 `unverified`，不视为正式定义。

空值口径尚未进入一期源契约。`compare` 会为每个特征显式返回 `null_handling.status=not_recorded`，不得从公式或名称推测；真实数据接入时应补充经确认的空值处理字段和证据。

## 受控业务分类

`knowledge/config/managed_feature_taxonomy.json` 是业务小类治理事实源，`maintenance_scope.json` 通过
`managed_feature_taxonomy_config` 引用它。配置包含稳定小类字典、88 个当前加工组的默认映射和仅在有明确业务证据时使用的特征级覆盖。

每条 `managed_features` 索引记录固化：

- `business_subcategory_code`：稳定查询值；
- `business_subcategory_name`：构建时展示快照；
- `business_subcategory_sort_order`：正整数且在字典内唯一；
- `group_code/group_name`：加工与血缘归属，不再承担业务小类语义。

`managed_feature_scopes(feature_code, package_name, feature_category)` 保存大类归属。同一全局
`feature_code` 可属于多个 package/大类；业务分类和加工组元数据仍只有一份。大类筛选及 taxonomy
计数通过 scope 关联，并在每个父级范围内按唯一 `feature_code` 去重。

解析优先级固定为 `feature override > group default`。小类、组或特征引用非法、映射重复、覆盖原因空白或最终覆盖率不足 100% 时构建失败。配置和四个 package 文件共同进入 managed manifest hash。

Web API 的新参数为 `business_subcategory=<稳定小类编码>` 和 `feature_group=<group_code>`；兼容期内
`feature_subcategory=<group_code>` 仍是加工组别名。全部 `count` 和列表 `total` 都按全局唯一 `feature_code` 在分页前计算。

`logic_ref` 是仓库相对路径；fixture 中引用 `logic/` 下的占位逻辑文件以证明引用链可校验。真实表血缘不使用 CSV：运行时从组逻辑 SQL 和 DP SQL 快照构建 `table_lineage_edges`，边上保留 `node_key` 和 `source_type` 作为证据。真实导入映射见 `docs/operations.md`。

## 特征使用治理

`knowledge/config/managed_feature_usage_governance.json` 是独立于特征快照和加工逻辑的只读治理事实源。构建后：

- 已关联特征写入 `managed_feature_usage_governance`，查询响应中的 `usage_governance` 会标明 `invalid`（失效）或 `not_recommended`（不推荐使用）、原因和来源；
- 未进入当前维护范围的受治理字段保留在 `managed_unmatched_usage_governance`，按字段名查询时仍返回提醒，但不提供或推断缺失元数据、逻辑与血缘；
- 治理配置以加工组选择器标记批量特征时必须声明并验证当前精确数量，避免组范围变化造成静默误标；
- 此配置不修改 package JSON、组 SQL、DP SQL 或其原有元数据。
