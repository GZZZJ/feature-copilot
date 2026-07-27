# 一期验收报告

本报告在 2026-07-15 的 Python 3.9.6 本地环境生成。

## 已验收能力

- CSV 数据契约、可维护 fixture、SQLite 原子索引、源 hash 与 FTS5 降级检测；
- `get/search/table/lineage/compare/perf/availability/stats/validate/build-index` 的 Service API 和 CLI；
- 不命中的 `NOT_FOUND`、未验证名称提示与可区分退出码；
- 可审计的 CSV、Markdown、表现和 PBOC 字段适配器；
- 查询 Skill、工作流、50,000 条合成数据性能验证与自动化测试。

## 验证证据

- `PYTHONPATH=src python3 -m pytest -q`：24 passed（含前身 Markdown staging 导入器）。
- 性能实测见 [benchmark-report.md](benchmark-report.md)，所有建议 P95 目标达到。
- 真实业务资产：未导入；所有知识记录均为 fixture。

## 已知边界

- 当前 fixture 不代表任何真实表、字段、模型表现或人行报文语义。
- Legacy Markdown 和 PBOC 导入器只做保守提取，仍需要显式字段映射及人工审核后才可合入知识源。
- 血缘“断链/非可信终点”会输出诊断；空必填端点、循环等错误会阻断构建。
