# 1. Gunakan base image resmi Python yang ringan
FROM python:3.11-slim

# 2. Tetapkan direktori kerja di dalam kontainer
WORKDIR /app

# 3. Salin file requirements terlebih dahulu untuk optimasi cache
COPY requirements.txt .

# 4. Install semua library Python yang dibutuhkan
RUN pip install --no-cache-dir -r requirements.txt

# 5. Salin seluruh isi folder proyek (termasuk folder model) ke dalam kontainer
COPY . .

# 6. Informasikan bahwa kontainer akan berjalan di port 8000 (sesuaikan jika berbeda)
EXPOSE 8000

# 7. Perintah default untuk menjalankan aplikasi saat kontainer dimulai
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]