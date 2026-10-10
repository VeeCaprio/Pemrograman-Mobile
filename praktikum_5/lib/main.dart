import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// MODEL PENGELUARAN
// =====================================================

class Pengeluaran {
  final int? id;
  final String nama;
  final int jumlah;
  final String kategori;
  final String tanggal;

  const Pengeluaran({
    this.id,
    required this.nama,
    required this.jumlah,
    required this.kategori,
    required this.tanggal,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jumlah': jumlah,
      'kategori': kategori,
      'tanggal': tanggal,
    };
  }

  factory Pengeluaran.fromMap(Map<String, Object?> map) {
    return Pengeluaran(
      id: map['id'] as int?,
      nama: map['nama'] as String,
      jumlah: map['jumlah'] as int,
      kategori: map['kategori'] as String,
      tanggal: map['tanggal'] as String,
    );
  }
}

// =====================================================
// DATABASE HELPER
// =====================================================

class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'pengeluaran.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pengeluaran (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT NOT NULL,
            jumlah INTEGER NOT NULL,
            kategori TEXT NOT NULL,
            tanggal TEXT NOT NULL
          )
        ''');
      },
    );

    // Aman jika database sudah pernah dibuat sebelumnya.
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS pengeluaran (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        jumlah INTEGER NOT NULL,
        kategori TEXT NOT NULL,
        tanggal TEXT NOT NULL
      )
    ''');

    return _db!;
  }

  static Future<List<Pengeluaran>> semua() async {
    final db = await database;

    final rows = await db.query(
      'pengeluaran',
      orderBy: 'tanggal DESC, id DESC',
    );

    return rows.map((row) => Pengeluaran.fromMap(row)).toList();
  }

  static Future<int> tambah(Pengeluaran data) async {
    final db = await database;

    return db.insert(
      'pengeluaran',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> ubah(Pengeluaran data) async {
    final db = await database;

    return db.update(
      'pengeluaran',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  static Future<int> hapus(int id) async {
    final db = await database;

    return db.delete(
      'pengeluaran',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> total() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT SUM(jumlah) AS total FROM pengeluaran',
    );

    return (result.first['total'] as int?) ?? 0;
  }
}

// =====================================================
// APP
// =====================================================

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _gelap = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _muatPengaturan();
  }

  Future<void> _muatPengaturan() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _gelap = prefs.getBool('gelap') ?? false;
      _loading = false;
    });
  }

  Future<void> _ubahTema(bool nilai) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('gelap', nilai);

    if (!mounted) return;

    setState(() {
      _gelap = nilai;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pencatat Pengeluaran',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: _gelap ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(
        gelap: _gelap,
        onThemeChanged: _ubahTema,
      ),
    );
  }
}

// =====================================================
// HALAMAN UTAMA
// =====================================================

class HomePage extends StatefulWidget {
  final bool gelap;
  final ValueChanged<bool> onThemeChanged;

  const HomePage({
    super.key,
    required this.gelap,
    required this.onThemeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pengeluaran> _data = [];
  int _total = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    final data = await DbHelper.semua();
    final total = await DbHelper.total();

    if (!mounted) return;

    setState(() {
      _data = data;
      _total = total;
      _loading = false;
    });
  }

  String _rupiah(int angka) {
    final text = angka.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(text[i]);
    }

    return 'Rp ${buffer.toString()}';
  }

  Future<void> _hapus(Pengeluaran data) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Pengeluaran'),
          content: Text(
            'Hapus "${data.nama}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (yakin != true) return;

    await DbHelper.hapus(data.id!);
    await _muat();
  }

  Future<void> _bukaForm([Pengeluaran? data]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormPengeluaranPage(
          data: data,
        ),
      ),
    );

    await _muat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatat Pengeluaran'),
        actions: [
          IconButton(
            tooltip: 'Mode gelap',
            onPressed: () {
              widget.onThemeChanged(!widget.gelap);
            },
            icon: Icon(
              widget.gelap
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: _muat,
        child: _data.isEmpty
            ? ListView(
          children: const [
            SizedBox(height: 200),
            Center(
              child: Text(
                'Belum ada pengeluaran',
              ),
            ),
          ],
        )
            : ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pengeluaran',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _rupiah(_total),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ..._data.map(
                  (data) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      _iconKategori(
                        data.kategori,
                      ),
                    ),
                  ),
                  title: Text(
                    data.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${data.kategori} • ${data.tanggal}',
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _bukaForm(data);
                      } else if (value == 'hapus') {
                        _hapus(data);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Ubah'),
                      ),
                      PopupMenuItem(
                        value: 'hapus',
                        child: Text('Hapus'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bukaForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  IconData _iconKategori(String kategori) {
    switch (kategori) {
      case 'Makanan':
        return Icons.restaurant;
      case 'Transportasi':
        return Icons.directions_car;
      case 'Belanja':
        return Icons.shopping_bag;
      case 'Tagihan':
        return Icons.receipt_long;
      default:
        return Icons.payments;
    }
  }
}

// =====================================================
// FORM PENGELUARAN
// =====================================================

class FormPengeluaranPage extends StatefulWidget {
  final Pengeluaran? data;

  const FormPengeluaranPage({
    super.key,
    this.data,
  });

  @override
  State<FormPengeluaranPage> createState() =>
      _FormPengeluaranPageState();
}

class _FormPengeluaranPageState
    extends State<FormPengeluaranPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nama;
  late final TextEditingController _jumlah;

  String? _kategori;
  DateTime _tanggal = DateTime.now();

  final List<String> _kategoriList = [
    'Makanan',
    'Transportasi',
    'Belanja',
    'Tagihan',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();

    _nama = TextEditingController(
      text: widget.data?.nama ?? '',
    );

    _jumlah = TextEditingController(
      text: widget.data?.jumlah.toString() ?? '',
    );

    _kategori = widget.data?.kategori;

    if (widget.data?.tanggal != null) {
      final parts = widget.data!.tanggal.split('-');

      if (parts.length == 3) {
        _tanggal = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }
    }
  }

  @override
  void dispose() {
    _nama.dispose();
    _jumlah.dispose();
    super.dispose();
  }

  String _formatTanggal(DateTime date) {
    final bulan = date.month.toString().padLeft(2, '0');
    final hari = date.day.toString().padLeft(2, '0');

    return '${date.year}-$bulan-$hari';
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (hasil == null) return;

    if (!mounted) return;

    setState(() {
      _tanggal = hasil;
    });
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = Pengeluaran(
      id: widget.data?.id,
      nama: _nama.text.trim(),
      jumlah: int.parse(_jumlah.text.trim()),
      kategori: _kategori!,
      tanggal: _formatTanggal(_tanggal),
    );

    if (widget.data == null) {
      await DbHelper.tambah(data);
    } else {
      await DbHelper.ubah(data);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final edit = widget.data != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          edit
              ? 'Ubah Pengeluaran'
              : 'Tambah Pengeluaran',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nama,
              decoration: const InputDecoration(
                labelText: 'Nama Pengeluaran',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _jumlah,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                hintText: 'Contoh: 25000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Jumlah wajib diisi';
                }

                final angka = int.tryParse(
                  value.trim(),
                );

                if (angka == null) {
                  return 'Jumlah harus berupa angka';
                }

                if (angka <= 0) {
                  return 'Jumlah harus lebih dari 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: _kategoriList.map(
                    (kategori) {
                  return DropdownMenuItem(
                    value: kategori,
                    child: Text(kategori),
                  );
                },
              ).toList(),
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

            const SizedBox(height: 16),

            InkWell(
              onTap: _pilihTanggal,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                child: Text(
                  _formatTanggal(_tanggal),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _simpan,
                icon: const Icon(Icons.save),
                label: Text(
                  edit
                      ? 'Simpan Perubahan'
                      : 'Simpan Pengeluaran',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}