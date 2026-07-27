# 资产盘点

盘点时间：2026-07-15（Asia/Shanghai）。

|资产类型|发现结果|位置|格式|只读/可写|可自动导入|
|---|---|---|---|---|---|
|现有项目代码|未发现|当前工作区|—|—|否|
|特征知识库（feature-copilot / dz-feature-copilot / pboc-feat）|未发现|当前工作区|—|—|否|
|特征字典（CSV / Excel / Markdown）|未发现|当前工作区|—|—|否|
|宽表清单、SQL、Python 衍生逻辑|未发现|当前工作区|—|—|否|
|人行报文字段字典|未发现|当前工作区|—|—|否|
|历史项目评估/筛选结果|未发现|当前工作区|—|—|否|
|已有 Skill / Python 工程 / DP、MaxCompute 工具|未发现|当前工作区|—|—|否|

## 结论与边界

- 当前目录为空，且不是 Git 仓库；本次创建独立的 `feature-copilot` 一期工程，不会修改旧资产。
- 运行环境已验证为 Python 3.9.6；实现兼容 Python 3.9+，不依赖运行时第三方库。
- 未找到真实业务资产，`knowledge/` 内的数据均为**非业务 fixture**，只用于验证框架，不代表真实表、字段、规则或项目表现。
- 未经验证的信息：工作区之外是否存在可导入资产、真实字段语义、真实表/任务命名、可用性及历史表现。

真实资产到位后应通过 `scripts/import_legacy.py` 导入；导入器只读源文件，并生成可审计的报告和拒绝记录。

## 后续发现的只读前身资产

|资产|位置|格式|可用方式|限制|
|---|---|---|---|---|
|贷中特征知识库前身|`/Users/guzijun/Desktop/AI攻坚/dz-feature-kb/ai-skills-decision-science/dz-feature-kb`|Markdown Skill 与 references|专用 `import_dz_legacy.py` 导入到 staging|无 CSV、SQL、Python、表现或可用性数据；统计口径不一致，不能直接合入正式知识|

本次只读 staging 结果：1,116 条显式字典候选、128 条表候选记录（127 个去重表名）、118 条上游候选和 72 条命名规则候选。完整对账见 [predecessor-reconciliation.md](predecessor-reconciliation.md)。

## 当前纳管的真实快照

- 维护范围固定为 `package_3_br`、`package_4_nuggets`、`package_5_04tnd`、`package_7_02inner`，当前共 23,702 条特征，且每条均有唯一 `featureCode`；
- `goal/_metadata/group_logic/` 中的 110 份组逻辑用于解释当前字段加工；
- `goal/dp_table_logic/` 中的 31 份目标表和 95 份 `pdm_risk` 上游表快照用于递归解释；
- 前身 1,116 条候选不属于维护范围，不进入正式索引。
