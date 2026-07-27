import json
from typing import Any


def render(data: Any, output_format: str) -> str:
    if output_format == "json":
        return json.dumps(data, ensure_ascii=False, indent=2, default=str)
    if isinstance(data, dict):
        if "edges" in data and "nodes" in data and "table_name" in data:
            lines = ["status: " + str(data.get("status", "OK")), "table: " + str(data["table_name"]), "direction: " + str(data.get("direction", "")), "tree:"]
            for edge in data["edges"]:
                lines.append("  " + edge["downstream_table"] + " <- " + edge["upstream_table"] + " (" + edge["source_type"] + ")")
            if data.get("standard_warehouse_terminals"): lines.append("standard_warehouse_terminals: " + json.dumps(data["standard_warehouse_terminals"], ensure_ascii=False))
            if data.get("diagnostics"): lines.append("diagnostics: " + json.dumps(data["diagnostics"], ensure_ascii=False))
            return "\n".join(lines)
        status = data.get("status", "OK")
        lines = ["status: " + str(status)]
        for key, value in data.items():
            if key == "status": continue
            if isinstance(value, (dict, list)):
                lines.append(key + ": " + json.dumps(value, ensure_ascii=False, default=str))
            else: lines.append(key + ": " + str(value))
        return "\n".join(lines)
    return str(data)
