import json, os, sys

resp = json.loads(open(sys.argv[1], 'r').read())
d = resp['data']
out = {'page': d['pageNum'], 'total': d['total'], 'featureCount': len(d['list']), 'features': d['list']}
outdir = '/Users/guzijun/Desktop/AI攻坚/feature-copilot/goal/package_1_rh'
os.makedirs(outdir, exist_ok=True)
fname = os.path.join(outdir, 'page_{:04d}.json'.format(d['pageNum']))
with open(fname, 'w', encoding='utf-8') as f:
    json.dump(out, f, ensure_ascii=False)
print('OK page={} count={} total={}'.format(d['pageNum'], len(d['list']), d['total']))
