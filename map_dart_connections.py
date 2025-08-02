import os
import re

# 🔹 Ganti sesuai folder project-mu
BASE_DIR = r"E:\SolusiPICT\ipm_web_regdrv\lib"

# Pola untuk menemukan Navigator.push + MaterialPageRoute
pattern = re.compile(
    r"Navigator\.push(?:Replacement)?\([^)]*MaterialPageRoute\([^)]*builder:\s*\(.*?\)\s*=>\s*(\w+)"
)

results = []

# 🔹 Scan semua file .dart
for root, _, files in os.walk(BASE_DIR):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()
                matches = pattern.findall(content)
                for m in matches:
                    results.append((file, m))

# 🔹 Cari definisi class di semua file untuk mapping class → file
class_map = {}
for root, _, files in os.walk(BASE_DIR):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8") as f:
                for line in f:
                    match = re.match(r"class\s+(\w+)\s+", line)
                    if match:
                        class_map[match.group(1)] = file

# 🔹 Cetak hasil
if results:
    print("\n📄 KETERHUBUNGAN FILE DART\n")
    print(f"{'File Asal':30} | {'Class Tujuan':25} | {'File Tujuan'}")
    print("-" * 80)
    for file, class_name in results:
        target_file = class_map.get(class_name, "❓ Tidak ditemukan")
        print(f"{file:30} | {class_name:25} | {target_file}")
else:
    print("⚠️ Tidak ada Navigator.push(MaterialPageRoute) ditemukan.")
