import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}

// =====================================================
// MODEL BELANJA
// =====================================================

class Belanja {
  String nama;
  int jumlah;
  String kategori;

  Belanja({
    required this.nama,
    required this.jumlah,
    required this.kategori,
  });
}

class BelanjaModel extends ChangeNotifier {
  final List<Belanja> items = [];

  // Menambahkan barang
  void tambah(String nama, int jumlah, String kategori) {
    items.add(
      Belanja(
        nama: nama,
        jumlah: jumlah,
        kategori: kategori,
      ),
    );

    notifyListeners();
  }

  // Menghapus barang
  void hapus(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}

// =====================================================
// APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Belanja',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const BelanjaPage(),
    );
  }
}

// =====================================================
// HALAMAN DAFTAR BELANJA
// =====================================================

class BelanjaPage extends StatelessWidget {
  const BelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja'),
      ),

      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Belum ada barang',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, index) {
          final barang = model.items[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text('${barang.jumlah}'),
            ),

            title: Text(barang.nama),

            subtitle: Text(
              'Kategori: ${barang.kategori}',
            ),

            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<BelanjaModel>().hapus(index);
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahBelanjaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// =====================================================
// FORM TAMBAH BELANJA
// =====================================================

class TambahBelanjaPage extends StatefulWidget {
  const TambahBelanjaPage({super.key});

  @override
  State<TambahBelanjaPage> createState() =>
      _TambahBelanjaPageState();
}

class _TambahBelanjaPageState
    extends State<TambahBelanjaPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController =
  TextEditingController();

  final TextEditingController _jumlahController =
  TextEditingController();

  String? _kategori;

  final List<String> kategoriList = [
    'Makanan',
    'Minuman',
    'Kebutuhan Rumah',
    'Alat Tulis',
    'Lainnya',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  // =====================================================
  // SIMPAN DATA
  // =====================================================

  void _tambahBarang() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();
    final jumlah = int.parse(_jumlahController.text.trim());

    context.read<BelanjaModel>().tambah(
      nama,
      jumlah,
      _kategori!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barang berhasil ditambahkan'),
      ),
    );

    Navigator.pop(context);
  }

  // =====================================================
  // BUILD FORM
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Belanja'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // ==========================================
              // NAMA BARANG
              // ==========================================

              TextFormField(
                controller: _namaController,

                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  hintText: 'Masukkan nama barang',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama barang wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ==========================================
              // JUMLAH
              // ==========================================

              TextFormField(
                controller: _jumlahController,

                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  hintText: 'Masukkan jumlah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Jumlah wajib diisi';
                  }

                  final jumlah = int.tryParse(
                    value.trim(),
                  );

                  if (jumlah == null) {
                    return 'Jumlah harus berupa angka';
                  }

                  if (jumlah <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ==========================================
              // KATEGORI
              // ==========================================

              DropdownButtonFormField<String>(
                value: _kategori,

                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),

                hint: const Text(
                  'Pilih kategori',
                ),

                items: kategoriList.map((kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    _kategori = value;
                  });
                },

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori wajib dipilih';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ==========================================
              // TOMBOL TAMBAH
              // ==========================================

              ElevatedButton.icon(
                onPressed: _tambahBarang,

                icon: const Icon(Icons.add),

                label: const Text(
                  'Tambah Barang',
                ),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}