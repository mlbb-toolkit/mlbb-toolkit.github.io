import json
import sys
import os
from google_play_scraper import app, reviews, Sort
from datetime import datetime

def convert_datetime(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError(f"Type {type(obj)} not serializable")

# --------------------------------------
# Output path (CLI arg or default)
# --------------------------------------
output_path = sys.argv[1] if len(sys.argv) > 1 else "assets/app.json"

# Ensure directory exists
os.makedirs(os.path.dirname(output_path), exist_ok=True)

# --------------------------------------
# Fetch app data
# --------------------------------------
app_data = app(
    "com.elfilibustero.toolkit",
    lang="en",
    country="us"
)

app_details = {
    "title": app_data.get("title"),
    "description": app_data.get("description"),
    "version": app_data.get("version"),
    "score": app_data.get("score"),
    "realInstalls": app_data.get("realInstalls"),
    "installs": app_data.get("installs"),
    "released": app_data.get("released"),
    "lastUpdatedOn": app_data.get("lastUpdatedOn")
}

# --------------------------------------
# Fetch reviews
# --------------------------------------
reviews_data, _ = reviews(
    "com.elfilibustero.toolkit",
    lang="en",
    country="us",
    sort=Sort.NEWEST,
    count=5
)

combined_data = {
    "app_details": app_details,
    "reviews": reviews_data,
    "generated_at": datetime.now().isoformat()
}

# --------------------------------------
# Write output
# --------------------------------------
with open(output_path, "w", encoding="utf-8") as json_file:
    json.dump(combined_data, json_file, indent=2, default=convert_datetime)

print(f"✅ App info generated at: {output_path}")
