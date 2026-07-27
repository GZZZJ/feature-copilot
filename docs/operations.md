# 安装、更新与维护

## 环境

核心运行时只使用 Python 标准库；当前实现兼容 Python 3.9+（当前已验证环境为 3.9.6）。可选开发依赖：`python -m pip install -e '.[dev]'`。只读 Web 管理页使用独立的 `web` extra，不会成为 CLI 或 Skill 的依赖。

## Web 管理页面

```bash
python3 -m pip install -e '.[web]'
feature-copilot-web --port 8765
```

- 服务固定绑定 `127.0.0.1`，首版不支持企业内网暴露或内置鉴权。
- 启动时检查并按需构建索引；若更新失败但旧索引仍可读，页面以降级状态启动并显示旧索引构建时间。
- Web API 均为 GET，只读取受控特征。若要对外开放，必须在独立方案中补充反向代理、身份认证、访问审计与 TLS。
- 列表页的大类/业务小类/加工组来自只读三级分类字典；业务小类使用稳定编码，加工组使用 `group_code`。
- 同一父级下若小类名称、排序或加工组名称不一致，分类接口返回 503 并保留 Key/名称查询能力，避免静默展示错误分类。
- 页面默认展示三层上游 SQL 摘要，不提供完整 SQL；`PARTIAL`、未下载节点和循环诊断必须原样展示。

## 例行流程

1. fixture 查询仅编辑 `knowledge/*.csv`；维护特征与逻辑的事实源是四个 `*_all_features.json`、group_logic 和 dp_table_logic。表级血缘由后两者构建为 `table_lineage_edges`，禁止人工编辑生成的 SQLite 缓存。
2. DP 加工逻辑以 `goal/dp_table_logic/` 的 `.sql` 为唯一运行时来源。若有新的 JSON 下载快照，可临时运行 `python3 scripts/export_dp_logic_sql.py` 转换后再删除 JSON；`logic-unavailable` 表示该快照没有 SQL，不得补造。SQL 文件名必须与头部 `table_name` 一致；不一致的文件不会被索引，需按目标表重新拉取。
3. 执行 `scripts/feature-copilot.sh validate --format json`。检查 `managed_catalog.taxonomy_audit`：唯一组数、分类特征数、覆盖项数和未分类数应符合本次维护范围；当前基线为 88 组、23,702 个唯一特征、未分类 0。
4. 新增或调整维护 package 时，先在 `knowledge/config/maintenance_scope.json` 为其设置 `business_stage`（当前支持 `pre_loan`、`in_loan`），再由 `PYTHONPATH=src python3 scripts/generate_full_semantic_snapshot.py` 确定性生成全量中文语义快照；随后运行 `scripts/feature-copilot.sh validate --format json` 和完整测试。快照中的 `rule_inferred` 只用于导航召回，不得升级为正式定义或逻辑证据。历史逾期专题审查工具 `manage_semantic_tags.py` 仅维护 v1 归档，不作为全量 v2 快照的发布门禁。
5. 为构建 shadow 索引、跑离线评测，可以在语义 `audit` 尚未通过时执行 `scripts/feature-copilot.sh build-index --format json`；这只表示配置结构可构建，不表示标签已通过发布审查。正式索引仍需在第 4 步通过后重建并原子替换。不预热时会在首次查询自动构建。
6. 对 shadow 索引运行 `PYTHONPATH=src python3 scripts/evaluate_semantic_search.py --database <sqlite> --backend service --format json`。只有 `release_gate.passed=true` 且命令退出 0，才能把标签检索升级为 Skill 默认建议；否则必须保留为 shadow/补充检索并记录未达标类别。
7. 运行 `PYTHONPATH=src python3 -m pytest -q`，并抽检 PDM、DWA 特征的 `explain-logic` 三层上游 JSON。
8. 提交维护范围配置、语义配置及审查归档、表级 SQL、文档，以及 `knowledge/feature_copilot.sqlite` 和 `knowledge/feature_copilot.manifest.json`。发布前必须运行 `scripts/feature-copilot.sh build-index --format json`，二者是随 Skill 交付、可由事实源完整重建的索引产物。
9. 若本次刷新产生了分页、groups、summary 或 feature_meta 目录，先运行 `python3 goal/scripts/manage_assets.py compact`，确认等价校验通过后再加 `--apply`。

## 导入

导入器只读源文件，输出 `build/import-report.json` 和 `build/import-rejects.csv`，不会自动写入正式知识：

```bash
PYTHONPATH=src python3 scripts/import_legacy.py feature_csv /readonly/features.csv
PYTHONPATH=src python3 scripts/import_legacy.py performance_csv /readonly/performance.csv
PYTHONPATH=src python3 scripts/import_legacy.py legacy_markdown /readonly/dictionary.md
PYTHONPATH=src python3 scripts/import_legacy.py pboc_assets /readonly/pboc_dictionary.csv
```

人工审核映射及冲突后，才可把合法记录合入 `knowledge/`。`manual_confirmed` 冲突不会被导入器静默覆盖。

### 前身 Markdown 知识库

前身 `dz-feature-kb` 只能作为只读来源。使用专用导入器把显式字典、宽表、上游和命名规则写入隔离 staging，不会改动正式知识或前身目录：

```bash
PYTHONPATH=src python3 scripts/import_dz_legacy.py /Users/guzijun/Desktop/AI攻坚/dz-feature-kb/ai-skills-decision-science/dz-feature-kb
```

输出位于 `build/dz_legacy_staging/`，包含候选 CSV、拒绝记录与 `import-report.json`。对账口径见 [predecessor-reconciliation.md](predecessor-reconciliation.md)。

## 故障处理

- 包内 SQLite 缺失或过期：在发布工作区运行 `scripts/feature-copilot.sh build-index --format json` 后重新上传完整 Skill 包；线上运行时不回退到用户缓存或临时目录。
- `VALIDATION_ERROR`：修复 CSV/逻辑引用；旧 SQLite 会被保留。
- taxonomy 校验错误：核对 `managed_feature_taxonomy.json` 的稳定编码、唯一排序、88 组默认映射及 override 的特征 Key/原因；不得通过增加兜底“其他”绕过缺失映射。
- `NOT_FOUND`：不是定义缺失的证明；按结果中的建议找原始逻辑、字典或负责人。
- FTS5 不可用：构建报告会标识 `fts5=false`，搜索自动回退参数化 `LIKE`。
- 刷新原始快照：`goal/scripts/direct_fetch.py`、`goal/scripts/direct_fetch_meta.py` 不由查询流程调用，需显式配置 `FEATURE_COPILOT_MCP_API_KEY`；密钥不能写入源码、文档或生成物。`direct_fetch_meta.py` 直接从特征总表提取 groupCode，不依赖 groups 中间件。
