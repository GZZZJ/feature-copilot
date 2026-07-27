#!/usr/bin/env sh
# 在任意工作目录调用当前 Skill 的本地查询入口。
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SKILL_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
PYTHON_BIN=${FEATURE_COPILOT_PYTHON:-python3}

export PYTHONPATH="$SKILL_ROOT/src${PYTHONPATH:+:$PYTHONPATH}"
exec "$PYTHON_BIN" -m feature_copilot "$@"
