

# CATATAN PRAKTIKUM PERTEMUAN 2

## Layout, ListView, dan Navigasi Antar Halaman

### A. Identitas Praktikum

**Mata Kuliah:** Pemrograman Mobile
**Pertemuan:** 2
**Materi:** Layout, ListView, dan Navigasi Antar Halaman
**Level:** Pemula
**Durasi:** 100–150 menit
**Prasyarat:** Menyelesaikan Pertemuan 1, yaitu instalasi, widget dasar, dan `StatefulWidget`. 

---

# B. Tujuan Praktikum

Setelah menyelesaikan praktikum ini, mahasiswa diharapkan mampu:

1. Menyusun layout menggunakan `Container`, `Padding`, `Row`, `Column`, dan `Expanded`.
2. Menampilkan daftar data menggunakan `ListView.builder`, `Card`, dan `ListTile`.
3. Memodelkan data sederhana menggunakan `class` Dart.
4. Berpindah halaman menggunakan `Navigator.push` dan `Navigator.pop`.
5. Mengirim data dari halaman daftar ke halaman detail. 

---

# C. Alat dan Bahan

Alat dan bahan yang digunakan:

* Flutter SDK
* VS Code atau Android Studio
* Emulator/perangkat dari Pertemuan 1
* Project Flutter baru

Project yang digunakan:

```bash
flutter create praktikum_2
```

Kemudian masuk ke folder project:

```bash
cd praktikum_2
```

Modul secara khusus menggunakan project **`praktikum_2`** untuk praktikum ini. 

---

# D. Materi Teori

## 1. Container

`Container` merupakan widget serbaguna yang dapat digunakan untuk mengatur:

* ukuran
* warna
* border
* radius
* padding
* margin

Contoh:

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(12),
  ),
  child: ...
)
```

Dalam praktikum, `Container` digunakan sebagai bagian dari kartu profil. 

---

# E. Padding

`Padding` digunakan untuk memberikan jarak di sekeliling widget anak.

Contoh:

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: ...
)
```

Dengan `Padding`, isi tampilan tidak langsung menempel pada batas halaman.

---

# F. Row

`Row` digunakan untuk menyusun beberapa widget secara **horizontal**.

Contoh struktur:

```text
[Avatar]   [Nama dan NIM]
```

Pada kartu profil, avatar ditempatkan di sebelah kiri dan informasi profil berada di sebelah kanan. 

---

# G. Column

`Column` digunakan untuk menyusun widget secara **vertikal**.

Contoh:

```text
Nama
NIM
```

Pada kartu profil, nama dan NIM disusun secara vertikal menggunakan `Column`.

---

# H. Expanded

`Expanded` digunakan untuk membuat widget anak mengisi sisa ruang yang tersedia pada `Row` atau `Column`.

Contoh:

```dart
Expanded(
  child: Column(
    children: [
      Text('Nama'),
      Text('NIM'),
    ],
  ),
)
```

Dalam praktikum, `Expanded` digunakan agar bagian teks profil dapat menggunakan ruang yang tersedia di sebelah avatar.

Modul juga memberikan checkpoint dengan mencoba menghapus `Expanded` dan memperpanjang nama untuk melihat perbedaannya. 

---

# I. Sumbu Layout

Pada `Row`:

```text
Main Axis    → horizontal
Cross Axis   → vertikal
```

Sedangkan pada `Column`:

```text
Main Axis    → vertikal
Cross Axis   → horizontal
```

Pengaturan posisi dapat dilakukan menggunakan:

```dart
mainAxisAlignment
crossAxisAlignment
```

Konsep ini penting untuk mengatur posisi widget di dalam `Row` dan `Column`. 

---

# J. Bagian A — Layout Kartu Profil

Pada tahap pertama dibuat **Kartu Profil**.

Tujuannya adalah memahami penggunaan:

* `Container`
* `Padding`
* `Row`
* `Column`
* `Expanded`
* `CircleAvatar`
* `Text`

---

## 1. Struktur Tampilan

Secara sederhana, struktur kartu profil adalah:

```text
┌─────────────────────────────────┐
│                                 │
│   (👤)     Nama                 │
│            NIM                  │
│                                 │
└─────────────────────────────────┘
```

Avatar berada di sebelah kiri, sedangkan nama dan NIM berada di sebelah kanan.

---

## 2. Container

Kartu menggunakan `Container` dengan:

* padding
* warna latar
* sudut membulat

Contohnya:

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(12),
  ),
)
```

---

## 3. CircleAvatar

Avatar dibuat menggunakan:

```dart
CircleAvatar(
  radius: 32,
  child: Icon(
    Icons.person,
    size: 32,
  ),
)
```

Widget ini digunakan untuk menampilkan ikon profil berbentuk lingkaran. 

---

## 4. Informasi Profil

Nama dan NIM ditampilkan menggunakan `Column`:

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      '[NAMA]',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text('[NIM]'),
  ],
)
```

`crossAxisAlignment: CrossAxisAlignment.start` membuat teks berada di sisi kiri.

---

# K. Checkpoint Bagian A

Hasil yang harus dicapai:

> Kartu profil tampil dengan avatar di kiri dan teks di kanan.

Selain itu, mahasiswa diminta mencoba menghapus `Expanded` dan memperpanjang nama untuk melihat perbedaannya. 

---

# L. Bagian B — Model Data dan ListView

Pada tahap kedua dibuat aplikasi **Daftar Menu**.

Pada tahap ini mahasiswa mulai memodelkan data menggunakan `class` Dart dan menampilkan data menggunakan `ListView.builder`.

---

# M. Membuat Class Makanan

Model data dibuat menggunakan:

```dart
class Makanan {
  final String nama;
  final int harga;

  const Makanan(this.nama, this.harga);
}
```

Class `Makanan` memiliki dua properti:

* `nama`
* `harga`

Dengan menggunakan class, data makanan dapat disimpan dalam bentuk objek. 

---

# N. Membuat Daftar Menu

Data makanan kemudian dimasukkan ke dalam list:

```dart
const daftarMenu = [
  Makanan('Nasi Goreng', 15000),
  Makanan('Mie Ayam', 12000),
  Makanan('Es Teh', 4000),
  Makanan('Ayam Bakar', 20000),
];
```

Jadi terdapat empat menu:

| Menu        |    Harga |
| ----------- | -------: |
| Nasi Goreng | Rp15.000 |
| Mie Ayam    | Rp12.000 |
| Es Teh      |  Rp4.000 |
| Ayam Bakar  | Rp20.000 |

Data tersebut sesuai dengan daftar yang terdapat pada modul. 

---

# O. ListView.builder

`ListView.builder` digunakan untuk menampilkan data dalam bentuk daftar.

Contoh:

```dart
ListView.builder(
  itemCount: daftarMenu.length,
  itemBuilder: (context, index) {
    final item = daftarMenu[index];

    return ...
  },
)
```

`itemCount` menentukan jumlah data yang ditampilkan, sedangkan `itemBuilder` membuat tampilan setiap item.

Menurut modul, `ListView.builder` merupakan daftar yang di-render sesuai kebutuhan sehingga efisien untuk data yang banyak. 

---

# P. Card dan ListTile

Setiap menu ditampilkan menggunakan:

```dart
Card(
  child: ListTile(
    leading: const Icon(Icons.restaurant),
    title: Text(item.nama),
    subtitle: Text('Rp ${item.harga}'),
    trailing: const Icon(Icons.chevron_right),
  ),
)
```

Struktur tampilannya:

```text
┌──────────────────────────────────┐
│ 🍴  Nasi Goreng          >       │
│     Rp 15000                     │
└──────────────────────────────────┘
```

### Fungsi bagian-bagiannya:

**`leading`**
Menampilkan ikon di sebelah kiri.

**`title`**
Menampilkan nama makanan.

**`subtitle`**
Menampilkan harga.

**`trailing`**
Menampilkan ikon di sebelah kanan.

Modul menggunakan `Card` dan `ListTile` untuk membuat setiap menu menjadi kartu daftar. 

---

# Q. Checkpoint Bagian B

Hasil yang diharapkan:

> Empat menu tampil sebagai kartu yang dapat di-scroll.

Halaman utama kemudian diarahkan ke:

```dart
home: const MenuPage()
```



---

# R. Bagian C — Navigasi ke Halaman Detail

Tahap ketiga adalah membuat navigasi dari halaman **Daftar Menu** ke halaman **Detail**.

Ketika pengguna mengetuk salah satu menu, aplikasi akan membuka halaman detail menu tersebut.

---

# S. Navigator.push

Navigasi dilakukan menggunakan:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailPage(
      makanan: item,
    ),
  ),
);
```

`Navigator.push` digunakan untuk menambahkan halaman baru ke dalam stack navigasi.

Alurnya:

```text
Daftar Menu
     │
     │ klik menu
     ↓
Detail Menu
```

Data makanan yang dipilih juga dikirim ke halaman detail melalui constructor. 

---

# T. Mengirim Data ke DetailPage

Halaman detail menerima objek `Makanan`:

```dart
class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });
}
```

Dengan cara tersebut, halaman detail dapat mengetahui makanan mana yang dipilih.

Misalnya pengguna memilih:

```text
Nasi Goreng
```

maka `DetailPage` menerima objek Nasi Goreng dan menampilkan datanya.

---

# U. Tampilan Detail Menu

Halaman detail menampilkan:

* Ikon makanan
* Nama makanan
* Harga
* Tombol Kembali

Contoh:

```dart
Text(
  makanan.nama,
  style: const TextStyle(
    fontSize: 24,
  ),
),

Text('Rp ${makanan.harga}'),
```

Dengan demikian, informasi yang ditampilkan sesuai dengan menu yang dipilih. 

---

# V. Navigator.pop

Untuk kembali ke halaman sebelumnya digunakan:

```dart
Navigator.pop(context);
```

Contohnya pada tombol:

```dart
ElevatedButton(
  onPressed: () => Navigator.pop(context),
  child: const Text('Kembali'),
)
```

Alurnya:

```text
Daftar Menu
     ↓
Detail Menu
     ↓
   Kembali
     ↓
Daftar Menu
```

Modul menyatakan bahwa mengetuk menu harus membuka halaman detail dengan data yang sesuai dan tombol **Kembali** atau tombol back harus menutup halaman detail. 

---

# W. Latihan Mandiri

Modul memberikan empat latihan mandiri.

### Latihan 1

Tambahkan **3 menu baru** ke `daftarMenu`.

Pastikan daftar tetap dapat di-scroll.

---

### Latihan 2

Tambahkan properti:

```dart
deskripsi
```

pada class `Makanan`.

Kemudian tampilkan deskripsi tersebut pada `DetailPage`.

---

### Latihan 3

Ganti widget `Card` dengan `Container` yang memiliki:

* warna latar
* sudut membulat

---

### Latihan 4

Tampilkan harga menggunakan format ribuan.

Contohnya:

```text
15000
```

menjadi:

```text
15.000
```

Modul menyarankan menggunakan fungsi buatan sendiri untuk melakukan format tersebut. 

---

# X. Tugas Utama — Daftar Kontak

Tugas Pertemuan 2 adalah membuat aplikasi **Daftar Kontak**.

Ketentuannya:

1. Minimal **6 kontak**.
2. Setiap kontak memiliki:

   * nama
   * nomor telepon
   * email
3. Data disimpan dalam list yang berisi objek dari sebuah class.
4. Halaman utama menggunakan:

   * `ListView.builder`
   * `ListTile`
5. Avatar berisi huruf pertama nama.
6. Ketika kontak diketuk, aplikasi membuka halaman detail.
7. Halaman detail menampilkan seluruh data kontak.
8. Terdapat tombol kembali.
9. Yang dikumpulkan:

   * screenshot kedua halaman
   * `main.dart` atau tautan repository. 

---

# Y. Struktur Data Kontak

Untuk tugas tersebut, data dapat dimodelkan dengan class:

```dart
class Kontak {
  final String nama;
  final String nomorTelepon;
  final String email;

  const Kontak({
    required this.nama,
    required this.nomorTelepon,
    required this.email,
  });
}
```

Kemudian dibuat list kontak.

Contohnya:

```dart
const daftarKontak = [
  Kontak(
    nama: 'Andi Saputra',
    nomorTelepon: '081234567890',
    email: 'andi@gmail.com',
  ),
  Kontak(
    nama: 'Budi Santoso',
    nomorTelepon: '081298765432',
    email: 'budi@gmail.com',
  ),
];
```

Untuk memenuhi tugas, jumlah kontak minimal adalah enam. 

---

# Z. Tampilan Daftar Kontak

Setiap kontak ditampilkan menggunakan `ListTile`.

Strukturnya dapat berupa:

```text
┌────────────────────────────────────┐
│  A    Andi Saputra          >      │
│       081234567890                 │
└────────────────────────────────────┘
```

Avatar menggunakan huruf pertama nama.

Misalnya:

```dart
CircleAvatar(
  child: Text(kontak.nama[0]),
)
```

Untuk:

```text
Andi Saputra
```

maka avatar menampilkan:

```text
A
```

---

# AA. Navigasi Daftar Kontak ke Detail

Ketika pengguna mengetuk kontak:

```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DetailKontakPage(
        kontak: kontak,
      ),
    ),
  );
}
```

Objek kontak dikirim ke halaman detail.

Kemudian halaman detail menampilkan:

```text
Andi Saputra

Nomor Telepon
081234567890

Email
andi@gmail.com

[Kembali]
```

---

# AB. Pengujian

## 1. Pengujian Kartu Profil

**Input:** menjalankan halaman profil.

**Hasil yang diharapkan:**

* Avatar tampil di kiri.
* Nama tampil di kanan.
* NIM tampil di bawah nama.

---

## 2. Pengujian Daftar Menu

**Input:** membuka halaman Daftar Menu.

**Hasil yang diharapkan:**

Empat menu tampil:

* Nasi Goreng
* Mie Ayam
* Es Teh
* Ayam Bakar

Daftar dapat di-scroll. 

---

## 3. Pengujian Navigasi

**Input:** mengetuk salah satu menu.

**Hasil yang diharapkan:**

Aplikasi membuka halaman detail dan menampilkan data menu yang dipilih.

---

## 4. Pengujian Tombol Kembali

**Input:** menekan tombol Kembali.

**Hasil yang diharapkan:**

Aplikasi kembali ke halaman Daftar Menu.

---

## 5. Pengujian Daftar Kontak

**Input:** membuka aplikasi Daftar Kontak.

**Hasil yang diharapkan:**

Minimal enam kontak tampil dalam daftar.

---

## 6. Pengujian Detail Kontak

**Input:** mengetuk salah satu kontak.

**Hasil yang diharapkan:**

Halaman detail menampilkan:

* nama
* nomor telepon
* email

serta tombol kembali. Ketentuan tersebut merupakan bagian dari tugas Daftar Kontak pada modul. 

---

# AC. Troubleshooting

Modul mencantumkan beberapa masalah umum.

| Masalah                                   | Solusi                                                       |
| ----------------------------------------- | ------------------------------------------------------------ |
| Garis kuning-hitam/overflow               | Gunakan `Expanded` atau `SingleChildScrollView`              |
| `ListView` tanpa tinggi di dalam `Column` | Bungkus `ListView` dengan `Expanded`                         |
| Navigator error                           | Pastikan halaman berada di bawah `MaterialApp`               |
| Perubahan kode tidak muncul               | Gunakan hot restart jika mengubah `main()` atau data `const` |



---

# AD. Pertanyaan Refleksi

### 1. Apa perbedaan ListView biasa dengan ListView.builder?

`ListView.builder` membuat item daftar sesuai kebutuhan melalui `itemBuilder` dan cocok digunakan untuk data yang banyak.

### 2. Mengapa Row yang berisi teks panjang dapat menyebabkan overflow?

Karena ruang horizontal pada `Row` terbatas. `Expanded` membantu dengan membuat widget anak menggunakan sisa ruang yang tersedia.

### 3. Bagaimana data dikirim dari halaman daftar ke halaman detail?

Data dikirim melalui constructor halaman detail ketika `Navigator.push` digunakan.

Contohnya:

```dart
DetailPage(
  makanan: item,
)
```

Ketiga pertanyaan tersebut merupakan pertanyaan refleksi yang tercantum dalam modul Pertemuan 2. 

---

# AE. Kesimpulan

Pada Praktikum Pertemuan 2 dipelajari konsep **layout, pembuatan daftar data, pemodelan data menggunakan class Dart, serta navigasi antar halaman**.

Pada bagian layout, digunakan `Container`, `Padding`, `Row`, `Column`, dan `Expanded`. Selanjutnya, data makanan dimodelkan menggunakan class `Makanan` dan ditampilkan menggunakan `ListView.builder`, `Card`, serta `ListTile`.

Kemudian dipelajari navigasi menggunakan `Navigator.push` untuk membuka halaman baru dan `Navigator.pop` untuk kembali ke halaman sebelumnya. Data dari halaman daftar dapat dikirim ke halaman detail melalui constructor.

Pada tugas akhir, seluruh konsep tersebut diterapkan dalam aplikasi **Daftar Kontak** yang memiliki minimal enam kontak, halaman daftar, halaman detail, dan navigasi antar halaman.  

### Ringkasan alur Pertemuan 2

```text
Flutter Project
      ↓
Layout Kartu Profil
      ↓
Container + Padding
      ↓
Row + Column + Expanded
      ↓
Model Data Makanan
      ↓
ListView.builder
      ↓
Card + ListTile
      ↓
Navigator.push
      ↓
Halaman Detail
      ↓
Navigator.pop
      ↓
Tugas Daftar Kontak
```


