#!/usr/bin/env python3
"""
拉取特征组 SQL 逻辑 + 特征补充元数据。
直接通过 HTTP 调用 sh_feature MCP 服务器。

用法:
  python3 direct_fetch_meta.py <outputDir>

会从 `goal/package_*/*_all_features.json` 提取 groupCode，然后逐一拉取
`group_logic_version` 和 `list_feature_meta_info`。

需要通过环境变量提供访问密钥：
  FEATURE_COPILOT_MCP_API_KEY=... python3 direct_fetch_meta.py <outputDir>

该脚本仅用于人工刷新原始快照，不属于查询 Skill 的运行时依赖。
"""
import json, os, sys, time, urllib.request

MCP_URL = os.environ.get("FEATURE_COPILOT_MCP_URL", "http://mcp.dmz.prod.caijj.net/mcp/sh_feature")
API_KEY = os.environ.get("FEATURE_COPILOT_MCP_API_KEY", "")


def mcp_call(tool_name: str, arguments: dict) -> dict:
    if not API_KEY:
        raise RuntimeError(
            "缺少 FEATURE_COPILOT_MCP_API_KEY；该刷新脚本需要通过环境变量显式提供访问密钥。"
        )
    payload = {
        "jsonrpc": "2.0",
        "method": "tools/call",
        "params": {"name": tool_name, "arguments": arguments},
        "id": 1,
    }
    req = urllib.request.Request(
        MCP_URL,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "X-CJJ-MCP-API-KEY": API_KEY,
        },
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=30) as resp:
        raw = json.loads(resp.read().decode("utf-8"))
    return json.loads(raw["result"]["content"][0]["text"])


def fetch_group_logic(group_code: str, output_dir: str):
    """拉取单个特征组的 SQL 逻辑"""
    fname = os.path.join(output_dir, f"group_logic_{group_code.replace('.','_').replace('/','_')}.json")
    if os.path.exists(fname):
        print(f"  已存在，跳过")
        return

    try:
        data = mcp_call("group_logic_version", {"groupCode": group_code})
        with open(fname, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        logic_len = len(data.get("data", {}).get("logicContent", ""))
        print(f"  ✓ SQL logic ({logic_len} chars) → {os.path.basename(fname)}")
    except Exception as e:
        print(f"  ✗ 失败: {e}")


def fetch_feature_meta_by_group(group_code: str, output_dir: str):
    """分页拉取单个特征组下的所有特征补充元数据"""
    fname = os.path.join(output_dir, f"feature_meta_{group_code.replace('.','_').replace('/','_')}.json")
    if os.path.exists(fname):
        print(f"  已存在，跳过")
        return

    all_features = []
    page = 1
    while True:
        try:
            data = mcp_call("list_feature_meta_info", {
                "groupCode": group_code,
                "pageNum": page,
                "pageSize": 100,
            })
            features = data.get("data", {}).get("list", [])
            if not features:
                break
            all_features.extend(features)
            total = data.get("data", {}).get("total", 0)
            if len(all_features) >= total:
                break
            page += 1
            time.sleep(0.15)
        except Exception as e:
            print(f"    page {page} 失败: {e}, 继续...")
            page += 1
            time.sleep(1)

    with open(fname, "w", encoding="utf-8") as f:
        json.dump(all_features, f, ensure_ascii=False, indent=2)
    print(f"  ✓ {len(all_features)} features → {os.path.basename(fname)}")


def load_existing_groups(base_dir: str) -> list:
    """从所有 goal/package_*/ 目录的特征总表提取 groupCode 列表。"""
    all_groups = set()
    for pkg_dir in sorted(os.listdir(base_dir)):
        if not pkg_dir.startswith("package_"):
            continue
        pkg_path = os.path.join(base_dir, pkg_dir)
        if not os.path.isdir(pkg_path):
            continue
        # *_groups.json 是可派生中间件，刷新流程不应依赖它。
        for f in os.listdir(pkg_path):
            if f.endswith("_all_features.json") and not f.startswith("_"):
                with open(os.path.join(pkg_path, f)) as fh:
                    features = json.load(fh)
                if not isinstance(features, list):
                    raise ValueError(f"非法特征总表: {os.path.join(pkg_path, f)}")
                all_groups.update(
                    feature["groupCode"]
                    for feature in features
                    if feature.get("groupCode")
                )
                break
    return sorted(all_groups)


if __name__ == "__main__":
    output_dir = sys.argv[1] if len(sys.argv) > 1 else "goal"
    meta_dir = os.path.join(output_dir, "_metadata")
    os.makedirs(meta_dir, exist_ok=True)

    groups = load_existing_groups(output_dir)
    print(f"共 {len(groups)} 个特征组待拉取\n")

    # Phase 1: Group SQL Logic
    print("=== Phase 1: 特征组 SQL 逻辑 (group_logic_version) ===")
    logic_dir = os.path.join(meta_dir, "group_logic")
    os.makedirs(logic_dir, exist_ok=True)
    for gc in groups:
        print(f"  {gc}")
        fetch_group_logic(gc, logic_dir)
        time.sleep(0.1)
    print()

    # Phase 2: Feature enriched metadata
    print("=== Phase 2: 特征补充元数据 (list_feature_meta_info) ===")
    feat_dir = os.path.join(meta_dir, "feature_meta")
    os.makedirs(feat_dir, exist_ok=True)
    for gc in groups:
        print(f"  {gc}")
        fetch_feature_meta_by_group(gc, feat_dir)
        time.sleep(0.1)

    print("\n完成！输出目录:", meta_dir)
