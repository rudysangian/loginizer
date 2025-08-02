import os
import re

BASE_DIR = r"E:\SolusiPICT\ipm_web_regdrv\lib"

# 1️⃣ Ambil mapping route dari main.dart
routes_file = os.path.join(BASE_DIR, "main.dart")
routes_map = {}

if os.path.exists(routes_file):
    with open(routes_file, "r", encoding="utf-8") as f:
        content = f.read()
        matches = re.findall(r"['\"](/[^'\"]+)['\"]\s*:\s*\(.*?\)\s*=>\s*(\w+)\(", content)
        for route, page in matches:
            routes_map[route] = page
else:
    print("⚠️ File main.dart tidak ditemukan:", routes_file)

# 2️⃣ Cari semua pushNamed
pattern = re.compile(r"Navigator\.pushNamed[^'\"]*['\"](/[^'\"]+)['\"]")
results = []

for root, _, files in os.walk(BASE_DIR):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8") as f:
                for i, line in enumerate(f, start=1):
                    if "Navigator.pushNamed" in line:
                        match = pattern.search(line)
                        if match:
                            route = match.group(1)
                            page_name = routes_map.get(route, "❓ Tidak ada di routes")
                            results.append((file, i, route, page_name))

# 3️⃣ Cetak hasil
if results:
    print("\n📄 PETA NAVIGASI APLIKASI LOGINIZER\n")
    print(f"{'File Asal':25} | {'Route':15} | {'Halaman Tujuan (Class)':25}")
    print("-"*70)
    for file, line, route, page in results:
        print(f"{file:25} | {route:15} | {page:25}")
else:
    print("⚠️ Tidak ada Navigator.pushNamed ditemukan.")
