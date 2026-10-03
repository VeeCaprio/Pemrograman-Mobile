

# CATATAN PRAKTIKUM PERTEMUAN 1

## PENGENALAN FLUTTER

### A. Identitas Praktikum

**Mata Kuliah:** Pemrograman Mobile
**Pertemuan:** 1
**Materi:** Pengenalan Flutter
**Nama:** Vramudhia Egy Pratama
**NIM:** 20240801382
**Program Studi:** Teknik Informatika
**Fakultas:** Ilmu Komputer

---

# B. Tujuan Praktikum

Praktikum Pertemuan 1 bertujuan untuk mengenal dasar-dasar pengembangan aplikasi mobile menggunakan **Flutter**.

Setelah melakukan praktikum, mahasiswa diharapkan dapat:

1. Mengenal framework Flutter.
2. Mengenal struktur dasar project Flutter.
3. Memahami file `main.dart`.
4. Memahami konsep widget pada Flutter.
5. Menggunakan `MaterialApp` dan `Scaffold`.
6. Membuat tampilan menggunakan `AppBar`, `Text`, `Icon`, `Column`, dan `Center`.
7. Memahami konsep `StatefulWidget`.
8. Menggunakan `setState()` untuk mengubah tampilan.
9. Membuat aplikasi counter sederhana.
10. Membuat tombol interaktif menggunakan `FloatingActionButton`.
11. Membuat tampilan kartu informasi menggunakan `Card`.
12. Menjalankan aplikasi Flutter menggunakan emulator Android.

Pada hasil praktikum, penggunaan widget dasar dan `StatefulWidget` memang menjadi bagian utama pembelajaran. 

---

# C. Pengenalan Flutter

**Flutter** adalah framework yang digunakan untuk membuat aplikasi dengan menggunakan bahasa pemrograman **Dart**.

Flutter menggunakan konsep **widget** untuk membangun tampilan aplikasi. Setiap bagian dari tampilan aplikasi dapat berupa widget, misalnya:

* `Text`
* `Icon`
* `Column`
* `Row`
* `Container`
* `Card`
* `AppBar`
* `Scaffold`
* `ElevatedButton`

Pada praktikum, beberapa widget tersebut digunakan untuk membuat tampilan aplikasi sederhana. 

---

# D. Persiapan Praktikum

Perangkat yang digunakan untuk pengembangan Flutter pada praktikum adalah:

1. Flutter SDK
2. Android Studio
3. Android SDK
4. Emulator Android
5. Dart
6. Project Flutter

Pertemuan berikutnya dalam modul menggunakan Flutter SDK, editor seperti VS Code/Android Studio, serta emulator/perangkat sebagai kelanjutan dari instalasi dan widget dasar pada Pertemuan 1. 

---

# E. Membuat Project Flutter

Project Flutter dapat dibuat menggunakan terminal.

Perintah yang digunakan:

```bash
flutter create praktikum_1
```

Kemudian masuk ke folder project:

```bash
cd praktikum_1
```

Setelah project dibuat, struktur utamanya kurang lebih:

```text
praktikum_1/
│
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
├── web/
├── pubspec.yaml
└── README.md
```

File yang paling sering digunakan pada praktikum dasar adalah:

```text
lib/main.dart
```

File `main.dart` merupakan tempat kode utama aplikasi Flutter ditulis.

---

# F. Struktur Dasar Program Flutter

Struktur paling dasar aplikasi Flutter adalah:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
```

### Penjelasan:

### 1. `import`

```dart
import 'package:flutter/material.dart';
```

Digunakan untuk mengimpor library Material Flutter sehingga widget seperti `Scaffold`, `AppBar`, `Text`, dan lainnya dapat digunakan.

### 2. `main()`

```dart
void main()
```

Merupakan fungsi utama yang pertama kali dijalankan ketika aplikasi dimulai.

### 3. `runApp()`

```dart
runApp(const MyApp());
```

Digunakan untuk menjalankan widget utama aplikasi.

---

# G. Praktikum 1 — Tampilan Awal Flutter

Pada tahap pertama dibuat tampilan sederhana dengan judul **Hello Flutter**.

Hasil aplikasi menampilkan:

* Judul **Hello Flutter**
* Logo Flutter
* Tulisan **“Halo, nama saya Vramudhia!”**
* NIM **20240801382**

Tampilan tersebut dibuat menggunakan beberapa widget dasar seperti `MaterialApp`, `Scaffold`, `AppBar`, `Center`, `Column`, `Icon`, `SizedBox`, dan `Text`. 

### Contoh struktur:

```dart
MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: const Text('Hello Flutter'),
    ),
    body: Center(
      child: Column(
        children: [
          const Icon(Icons.flutter_dash),
          const SizedBox(height: 20),
          const Text('Halo, nama saya Vramudhia!'),
          const Text('20240801382'),
        ],
      ),
    ),
  ),
);
```

---

# H. Penjelasan Widget Dasar

## 1. MaterialApp

`MaterialApp` digunakan sebagai widget utama aplikasi.

Contoh:

```dart
MaterialApp(
  home: const HomePage(),
)
```

---

## 2. Scaffold

`Scaffold` menyediakan struktur dasar sebuah halaman Flutter.

Contohnya:

```dart
Scaffold(
  appBar: AppBar(),
  body: ...
)
```

---

## 3. AppBar

`AppBar` digunakan sebagai bagian atas aplikasi.

Contoh:

```dart
AppBar(
  title: const Text('Hello Flutter'),
)
```

Pada praktikum, `AppBar` digunakan untuk menampilkan judul **Hello Flutter**. 

---

## 4. Text

Widget `Text` digunakan untuk menampilkan tulisan.

Contoh:

```dart
Text('Halo, nama saya Vramudhia!')
```

---

## 5. Icon

Widget `Icon` digunakan untuk menampilkan ikon.

Contoh:

```dart
Icon(Icons.person)
```

---

## 6. Center

`Center` digunakan untuk menempatkan widget di tengah area yang tersedia.

```dart
Center(
  child: Text('Hello Flutter'),
)
```

---

## 7. Column

`Column` digunakan untuk menyusun beberapa widget secara vertikal.

```text
Widget 1
   ↓
Widget 2
   ↓
Widget 3
```

Contoh:

```dart
Column(
  children: [
    Text('Nama'),
    Text('NIM'),
  ],
)
```

---

## 8. SizedBox

`SizedBox` dapat digunakan untuk memberikan jarak antar-widget.

Contoh:

```dart
const SizedBox(height: 20)
```

---

# I. Praktikum 2 — StatefulWidget dan Counter

Setelah mempelajari widget dasar, praktikum dilanjutkan dengan membuat aplikasi **Counter Saya**.

Tujuannya adalah memahami bagaimana data yang berubah dapat diperbarui pada tampilan Flutter.

Pada laporan, aplikasi Counter digunakan untuk memahami konsep `StatefulWidget` dan perubahan nilai. 

---

# J. Apa Itu StatefulWidget?

`StatefulWidget` digunakan ketika sebuah widget memiliki **data atau keadaan (state) yang dapat berubah**.

Contohnya adalah counter.

Nilai awal:

```dart
int _count = 0;
```

Kemudian nilai tersebut dapat berubah ketika tombol ditekan.

Pada laporan, `_count` digunakan sebagai variabel penyimpan nilai counter. 

---

# K. Fungsi setState()

Untuk mengubah tampilan ketika nilai counter berubah digunakan:

```dart
setState(() => _count++);
```

Artinya:

```text
Nilai _count bertambah 1
        ↓
State berubah
        ↓
Flutter memperbarui tampilan
```

Contohnya:

```text
Nilai awal : 0
Tekan +    : 1
Tekan +    : 2
Tekan +    : 3
```

Penggunaan `setState()` menyebabkan tampilan diperbarui setelah nilai counter berubah. 

---

# L. Praktikum 3 — Counter dengan Tiga Tombol

Counter kemudian dikembangkan dengan tiga tombol:

| Tombol | Fungsi           |
| ------ | ---------------- |
| `+`    | Menambah nilai   |
| `−`    | Mengurangi nilai |
| `↻`    | Reset nilai      |

Ketiga tombol dibuat menggunakan `FloatingActionButton`. 

---

## 1. Tombol Tambah

Fungsi tombol tambah:

```dart
onPressed: _tambah,
```

Digunakan untuk menambah nilai counter.

---

## 2. Tombol Kurang

Fungsi tombol kurang:

```dart
onPressed: _kurang,
```

Digunakan untuk mengurangi nilai counter.

---

## 3. Tombol Reset

Fungsi tombol reset:

```dart
onPressed: _reset,
```

Digunakan untuk mengembalikan nilai counter ke kondisi awal.

Ketiga fungsi tersebut tercatat dalam hasil praktikum. 

---

# M. Hasil Pengujian Counter

Pada emulator, nilai counter terlihat mencapai:

```text
3
```

Hal tersebut menunjukkan bahwa tombol tambah berhasil digunakan beberapa kali dan nilai counter berubah sesuai interaksi pengguna. 

---

# N. Praktikum 4 — Kartu Perkenalan

Tahap selanjutnya adalah membuat **Kartu Perkenalan**.

Kartu digunakan untuk menampilkan informasi pribadi mahasiswa.

Informasi yang ditampilkan adalah:

**Nama:** Vramudhia Egy Pratama
**NIM:** 20240801382
**Program Studi:** Teknik Informatika
**Hobi:** Coding & Bermain Game

Selain informasi tersebut terdapat:

* Ikon profil
* Tombol **Halo!**
* Ikon hati



---

# O. Widget Card

Widget:

```dart
Card()
```

digunakan untuk membuat tampilan berbentuk kartu.

Pada praktikum ini `Card` digunakan sebagai wadah untuk mengelompokkan informasi pribadi mahasiswa.

---

# P. ElevatedButton.icon

Tombol **Halo!** dibuat menggunakan:

```dart
ElevatedButton.icon()
```

Widget tersebut memungkinkan tombol memiliki:

* Teks
* Ikon
* Fungsi ketika ditekan

Pada hasil praktikum, tombol menggunakan ikon hati. 

---

# Q. Konsep Penting yang Dipelajari

Dari seluruh kegiatan Pertemuan 1, terdapat beberapa konsep penting.

### 1. Widget

Flutter menggunakan widget sebagai komponen utama antarmuka.

### 2. Layout

Widget dapat disusun menggunakan `Column`, `Center`, dan widget layout lainnya.

### 3. StatelessWidget

Digunakan ketika tampilan tidak memiliki data yang berubah.

### 4. StatefulWidget

Digunakan ketika terdapat data yang dapat berubah selama aplikasi berjalan.

### 5. State

State adalah data atau keadaan yang menentukan kondisi tampilan.

Contohnya:

```dart
int _count = 0;
```

### 6. setState()

Digunakan untuk memberi tahu Flutter bahwa state telah berubah.

### 7. Event

Tombol dapat menjalankan fungsi tertentu ketika ditekan melalui `onPressed`.

---

# R. Alur Praktikum Pertemuan 1

Secara keseluruhan, alurnya dapat diringkas:

```text
Persiapan Flutter
       ↓
Membuat Project
       ↓
Mengenal main.dart
       ↓
Mengenal Widget
       ↓
Membuat Hello Flutter
       ↓
Mengenal StatefulWidget
       ↓
Membuat Counter
       ↓
Menggunakan setState()
       ↓
Membuat tombol +, −, Reset
       ↓
Membuat Kartu Perkenalan
       ↓
Menjalankan pada Emulator
       ↓
Melakukan Pengujian
```

Urutan tersebut sesuai dengan hasil laporan, yang menunjukkan pembelajaran dari tampilan dasar, Counter, pengubahan nilai menggunakan tombol, hingga Kartu Perkenalan. 

---

# S. Hasil Praktikum

Hasil yang diperoleh dari praktikum adalah:

1. Berhasil membuat project Flutter.
2. Berhasil menjalankan aplikasi pada emulator Android.
3. Berhasil membuat tampilan **Hello Flutter**.
4. Berhasil menampilkan nama dan NIM.
5. Berhasil membuat aplikasi Counter.
6. Berhasil mengubah nilai counter menggunakan `setState()`.
7. Berhasil menambahkan tombol tambah, kurang, dan reset.
8. Berhasil membuat Kartu Perkenalan.
9. Berhasil menggunakan berbagai widget Flutter.

Pada laporan, project `praktikum_1` dinyatakan berhasil dijalankan pada emulator Android. 

---

# T. Kesimpulan

Praktikum Pertemuan 1 memberikan pemahaman dasar mengenai pengembangan aplikasi mobile menggunakan Flutter. Pada praktikum ini dipelajari struktur dasar aplikasi Flutter, penggunaan berbagai widget, pembuatan layout sederhana, serta konsep `StatefulWidget` dan `setState()`.

Melalui aplikasi Counter, dapat dipahami bahwa perubahan nilai pada state dapat menyebabkan tampilan aplikasi diperbarui. Selanjutnya, melalui Kartu Perkenalan, beberapa widget dapat digabungkan untuk membuat antarmuka yang menampilkan informasi pribadi.

Dengan demikian, Praktikum Pertemuan 1 menjadi dasar untuk mempelajari materi Flutter berikutnya, khususnya **layout, ListView, pemodelan data, dan navigasi antarhalaman**. Modul Pertemuan 2 juga menyebutkan bahwa instalasi, widget dasar, dan `StatefulWidget` dari Pertemuan 1 menjadi prasyarat untuk materi berikutnya. 
