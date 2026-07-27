import re
from typing import List


def normalized(value: str) -> str:
    return (value or "").strip().casefold()


def multi_values(value: str) -> List[str]:
    return [item.strip() for item in (value or "").split("|") if item.strip()]


def name_inference(name: str) -> dict:
    """A deliberately weak hint for a missing feature, never a definition."""
    tokens = [t for t in re.split(r"[_\-\s]+", name.strip()) if t]
    return {
        "verified": False,
        "hint": "名称仅可用于定位待确认资产，不能作为正式定义。",
        "tokens": tokens[:12],
        "suggested_confirmation": ["原始 SQL 或 Python 逻辑", "宽表/字段字典", "负责团队确认"],
    }
