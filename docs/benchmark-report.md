# 本地性能验证

本报告由 `scripts/benchmark_query.py` 自动生成。数据为 50,000 条 `synthetic_*` 合成记录，非业务资产。

|指标|结果|目标|结论|
|---|---:|---:|---|
|索引构建|10.600 s|—|记录|
|exact P95|140.481 ms|1000 ms|PASS|
|keyword P95|1221.323 ms|3000 ms|PASS|
|multi_filter P95|454.372 ms|5000 ms|PASS|
|lineage P95|0.129 ms|—|PASS|

- SQLite 大小：38928384 bytes
- FTS5：True
- 查询每类重复 30 次，P95 为本机实测。
