import sys, json, os

target_dir = sys.argv[1]
page_num = int(sys.argv[2])
total = int(sys.argv[3])

data = json.loads(sys.stdin.read())

page_json = {
    "page": page_num,
    "total": total,
    "featureCount": len(data),
    "features": data
}

fname = os.path.join(target_dir, f"page_{page_num:04d}.json")
with open(fname, 'w', encoding='utf-8') as f:
    json.dump(page_json, f, ensure_ascii=False)
print(f"OK: {fname} ({len(data)} features)")
