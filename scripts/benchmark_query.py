#!/usr/bin/env python3
"""Generate non-business synthetic data and measure local query paths."""
import csv
import shutil
import statistics
import tempfile
import time
from pathlib import Path

from feature_copilot.index_builder import build_index
from feature_copilot.models import FEATURE_COLUMNS
from feature_copilot.service import FeatureService

ROOT = Path(__file__).resolve().parents[1]


def p95(values):
    ordered = sorted(values)
    return ordered[max(0, int((len(ordered) - 1) * 0.95))]


def timed(callable_, repeats=30):
    values = []
    for _ in range(repeats):
        start = time.perf_counter(); callable_(); values.append(time.perf_counter() - start)
    return {"p50_ms": round(statistics.median(values) * 1000, 3), "p95_ms": round(p95(values) * 1000, 3)}


def main():
    with tempfile.TemporaryDirectory(prefix="feature_copilot_benchmark_") as directory:
        root = Path(directory); knowledge = root / "knowledge"; shutil.copytree(ROOT / "knowledge", knowledge)
        base = next(csv.DictReader((ROOT / "knowledge" / "features.csv").open(encoding="utf-8")))
        with (knowledge / "features.csv").open("a", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(handle, fieldnames=FEATURE_COLUMNS)
            for index in range(50000):
                row = dict(base); row.update({"feature_id": "synthetic_%05d" % index, "feature_name": "synthetic_metric_%05d_30d" % index, "cn_meaning": "合成性能测试指标 %05d" % index, "technical_definition": "仅性能验证的合成记录", "category": "synthetic_a" if index % 2 else "synthetic_b", "status": "active", "version": "1.0.0", "definition_source": "sql", "definition_confidence": "verified"})
                writer.writerow(row)
        database = root / "feature_copilot.sqlite"; started = time.perf_counter(); report = build_index(knowledge, database, ROOT); build_seconds = time.perf_counter() - started
        service = FeatureService(database)
        try:
            service.get("synthetic_metric_49999_30d")
            outcomes = {"exact": timed(lambda: service.get("synthetic_metric_49999_30d")), "keyword": timed(lambda: service.search(["synthetic", "30d"])), "multi_filter": timed(lambda: service.search(["synthetic"], {"category": "synthetic_a", "table": "fixture_customer_wide", "status": "active"}))}
        finally:
            service.close()
        limits = {"exact": 1000, "keyword": 3000, "multi_filter": 5000}
        lines = ["# 本地性能验证", "", "本报告由 `scripts/benchmark_query.py` 自动生成。数据为 50,000 条 `synthetic_*` 合成记录，非业务资产。", "", "|指标|结果|目标|结论|", "|---|---:|---:|---|"]
        lines.append("|索引构建|%.3f s|—|记录|" % build_seconds)
        for name, result in outcomes.items():
            target = limits.get(name); conclusion = "PASS" if target is None or result["p95_ms"] < target else "NOT_MET"
            lines.append("|%s P95|%s ms|%s|%s|" % (name, result["p95_ms"], ("%s ms" % target) if target else "—", conclusion))
        lines.extend(["", "- SQLite 大小：%d bytes" % database.stat().st_size, "- FTS5：%s" % report["fts5"], "- 查询每类重复 30 次，P95 为本机实测。"])
        (ROOT / "docs" / "benchmark-report.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
        print("\n".join(lines))


if __name__ == "__main__": main()
