import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../utils/format.dart';
import '../widgets/ringkasan_card.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  late String _tanggal;
  Future<Ringkasan>? _futureRingkasan;
  Future<Map<String, int>>? _futureKategori;
  Future<List<Map<String, Object?>>>? _futureTujuhHari;

  @override
  void initState() {
    super.initState();
    _tanggal = tanggalHariIni();
    _muatData();
    versiData.addListener(_saatDataBerubah);
  }

  void _muatData() {
    _futureRingkasan = DbHelper.instance.ringkasan(_tanggal);
    _futureKategori = DbHelper.instance.pengeluaranPerKategori(_tanggal);
    _futureTujuhHari = DbHelper.instance.ringkasanTujuhHari(_tanggal);
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
      helpText: 'Pilih tanggal laporan',
    );

    if (hasil == null || !mounted) return;

    setState(() {
      _tanggal = '${hasil.year.toString().padLeft(4, '0')}-'
          '${hasil.month.toString().padLeft(2, '0')}-'
          '${hasil.day.toString().padLeft(2, '0')}';
      _muatData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Keuangan'),
        actions: [
          IconButton(
            onPressed: _pilihTanggal,
            tooltip: 'Pilih tanggal laporan',
            icon: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(_muatData);
          await Future.wait([
            _futureRingkasan!,
            _futureKategori!,
            _futureTujuhHari!,
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.date_range),
                  title: const Text('Tanggal laporan'),
                  subtitle: Text(formatTanggal(_tanggal)),
                  trailing: const Icon(Icons.edit_calendar),
                  onTap: _pilihTanggal,
                ),
              ),
            ),
            FutureBuilder<Ringkasan>(
              future: _futureRingkasan,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const ListTile(
                    title: Text('Gagal memuat ringkasan.'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return RingkasanCard(ringkasan: snapshot.data!);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Pengeluaran per Kategori',
                style: tema.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder<Map<String, int>>(
              future: _futureKategori,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const ListTile(
                    title: Text('Gagal memuat kategori pengeluaran.'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final kategori = snapshot.data!;

                if (kategori.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Belum ada pengeluaran pada tanggal ini.',
                    ),
                  );
                }

                final total = kategori.values.fold<int>(
                  0,
                  (jumlah, nilai) => jumlah + nilai,
                );

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: kategori.entries.map((entri) {
                        final persentase =
                            total == 0 ? 0.0 : entri.value / total;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(entri.key)),
                                  Text(
                                    formatRupiah(entri.value),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: persentase,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Ringkasan 7 Hari Terakhir',
                style: tema.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder<List<Map<String, Object?>>>(
              future: _futureTujuhHari,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const ListTile(
                    title: Text('Gagal memuat laporan mingguan.'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final hari = snapshot.data!;

                if (hari.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Belum ada data kegiatan dalam 7 hari ini.',
                    ),
                  );
                }

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: hari.map((baris) {
                      final tanggal = baris['tanggal'] as String;
                      final jumlah = (baris['jumlah'] as num).toInt();
                      final masuk = (baris['masuk'] as num).toInt();
                      final keluar = (baris['keluar'] as num).toInt();

                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.calendar_today_outlined),
                        ),
                        title: Text(formatTanggal(tanggal)),
                        subtitle: Text('$jumlah kegiatan'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '+ ${formatRupiah(masuk)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '- ${formatRupiah(keluar)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
