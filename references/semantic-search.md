# 中文语义检索指南

语义标签是导航元数据，不是特征正式定义。当前一期只治理逾期与逾期天数专题，并处于 shadow/补充检索阶段；默认结果仍以原始关键词、字段名和技术缩写为主，标签通道不得单独宣称完整。

## 查询原语

```bash
scripts/feature-copilot.sh tags [keywords...] [--dimension business|metric|time|derivation] --format json
scripts/feature-copilot.sh search [keywords...] [--tag <code或中文标准名> ...] [--metric-scope primary|related|any] --format json
```

- `--tag` 可重复；多个标签必须同时命中。
- `--metric-scope` 默认 `any`，只约束指标标签。
- 显式标签使用稳定 code 或中文标准名。中文别名和技术别名用于关键词召回，不作为静默替换规则。
- OR 查询通过多次调用后由模型合并，不在命令中表达复杂布尔式。
- 允许只传标签；关键词和标签不能同时为空。

## 动态检索

直接理解用户问题，不生成固定意图 JSON。根据结果自由选择以下动作：

1. 使用用户原词搜索。
2. 使用 `tags` 查看可用中文标准名、同义词和技术别名。
3. 使用主指标标签收窄直接度量，并注意 `tags` 可能返回更具体的兼容指标（例如“连续逾期天数”）；必要时分别查询后合并。使用 `any` 扩展相关派生。
4. 组合业务、时间和衍生方式标签继续收窄。
5. 标签无结果时改用中文别名、字段缩写或原始关键词。对“相关的都有哪些”这类宽泛问题，标签有结果也不代表试点外没有候选；可再用技术缩写等做一轮关键词补充并单列未标注结果。
6. 对需要正式定义的候选调用 `get`；需要加工逻辑时调用 `explain-logic`。

不要机械执行全部步骤。首轮结果已经准确时直接回答；结果过宽、过窄或歧义时再扩展。

## 结果解释

读取每项的 `semantic_metadata`、`matched_tags` 和 `match_sources`：

- `primary`：特征直接度量该指标。
- `related`：该指标参与条件或派生，但不是最终输出主题。
- `coverage=untagged`：当前语义专题未覆盖，不能据此判断不相关。
- `source_type=model_inferred`：标签由名称等元数据推断，只可用于导航。
- `source_type=manual_confirmed`：关系经过独立人工/模型审查确认，但仍是导航元数据。
- `source_type=logic_verified`：关系已对照 SQL 证据核验；它提升标签证据强度，不改变特征本身的验证等级。
- `confidence=low`：单列为待确认候选，不与高置信结果混合表述。

例如“逾期天数特征有哪些”可先查主指标；“和逾期天数相关的特征有哪些”可比较主指标与 `any` 结果，再按直接指标、阈值/派生指标和低置信候选分组。

## 事实边界

- 标签、别名和中文摘要不改变维护特征的 `verified=false`。
- `semantic_summary_zh` 不替代原始特征名、字段逻辑或 SQL。
- 当前只覆盖逾期专题；回答中披露覆盖边界，并保留关键词回退结果。
- 需要精确公式、分子分母、窗口绑定或导数顺序时，必须查看 `get`/`explain-logic` 的证据和解析状态。
