import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../state/pengaturan.dart';

class StatusKoneksiPage extends StatefulWidget {
  final Pengaturan pengaturan;

  const StatusKoneksiPage({
    super.key,
    required this.pengaturan,
  });

  @override
  State<StatusKoneksiPage> createState() => _StatusKoneksiPageState();
}

class _StatusKoneksiPageState extends State<StatusKoneksiPage> {
  bool _memuat = false;
  Map<String, dynamic>? _hasil;

  Future<void> _periksaKoneksi() async {
    setState(() {
      _memuat = true;
    });

    final service = ApiService(baseUrl: widget.pengaturan.urlApi);
    final hasil = await service.cekKoneksi();
    service.dispose();

    if (!mounted) return;

    setState(() {
      _hasil = hasil;
      _memuat = false;
    });
  }

  Widget _statusItem({
    required IconData ikon,
    required String judul,
    required bool? aktif,
    String? keterangan,
  }) {
    final warna = aktif == null
        ? Colors.grey
        : aktif
            ? Colors.green
            : Colors.red;

    final status = aktif == null
        ? 'Belum diperiksa'
        : aktif
            ? 'Terhubung'
            : 'Tidak terhubung';

    return ListTile(
      leading: Icon(ikon, color: warna, size: 30),
      title: Text(judul),
      subtitle: Text(keterangan ?? status),
      trailing: Text(
        status,
        style: TextStyle(
          color: warna,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final api = _hasil?['api'] as bool?;
    final database = _hasil?['database'] as bool?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Koneksi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Konfigurasi Backend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(widget.pengaturan.urlApi),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _statusItem(
                  ikon: Icons.cloud_outlined,
                  judul: 'Backend API',
                  aktif: api,
                ),
                const Divider(height: 1),
                _statusItem(
                  ikon: Icons.storage_outlined,
                  judul: 'Database MySQL',
                  aktif: database,
                  keterangan: _hasil?['mysql_version']?.toString(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_hasil != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _hasil!['pesan']?.toString() ?? 'Tidak ada informasi.',
                ),
              ),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _memuat ? null : _periksaKoneksi,
            icon: _memuat
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            label: Text(
              _memuat ? 'Memeriksa koneksi...' : 'Periksa Koneksi',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tekan tombol untuk memeriksa koneksi backend API dan database.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
