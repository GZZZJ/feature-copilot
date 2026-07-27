# 架构

采用“特征/组逻辑 JSON + 表级 SQL + 规范化 SQLite 运行时索引 + 确定性查询”架构。原有 CSV fixture 仅保留兼容查询。

```text
goal/package_{3,4,5,7}_*/ + managed_feature_taxonomy.json + group_logic/ + dp_table_logic/*.sql（只读事实源）
        │ scope / validate / normalize
        ▼
index_builder.py ──原子替换──> knowledge/feature_copilot.sqlite（随 Skill 发布的生成物）
        │                              │
        ├─ manifest（源 hash、构建时间、FTS 能力） │
        ▼                              ▼
importers                         Service API / CLI JSON
                                       ├─ SKILL.md（仅编排）
                                       └─ 可选 Web 插件（Flask API + 原生前端）
```

关键决策：

- `knowledge/config/maintenance_scope.json` 定义唯一维护范围：package_3_br、package_4_nuggets、package_5_04tnd、package_7_02inner。前身候选数据不进入构建。
- `managed_feature_taxonomy.json` 将稳定业务小类与加工组解耦。加载器先应用特征级覆盖，再继承组默认；任一当前特征未分类即拒绝构建。
- 受控特征/组逻辑 JSON、表级 SQL 和 SQLite 都不允许人工编辑；SQLite 是 Skill 包内、可由事实源完整重建的查询镜像。
- 发布包必须包含与事实源匹配的 SQLite 和 manifest。查询入口不会写入用户缓存或临时目录；包内索引缺失或过期时明确报错，由发布者在包内重建。
- 构建先校验，临时库完整构建成功后才原子替换现有索引，失败不会覆盖上一版。
- SQLite FTS5 可用时用于全文候选召回；不可用时降级为参数化 `LIKE`，功能不变。
- 查询层不从名称推导正式定义。未命中返回 `NOT_FOUND` 和受限、未验证的 `inferred_from_name`。
- 表级血缘是从特征组 SQL 与 DP 任务快照构建的 `table_lineage_edges` 边表，支持正反向递归、循环、未解析终点、数仓标准表终点和最大深度提示；默认回溯三层。
- `explain-logic` 始终以 group_logic 回答当前字段加工；默认以直接读取表为第 1 层，展开至第 3 层，并仅返回有界 SQL 摘要。只有显式 `--full` 才返回已下载节点的完整 SQL；外部表或文件名与 `table_name` 不一致的 SQL 会明确返回 `not_downloaded`，不会伪造血缘。
- Web 管理页面是单向依赖 Service API 的可选适配层。基础包、CLI 与 Skill 不导入 Web 包；未安装 `web` extra 时查询能力不受影响。
- Web 只展示 `managed_features`，列表按 `feature_code` 稳定分页；特征大类、业务小类和加工组分别精确过滤，Key 与名称做包含匹配，所有条件按 AND 组合。
- Web 通过只读分类字典提供“大类 → 业务小类 → 加工特征组”级联。跨语义组可出现在多个小类节点，每个节点计数只覆盖该小类下的唯一特征。
- 旧 `feature_subcategory` 参数在兼容期内仍按 `group_code` 过滤；新页面只生成 `business_subcategory` 和 `feature_group`。
- Web 只监听 `127.0.0.1`，不提供写接口或完整 SQL。详情中的 `PARTIAL` 是有效查询结果，必须同时展示缺失节点和诊断。
