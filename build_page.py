#!/usr/bin/env python3
"""Build page output from MCP response JSON file."""
import json, os, sys

resp_file = sys.argv[1]
with open(resp_file) as f:
    raw = json.load(f)

d = raw['data']
page_num = d['pageNum']
out = {'page': page_num, 'total': d['total'], 'featureCount': len(d['list']), 'features': d['list']}
os.makedirs('goal/package_1_rh', exist_ok=True)
outfile = f'goal/package_1_rh/page_{page_num:04d}.json'
with open(outfile, 'w') as f:
    json.dump(out, f, ensure_ascii=False)
print(f'Saved {len(d["list"])} features to {outfile}')
