import json, os, sys

# Save pages with features data
# This script saves pages 40, 41, 42 with their full feature lists
# Each page's data comes from the MCP response

os.makedirs('goal/package_2_dzfinal', exist_ok=True)

# Read page data from stdin as JSON array of pages
data = json.load(sys.stdin)
for pg in data:
    page_num = pg['page']
    fname = f'goal/package_2_dzfinal/page_{page_num:04d}.json'
    with open(fname, 'w') as f:
        json.dump(pg, f, ensure_ascii=False)
    print(f'OK page {page_num}: {len(pg["features"])} features saved')
