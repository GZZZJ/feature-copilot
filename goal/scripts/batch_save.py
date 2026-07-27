#!/usr/bin/env python3
"""Save page data: piped JSON -> page_XXXX.json"""
import json, sys, os

if len(sys.argv) < 3:
    print("Usage: echo '<json>' | python3 batch_save.py <dir> <page_num>")
    sys.exit(1)

outdir = sys.argv[1]
page = int(sys.argv[2])
os.makedirs(outdir, exist_ok=True)

data = json.load(sys.stdin)
# Auto-detect format: either raw MCP response or just the list array
if isinstance(data, dict) and 'data' in data:
    features = data['data'].get('list', [])
    total = data['data'].get('total', 0)
else:
    features = data if isinstance(data, list) else []
    total = len(features)

output = {
    'page': page,
    'total': total,
    'featureCount': len(features),
    'features': features
}

fname = os.path.join(outdir, f'page_{page:04d}.json')
with open(fname, 'w', encoding='utf-8') as f:
    json.dump(output, f, ensure_ascii=False)
print(f'Saved {len(features)} features to {fname}')
