# 特征小类业务语义化实施计划

## 实施目标

在不改变现有加工逻辑和血缘事实源的前提下，将 Web“特征小类”从物理 `group_code` 改为业务语义分类，并把加工特征组保留为独立下钻筛选。保持旧 API 参数一个版本周期的兼容。

## 实施顺序

### 1. 建立分类事实源

文件：

- `knowledge/config/managed_feature_taxonomy.json`
- `knowledge/config/maintenance_scope.json`

- 定义 10 个稳定业务小类及排序。
- 为当前维护范围内 88 个唯一 `group_code` 建立默认映射。
- 对已识别的跨语义宽表预留 `feature_overrides`；第一版只添加有明确证据的覆盖，不做名称猜测。
- 在 `maintenance_scope.json` 增加 `managed_feature_taxonomy_config` 路径；加载器将该文件哈希加入现有 `catalog["manifest_files"]`，由 `index_builder` 现有 managed manifest 哈希自动纳入缓存失效计算，不新增第二套 manifest。

验证：配置 JSON 可解析；小类、组映射和特征覆盖无重复；88 个当前组全部命中。

### 2. 扩展目录加载与强校验

文件：`src/feature_copilot/logic_catalog.py`

- 从 `maintenance_scope.json` 读取 taxonomy 配置路径。
- 校验小类编码、名称、排序、组和特征引用；`sort_order` 必须是正整数且全局唯一，已发布编码不得因文案变化而重排。
- `feature_overrides.reason` 必填且去除首尾空白后非空，审计报告按覆盖原因计数并保留覆盖明细。
- 对每个特征执行“feature override > group default”的确定性解析。
- 在 managed feature 记录中加入 `business_subcategory_code/name/sort_order`。
- 若最终分类覆盖率不是 100%，抛出 `ValidationError`。
- 在 catalog 返回分类字典与分类审计统计。

测试：在 `tests/test_managed_logic.py` 增加缺组、非法编码、冲突覆盖、特征级覆盖优先、跨包重复 Key 冲突等用例。

### 3. 扩展 SQLite 索引

文件：`src/feature_copilot/index_builder.py`

- 扩展 `managed_features` 表字段和过滤索引。
- 扩展 FTS managed search 展示字段，但不把分类值拼入 SQL 条件。
- 写入分类审计 metadata：小类数、组数、覆盖数、覆盖项数、未分类数。
- 保证临时库构建、校验通过后才原子替换旧库。

测试：更新 `tests/test_build_index.py`、`tests/test_managed_logic.py` 的 schema、统计和 manifest 断言。

### 4. 改造服务查询与分类字典

文件：`src/feature_copilot/service.py`

- `list_managed_features` 新增 `business_subcategory` 和 `feature_group`。
- 保留 `feature_subcategory` 作为组过滤兼容入口；冲突由 Web API 层校验。
- taxonomy 查询改成“大类 → 业务小类 → 加工特征组”，按父级范围统计唯一 feature。跨语义组可同时出现在多个小类节点下；每个节点的组计数只统计该小类下的特征，选择该组与小类后按 AND 返回同一子集，不使用组全量计数。
- 列表和详情自然返回业务小类字段，并保留 group 字段。
- 对非法分类/组和大类归属提供只读存在性检查方法，供 API 参数校验。

测试：更新 `tests/test_managed_web_service.py`，覆盖组合 AND、特征覆盖、同一组挂载多个小类、父级范围计数、归属冲突和稳定排序。

### 5. 改造 Flask API 并保持兼容

文件：`src/feature_copilot_web/app.py`

- `/api/v1/features` 接收 `business_subcategory`、`feature_group` 和旧 `feature_subcategory`。
- 读取参数列表而非只取首值，拒绝重复参数。
- 兼容组参数同值可接受、冲突返回 400。
- 小类或组不存在、组不属于大类返回 400；小类与组语义不一致按 AND 返回空列表。
- `/api/v1/feature-taxonomy` 返回三级分类。

测试：更新 `tests/test_web_api.py` 覆盖所有参数边界和旧链接兼容。

### 6. 改造 Web 列表与详情

文件：

- `src/feature_copilot_web/templates/list.html`
- `src/feature_copilot_web/templates/detail.html`
- `src/feature_copilot_web/static/app.js`
- `src/feature_copilot_web/static/styles.css`（仅在布局确有需要时修改）

- 增加“加工特征组”级联选择器。
- 新页面 URL 使用 `business_subcategory` 和 `feature_group`。
- 历史 URL 中 `feature_subcategory` 仍可由后端执行；前端读取时迁移为加工组状态。
- 大类变化清空小类和组；小类变化只清空组。
- 列表同时展示“特征小类”和“特征组”；详情增加业务小类。
- taxonomy 失败时保留文本查询能力，并准确展示当前 URL 条件。

测试：更新 Web API fixture；对静态 JS 关键参数和模板字段增加断言。

### 7. 文档、审计与全量验证

文件：

- `docs/data-contract.md`
- `docs/architecture.md`
- `docs/operations.md`
- `references/feature-copilot-guide.md`
- `scripts/validate_feature_copilot.py`（若现有入口适合承载分类审计）

- 记录业务小类、加工组的字段职责与兼容期。
- 输出全量分类覆盖统计，不修改四个 package JSON。
- 运行定向测试、完整 `pytest`、资产校验和索引构建。
- 用真实 taxonomy 接口核对各级 count 与列表 total。

## 完成定义

- 当前维护范围的唯一特征全部拥有一个业务小类。
- 当前 88 个加工组全部可查询和下钻。
- 旧 `feature_subcategory=<group_code>` API 查询仍可用。
- 新 Web 只生成新参数，业务小类和加工组可组合过滤。
- 全量自动化测试、资产校验和索引构建通过。
- 独立 verifier 审核实现与设计规格一致，无阻塞问题。
