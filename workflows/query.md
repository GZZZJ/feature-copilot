# 查询工作流

## 0. 前置

1. 执行 `scripts/feature-copilot.sh validate --format json`；若存在 `ERROR`，停止并反馈事实源问题。
2. 索引不存在或源数据更新时，执行 `scripts/feature-copilot.sh build-index --format json`。
3. 后续所有回答只使用 CLI JSON；不要扫描原始 JSON 或 SQL 来组织答案。

## 特征级

`get` → `OK`：返回定义、特征大类、公式、来源、粒度、窗口、统计、场景、客群、状态、血缘/表现摘要和证据。维护 package 特征的大类使用 CLI 返回的 `feature_category`，不自行推测。  
`NOT_FOUND`：原样返回未命中与未验证的名称提示；建议查 SQL、字典或负责人。  
`AMBIGUOUS`：让调用方提供 `--version`。

## 加工逻辑

- 必须使用 `explain-logic <featureCode>`，不以中文名或字段名推测加工规则。
- 先展示字段片段、表达式状态和 group_logic 证据；只有检测到 `pdm_risk` 上游时才展示 DP 递归链路。
- `OK` 表示当前快照内链路已遍历；`PARTIAL` 必须原样展示缺失表、循环或深度诊断。完整 SQL 仅在调用方显式请求 `--full` 时返回。

## 搜索与表级

- `search` 的多个关键词是 AND；先给 `total` 和过滤条件，再展示有限结果。
- `table` 先给表粒度、更新频率和特征数量，再给分类/窗口/统计聚合与代表特征；默认不展开整表。

## 血缘、对比、表现、可用性

- 血缘：按用户指定方向，检查 `diagnostics` 和 `trusted_endpoints`。
- 对比：逐项呈现结构化差异；相似性仅引用输出中的方法和提示。
- 表现：只报告已有指标和标签/窗口；空值不补全。
- 可用性：没有场景、客群、观察时点或匹配证据，不能输出绝对“可用”。
