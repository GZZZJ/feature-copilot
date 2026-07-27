import json, os

# Parse the API response from the tool call result
# The API returned 100 features for page 97, total=17257

# Since we already have the API response in context, let's parse it directly
# We'll use a simpler approach: read from stdin

import sys
data = json.load(sys.stdin)
features = data["data"]["list"]
total = data["data"]["total"]

output = {
    "page": 97,
    "total": total,
    "featureCount": len(features),
    "features": features
}

os.makedirs("goal/package_1_rh", exist_ok=True)
with open("goal/package_1_rh/page_0097.json", "w", encoding="utf-8") as f:
    json.dump(output, f, ensure_ascii=False, indent=2)

print(f"Written {len(features)} features, total={total}")
