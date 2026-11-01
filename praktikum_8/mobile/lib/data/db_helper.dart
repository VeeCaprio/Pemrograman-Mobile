import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/kegiatan.dart';

/// Berubah setiap kali data kegiatan berhasil dimutasi.
/// Halaman lain dapat mendengarkan notifier ini untuk memuat ulang data.
final ValueNotifier<int> versiData = ValueNotifier<int>(0);

class DbHelper {
  DbHelper._();

  static final DbHelper instance = DbHelper._();

  static Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;

    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, 'tabungku.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE kegiatan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            tanggal TEXT NOT NULL,
            selesai INTEGER NOT NULL DEFAULT 0,
            tipe TEXT NOT NULL DEFAULT 'tanpa',
            nominal INTEGER NOT NULL DEFAULT 0,
            kategori TEXT NOT NULL DEFAULT '-'
          )
        ''');
      },
    );

    return _db!;
  }

  /// Membaca semua kegiatan pada tanggal tertentu.
  Future<List<Kegiatan>> pada(String tanggal) async {
    final db = await _database;

    final rows = await db.query(
      'kegiatan',
      where: 'tanggal = ?',
      whereArgs: [tanggal],
      orderBy: 'id DESC',
    );

    return rows.map((row) => Kegiatan.fromMap(row)).toList();
  }

  /// Membaca satu kegiatan berdasarkan ID.
  Future<Kegiatan?> berdasarkanId(int id) async {
    final db = await _database;

    final rows = await db.query(
      'kegiatan',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) return null;

    return Kegiatan.fromMap(rows.first);
  }

  /// Menambahkan kegiatan baru.
  Future<int> tambah(Kegiatan kegiatan) async {
    final db = await _database;

    final data = kegiatan.toMap()..remove('id');

    final id = await db.insert(
      'kegiatan',
      data,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    versiData.value++;
    return id;
  }

  /// Mengubah kegiatan yang sudah ada.
  Future<int> ubah(Kegiatan kegiatan) async {
    if (kegiatan.id == null) {
      throw ArgumentError('ID kegiatan wajib diisi untuk mengubah data.');
    }

    final db = await _database;
    final data = kegiatan.toMap()..remove('id');

    final jumlah = await db.update(
      'kegiatan',
      data,
      where: 'id = ?',
      whereArgs: [kegiatan.id],
    );

    if (jumlah > 0) versiData.value++;

    return jumlah;
  }

  /// Menghapus kegiatan berdasarkan ID.
  Future<int> hapus(int id) async {
    final db = await _database;

    final jumlah = await db.delete(
      'kegiatan',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (jumlah > 0) versiData.value++;

    return jumlah;
  }

  /// Mengubah status selesai suatu kegiatan.
  Future<int> ubahStatus(int id, bool selesai) async {
    final db = await _database;

    final jumlah = await db.update(
      'kegiatan',
      {'selesai': selesai ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    if (jumlah > 0) versiData.value++;

    return jumlah;
  }

  /// Menghitung ringkasan keuangan pada tanggal tertentu.
  /// Semua kegiatan dihitung, termasuk yang belum selesai.
  Future<Ringkasan> ringkasan(String tanggal) async {
    final db = await _database;

    final hasil = await db.rawQuery(
      '''
      SELECT
        COUNT(*) AS jumlah,
        COALESCE(SUM(selesai), 0) AS selesai,
        COALESCE(
          SUM(CASE WHEN tipe = 'pemasukan' THEN nominal ELSE 0 END),
          0
        ) AS masuk,
        COALESCE(
          SUM(CASE WHEN tipe = 'pengeluaran' THEN nominal ELSE 0 END),
          0
        ) AS keluar
      FROM kegiatan
      WHERE tanggal = ?
      ''',
      [tanggal],
    );

    final row = hasil.first;

    return Ringkasan(
      jumlahKegiatan: (row['jumlah'] as num).toInt(),
      selesai: (row['selesai'] as num).toInt(),
      pemasukan: (row['masuk'] as num).toInt(),
      pengeluaran: (row['keluar'] as num).toInt(),
    );
  }

  /// Total pengeluaran berdasarkan kategori pada tanggal tertentu.
  Future<Map<String, int>> pengeluaranPerKategori(
    String tanggal,
  ) async {
    final db = await _database;

    final hasil = await db.rawQuery(
      '''
      SELECT kategori, COALESCE(SUM(nominal), 0) AS total
      FROM kegiatan
      WHERE tanggal = ? AND tipe = 'pengeluaran'
      GROUP BY kategori
      ORDER BY total DESC
      ''',
      [tanggal],
    );

    return {
      for (final row in hasil)
        row['kategori'] as String: (row['total'] as num).toInt(),
    };
  }

  /// Ringkasan setiap hari, termasuk tanggal tanpa data yang dilewati.
  Future<List<Map<String, Object?>>> ringkasanTujuhHari(
    String tanggalAkhir,
  ) async {
    final db = await _database;

    final hasil = await db.rawQuery(
      '''
      SELECT
        tanggal,
        COUNT(*) AS jumlah,
        COALESCE(
          SUM(CASE WHEN tipe = 'pemasukan' THEN nominal ELSE 0 END),
          0
        ) AS masuk,
        COALESCE(
          SUM(CASE WHEN tipe = 'pengeluaran' THEN nominal ELSE 0 END),
          0
        ) AS keluar
      FROM kegiatan
      WHERE tanggal <= ?
        AND tanggal >= date(?, '-6 days')
      GROUP BY tanggal
      ORDER BY tanggal ASC
      ''',
      [tanggalAkhir, tanggalAkhir],
    );

    return hasil;
  }

  /// Menutup koneksi database.
  Future<void> tutup() async {
    await _db?.close();
    _db = null;
  }
}
