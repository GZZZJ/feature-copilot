#!/usr/bin/env python3
"""Generate summary.json and README.md for pdm_risk_upstream directory."""

import json
import os
import re
from collections import defaultdict

UPSTREAM_DIR = os.path.dirname(os.path.abspath(__file__))
SUMMARY_FILE = os.path.join(UPSTREAM_DIR, 'summary.json')
README_FILE = os.path.join(UPSTREAM_DIR, 'README.md')

PATTERNS = [
    r'create\s+table\s+(?:if\s+not\s+exists\s+)?\$\{([^}]+)\}\.(\w+)',
    r'insert\s+(?:overwrite|into)\s+table\s+\$\{([^}]+)\}\.(\w+)',
    r'create\s+table\s+(?:if\s+not\s+exists\s+)?(\w+)\.(\w+)',
    r'insert\s+(?:overwrite|into)\s+table\s+(\w+)\.(\w+)',
]


def extract_tables(sql: str) -> set:
    """Extract project.table references from SQL."""
    tables = set()
    for pattern in PATTERNS:
        for match in re.findall(pattern, sql, re.IGNORECASE):
            if isinstance(match, tuple) and len(match) == 2:
                project, table = match
                tables.add(f'{project}.{table}')
    return tables


def main():
    summaries = []
    project_counter = defaultdict(int)
    all_upstream_tables = set()

    for filename in sorted(os.listdir(UPSTREAM_DIR)):
        if not filename.endswith('.json') or filename == 'summary.json':
            continue
        filepath = os.path.join(UPSTREAM_DIR, filename)
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
        except Exception as e:
            print(f'Warning: failed to read {filename}: {e}')
            continue

        table_name = filename[:-5]
        node = data.get('data', [{}])[0] if data.get('data') else {}
        task_name = node.get('taskName', '')
        owner_name = node.get('ownerName', '')
        sql = node.get('sql', '')
        upstream_tables = node.get('upstreamTables', [])
        file_size = os.path.getsize(filepath)

        tables_in_sql = extract_tables(sql)

        for upstream in upstream_tables:
            all_upstream_tables.add(upstream)
            parts = upstream.split('.')
            if parts:
                project_counter[parts[0]] += 1

        summaries.append({
            'tableName': table_name,
            'fullName': f'pdm_risk.{table_name}',
            'taskName': task_name,
            'ownerName': owner_name,
            'nodeCount': len(data.get('data', [])),
            'sqlLength': len(sql),
            'fileSize': file_size,
            'upstreamTables': upstream_tables,
            'tablesInSql': sorted(tables_in_sql),
        })

    summary = {
        'totalTables': len(summaries),
        'totalFileSize': sum(s['fileSize'] for s in summaries),
        'projectSpaceDistribution': dict(sorted(project_counter.items(), key=lambda x: -x[1])),
        'uniqueUpstreamTables': sorted(all_upstream_tables),
        'tables': summaries,
    }

    with open(SUMMARY_FILE, 'w', encoding='utf-8') as f:
        json.dump(summary, f, ensure_ascii=False, indent=2)

    # Build README
    lines = [
        '# pdm_risk 上游表建表逻辑汇总',
        '',
        f'- 总表数：{len(summaries)}',
        f'- 总文件大小：{summary["totalFileSize"]:,} bytes',
        '',
        '## 上游项目空间分布',
        '',
        '| 项目空间 | 被依赖次数 |',
        '|----------|------------|',
    ]
    for project, count in sorted(project_counter.items(), key=lambda x: -x[1]):
        lines.append(f'| {project} | {count} |')

    lines.extend([
        '',
        '## 表清单',
        '',
        '| 序号 | 表名 | 任务名 | 文件大小 | 上游表数 |',
        '|------|------|--------|----------|----------|',
    ])
    for idx, s in enumerate(summaries, start=1):
        task_display = s['taskName'] or '-'
        lines.append(
            f'| {idx} | `{s["tableName"]}` | `{task_display}` | {s["fileSize"]:,} | {len(s["upstreamTables"])} |'
        )

    lines.extend([
        '',
        '## 说明',
        '',
        '- 每个 JSON 文件包含对应表的完整 DDL+DML 逻辑（`sql` 字段）及其直接上游表（`upstreamTables`）。',
        '- 若多个表名指向同一 dp-mcp 任务，它们的 JSON 内容相同。',
    ])

    with open(README_FILE, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))

    print(f'Generated {SUMMARY_FILE} and {README_FILE}')
    print(f'Total tables: {len(summaries)}')


if __name__ == '__main__':
    main()
