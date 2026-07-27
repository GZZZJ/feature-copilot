import json, os, sys
page_num = int(sys.argv[1])
data = json.load(sys.stdin)
d = data['data']
out = {'page': page_num, 'total': d['total'], 'pages': d.get('pages'), 'featureCount': len(d['list']), 'features': d['list']}
os.makedirs('goal/package_2_dzfinal', exist_ok=True)
with open(f'goal/package_2_dzfinal/page_{page_num:04d}.json', 'w') as f:
    json.dump(out, f, ensure_ascii=False)
print(f'OK page {page_num}: {len(d["list"])} features saved')
