Attendansystem — Mobile Attendance App
Aplikasi absensi kantor digital untuk Android yang dirancang menggunakan Flutter (Dart). Aplikasi Pegawai direncanakan terhubung dengan backend Laravel 12, sementara pengelolaan data dan approval Admin tetap dilakukan melalui Filament v3.
Status dokumentasi: README ini disusun dari PRD Mobile dan rancangan UI/UX Figma. Struktur source code, status implementasi fitur, endpoint API, dan hasil pengujian belum diverifikasi dari repository pada sesi ini. Jangan menganggap seluruh fitur sudah berjalan sebelum diuji.

Repository
- GitHub: https://github.com/VeeCaprio/Pemrograman-Mobile
UI/UX Design
- Figma — Attendansystem UI/UX Mockup & Prototype
- Prototype — mulai dari layar awal
Teknologi
Komponen	Teknologi
Mobile	Flutter, Dart, Android
Backend	Laravel 12
Admin Panel	Filament v3, Blade, Livewire
Database	MariaDB
Environment	Docker
UI/UX	Figma


Ruang Lingkup Fitur
- Login Pegawai
- Beranda dan status kehadiran
- Check-in dan check-out
- Riwayat absensi dan kalender
- Pengajuan cuti
- Pengajuan izin/sakit
- Pengumuman
- Profil Pegawai
- Tampilan status sistem (loading, empty state, offline, dan error)
Arsitektur Singkat
Flutter menjadi aplikasi klien untuk Pegawai. Laravel menjadi sumber data dan validasi bisnis. Panel Admin tetap berada di aplikasi web Filament v3. Keputusan absensi, waktu resmi, dan approval harus berasal dari server, bukan dihitung atau diputuskan hanya di sisi aplikasi.
Screenshot
Rancangan visual dapat dilihat di Figma Prototype.

Untuk melengkapi dokumentasi implementasi, simpan screenshot aktual emulator ke folder docs/screenshots/, lalu tampilkan dengan format berikut:
![Login](docs/screenshots/login.png)
![Dashboard](docs/screenshots/dashboard.png)
![Attendance](docs/screenshots/attendance.png)
Screenshot emulator belum disertakan sebagai bukti karena aplikasi belum dijalankan dan diverifikasi pada sesi penyusunan README ini.
Menjalankan Project
Langkah menjalankan aplikasi perlu disesuaikan dengan struktur repository dan konfigurasi aktual. Secara umum, proyek Flutter menggunakan:
flutter pub get
flutter run
Pastikan Flutter SDK, Android SDK, emulator/perangkat Android, serta konfigurasi API sudah tersedia. Base URL API untuk emulator Android biasanya berbeda dari URL host desktop; gunakan konfigurasi yang sesuai dengan environment backend.
Keamanan dan Integrasi API
- Gunakan autentikasi berbasis token pribadi (contoh: Laravel Sanctum) setelah endpoint backend tersedia dan diverifikasi.
- Simpan token menggunakan secure storage.
- Jangan menanam secret/API key privat permanen di binary aplikasi.
- Identitas Pegawai harus diturunkan dari sesi/token, bukan menerima employee_id bebas dari klien.
- Hindari retry otomatis pada request check-in/check-out yang dapat membuat transaksi ganda.