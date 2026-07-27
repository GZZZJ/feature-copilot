---
name: feature-copilot
description: 使用本目录内的确定性 JSON 查询结果和维护者确认的元数据回答四个维护 package 内的中文特征检索、特征定义、加工逻辑、递归血缘、特征包背景及 JSON 字段含义问题；支持按中文语义标签动态扩展相关特征，未命中或背景知识未维护时不编造定义。
---

# 特征查询 Skill

只编排本地查询，不修改特征快照、语义标签、组逻辑或 DP 逻辑。安装、更新、归档与安全边界见 [参考指南](references/feature-copilot-guide.md)；中文相关特征检索见 [语义检索指南](references/semantic-search.md)。用户询问特征包背景时读取 [特征包背景知识](references/feature-package-backgrounds.md)；询问 JSON 字段含义、主题域、是否回溯当天或缓存天数时读取 [特征快照字段字典](references/feature-snapshot-fields.md)。

## 事实来源

具体特征的名称、取值、加工逻辑和血缘只采信本地命令的 JSON 输出。特征是否失效或不推荐使用只采信返回的 `usage_governance`；它是独立治理记录，不改变或否定原始元数据、加工逻辑和血缘。JSON 字段含义只采信 [特征快照字段字典](references/feature-snapshot-fields.md)，特征包级背景只采信 [特征包背景知识](references/feature-package-backgrounds.md)。不要把命名规则、模型知识或未写入对应维护参考的临时描述作为正式定义。

包级背景只用于补充业务上下文，不能替代单个特征的正式定义、统计口径或加工证据。字段字典只解释元数据字段，不能替代 SQL 中的特征计算窗口。

```bash
scripts/feature-copilot.sh <command> --format json
```

统一使用上述入口；默认索引为包内 `knowledge/feature_copilot.sqlite`，与 manifest 一并随 Skill 发布。更新进入索引的特征快照、分类、语义标签或逻辑事实源后，发布者必须执行 `build-index` 重建该索引；只更新字段字典或特征包背景参考文件不需要重建索引。只有开发环境可通过 `--db` 或环境变量覆盖索引位置。

## 路由

|用户意图|命令|
|---|---|
|某特征是什么、怎么计算、来自哪里|`get <feature> [--version <version>]`|
|某特征的加工逻辑、SQL 摘要和上游三层表|`explain-logic <featureCode> [--max-depth 3]`|
|明确要求完整、全部或可执行 SQL 加工逻辑|`explain-logic <featureCode> --max-depth 3 --full`|
|审计全部特征表的逻辑留存完整性|`audit-logic [--max-depth 20]`|
|中文含义、名称、分类、场景等检索|`search <keywords...>` 加对应筛选|
|中文主题、同义词、相关特征等语义检索|按问题自由组合原关键词、`--tag`、`--metric-scope` 与多轮查询；需要发现词表时使用 `tags`，并与原结果合并去重|
|特征包是什么、包内特征的业务背景或术语|读取 `references/feature-package-backgrounds.md`；需要列举具体特征时再执行 `search`|
|`featureCode`、`domainCode`、`includeTodayFlag`、`timeRange` 等 JSON 字段是什么意思|读取 `references/feature-snapshot-fields.md`|
|某宽表包含什么|`table <table>`|
|某表的上游/下游来源|`lineage <table> --direction forward|reverse|both --max-depth 3`|
|多个特征差异|`compare <feature...>`|
|历史项目表现|`perf` 加筛选|
|指定场景、客群、观察时点能否使用|`availability <feature> --scene ... --population ... --observation-timing ...`|

## 回答规则

1. 执行本地查询时先报告 `status`，并展示证据路径和 `synced_at`/`updated_at`。仅回答字段字典或包级背景时，展示对应参考文件的证据路径和口径确认日期，不虚构查询状态或同步时间。
2. 加工逻辑必须使用精确 `featureCode`。用户只提供中文名称或字段名时，先 `search` 定位候选；仅在唯一命中时继续，否则要求其选择。随后依次读取特征所属 `groupCode`、特征目标宽表和由 `table_lineage_edges` 给出的第 1、2、3 层上游表；先解释当前字段的组 SQL 片段，再返回每层表、父表、SQL 文件路径和可用状态。
3. 默认不要使用 `--full`。只有用户明确要求“完整 SQL”“全部加工逻辑”“可执行 SQL”或同义表达时才使用 `--full`；此时逐层展示可用 SQL，并继续披露 `PARTIAL`、未下载表、断链和循环，不能把本地缺失的逻辑称为完整。
4. `PARTIAL` 时必须展示未下载表或循环诊断；不得把不完整链路称为全流程。任务 SQL 内通过有效 `CREATE TABLE` 或 `INSERT OVERWRITE TABLE` 加工的中间表若标记为 `inline_materialized`，应说明其逻辑在宿主任务中可见，不得误报为“未下载”；注释中的伪写入语句不能作为证据。`--max-depth` 仅改变展开层数，不会补全本地未下载的任务逻辑。
5. `NOT_FOUND` 时明确说“知识库未命中，不能提供正式定义”；仅可展示 `inferred_from_name`，且必须保留 `verified=false` 和建议确认路径。
6. `AMBIGUOUS` 时列出候选，要求调用者指定版本；不要擅自选择。
7. 可用性结论必须复述场景、客群和观察时点；缺参或缺证据只能为 `conditional` 或 `unknown`。
8. 表血缘只查询运行时从组逻辑和 DP 任务快照构建的 `table_lineage_edges`；默认最多回溯三层。输出需要显示未解析终点、环、最大深度、数仓标准表终点及短表名解析等诊断。
9. 对比中的 `logic_similarity_hint` 只是可解释提示，不能表述为“重复特征”。
10. 结果较多时，先按数量、分类或状态归纳，再给少量代表项和下一步筛选建议。
11. 维护 package 内的特征详情与搜索结果必须展示 `feature_category`（特征大类）；该值只采信维护范围配置，不根据特征名或表名推测。
12. 回溯至 `knowledge/config/standard_warehouse_tables.json` 声明的数仓标准表时，只停止该表所在分支的继续展开，并标注“数仓标准表”。同一父表的其他上游分支必须继续按原规则回溯；例如 `cdmx` 分支终止时，`pdm_risk` 分支仍需继续展开。标准 schema 和排除项一律以该配置为准，不在 Skill 中维护副本；`dwa_risk` 明确不属于终点。表级说明仅采信该配置中的 `table_metadata`；缺失时说明“标准表元数据尚未维护”，不得按表名编造含义。
13. 本 Skill 只解释存量特征的静态元数据、加工逻辑和血缘，不推断、评估或报告任务调度、并发、重跑、分区覆盖等运行问题；这些问题属于外部任务调度平台的职责范围。
14. 完整性审计使用 `audit-logic --format json`，只汇总缺失表、影响范围、内联物化数量、深度和循环诊断，不请求或展示 SQL 正文。
15. 中文语义标签已覆盖当前 23,702 个特征，但仍是导航元数据，不替代原关键词检索或正式定义验证。模型可根据问题自由组合原词、标签、别名、技术缩写和多轮收窄，不要求固定解析步骤；标签未知或结果为空时必须回退原始关键词结果。
16. `semantic_metadata` 中的 `alias_zh` 是对原始 `featureName` 的可读中文别名，只用于召回和理解；原始字段名、特征名称和加工逻辑仍以特征快照和本地 SQL 为准。别名的来源、置信度与证据分别见 `alias_source_type`、`alias_confidence`、`alias_evidence_ref`。标签按 `primary`、`related` 和低置信候选分组；必须展示 `coverage`、`source_type` 和 `confidence`，不得据此提升 `verified` 或生成正式定义。
17. 用户询问“某主题特征”时可优先查看主指标标签；询问“和某主题相关”时可同时检查主指标、相关指标和业务主题标签。特征角色、时间语义和衍生方式允许为空；标签检索不是强制意图分类，仍应保留一轮原词或技术缩写检索以发现命名未覆盖候选。
18. 解释快照元数据时严格采用字段字典：`domainCode=UID` 表示用户主题域；`includeTodayFlag=0/1` 分别表示特征回溯不包含/包含当天；`timeRange` 表示缓存天数，不得解释为特征计算或统计的回溯窗口。
19. 使用包级背景时明确它是整个特征包的业务上下文。不得从“百融多头”等包级描述外推出单个特征的机构范围、时间窗口、次数口径或加工公式。
20. 参考文件标记为“尚未维护”的包级知识必须如实说明缺失；不得根据包名、行业常识或其他包的背景补全。
21. 特征包背景中的“维护者确认口径”可作为包级定义；由代表性 SQL 归纳的补充说明只能表述为当前代码证据所见，不得声称覆盖包内每个特征。比较百融与同盾多头时，明确二者数据源和加工口径不同，不能按相似中文名直接等同或替换。
22. 任一查询响应中的 `usage_governance.is_recommended=false` 必须在答案开头明确提醒“失效”或“不推荐使用”，展示治理原因与 `source_ref`，随后才可按原有规则提供保留的元数据、加工逻辑和血缘。若特征未进入当前受控目录但命中治理记录，说明“当前目录未维护元数据与逻辑”，不得补全或推断。
