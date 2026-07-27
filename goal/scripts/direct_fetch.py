#!/usr/bin/env python3
"""
直接通过 HTTP 调用 sh_feature MCP 服务器拉取特征包元数据。
0 Claude token 消耗。该脚本仅用于人工刷新原始快照，不属于查询 Skill 的运行时依赖。

用法:
  FEATURE_COPILOT_MCP_API_KEY=... python3 direct_fetch.py <packageCode> <outputDir> [--start N] [--end M]

示例:
  FEATURE_COPILOT_MCP_API_KEY=... python3 direct_fetch.py <维护中的packageCode> <outputDir>
"""
import json, os, sys, time, argparse
import urllib.request

MCP_URL = os.environ.get("FEATURE_COPILOT_MCP_URL", "http://mcp.dmz.prod.caijj.net/mcp/sh_feature")
API_KEY = os.environ.get("FEATURE_COPILOT_MCP_API_KEY", "")


def mcp_call(tool_name: str, arguments: dict) -> dict:
    """直接调用 MCP HTTP 端点"""
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
    # MCP wraps the actual response in result.content[0].text
    inner = json.loads(raw["result"]["content"][0]["text"])
    return inner


def fetch_package(package_code: str, output_dir: str, start_page: int = 1, end_page: int = None):
    """拉取特征包的全部页面并保存到磁盘"""
    os.makedirs(output_dir, exist_ok=True)

    # 第一页：获取 total 确定总页数
    print(f"正在拉取 {package_code}...")
    first = mcp_call("query_feature_package", {
        "packageCode": package_code,
        "pageNum": start_page,
        "pageSize": 100,
    })
    total = first["data"]["total"]
    total_pages = first["data"]["pages"]
    if end_page is None:
        end_page = total_pages

    print(f"  总特征数: {total}, 总页数: {total_pages}, 拉取范围: {start_page}-{end_page}")

    # 保存第一页
    _save_page(first, start_page, output_dir, total)

    success_count = 1
    fail_count = 0
    last_report = time.time()

    # 拉取剩余页面
    for page in range(start_page + 1, end_page + 1):
        try:
            data = mcp_call("query_feature_package", {
                "packageCode": package_code,
                "pageNum": page,
                "pageSize": 100,
            })
            _save_page(data, page, output_dir, total)
            success_count += 1
        except Exception as e:
            print(f"  ✗ 第 {page} 页失败: {e}")
            fail_count += 1
            time.sleep(2)  # 失败后稍等再继续

        # 每 30 秒报告进度
        if time.time() - last_report > 30:
            pct = (page - start_page + 1) / (end_page - start_page + 1) * 100
            print(f"  进度: {page}/{end_page} ({pct:.0f}%), 成功 {success_count}, 失败 {fail_count}")
            last_report = time.time()

        # 小延迟避免打爆服务器
        time.sleep(0.1)

    print(f"  完成: {success_count} 页成功, {fail_count} 页失败")
    return success_count, fail_count


def _save_page(response: dict, page: int, output_dir: str, total: int):
    """保存单页数据"""
    features = response["data"]["list"]
    out = {
        "page": page,
        "total": total,
        "featureCount": len(features),
        "features": features,
    }
    fname = os.path.join(output_dir, f"page_{page:04d}.json")
    with open(fname, "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="直接拉取特征包元数据")
    parser.add_argument("packageCode", help="特征包代码")
    parser.add_argument("outputDir", help="输出目录")
    parser.add_argument("--start", type=int, default=1, help="起始页 (默认 1)")
    parser.add_argument("--end", type=int, default=None, help="结束页 (默认全部)")
    args = parser.parse_args()

    t0 = time.time()
    ok, bad = fetch_package(args.packageCode, args.outputDir, args.start, args.end)
    elapsed = time.time() - t0
    print(f"\n总耗时: {elapsed:.0f}s, 成功 {ok}, 失败 {bad}")
