# Praktikum 5 — Pemrograman Mobile

## 1. Deskripsi Praktikum

Praktikum 5 merupakan kegiatan pembelajaran pengembangan aplikasi mobile menggunakan Flutter dan bahasa pemrograman Dart. Pada praktikum ini, mahasiswa mempelajari konsep penyimpanan data lokal menggunakan database SQLite sehingga data dapat dikelola langsung dari aplikasi.

Penggunaan database lokal memungkinkan aplikasi melakukan operasi terhadap data tanpa harus selalu terhubung ke server. Dalam Flutter, package `sqflite` digunakan untuk berinteraksi dengan database SQLite, sedangkan package `path` membantu mengelola lokasi file database.

## 2. Tujuan Praktikum

Tujuan dari Praktikum 5 adalah:

1. Memahami konsep penyimpanan data lokal pada aplikasi mobile.
2. Mengenal database SQLite dalam pengembangan aplikasi Flutter.
3. Memahami fungsi package `sqflite` untuk mengelola database.
4. Memahami penggunaan package `path` untuk menentukan lokasi database.
5. Mempelajari proses pengelolaan data melalui aplikasi.
6. Menjalankan dan menguji aplikasi pada emulator Android.

## 3. Teknologi yang Digunakan

* **Flutter** — framework untuk membangun aplikasi mobile.
* **Dart** — bahasa pemrograman aplikasi.
* **SQLite** — database relasional lokal.
* **sqflite** — package Flutter untuk mengakses SQLite.
* **path** — package untuk membantu pengelolaan jalur file.
* **Android Emulator** — media pengujian aplikasi.

## 4. Konsep yang Dipelajari

### A. Database Lokal

Database lokal digunakan untuk menyimpan data langsung di perangkat pengguna. Data yang disimpan dapat tetap tersedia setelah aplikasi ditutup, selama database tidak dihapus atau direset.

### B. SQLite

SQLite merupakan sistem database relasional yang dapat digunakan tanpa memerlukan server database terpisah. SQLite sesuai untuk kebutuhan penyimpanan data lokal pada aplikasi mobile.

### C. Package sqflite

Package `sqflite` menyediakan fungsi untuk menjalankan operasi database SQLite dari aplikasi Flutter, seperti membuat tabel, memasukkan data, membaca data, memperbarui data, dan menghapus data.

### D. Package path

Package `path` membantu menyusun jalur file database dengan lebih teratur dan sesuai dengan struktur direktori perangkat.

### E. Operasi CRUD

CRUD merupakan singkatan dari empat operasi utama pengelolaan data:

* **Create** — menambahkan data baru.
* **Read** — membaca atau menampilkan data.
* **Update** — memperbarui data yang tersimpan.
* **Delete** — menghapus data.

Operasi yang benar-benar diterapkan dapat disesuaikan dengan implementasi aplikasi pada praktikum.

## 5. Langkah Menjalankan Aplikasi

Pastikan Flutter SDK dan emulator Android sudah tersedia.

1. Buka Terminal.

2. Masuk ke folder proyek:

   ```bash
   cd praktikum_5
   ```

3. Unduh dependensi:

   ```bash
   flutter pub get
   ```

4. Pastikan package yang dibutuhkan sudah tercantum pada `pubspec.yaml`, khususnya `sqflite` dan `path` jika digunakan oleh kode aplikasi.

5. Periksa kode program:

   ```bash
   flutter analyze
   ```

6. Jalankan aplikasi:

   ```bash
   flutter run
   ```

7. Uji fungsi aplikasi melalui emulator Android dan periksa apakah data dapat dikelola sesuai fitur yang diimplementasikan.

## 6. Hasil Praktikum

Hasil praktikum berupa proyek Flutter yang mempelajari penyimpanan dan pengelolaan data lokal menggunakan SQLite. Melalui praktikum ini, mahasiswa memperoleh pemahaman mengenai penggunaan database pada aplikasi mobile serta integrasi package Flutter dengan penyimpanan lokal.

Screenshot tampilan aplikasi, proses pengelolaan data, dan hasil pengujian dapat ditambahkan sebagai dokumentasi sesuai hasil implementasi.

## 7. Kesimpulan

Praktikum 5 memperkenalkan penggunaan database lokal dalam pengembangan aplikasi mobile menggunakan Flutter. Dengan mempelajari SQLite, `sqflite`, dan `path`, mahasiswa memahami dasar penyimpanan data di perangkat serta konsep operasi CRUD yang dapat digunakan untuk membangun aplikasi dengan pengelolaan data yang lebih terstruktur.

---

**Mata Kuliah:** Pemrograman Mobile
**Praktikum:** Pertemuan 5
**Framework:** Flutter
**Bahasa Pemrograman:** Dart
**Database:** SQLite
