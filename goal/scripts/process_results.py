#!/usr/bin/env python3
"""
Post-process workflow results: save feature data to local directories.
Reads workflow JSON output and produces organized files.
"""
import json, csv, os, sys
from collections import defaultdict

OUTPUT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def process_package(pkg_data, pkg_name, output_subdir):
    """Process a package's feature data and save to files."""
    out_dir = os.path.join(OUTPUT_DIR, output_subdir)
    os.makedirs(out_dir, exist_ok=True)

    features = pkg_data.get('features', [])
    groups = pkg_data.get('groups', {})

    if not features:
        print(f"No features found for {pkg_name}")
        return

    # Save all features JSON
    all_path = os.path.join(out_dir, f"{pkg_name}_all_features.json")
    with open(all_path, 'w', encoding='utf-8') as f:
        json.dump(features, f, ensure_ascii=False, indent=2)
    print(f"[{pkg_name}] Saved {len(features)} features to {all_path}")

    # Save CSV summary
    csv_path = os.path.join(out_dir, f"{pkg_name}_summary.csv")
    with open(csv_path, 'w', newline='', encoding='utf-8-sig') as f:
        writer = csv.writer(f)
        writer.writerow(['featureCode', 'featureName', 'featureColumnName',
                        'groupCode', 'groupName', 'domainCode',
                        'includeTodayFlag', 'timeRange'])
        for feat in features:
            writer.writerow([feat.get(k, '') for k in [
                'featureCode', 'featureName', 'featureColumnName',
                'groupCode', 'groupName', 'domainCode',
                'includeTodayFlag', 'timeRange'
            ]])
    print(f"[{pkg_name}] Saved CSV to {csv_path}")

    # Save groups JSON
    group_path = os.path.join(out_dir, f"{pkg_name}_groups.json")
    with open(group_path, 'w', encoding='utf-8') as f:
        json.dump(groups, f, ensure_ascii=False, indent=2)
    print(f"[{pkg_name}] Saved {len(groups)} groups to {group_path}")

    # Save group codes list
    codes_path = os.path.join(out_dir, f"{pkg_name}_group_codes.txt")
    with open(codes_path, 'w') as f:
        for gc in sorted(groups.keys()):
            f.write(f"{gc}\n")
    print(f"[{pkg_name}] Saved group codes to {codes_path}")

    return features, groups

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: process_results.py <results.json>")
        sys.exit(1)

    with open(sys.argv[1], 'r') as f:
        data = json.load(f)

    # Handle workflow output format
    pkg1_data = data.get('pkg1', {})
    pkg2_data = data.get('pkg2', {})

    if pkg1_data:
        process_package(pkg1_data, 'package_1_rh', 'package_1_rh')
    if pkg2_data:
        process_package(pkg2_data, 'package_2_dzfinal', 'package_2_dzfinal')

    print("\nDone! Check output directories:")
    print(f"  {os.path.join(OUTPUT_DIR, 'package_1_rh')}")
    print(f"  {os.path.join(OUTPUT_DIR, 'package_2_dzfinal')}")
