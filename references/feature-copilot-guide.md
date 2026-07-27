# feature-copilot 参考指南

## 项目定位与一期边界

这是一个供 AI 编程环境调用的本地特征知识查询系统。它将 fixture CSV 及四个受控 package 的 JSON 特征快照、组逻辑和 DP 任务逻辑构建为 SQLite 索引，并通过 Python API、CLI 和 Skill 提供确定性查询。

四个受控 package 的通用 JSON 字段口径维护在 `references/feature-snapshot-fields.md`，包级业务背景维护在 `references/feature-package-backgrounds.md`。两份文件按问题类型分别提供解释上下文，不进入 SQLite，也不替代具体特征的名称、加工逻辑和血缘证据。

已实现：特征、表、血缘、对比、历史表现、可用性与加工逻辑查询。加工逻辑优先给出字段级 group SQL 片段，并默认展开三层上游表；PDM 和 DWA 的任务逻辑均以同名 `.sql` 文件提供证据。

查询只解释静态特征逻辑和血缘，不对任务调度、并发、重跑或分区覆盖做任何推断或风险判断；这些运行问题由外部调度平台维护。

未实现：特征衍生 Agent、自动组合/训练/指标计算、DP 发布、生产表修改，以及向外部模型发送原始用户数据。Web 管理页面作为可选、只读适配层提供，不属于 Skill 的运行前置条件。

`knowledge/` 中全部 `fixture_*` 记录均为非业务测试数据，不能用于业务决策。

## 运行与安装

无需安装即可从源码运行。入口脚本会自动定位项目根目录并设置 `PYTHONPATH`：

```bash
scripts/feature-copilot.sh --help
```

若当前环境的 Python 不叫 `python3`，可设置 `FEATURE_COPILOT_PYTHON`；例如 `FEATURE_COPILOT_PYTHON=python3.11 scripts/feature-copilot.sh --help`。

默认查询直接读取包内预构建的 SQLite 索引，不向用户目录或临时目录写入数据。发布者更新进入索引的事实源后必须在包内执行 `build-index`；开发环境可通过 `FEATURE_COPILOT_CACHE_DIR` 或 `FEATURE_COPILOT_DB` 显式指定影子索引。

可选安装 CLI 和测试依赖：

```bash
python3 -m pip install -e '.[dev]'
feature-copilot --help
```

运行时仅依赖 Python 标准库，要求 Python 3.9+。

### 可选 Web 管理页面

Web 页面只展示四个维护 package 的受控特征，不包含 fixture 数据。安装可选依赖后启动：

```bash
python3 -m pip install -e '.[web]'
feature-copilot-web --port 8765
```

服务固定监听 `127.0.0.1`。打开 `http://127.0.0.1:8765/features` 可按特征 Key、特征名、特征大类、业务小类和加工特征组查询；所有已填写条件必须同时匹配。业务小类表达稳定风险语义，加工组保留 SQL 与血缘归属。详情页同时展示两者以及三层上游摘要。页面不提供编辑、刷新事实源或完整 SQL 下载。

## 构建与校验

```bash
scripts/feature-copilot.sh validate --format json
scripts/feature-copilot.sh build-index --format json
scripts/feature-copilot.sh audit-logic --max-depth 20 --format json
```

SQLite 与 manifest 位于 `knowledge/`，是随 Skill 一起发布、可由包内事实源完整重建的索引产物。普通查询默认读取包内 `knowledge/feature_copilot.sqlite`；发布或更新进入索引的事实源后必须执行 `scripts/feature-copilot.sh build-index --format json`，构建会原子替换旧索引。`FEATURE_COPILOT_DB`、`FEATURE_COPILOT_CACHE_DIR` 或 `--db` 仅用于开发环境的显式覆盖；无 FTS5 时自动回退为参数化 `LIKE` 查询。

受控目录内每个特征还维护 `semantic_metadata.alias_zh`：这是基于原始特征名、字段代码和可用本地 SQL 生成的可读中文别名，用于展示与检索，不覆盖快照中的 `featureName` 或 `featureColumnName`。别名随 `managed_feature_semantics_full.json` 进入索引；修改生成规则后，先运行 `PYTHONPATH=src python scripts/generate_full_semantic_snapshot.py`，再重建索引。

`validate` 的 `managed_catalog.taxonomy_audit` 会报告源记录数、唯一特征数、唯一组数、组默认命中、特征覆盖命中及未分类数。任何 taxonomy 校验失败都会保留上一份可读索引。

`audit-logic` 每张物理特征表只选择一个代表特征进行递归检查，返回缺失表及聚合诊断，不返回 SQL 正文。任务 SQL 内有效的 `CREATE TABLE` 和 `INSERT OVERWRITE TABLE` 都视为可读取的内联加工逻辑；注释中的语句不计入。

## 查询示例

```bash
scripts/feature-copilot.sh get fixture_income_avg_30d --format text
scripts/feature-copilot.sh get ftr.off.usr.dwa_risk_tnd_feature_di.tnd_rsk_itm_d7_bnk_sml_lon --format json
scripts/feature-copilot.sh explain-logic ftr.off.usr.dwa_risk_tnd_feature_di.tnd_rsk_itm_d7_bnk_sml_lon --format json
scripts/feature-copilot.sh explain-logic ftr.off.usr.dwa_risk_tnd_feature_di.tnd_rsk_itm_d7_bnk_sml_lon --max-depth 3 --full --format json
scripts/feature-copilot.sh search 示例 30日 --table fixture_customer_wide --format json
scripts/feature-copilot.sh table fixture_customer_wide --format json
scripts/feature-copilot.sh lineage dwa_risk.dwa_risk_tnd_feature_di --direction forward --max-depth 3 --format json
scripts/feature-copilot.sh compare fixture_income_avg_30d fixture_payment_count_30d --format json
scripts/feature-copilot.sh perf --project fixture_project_beta --min-iv 0.1 --format json
scripts/feature-copilot.sh availability fixture_payment_count_30d --scene fixture_credit --population fixture_customer --observation-timing pre_decision --as-of 2026-07-15 --format json
```

所有命令支持 `--format text|json` 和 `--full`。对 `search`、`table`、`perf`，`--full` 会将返回上限提升为 100,000；对 `explain-logic`，默认只返回有界 SQL 摘要和上游节点元数据，只有调用方明确需要完整加工 SQL 时才使用 `--full`。`--full` 不会补齐未下载的 DP 逻辑，仍须以 `status` 和诊断判断完整性。也可使用 `--limit`、`--offset`。退出码：`0` 成功，`2` 校验错误，`3` 未命中，`4` 运行时或索引错误。

## Python API

```python
from pathlib import Path
from feature_copilot import FeatureService

service = FeatureService(Path("/path/to/generated/feature_copilot.sqlite"))
result = service.search(["示例", "30日"], {"category": "transaction"})
service.close()
```

Python API 是低层接口，需要调用方传入已构建的 SQLite；对 Claude Code/Codex 交付时应优先调用 `scripts/feature-copilot.sh`，由入口管理缓存。

## 数据更新与安全

- 运行时只读取四个 `*_all_features.json`、业务分类配置、`goal/_metadata/group_logic/`、`goal/dp_table_logic/` 及 `knowledge/`。表级血缘由组逻辑和 DP 任务快照在构建期生成 `table_lineage_edges`，不维护独立 fixture 血缘 CSV；`standard_warehouse_tables.json` 定义可作为血缘终点的标准数仓 schema。分页 JSON、groups JSON、CSV summary 和 group codes 都是可重建中间件，不应留在交付目录。
- `references/feature-snapshot-fields.md` 和 `references/feature-package-backgrounds.md` 分别维护字段字典与包级背景知识，由 Skill 按问题类型加载；更新这两份文件不需要重建 SQLite。若变更涉及特征值、包范围、分类或逻辑证据，仍须修改对应事实源并执行 `build-index`。
- `goal/_metadata/feature_meta.snapshot.tar.gz` 保留原始补充元数据，不参与查询构建。用 `python3 goal/scripts/manage_assets.py verify` 校验，用 `extract-meta` 恢复为可读 JSON 目录。
- 刷新完成后先运行 `python3 goal/scripts/manage_assets.py compact`。只读校验通过后，再运行 `python3 goal/scripts/manage_assets.py compact --apply` 压缩元数据并清理已证明可重建的中间件。
- `goal/dp_table_logic/` 内的 `.sql` 是 DP 加工逻辑的唯一运行时事实来源；只有文件名与头部 `table_name` 一致的 SQL 会进入索引。
- 真实资产只能经只读导入适配器生成审计报告和拒绝记录；详见 `docs/operations.md`。
- 查询参数必须使用 SQLite 绑定，不将用户输入拼接为 SQL。
- 查询入口不调用外部服务，也不发送原始用户数据。
- `goal/scripts/direct_fetch.py` 与 `goal/scripts/direct_fetch_meta.py` 是人工刷新快照的独立工具，不由 Skill 查询入口调用；访问密钥仅通过 `FEATURE_COPILOT_MCP_API_KEY` 环境变量传入。
- 未命中返回 `NOT_FOUND` 和 `verified=false` 的名称提示，不能生成正式定义。

## 二期预留与当前阻塞

字段级解析状态为 `resolved`、`pass_through`、`located` 或 `unresolved`。后两类不应被表述为已验证公式；应展示证据片段和完整性状态。
