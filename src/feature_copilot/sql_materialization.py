"""Deterministically locate table materialization statements in retained SQL."""

import re
from typing import Any, Dict, List


_IDENTIFIER = r"(?:`[^`]+`|\$\{[^}\r\n]+\}|[A-Za-z_][A-Za-z0-9_$]*)"
_TABLE_NAME = _IDENTIFIER + r"(?:\s*\.\s*" + _IDENTIFIER + r"){0,2}"
_MATERIALIZATION = re.compile(
    r"(?im)^[ \t]*(?P<statement>"
    r"create[ \t]+(?:(?:external|temporary)[ \t]+)?table"
    r"(?:[ \t]+if[ \t]+not[ \t]+exists)?"
    r"|insert[ \t]+overwrite[ \t]+table"
    r")[ \t]+(?P<table>" + _TABLE_NAME + r")(?![A-Za-z0-9_$])"
)


def _mask_comments(sql: str) -> str:
    """Replace SQL comments with spaces while preserving offsets and line numbers."""
    result = list(sql)
    index = 0
    quote = ""
    block_comment = False
    while index < len(sql):
        current = sql[index]
        following = sql[index + 1] if index + 1 < len(sql) else ""
        if block_comment:
            if current == "*" and following == "/":
                result[index] = result[index + 1] = " "
                block_comment = False
                index += 2
                continue
            if current not in "\r\n":
                result[index] = " "
            index += 1
            continue
        if quote:
            if current == quote:
                if following == quote and quote in {"'", '"'}:
                    index += 2
                    continue
                quote = ""
            index += 1
            continue
        if current in {"'", '"', "`"}:
            quote = current
            index += 1
            continue
        if current == "-" and following == "-":
            while index < len(sql) and sql[index] not in "\r\n":
                result[index] = " "
                index += 1
            continue
        if current == "/" and following == "*":
            result[index] = result[index + 1] = " "
            block_comment = True
            index += 2
            continue
        index += 1
    return "".join(result)


def _normalize_identifier(value: str) -> str:
    parts = []
    for part in re.split(r"\s*\.\s*", value.strip()):
        cleaned = part.strip()
        if len(cleaned) >= 2 and cleaned[0] == cleaned[-1] == "`":
            cleaned = cleaned[1:-1]
        parts.append(cleaned.lower())
    return ".".join(parts)


def find_materializations(sql: str) -> List[Dict[str, Any]]:
    """Return executable CREATE/INSERT table writes in source order."""
    masked = _mask_comments(sql)
    found: List[Dict[str, Any]] = []
    for match in _MATERIALIZATION.finditer(masked):
        table_name = _normalize_identifier(match.group("table"))
        statement = match.group("statement").lower()
        found.append({
            "type": "create_table" if statement.startswith("create") else "insert_overwrite",
            "table_name": table_name,
            "short_table_name": table_name.rsplit(".", 1)[-1],
            "schema_variable": any(part.startswith("${") for part in table_name.split(".")[:-1]),
            "line_start": sql.count("\n", 0, match.start()) + 1,
            "offset_start": match.start(),
        })
    return found
