import os
import re

BASE_DIR = r"E:\SolusiPICT\ipm_web_regdrv\lib\pages"

# Pola class dan navigasi
class_pattern = re.compile(r"class\s+(\w+)\s+")
nav_pattern = re.compile(
    r"Navigator\.push(?:Replacement)?\([^)]*MaterialPageRoute\([^)]*builder:\s*\(.*?\)\s*=>\s*(\w+)"
)

# Simpan semua class beserta file-nya
class_map = {}
for root, _, files in os.walk(BASE_DIR):
    for file in files:
        if file.endswith(".dart"):
            with open(os.path.join(root, file), "r", encoding="utf-8") as f:
                for line in f:
                    match = class_pattern.search(line)
                    if match:
                        class_map[match.group(1)] = file

# Cari semua navigasi
connections = []
for root, _, files in os.walk(BASE_DIR):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()
                for target_class in nav_pattern.findall(content):
                    target_file = class_map.get(target_class, "❓ Tidak ditemukan")
                    connections.append((file, target_class, target_file))

# Tampilkan semua file meskipun tidak ada navigasi
print("\n📄 PETA SEMUA FILE DART + KETERHUBUNGANNYA\n")
print(f"{'File Asal':30} | {'Class Tujuan':25} | {'File Tujuan'}")
print("-" * 80)

all_files = [f for f in os.listdir(BASE_DIR) if f.endswith(".dart")]

for f in all_files:
    related = [(c[1], c[2]) for c in connections if c[0] == f]
    if related:
        for r in related:
            print(f"{f:30} | {r[0]:25} | {r[1]}")
    else:
        print(f"{f:30} | {'-':25} | {'-'}")
