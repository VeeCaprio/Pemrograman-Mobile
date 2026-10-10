# Praktikum 6 — Pemrograman Mobile

## 1. Deskripsi Praktikum

Praktikum 6 membahas pengembangan aplikasi mobile menggunakan Flutter dan bahasa pemrograman Dart dengan menerapkan pengaturan tema, navigasi halaman, serta animasi pada antarmuka pengguna.

Pada praktikum ini dibuat aplikasi **Galeri Interaktif** yang memiliki tiga menu utama, yaitu Galeri, Favorit, dan Pengaturan. Aplikasi menyediakan halaman detail untuk setiap item galeri, pilihan tema terang dan gelap, serta beberapa pilihan warna tema. Preferensi tema disimpan menggunakan `shared_preferences` agar tetap digunakan ketika aplikasi dibuka kembali.

## 2. Tujuan Praktikum

Tujuan Praktikum 6 adalah:

1. Memahami penggunaan `ThemeData` untuk mengatur tampilan aplikasi.
2. Menerapkan tema terang dan gelap menggunakan `ThemeMode`.
3. Menyediakan beberapa pilihan warna tema.
4. Menerapkan navigasi menggunakan named route.
5. Mengirimkan data ke halaman detail melalui route arguments.
6. Menerapkan navigasi tab menggunakan `NavigationBar` dan `IndexedStack`.
7. Memahami penggunaan animasi implisit dan eksplisit.
8. Menerapkan transisi Hero pada perpindahan halaman.
9. Menyimpan preferensi tema menggunakan `shared_preferences`.

## 3. Teknologi yang Digunakan

* **Flutter** — framework untuk membangun aplikasi mobile.
* **Dart** — bahasa pemrograman yang digunakan.
* **Material Design 3** — sistem komponen antarmuka Flutter.
* **shared_preferences** — package untuk menyimpan preferensi sederhana secara lokal.
* **Android Emulator** — digunakan untuk menjalankan dan menguji aplikasi.

## 4. Fitur Aplikasi

### A. Halaman Galeri

Halaman Galeri menampilkan enam item, yaitu Pegunungan, Laut, Matahari, Hutan, Bintang, dan Bunga. Setiap item memiliki ikon, judul, warna, dan deskripsi.

Pengguna dapat memilih item untuk membuka halaman detail atau menekan ikon hati untuk menambahkan item ke daftar favorit.

### B. Halaman Favorit

Halaman Favorit menampilkan item yang telah ditandai menggunakan ikon hati pada halaman Galeri. Jika belum ada item yang dipilih, aplikasi menampilkan informasi bahwa daftar favorit masih kosong.

Pada implementasi ini, data favorit disimpan dalam memori aplikasi dan belum disimpan secara permanen.

### C. Halaman Pengaturan

Halaman Pengaturan menyediakan fitur untuk mengaktifkan atau menonaktifkan mode gelap serta memilih warna utama aplikasi. Terdapat empat pilihan warna tema, yaitu indigo, teal, deep orange, dan pink.

Preferensi mode gelap dan indeks warna tema disimpan menggunakan `shared_preferences`.

### D. Halaman Detail

Halaman Detail menampilkan judul, ikon, dan deskripsi dari item galeri yang dipilih. Data dikirim dari halaman Galeri melalui named route menggunakan `Navigator.pushNamed()` dan `arguments`.

### E. Navigasi Tab

Aplikasi menggunakan `NavigationBar` untuk berpindah di antara tiga menu utama. Widget `IndexedStack` digunakan untuk mengelola tampilan halaman berdasarkan tab yang sedang dipilih.

## 5. Implementasi Materi

### A. ThemeData dan ThemeMode

Aplikasi menggunakan `ThemeData` untuk mengatur tema terang dan gelap. Properti `colorSchemeSeed` menentukan warna utama berdasarkan pilihan pengguna, sedangkan `brightness` membedakan mode terang dan gelap.

Properti `themeMode` menentukan tema yang sedang aktif.

### B. Named Route dan Arguments

Navigasi menuju halaman detail menggunakan nama route `/detail`. Properti `onGenerateRoute` memproses route yang diminta dan membaca data melalui `settings.arguments`.

Dengan cara ini, informasi item dan indeksnya dapat diteruskan ke halaman detail.

### C. NavigationBar dan IndexedStack

`NavigationBar` menyediakan navigasi untuk tiga tab aplikasi. Nilai `tabAktif` menentukan tab yang dipilih, sedangkan `IndexedStack` menampilkan halaman sesuai indeks tersebut.

### D. Animasi Implisit

Aplikasi menggunakan `AnimatedContainer` untuk memberikan perubahan tampilan secara bertahap serta `AnimatedSwitcher` dengan `ScaleTransition` untuk menganimasikan pergantian ikon favorit.

Animasi ini dikelola oleh Flutter tanpa perlu membuat `AnimationController` untuk setiap perubahan tersebut.

### E. Animasi Eksplisit

Pada halaman detail, aplikasi menggunakan `AnimationController`, `CurvedAnimation`, dan `ScaleTransition`. Controller menjalankan animasi selama 800 milidetik dengan kurva `Curves.elasticOut`, sehingga ikon mengalami efek pembesaran saat halaman dibuka.

### F. Hero Animation

Widget `Hero` digunakan pada kartu galeri dan halaman detail dengan tag yang sama untuk setiap item. Hal ini menghasilkan transisi visual ketika pengguna berpindah dari kartu menuju halaman detail.

### G. Penyimpanan Preferensi

Package `shared_preferences` menyimpan dua nilai, yaitu `modeGelap` dan `warnaTema`. Ketika aplikasi dijalankan, kedua nilai dibaca kembali untuk menentukan tema awal.

## 6. Struktur Kode Utama

```text
praktikum_6/
├── lib/
│   └── main.dart
├── test/
├── android/
├── pubspec.yaml
└── README.md
```

Keterangan:

* `lib/main.dart` berisi kode utama aplikasi, pengaturan tema, navigasi, galeri, dan animasi.
* `test/` berisi pengujian aplikasi.
* `android/` berisi konfigurasi platform Android.
* `pubspec.yaml` berisi informasi proyek dan dependensi Flutter.
* `README.md` berisi dokumentasi praktikum.

## 7. Langkah Menjalankan Aplikasi

Pastikan Flutter SDK, dependensi, dan emulator Android sudah tersedia.

1. Buka Terminal.

2. Masuk ke folder proyek:

   ```bash
   cd praktikum_6
   ```

3. Unduh dependensi:

   ```bash
   flutter pub get
   ```

4. Periksa kode:

   ```bash
   flutter analyze
   ```

5. Jalankan pengujian:

   ```bash
   flutter test
   ```

6. Jalankan aplikasi:

   ```bash
   flutter run
   ```

7. Uji navigasi, animasi, pilihan warna tema, mode terang dan gelap, serta penyimpanan preferensi.

## 8. Hasil Pengujian

Berdasarkan pengujian yang dilakukan pada proyek ini:

* `flutter analyze` berhasil dengan hasil **No issues found**.
* `flutter test` berhasil dengan hasil **All tests passed**.
* `flutter run` berhasil membangun APK, memasang aplikasi, dan menjalankannya pada emulator Android.

Hasil tersebut menunjukkan bahwa pemeriksaan statis kode, pengujian yang tersedia, dan proses build aplikasi berhasil. Pengujian manual tetap diperlukan untuk memastikan setiap fitur berjalan sesuai kebutuhan.

## 9. Dokumentasi Screenshot

Screenshot berikut dapat ditambahkan untuk melengkapi laporan praktikum:

1. Tampilan halaman Galeri dalam mode terang.
2. Tampilan halaman Favorit.
3. Tampilan halaman Pengaturan dengan empat pilihan warna.
4. Tampilan halaman Galeri dalam mode gelap.
5. Tampilan halaman Detail ketika animasi Hero dan Scale dijalankan.

## 10. Kesimpulan

Praktikum 6 menghasilkan aplikasi Galeri Interaktif yang menerapkan pengaturan tema, navigasi tab, named route, pengiriman arguments, serta animasi implisit dan eksplisit. Penggunaan `shared_preferences` memungkinkan pilihan mode terang atau gelap dan warna tema tetap tersimpan ketika aplikasi dibuka kembali.

Berdasarkan hasil pemeriksaan, kode berhasil melewati `flutter analyze`, pengujian `flutter test` berhasil, dan aplikasi dapat dijalankan pada emulator Android.

---

**Mata Kuliah:** Pemrograman Mobile
**Praktikum:** Pertemuan 6
**Framework:** Flutter
**Bahasa Pemrograman:** Dart
**Penyimpanan Preferensi:** shared_preferences
