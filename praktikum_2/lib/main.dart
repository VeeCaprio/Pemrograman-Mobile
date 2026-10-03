import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// MODEL DATA KONTAK
// =====================================================

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

// =====================================================
// DATA KONTAK
// =====================================================

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
  Kontak(
    nama: 'Citra Lestari',
    nomorTelepon: '082112345678',
    email: 'citra@gmail.com',
  ),
  Kontak(
    nama: 'Dina Permata',
    nomorTelepon: '082198765432',
    email: 'dina@gmail.com',
  ),
  Kontak(
    nama: 'Eko Pratama',
    nomorTelepon: '083812345678',
    email: 'eko@gmail.com',
  ),
  Kontak(
    nama: 'Fajar Ramadhan',
    nomorTelepon: '085712345678',
    email: 'fajar@gmail.com',
  ),
];

// =====================================================
// APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Kontak',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const KontakPage(),
    );
  }
}

// =====================================================
// HALAMAN DAFTAR KONTAK
// =====================================================

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),

      body: ListView.builder(
        itemCount: daftarKontak.length,

        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            child: ListTile(
              // Avatar berisi huruf pertama nama
              leading: CircleAvatar(
                child: Text(
                  kontak.nama[0],
                ),
              ),

              // Nama kontak
              title: Text(
                kontak.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Nomor telepon
              subtitle: Text(
                kontak.nomorTelepon,
              ),

              // Icon navigasi
              trailing: const Icon(
                Icons.chevron_right,
              ),

              // Membuka halaman detail
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailKontakPage(
                      kontak: kontak,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// =====================================================
// HALAMAN DETAIL KONTAK
// =====================================================

class DetailKontakPage extends StatelessWidget {
  final Kontak kontak;

  const DetailKontakPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kontak.nama),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar besar
            CircleAvatar(
              radius: 50,
              child: Text(
                kontak.nama[0],
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Nama
            Text(
              kontak.nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // Nomor telepon
            ListTile(
              leading: const Icon(
                Icons.phone,
              ),
              title: const Text(
                'Nomor Telepon',
              ),
              subtitle: Text(
                kontak.nomorTelepon,
              ),
            ),

            // Email
            ListTile(
              leading: const Icon(
                Icons.email,
              ),
              title: const Text(
                'Email',
              ),
              subtitle: Text(
                kontak.email,
              ),
            ),

            const SizedBox(height: 24),

            // Tombol kembali
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back,
              ),

              label: const Text(
                'Kembali',
              ),
            ),
          ],
        ),
      ),
    );
  }
}