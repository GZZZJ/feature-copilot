#!/usr/bin/env python3
"""Stage the dz-feature-kb Markdown predecessor without changing active knowledge."""
import argparse
import json
from pathlib import Path

from feature_copilot.importers import import_dz_markdown


def main() -> int:
    parser = argparse.ArgumentParser(description="Stage dz-feature-kb Markdown candidates")
    parser.add_argument("source_root", type=Path)
    parser.add_argument("--output-dir", type=Path, default=Path("build/dz_legacy_staging"))
    args = parser.parse_args()
    report = import_dz_markdown(args.source_root, args.output_dir)
    (args.output_dir / "import-report.json").write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False)); return 0


if __name__ == "__main__": raise SystemExit(main())
