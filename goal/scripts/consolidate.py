#!/usr/bin/env python3
"""
Consolidate feature data from MCP query_feature_package results.

Reads individual page JSON files and produces:
1. {name}_all_features.json - flat list of all features
2. {name}_groups.json - groupCode -> {groupName, featureCount, featureCodes}
3. {name}_summary.csv - feature summary CSV
"""
import json, csv, os, sys
from collections import defaultdict

def consolidate(package_dir: str, output_name: str):
    all_features = []
    groups = defaultdict(lambda: {'groupName': '', 'featureCodes': [], 'domainCode': ''})

    page_files = sorted([
        f for f in os.listdir(package_dir)
        if f.startswith('page_') and f.endswith('.json')
    ])

    if not page_files:
        print(f"No page files found in {package_dir}")
        return None, None

    print(f"Processing {len(page_files)} page files...")

    for fname in page_files:
        filepath = os.path.join(package_dir, fname)
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            # Support both raw MCP response format and our page file format
            if 'data' in data:
                features = data.get('data', {}).get('list', [])
            elif 'features' in data:
                features = data['features']
            else:
                features = []
            for feat in features:
                all_features.append(feat)
                gc = feat['groupCode']
                groups[gc]['groupName'] = feat.get('groupName', '')
                groups[gc]['domainCode'] = feat.get('domainCode', '')
                groups[gc]['featureCodes'].append(feat['featureCode'])
        except Exception as e:
            print(f"  Error reading {fname}: {e}")

    # Save full feature list
    full_path = os.path.join(package_dir, f"{output_name}_all_features.json")
    with open(full_path, 'w', encoding='utf-8') as f:
        json.dump(all_features, f, ensure_ascii=False, indent=2)
    print(f"Saved {len(all_features)} features to {full_path}")

    # Save group summary
    group_summary = {
        gc: {
            'groupName': info['groupName'],
            'domainCode': info['domainCode'],
            'featureCount': len(info['featureCodes']),
            'featureCodes': info['featureCodes'],
        }
        for gc, info in groups.items()
    }
    group_path = os.path.join(package_dir, f"{output_name}_groups.json")
    with open(group_path, 'w', encoding='utf-8') as f:
        json.dump(group_summary, f, ensure_ascii=False, indent=2)
    print(f"Saved {len(group_summary)} groups to {group_path}")

    # Save CSV summary
    csv_path = os.path.join(package_dir, f"{output_name}_summary.csv")
    with open(csv_path, 'w', newline='', encoding='utf-8-sig') as f:
        writer = csv.writer(f)
        writer.writerow([
            'featureCode', 'featureName', 'featureColumnName',
            'groupCode', 'groupName', 'domainCode',
            'includeTodayFlag', 'timeRange'
        ])
        for feat in all_features:
            writer.writerow([
                feat.get('featureCode', ''),
                feat.get('featureName', ''),
                feat.get('featureColumnName', ''),
                feat.get('groupCode', ''),
                feat.get('groupName', ''),
                feat.get('domainCode', ''),
                feat.get('includeTodayFlag', ''),
                feat.get('timeRange', ''),
            ])
    print(f"Saved CSV to {csv_path}")

    # Save group codes list
    codes_path = os.path.join(package_dir, f"{output_name}_group_codes.txt")
    with open(codes_path, 'w') as f:
        for gc in sorted(groups.keys()):
            f.write(f"{gc}\n")
    print(f"Saved {len(groups)} group codes to {codes_path}")

    return all_features, groups

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: consolidate.py <package_dir> <output_name>")
        sys.exit(1)
    consolidate(sys.argv[1], sys.argv[2])
