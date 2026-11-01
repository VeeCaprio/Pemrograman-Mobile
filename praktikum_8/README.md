Tentang Proyek

TabungKu Cloud adalah aplikasi Flutter yang terhubung ke backend FastAPI dan database MySQL menggunakan Docker Compose.

Teknologi

Flutter 3.24.3 dan Dart

FastAPI dan Python 3.12

MySQL 8.4 dan SQLAlchemy

Docker Compose dan Adminer

SharedPreferences dan HTTP MockClient

Struktur Proyek

backend/ — kode FastAPI, konfigurasi database, Dockerfile, requirements.

mobile/ — aplikasi Flutter dan pengujian.

docker-compose.yml — service MySQL, API, dan Adminer.

.env.example — contoh variabel environment.

Konfigurasi Environment

Salin .env.example menjadi .env, lalu sesuaikan kredensial database. Jangan commit .env.

cp .env.example .env

Menjalankan Backend

docker compose up -d --build
docker compose ps

Port host: MySQL 3307, FastAPI 9000, Adminer 8081. Port internal API tetap 8000.

Endpoint API

GET / — pesan sambutan.
GET /health — status API dan database, termasuk SELECT VERSION().
GET /info — nama aplikasi, versi, timezone, dan waktu server.
Swagger: http://localhost:9000/docs
Adminer: http://localhost:8081

Menjalankan Flutter

cd mobile
flutter pub get
flutter run

Untuk Android Emulator gunakan http://10.0.2.2:9000. URL dapat diedit melalui Pengaturan dan disimpan menggunakan SharedPreferences.

Pengujian

cd mobile
flutter test test/api_service_test.dart
flutter analyze

Unit test mencakup HTTP 200, HTTP 503, dan HTTP 404.

Persistensi Database

MySQL menggunakan named volume mysql_data. Pengujian docker compose down lalu docker compose up -d menunjukkan data uji tetap tersedia. Hindari docker compose down -v jika ingin mempertahankan data.

Perbandingan Image

python:3.12-slim = 177 MB.
python:3.12 = 1.6 GB.
Image slim lebih kecil dan menghemat ruang penyimpanan.

Catatan

Dokumen ini merupakan README dalam format Word untuk dibaca/dicetak. Untuk GitHub, simpan konten panduan sebagai file teks README.md di root repository.

Dokumen praktikum • TabungKu Cloud