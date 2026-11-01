import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../utils/format.dart';
import '../widgets/kegiatan_tile.dart';
import '../widgets/ringkasan_card.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late String _tanggal;
  Future<List<Kegiatan>>? _futureKegiatan;
  Future<Ringkasan>? _futureRingkasan;

  @override
  void initState() {
    super.initState();
    _tanggal = tanggalHariIni();
    _muatData();
    versiData.addListener(_saatDataBerubah);
  }

  void _muatData() {
    _futureKegiatan = DbHelper.instance.pada(_tanggal);
    _futureRingkasan = DbHelper.instance.ringkasan(_tanggal);
  }

  void _saatDataBerubah() {
    if (!mounted) return;

    setState(_muatData);
  }

  @override
  void dispose() {
    versiData.removeListener(_saatDataBerubah);
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final awal = DateTime.tryParse(_tanggal) ?? DateTime.now();

    final hasil = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: 'Pilih tanggal kegiatan',
    );

    if (hasil == null || !mounted) return;

    setState(() {
      _tanggal = '${hasil.year.toString().padLeft(4, '0')}-'
          '${hasil.month.toString().padLeft(2, '0')}-'
          '${hasil.day.toString().padLeft(2, '0')}';
      _muatData();
    });
  }

  Future<void> _tambahKegiatan() async {
    await Navigator.pushNamed(
      context,
      '/form',
      arguments: {'tanggal': _tanggal},
    );
  }

  Future<void> _editKegiatan(Kegiatan kegiatan) async {
    await Navigator.pushNamed(
      context,
      '/form',
      arguments: {
        'tanggal': kegiatan.tanggal,
        'kegiatan': kegiatan,
      },
    );
  }

  Future<void> _hapusKegiatan(Kegiatan kegiatan) async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus kegiatan?'),
        content: Text(
          'Kegiatan "${kegiatan.judul}" akan dihapus permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (setuju != true || !mounted) return;

    await DbHelper.instance.hapus(kegiatan.id!);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kegiatan berhasil dihapus.')),
    );
  }

  Future<void> _ubahStatus(Kegiatan kegiatan, bool selesai) async {
    if (kegiatan.id == null) return;

    await DbHelper.instance.ubahStatus(kegiatan.id!, selesai);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(_muatData);
            await Future.wait([
              _futureKegiatan!,
              _futureRingkasan!,
            ]);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, selamat datang! 👋',
                        style: tema.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Atur kegiatan dan keuanganmu.',
                        style: tema.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              formatTanggal(_tanggal),
                              style: tema.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: _pilihTanggal,
                            icon: const Icon(Icons.edit_calendar_outlined),
                            label: const Text('Pilih tanggal'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FutureBuilder<Ringkasan>(
                  future: _futureRingkasan,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Gagal memuat ringkasan keuangan.'),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return RingkasanCard(ringkasan: snapshot.data!);
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Daftar Kegiatan',
                          style: tema.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: _tambahKegiatan,
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah'),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Kegiatan>>(
                future: _futureKegiatan,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: Text('Gagal memuat daftar kegiatan.'),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  final kegiatan = snapshot.data!;

                  if (kegiatan.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.event_note_outlined,
                              size: 56,
                              color: tema.colorScheme.primary,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Belum ada kegiatan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Tekan tombol Tambah untuk mencatat kegiatanmu.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = kegiatan[index];

                        return KegiatanTile(
                          key: ValueKey(item.id),
                          kegiatan: item,
                          onStatusChanged: (nilai) {
                            _ubahStatus(item, nilai);
                          },
                          onEdit: () => _editKegiatan(item),
                          onDelete: () => _hapusKegiatan(item),
                        );
                      },
                      childCount: kegiatan.length,
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
