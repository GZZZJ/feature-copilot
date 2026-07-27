import hashlib
import re
from pathlib import Path
from typing import Dict, List, Tuple


def import_legacy_markdown(source: Path) -> Tuple[List[Dict[str, str]], List[Dict[str, str]], Dict[str, object]]:
    """Conservative parser: extracts only explicit Markdown table rows for review.

    It never claims a parsed name is a formal definition; rows are returned for a
    human mapping step and all non-table content remains unparsed.
    """
    text = source.read_text(encoding="utf-8")
    rows, rejects = [], []
    for number, line in enumerate(text.splitlines(), 1):
        if line.startswith("|") and line.count("|") >= 3 and not re.match(r"^\|[- :|]+\|$", line):
            cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
            rows.append({"line": str(number), "cells": cells, "definition_source": "unmapped_markdown"})
    if not rows: rejects.append({"row": "", "reason": "no_explicit_markdown_table_rows", "raw": ""})
    return rows, rejects, {"adapter": "legacy_markdown", "source": str(source), "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(), "read": len(text.splitlines()), "accepted": len(rows), "rejected": len(rejects), "mapping": "table extraction only; requires explicit mapping"}
