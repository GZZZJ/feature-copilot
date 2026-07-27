#!/usr/bin/env python3
"""Read-only import runner. It reports mappings/rejects; it does not overwrite knowledge."""
import argparse
import csv
import json
from pathlib import Path

from feature_copilot.importers import import_feature_csv, import_legacy_markdown, import_performance_csv, import_pboc_assets
from feature_copilot.validators import load_csv


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("adapter", choices=("feature_csv", "performance_csv", "legacy_markdown", "pboc_assets"))
    parser.add_argument("source", type=Path)
    parser.add_argument("--knowledge-dir", type=Path, default=Path("knowledge"))
    parser.add_argument("--output-dir", type=Path, default=Path("build"))
    args = parser.parse_args()
    if args.adapter == "feature_csv": result = import_feature_csv(args.source, load_csv(args.knowledge_dir / "features.csv"))
    elif args.adapter == "performance_csv": result = import_performance_csv(args.source)
    elif args.adapter == "legacy_markdown": result = import_legacy_markdown(args.source)
    else: result = import_pboc_assets(args.source)
    accepted, rejects, report = result
    args.output_dir.mkdir(parents=True, exist_ok=True)
    (args.output_dir / "import-report.json").write_text(json.dumps({**report, "accepted_preview": accepted[:10]}, ensure_ascii=False, indent=2), encoding="utf-8")
    with (args.output_dir / "import-rejects.csv").open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=("row", "reason", "raw")); writer.writeheader(); writer.writerows(rejects)
    print(json.dumps(report, ensure_ascii=False)); return 0


if __name__ == "__main__": raise SystemExit(main())
