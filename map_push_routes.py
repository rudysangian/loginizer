import os
import re

# 🔹 Ganti path ini sesuai folder project-mu
BASE_DIR = r"E:\SolusiPICT\ipm_web_regdrv\lib"

# Pola untuk menangkap nama class tujuan dari MaterialPageRoute
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

# 🔹 Cetak hasil
if results:
    print("\n📄 PETA NAVIGASI BERDASARKAN Navigator.push(MaterialPageRoute)\n")
    print(f"{'File Asal':30} | {'Halaman Tujuan (Class)':30}")
    print("-" * 65)
    for file, page in results:
        print(f"{file:30} | {page:30}")
else:
    print("⚠️ Tidak ada Navigator.push(MaterialPageRoute) ditemukan.")
