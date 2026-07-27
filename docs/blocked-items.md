# 阻塞事项

四个维护 package 的特征快照、110 份 group_logic 与本地 DP 任务快照现已接入查询索引。当前剩余边界：

- 23,702 个唯一 `featureCode` 中，字段 SQL 定位为 `unresolved` 的记录不能被表述为字段级正式公式，只能返回对应 group SQL；
- `pdm_risk` 递归仅覆盖本地 `goal/dp_table_logic/` 已下载的任务快照，缺失任务、循环和最大深度会返回 `PARTIAL`；
- 历史项目表现、标签定义、观测期、稳定性和指定场景可用性仍只有 fixture，未接入真实业务证据；
- 不连接 DP、MaxCompute 或代码仓；本 Skill 只查询已下载的本地快照。
