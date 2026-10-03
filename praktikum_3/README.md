

# CATATAN PRAKTIKUM PERTEMUAN 3

## PEMROGRAMAN MOBILE – FLUTTER

**Nama:** Vramudhia Egy Pratama
**NIM:** 20240801382
**Program Studi:** Teknik Informatika
**Materi:** Form Input, Validasi, Pengelolaan State, dan Aplikasi Daftar Tugas

---

## 1. Judul Praktikum

**Praktikum 3 – Form Input, Validasi, dan Pengelolaan Data pada Flutter**

Pada praktikum pertemuan 3, aplikasi Flutter dikembangkan agar tidak hanya menampilkan data, tetapi juga dapat menerima input dari pengguna, melakukan validasi, menyimpan data, mengubah data, dan menghapus data.

Hasil praktikum mencakup beberapa tampilan seperti **Form Pendaftaran**, **Daftar Tugas**, **Tambah Tugas**, **Tambah Belanja**, dan **Daftar Belanja**.

---

# 2. Tujuan Praktikum

Tujuan dari praktikum ini adalah:

1. Memahami penggunaan form pada Flutter.
2. Membuat input menggunakan `TextField` dan `TextFormField`.
3. Melakukan validasi terhadap data yang dimasukkan pengguna.
4. Menggunakan `Checkbox` untuk mengubah status data.
5. Membuat dialog untuk memasukkan dan mengedit data.
6. Menampilkan data dalam bentuk daftar.
7. Menambahkan, mengedit, dan menghapus data.
8. Memahami pengelolaan state menggunakan `ChangeNotifier`.
9. Menggunakan `Provider` untuk menghubungkan state dengan tampilan.
10. Membuat aplikasi sederhana yang memiliki interaksi dengan pengguna.

Pada implementasi tugas, model `Tugas` memiliki data judul dan status selesai, sedangkan `TugasModel` mengelola daftar tugas serta operasi tambah, edit, hapus, dan perubahan status. 

---

# 3. Alat dan Bahan

Alat yang digunakan:

* Flutter SDK
* Dart
* Android Studio atau Visual Studio Code
* Android Emulator/perangkat Android
* Terminal
* Project Flutter `praktikum_3`

Library yang digunakan pada implementasi adalah:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
```

Package `provider` digunakan untuk membantu pengelolaan state aplikasi. 

---

# 4. Persiapan Project

Project dapat dibuat melalui terminal dengan perintah:

```bash
flutter create praktikum_3
```

Kemudian masuk ke folder project:

```bash
cd praktikum_3
```

Setelah itu jalankan aplikasi:

```bash
flutter run
```

File utama yang digunakan adalah:

```text
lib/main.dart
```

---

# 5. Konsep Dasar Praktikum

## 5.1 Form

Form digunakan untuk menerima data yang dimasukkan oleh pengguna.

Contohnya pada aplikasi terdapat form:

* Nama
* Email
* Password
* Konfirmasi Password
* Nama barang
* Jumlah
* Kategori

Form membuat aplikasi dapat berinteraksi dengan pengguna secara langsung.

---

## 5.2 TextField dan TextFormField

`TextField` digunakan untuk menerima input teks dari pengguna.

Contoh:

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Nama',
  ),
)
```

Sedangkan `TextFormField` dapat digunakan bersama validasi.

Contoh:

```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Judul tugas',
    border: OutlineInputBorder(),
  ),
)
```

Pada aplikasi tugas, `TextFormField` digunakan untuk memasukkan judul tugas. 

---

# 6. Validasi Form

Validasi digunakan untuk memastikan data yang dimasukkan pengguna sesuai dengan ketentuan.

Contohnya, pada aplikasi daftar tugas, judul tugas tidak boleh kosong dan minimal terdiri dari 3 karakter.

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Judul tugas wajib diisi';
  }

  if (value.trim().length < 3) {
    return 'Minimal 3 karakter';
  }

  return null;
},
```

Selain validasi pada `validator`, implementasi praktikum juga melakukan pemeriksaan secara manual ketika tombol **Tambah** ditekan. 

---

# 7. Tampilan Awal Aplikasi

Pada awal praktikum dibuat aplikasi sederhana yang memiliki tampilan daftar.

Tampilan awal menunjukkan konsep aplikasi yang kemudian dikembangkan menjadi aplikasi yang dapat menerima input pengguna.

Dari hasil praktikum, aplikasi kemudian dikembangkan menjadi beberapa fitur seperti:

* Form pendaftaran
* Daftar tugas
* Tambah tugas
* Checklist tugas
* Daftar belanja
* Form tambah belanja

---

# 8. Form Pendaftaran

Pada bagian form pendaftaran, aplikasi menampilkan beberapa input yang harus diisi oleh pengguna.

Field yang digunakan antara lain:

1. Nama
2. Email
3. Password
4. Konfirmasi password
5. Persetujuan
6. Tombol Register

Tujuan bagian ini adalah memahami bagaimana aplikasi menerima beberapa jenis input sekaligus.

---

# 9. Validasi Form Pendaftaran

Validasi digunakan untuk memastikan input pengguna tidak kosong dan sesuai aturan.

Contoh kondisi yang dapat diperiksa:

* Nama harus diisi.
* Email harus diisi.
* Password harus diisi.
* Konfirmasi password harus sesuai.
* Pengguna harus menyetujui persyaratan.

Jika input tidak sesuai, aplikasi akan menampilkan pesan kesalahan pada form.

Dengan adanya validasi, data yang masuk ke aplikasi dapat diperiksa terlebih dahulu sebelum diproses.

---

# 10. Aplikasi Daftar Tugas

Pada bagian berikutnya dibuat aplikasi **Daftar Tugas**.

Tampilan awal ketika belum terdapat data tugas menunjukkan pesan:

**"Belum ada tugas"**

Kemudian terdapat tombol **+** pada bagian bawah untuk menambahkan tugas.

Pada implementasi state, halaman tugas membaca data dari `TugasModel`, kemudian menampilkan daftar menggunakan `ListView.builder`. 

---

# 11. Model Data Tugas

Data tugas dibuat menggunakan class:

```dart
class Tugas {
  String judul;
  bool selesai;

  Tugas({
    required this.judul,
    this.selesai = false,
  });
}
```

Class tersebut mempunyai dua properti:

### `judul`

Digunakan untuk menyimpan nama atau judul tugas.

### `selesai`

Digunakan untuk menyimpan status apakah tugas sudah selesai atau belum.

Nilai awal:

```dart
selesai = false
```

berarti tugas yang baru dibuat belum selesai.

---

# 12. TugasModel

Pengelolaan daftar tugas dilakukan melalui `TugasModel`.

Contoh:

```dart
class TugasModel extends ChangeNotifier {
  final List<Tugas> items = [
    Tugas(judul: 'Mengerjakan Praktikum Flutter'),
  ];
}
```

`ChangeNotifier` digunakan agar perubahan data dapat diberitahukan kepada widget yang menggunakan model tersebut.

Pada model terdapat beberapa fungsi utama:

```text
tambah()
toggle()
hapus()
edit()
hapusSelesai()
```

Fungsi-fungsi tersebut digunakan untuk mengelola data tugas. 

---

# 13. Menambahkan Tugas

Ketika tombol **+** ditekan, aplikasi menampilkan dialog **Tambah Tugas**.

Dialog tersebut memiliki input:

**Judul tugas**

dan dua tombol:

* Batal
* Tambah

Input kemudian diperiksa.

Jika kosong:

```text
Judul tugas wajib diisi
```

Jika kurang dari 3 karakter:

```text
Judul tugas minimal 3 karakter
```

Jika data valid, tugas dimasukkan ke dalam daftar.

Setelah berhasil ditambahkan, aplikasi menampilkan pesan:

```text
Tugas ditambahkan
```

Implementasi tersebut menggunakan `AlertDialog`, `TextFormField`, validasi, dan `SnackBar`. 

---

# 14. Menampilkan Daftar Tugas

Data tugas ditampilkan menggunakan:

```dart
ListView.builder()
```

Setiap tugas ditampilkan menggunakan `ListTile`.

Bagian kiri menggunakan:

```dart
Checkbox()
```

Sedangkan bagian kanan menyediakan tombol:

* Edit
* Hapus

Contoh struktur:

```text
☐ Mengerjakan Praktikum Flutter       ✎  🗑
```

Dengan menggunakan `ListView.builder`, jumlah item dapat berubah sesuai jumlah data dalam list. 

---

# 15. Checkbox Tugas

Checkbox digunakan untuk mengubah status tugas.

Ketika checkbox dipilih, fungsi:

```dart
toggle(i)
```

akan dijalankan.

Di dalam model:

```dart
items[index].selesai = !items[index].selesai;
notifyListeners();
```

Kode tersebut membalik status tugas:

```text
false → true
true → false
```

Kemudian `notifyListeners()` memberitahukan bahwa data telah berubah sehingga tampilan diperbarui.

---

# 16. Tampilan Tugas yang Sudah Selesai

Ketika tugas selesai, teks tugas diberi efek coret.

Contohnya menggunakan:

```dart
TextDecoration.lineThrough
```

Kode:

```dart
style: TextStyle(
  decoration: t.selesai
      ? TextDecoration.lineThrough
      : null,
),
```

Sehingga tugas yang sudah dicentang dapat dibedakan dari tugas yang belum selesai. 

---

# 17. Mengedit Tugas

Setiap tugas mempunyai tombol **Edit**.

Ketika tombol tersebut ditekan, muncul dialog:

**Edit Tugas**

Judul lama dimasukkan ke dalam `TextEditingController`.

Kemudian pengguna dapat mengubah judul tersebut.

Setelah tombol **Simpan** ditekan, fungsi:

```dart
edit(index, judulBaru)
```

dijalankan.

Jika judul baru kurang dari 3 karakter, aplikasi memberikan pesan:

```text
Judul tugas minimal 3 karakter
```

Implementasi edit menggunakan `AlertDialog` dan `TextField`. 

---

# 18. Menghapus Tugas

Tombol hapus menggunakan:

```dart
context.read<TugasModel>().hapus(i);
```

Kemudian model menjalankan:

```dart
items.removeAt(index);
notifyListeners();
```

`removeAt()` digunakan untuk menghapus data berdasarkan posisi/index.

Setelah data dihapus, `notifyListeners()` membuat tampilan diperbarui.

---

# 19. Menghitung Jumlah Tugas Selesai

Aplikasi juga menghitung jumlah tugas yang sudah selesai.

Kode:

```dart
int get jumlahSelesai {
  return items.where((tugas) => tugas.selesai).length;
}
```

Hasilnya digunakan pada judul AppBar:

```dart
'Tugas (${model.jumlahSelesai}/${model.items.length})'
```

Misalnya terdapat 3 tugas dan 1 sudah selesai, tampilan menjadi:

```text
Tugas (1/3)
```

Dengan demikian pengguna dapat melihat jumlah tugas yang sudah diselesaikan dibandingkan dengan jumlah seluruh tugas. 

---

# 20. Menghapus Semua Tugas yang Selesai

Pada pengembangan aplikasi terdapat tombol untuk menghapus seluruh tugas yang sudah selesai.

Fungsinya:

```dart
void hapusSelesai() {
  items.removeWhere((tugas) => tugas.selesai);
  notifyListeners();
}
```

`removeWhere()` akan menghapus semua item yang memenuhi kondisi.

Setelah proses selesai, aplikasi memberikan pesan melalui `SnackBar` bahwa tugas selesai telah dihapus. 

---

# 21. Penggunaan Provider

Pada bagian `main()`, model tugas diberikan kepada aplikasi menggunakan:

```dart
ChangeNotifierProvider(
  create: (_) => TugasModel(),
  child: const MyApp(),
)
```

Dengan cara tersebut, `TugasModel` dapat digunakan oleh widget yang berada di bawahnya.

Untuk membaca perubahan data digunakan:

```dart
context.watch<TugasModel>()
```

Sedangkan untuk menjalankan fungsi tanpa mendengarkan perubahan secara langsung digunakan:

```dart
context.read<TugasModel>()
```

Contohnya:

```dart
final model = context.watch<TugasModel>();
```

dan:

```dart
context.read<TugasModel>().hapus(i);
```

---

# 22. Aplikasi Daftar Belanja

Selain aplikasi daftar tugas, hasil praktikum juga menunjukkan pembuatan aplikasi **Daftar Belanja**.

Terdapat halaman:

**Tambah Belanja**

dengan beberapa input:

* Nama Barang
* Jumlah
* Kategori
* Tombol Tambah Belanja

Setelah data ditambahkan, data ditampilkan pada halaman:

**Daftar Belanja**

---

# 23. Data Daftar Belanja

Pada hasil praktikum terdapat beberapa contoh barang:

1. Indomie
2. Beras
3. Minyak
4. Gula
5. Minuman

Data tersebut kemudian ditampilkan sebagai daftar belanja.

Aplikasi juga menunjukkan kondisi ketika input belum benar melalui pesan validasi.

---

# 24. Alur Kerja Aplikasi

Secara sederhana, alur aplikasi dapat digambarkan seperti berikut:

```text
Mulai
  ↓
Tampilan Daftar
  ↓
Tekan tombol +
  ↓
Form Tambah Data
  ↓
Masukkan Data
  ↓
Validasi
  ↓
Apakah valid?
  ├── Tidak → Tampilkan pesan error
  │             ↓
  │          Kembali ke form
  │
  └── Ya
       ↓
    Simpan Data
       ↓
    notifyListeners()
       ↓
    Tampilan diperbarui
       ↓
      Selesai
```

---

# 25. Pengujian Aplikasi

Pengujian dilakukan untuk memastikan setiap fungsi dapat berjalan.

| No | Pengujian                       | Hasil    |
| -- | ------------------------------- | -------- |
| 1  | Aplikasi dapat dijalankan       | Berhasil |
| 2  | Form pendaftaran tampil         | Berhasil |
| 3  | Validasi form bekerja           | Berhasil |
| 4  | Daftar tugas tampil             | Berhasil |
| 5  | Menambah tugas                  | Berhasil |
| 6  | Checkbox dapat digunakan        | Berhasil |
| 7  | Mengedit tugas                  | Berhasil |
| 8  | Menghapus tugas                 | Berhasil |
| 9  | Jumlah tugas selesai diperbarui | Berhasil |
| 10 | Form daftar belanja tampil      | Berhasil |
| 11 | Menambahkan barang belanja      | Berhasil |
| 12 | Validasi daftar belanja bekerja | Berhasil |

---

# 26. Hasil Praktikum

Berdasarkan hasil praktikum, aplikasi Flutter berhasil dikembangkan dari tampilan sederhana menjadi aplikasi yang dapat menerima dan mengelola data pengguna.

Fitur yang berhasil dibuat meliputi:

* Input data menggunakan form.
* Validasi input.
* Penambahan data.
* Menampilkan data dalam daftar.
* Checkbox status selesai.
* Edit data.
* Hapus data.
* Penghitungan jumlah data selesai.
* Penghapusan data yang telah selesai.
* Penggunaan `ChangeNotifier`.
* Penggunaan `Provider`.
* Penggunaan `AlertDialog`.
* Penggunaan `SnackBar`.

Kode yang digunakan untuk aplikasi tugas memang mengimplementasikan fitur tambah, toggle, edit, hapus, serta penghapusan semua tugas selesai melalui `TugasModel`. 

---

# 27. Troubleshooting

## 27.1 Data tidak berubah di layar

Pastikan setelah mengubah data terdapat:

```dart
notifyListeners();
```

Tanpa pemberitahuan tersebut, widget yang bergantung pada model tidak akan menerima pembaruan state.

---

## 27.2 Provider tidak dikenali

Pastikan import berikut tersedia:

```dart
import 'package:provider/provider.dart';
```

Dan package `provider` sudah ditambahkan pada project.

---

## 27.3 Dialog tidak tertutup

Gunakan:

```dart
Navigator.pop(dialogContext);
```

`Navigator.pop()` digunakan untuk menutup dialog setelah proses selesai.

---

## 27.4 Input kosong tetap tersimpan

Pastikan terdapat pemeriksaan:

```dart
if (judul.trim().isEmpty) {
  return;
}
```

atau validasi pada `TextFormField`.

---

# 28. Kesimpulan

Pada Praktikum Pertemuan 3, telah dipelajari bagaimana membuat aplikasi Flutter yang dapat menerima dan mengelola input dari pengguna.

Materi utama yang dipelajari meliputi **Form, TextFormField, validasi, Dialog, Checkbox, ListView, Provider, ChangeNotifier, dan pengelolaan state**.

Melalui aplikasi **Daftar Tugas**, data dapat ditambahkan, diubah, ditandai selesai, dan dihapus. Aplikasi juga dapat menampilkan jumlah tugas yang telah selesai.

Selain itu, melalui aplikasi **Daftar Belanja**, dipelajari bagaimana membuat form input dengan beberapa field serta menampilkan data yang telah dimasukkan ke dalam daftar.

Dengan demikian, Praktikum 3 memperkenalkan proses pengembangan aplikasi Flutter yang lebih interaktif karena aplikasi tidak hanya menampilkan informasi, tetapi juga dapat **menerima input, memvalidasi, menyimpan, mengubah, dan menghapus data**.
