TabungKu — Aplikasi Pemantauan Kegiatan dan Keuangan
Deskripsi
TabungKu adalah aplikasi mobile berbasis Flutter yang menampilkan daftar kegiatan, formulir tambah dan edit kegiatan, ringkasan keuangan, laporan, serta pengaturan aplikasi.

README ini dibuat berdasarkan tampilan aplikasi yang tersedia pada dokumen tugas. Detail implementasi internal perlu disesuaikan dengan kode sumber proyek yang sebenarnya.
Fitur Utama
- Beranda: menampilkan ringkasan keuangan dan daftar kegiatan.
- Tambah kegiatan: mencatat nama kegiatan, tanggal, kategori, dan nominal.
- Edit kegiatan: memperbarui informasi kegiatan yang sudah dicatat.
- Laporan: melihat ringkasan pemasukan, pengeluaran, saldo, dan pengeluaran per kategori.
- Pengaturan: menyediakan opsi preferensi aplikasi yang tersedia.
Teknologi
- Flutter
- Dart
- Android Emulator atau perangkat Android untuk menjalankan aplikasi
Catatan: teknologi di atas diidentifikasi dari tampilan proyek pada screenshot. Periksa kembali pubspec.yaml dan kode proyek untuk memastikan dependensi yang digunakan.

Persiapan
Pastikan perangkat telah memiliki:
1. Flutter SDK.
2. Android Studio atau Visual Studio Code dengan dukungan Flutter.
3. Android SDK dan Android Emulator, atau HP Android dengan USB debugging aktif.
4. Folder proyek TabungKu yang lengkap.
Periksa instalasi Flutter melalui terminal:
flutter doctor
Cara Menjalankan Proyek
1. Buka folder utama proyek TabungKu di Android Studio atau Visual Studio Code.
2. Pastikan file pubspec.yaml dan folder lib tersedia.
3. Buka terminal di folder utama proyek.
4. Unduh dependensi proyek:
   flutter pub get
5. Nyalakan emulator Android atau hubungkan perangkat Android yang sudah mengizinkan USB debugging.
6. Periksa perangkat yang terdeteksi:
   flutter devices
7. Jalankan aplikasi:
   flutter run
Panduan Penggunaan
1. Menambahkan kegiatan
1. Buka halaman Beranda.
2. Tekan tombol tambah kegiatan.
3. Isi nama kegiatan dan tanggal.
4. Pilih kategori yang sesuai.
5. Masukkan nominal.
6. Periksa kembali data, lalu simpan.
7. Pastikan kegiatan muncul pada daftar.
2. Mengedit kegiatan
1. Pilih kegiatan yang ingin diubah.
2. Buka formulir edit.
3. Perbarui informasi yang diperlukan.
4. Simpan perubahan.
5. Periksa apakah daftar dan ringkasan sudah diperbarui.
3. Melihat laporan
1. Buka tab Laporan.
2. Pilih tanggal atau periode jika tersedia.
3. Periksa ringkasan pemasukan, pengeluaran, saldo, dan kategori pengeluaran.
4. Cocokkan hasilnya dengan kegiatan yang telah dicatat.
4. Mengubah pengaturan
1. Buka tab Pengaturan.
2. Periksa opsi yang tersedia.
3. Ubah preferensi yang diperlukan dan pastikan perubahan diterapkan.
Struktur Proyek
Struktur berikut merupakan gambaran umum berdasarkan folder yang terlihat pada screenshot. Nama folder dan file dapat berbeda pada proyek sebenarnya.
tabungku/
├── lib/
│   ├── main.dart
│   ├── pages/
│   ├── models/ atau data/
│   └── widgets/
├── pubspec.yaml
└── ...
- lib/main.dart: biasanya menjadi titik awal aplikasi Flutter.
- pages/: kemungkinan berisi halaman aplikasi.
- models/ atau data/: kemungkinan berisi model atau pengelolaan data.
- widgets/: kemungkinan berisi komponen antarmuka yang digunakan kembali.
- pubspec.yaml: konfigurasi proyek dan daftar dependensi.
Periksa struktur aktual proyek sebelum menggunakan daftar ini sebagai dokumentasi teknis final.
Pengujian yang Disarankan
No.	Skenario	Hasil yang Diharapkan
1	Membuka aplikasi	Halaman Beranda tampil
2	Menambahkan kegiatan valid	Data muncul di daftar
3	Mengirim formulir kosong	Validasi tampil atau data tidak disimpan
4	Mengedit kegiatan	Perubahan tersimpan
5	Membuka laporan	Ringkasan sesuai dengan data
6	Mengubah pengaturan	Preferensi diterapkan sesuai opsi


Lakukan pengujian secara langsung dan catat hasil sebenarnya; tabel ini berisi skenario yang disarankan, bukan hasil pengujian yang telah dikonfirmasi.
Pemecahan Masalah
- Jika dependensi belum tersedia, jalankan flutter pub get.
- Jika perangkat tidak muncul, jalankan flutter devices dan periksa emulator/koneksi USB.
- Jika aplikasi gagal dibangun, baca pesan error pada terminal dan pastikan proyek dibuka dari folder utama.
- Jika flutter tidak dikenali, periksa pemasangan Flutter SDK dan konfigurasi PATH.
Pengembangan Lebih Lanjut
Untuk menjelaskan kode per fungsi atau per baris secara akurat, lengkapi dokumentasi ini menggunakan file Dart dan konfigurasi proyek yang sebenarnya.
Lisensi
Belum ditentukan. Tambahkan informasi lisensi jika proyek akan dibagikan secara publik.