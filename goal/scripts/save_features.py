#!/usr/bin/env python3
"""Save feature package query results to structured files."""
import json, sys, os
from collections import defaultdict

def save_page(data, package_dir, page_num):
    """Save a single page of feature data to JSON."""
    os.makedirs(package_dir, exist_ok=True)
    filepath = os.path.join(package_dir, f"page_{page_num:04d}.json")
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    return filepath

def consolidate(package_dir, output_name):
    """Read all page files and produce consolidated outputs."""
    all_features = []
    groups = defaultdict(list)

    for fname in sorted(os.listdir(package_dir)):
        if not fname.startswith('page_') or not fname.endswith('.json'):
            continue
        with open(os.path.join(package_dir, fname), 'r') as f:
            data = json.load(f)
        features = data.get('data', {}).get('list', [])
        for feat in features:
            all_features.append(feat)
            groups[feat['groupCode']].append(feat['featureCode'])

    # Save full feature list
    full_path = os.path.join(package_dir, f"{output_name}_all_features.json")
    with open(full_path, 'w', encoding='utf-8') as f:
        json.dump(all_features, f, ensure_ascii=False, indent=2)
    print(f"Saved {len(all_features)} features to {full_path}")

    # Save group summary
    group_summary = {
        group_code: {
            'groupName': next((f['groupName'] for f in all_features if f['groupCode'] == group_code), ''),
            'featureCount': len(features),
            'featureCodes': features
        }
        for group_code, features in groups.items()
    }
    group_path = os.path.join(package_dir, f"{output_name}_groups.json")
    with open(group_path, 'w', encoding='utf-8') as f:
        json.dump(group_summary, f, ensure_ascii=False, indent=2)
    print(f"Saved {len(group_summary)} groups to {group_path}")

    # Save unique group codes list
    codes_path = os.path.join(package_dir, f"{output_name}_group_codes.txt")
    with open(codes_path, 'w') as f:
        for gc in sorted(groups.keys()):
            f.write(f"{gc}\n")
    print(f"Saved {len(groups)} group codes to {codes_path}")

    return groups

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: save_features.py <command> [args...]")
        print("  save <package_dir> <page_num> < json_data")
        print("  consolidate <package_dir> <output_name>")
        sys.exit(1)

    cmd = sys.argv[1]
    if cmd == 'save':
        pkg_dir = sys.argv[2]
        page = int(sys.argv[3])
        data = json.load(sys.stdin)
        fpath = save_page(data, pkg_dir, page)
        print(f"Saved page {page} to {fpath}")
    elif cmd == 'consolidate':
        pkg_dir = sys.argv[2]
        out_name = sys.argv[3]
        consolidate(pkg_dir, out_name)
