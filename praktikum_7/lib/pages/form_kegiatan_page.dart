import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../utils/format.dart';

class FormKegiatanPage extends StatefulWidget {
  const FormKegiatanPage({super.key});

  @override
  State<FormKegiatanPage> createState() => _FormKegiatanPageState();
}

class _FormKegiatanPageState extends State<FormKegiatanPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _nominalController = TextEditingController();

  DateTime _tanggal = DateTime.now();
  Tipe _tipe = Tipe.tanpa;
  String _kategori = 'Makan';
  Kegiatan? _kegiatanAwal;
  bool _sudahInisialisasi = false;
  bool _menyimpan = false;

  static const _kategoriList = [
    'Makan',
    'Transport',
    'Belajar',
    'Hiburan',
    'Lainnya',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_sudahInisialisasi) return;
    _sudahInisialisasi = true;

    final argumen = ModalRoute.of(context)?.settings.arguments;

    if (argumen is Map) {
      final tanggalString = argumen['tanggal'];
      if (tanggalString is String) {
        _tanggal = DateTime.tryParse(tanggalString) ?? DateTime.now();
      }

      final kegiatan = argumen['kegiatan'];
      if (kegiatan is Kegiatan) {
        _kegiatanAwal = kegiatan;
        _judulController.text = kegiatan.judul;
        _nominalController.text = kegiatan.nominal.toString();
        _tanggal = DateTime.tryParse(kegiatan.tanggal) ?? _tanggal;
        _tipe = kegiatan.tipe;

        if (_kategoriList.contains(kegiatan.kategori)) {
          _kategori = kegiatan.kategori;
        }
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (hasil != null && mounted) {
      setState(() => _tanggal = hasil);
    }
  }

  Future<void> _simpan() async {
    if (_menyimpan) return;
    if (!_formKey.currentState!.validate()) return;

    final nominal =
        _tipe == Tipe.tanpa ? 0 : int.parse(_nominalController.text.trim());

    final tanggalString = '${_tanggal.year.toString().padLeft(4, '0')}-'
        '${_tanggal.month.toString().padLeft(2, '0')}-'
        '${_tanggal.day.toString().padLeft(2, '0')}';

    final kegiatan = Kegiatan(
      id: _kegiatanAwal?.id,
      judul: _judulController.text.trim(),
      tanggal: tanggalString,
      selesai: _kegiatanAwal?.selesai ?? false,
      tipe: _tipe,
      nominal: nominal,
      kategori: _tipe == Tipe.pengeluaran ? _kategori : '-',
    );

    setState(() => _menyimpan = true);

    try {
      if (_kegiatanAwal == null) {
        await DbHelper.instance.tambah(kegiatan);
      } else {
        await DbHelper.instance.ubah(kegiatan);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _kegiatanAwal == null
                ? 'Kegiatan berhasil ditambahkan.'
                : 'Kegiatan berhasil diperbarui.',
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan kegiatan: $e')),
      );
    } finally {
      if (mounted) setState(() => _menyimpan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mengedit = _kegiatanAwal != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(mengedit ? 'Edit Kegiatan' : 'Tambah Kegiatan'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _judulController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nama kegiatan',
                  hintText: 'Contoh: Mengerjakan tugas kuliah',
                  prefixIcon: Icon(Icons.edit_note),
                  border: OutlineInputBorder(),
                ),
                maxLength: 100,
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Nama kegiatan wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text('Tanggal kegiatan'),
                  subtitle: Text(formatTanggal(
                    '${_tanggal.year.toString().padLeft(4, '0')}-'
                    '${_tanggal.month.toString().padLeft(2, '0')}-'
                    '${_tanggal.day.toString().padLeft(2, '0')}',
                  )),
                  trailing: const Icon(Icons.edit_calendar),
                  onTap: _pilihTanggal,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Tipe>(
                value: _tipe,
                decoration: const InputDecoration(
                  labelText: 'Jenis transaksi',
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: Tipe.tanpa,
                    child: Text('Tanpa transaksi'),
                  ),
                  DropdownMenuItem(
                    value: Tipe.pemasukan,
                    child: Text('Pemasukan'),
                  ),
                  DropdownMenuItem(
                    value: Tipe.pengeluaran,
                    child: Text('Pengeluaran'),
                  ),
                ],
                onChanged: (nilai) {
                  if (nilai != null) setState(() => _tipe = nilai);
                },
              ),
              if (_tipe != Tipe.tanpa) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nominalController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nominal (Rupiah)',
                    hintText: 'Contoh: 20000',
                    prefixText: 'Rp ',
                    prefixIcon: Icon(Icons.payments_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) {
                    if (_tipe == Tipe.tanpa) return null;

                    final angka = int.tryParse(nilai?.trim() ?? '');

                    if (angka == null || angka <= 0) {
                      return 'Nominal harus berupa angka lebih dari nol.';
                    }

                    return null;
                  },
                ),
              ],
              if (_tipe == Tipe.pengeluaran) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _kategori,
                  decoration: const InputDecoration(
                    labelText: 'Kategori pengeluaran',
                    prefixIcon: Icon(Icons.category_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: _kategoriList.map((kategori) {
                    return DropdownMenuItem(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
                  onChanged: (nilai) {
                    if (nilai != null) {
                      setState(() => _kategori = nilai);
                    }
                  },
                ),
              ],
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _menyimpan ? null : _simpan,
                icon: _menyimpan
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(_menyimpan ? 'Menyimpan...' : 'Simpan Kegiatan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
