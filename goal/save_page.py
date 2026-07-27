import json, sys, os

# Read JSON from stdin, write to target path
data = json.loads(sys.stdin.read())
target = sys.argv[1]
os.makedirs(os.path.dirname(target), exist_ok=True)
with open(target, 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False)
print(f"OK: {target}")
