#!/usr/bin/env python3
"""
Generate group_logic_version request batches for all unique feature groups.

Reads group codes from {package_dir}/{output_name}_all_features.json,
calls mcp__sh_feature__group_logic_version for each group.

Since MCP calls must be made from the AI conversation, this script
generates a batch call list for the AI to process.
"""
import argparse
import json
import os

def gen_batch_requests(package_dir: str, output_name: str, batch_size: int = 16):
    """Derive group codes from the feature total and generate request batches."""
    feature_file = os.path.join(package_dir, f"{output_name}_all_features.json")
    if not os.path.exists(feature_file):
        raise FileNotFoundError(f"Feature total not found: {feature_file}")

    with open(feature_file, encoding="utf-8") as handle:
        features = json.load(handle)
    if not isinstance(features, list):
        raise ValueError(f"Feature total is not a JSON array: {feature_file}")
    group_codes = sorted({feature["groupCode"] for feature in features if feature.get("groupCode")})

    batches = []
    for i in range(0, len(group_codes), batch_size):
        batches.append(group_codes[i:i+batch_size])

    print(f"Total groups: {len(group_codes)}")
    print(f"Batches: {len(batches)} (batch size: {batch_size})")

    return batches

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("package_dir")
    parser.add_argument("output_name")
    parser.add_argument("--batch-size", type=int, default=16)
    parser.add_argument("--output", help="可选输出文件；默认只写标准输出")
    args = parser.parse_args()
    result = gen_batch_requests(args.package_dir, args.output_name, args.batch_size)
    payload = json.dumps(result, ensure_ascii=False, indent=2)
    if args.output:
        with open(args.output, "w", encoding="utf-8") as handle:
            handle.write(payload + "\n")
    else:
        print(payload)
