#!/bin/bash
# Helper: save JSON page data to a file
# Usage: echo '{"code":10000,...}' | sh fetch_and_save.sh <output_dir> <page_num>
OUTDIR="$1"
PAGE="$2"
python3 -c "
import json, sys, os
data = json.load(sys.stdin)
features = data.get('data', {}).get('list', [])
out = {'page': $PAGE, 'total': data.get('data',{}).get('total',0), 'features': features}
os.makedirs('$OUTDIR', exist_ok=True)
fname = f'$OUTDIR/page_{$PAGE:04d}.json'
with open(fname, 'w') as f:
    json.dump(out, f, ensure_ascii=False)
print(f'Saved {len(features)} features to {fname}')
"
