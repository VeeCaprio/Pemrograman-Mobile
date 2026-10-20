import 'package:flutter/material.dart';

import '../state/pengaturan.dart';
import '../utils/format.dart';

class PengaturanPage extends StatelessWidget {
  final Pengaturan pengaturan;

  const PengaturanPage({
    super.key,
    required this.pengaturan,
  });

  Future<void> _aturTarget(BuildContext context) async {
    final hasil = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        final controller = TextEditingController(
          text: pengaturan.targetTabungan.toString(),
        );
        final formKey = GlobalKey<FormState>();

        return AlertDialog(
          title: const Text('Target Tabungan Harian'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target dalam Rupiah',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
                helperText: 'Contoh: 20000',
              ),
              validator: (nilai) {
                final angka = int.tryParse(nilai?.trim() ?? '');
                if (angka == null || angka <= 0) {
                  return 'Masukkan nominal lebih dari nol.';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(
                    dialogContext,
                    int.parse(controller.text.trim()),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (hasil == null || !context.mounted) return;

    await pengaturan.ubahTarget(hasil);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Target tabungan berhasil diperbarui.'),
      ),
    );
  }

  Future<void> _pilihWarna(BuildContext context) async {
    const pilihanWarna = <Color>[
      Colors.teal,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.green,
      Colors.red,
    ];

    final warna = await showDialog<Color>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Warna Tema'),
        content: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: pilihanWarna.map((warna) {
            final terpilih = warna.value == pengaturan.warnaTema.value;

            return InkWell(
              onTap: () => Navigator.pop(dialogContext, warna),
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                backgroundColor: warna,
                child: terpilih
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
        ],
      ),
    );

    if (warna == null || !context.mounted) return;

    await pengaturan.ubahWarnaTema(warna);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) {
        final tema = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Pengaturan'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: pengaturan.warnaTema,
                        child: const Icon(
                          Icons.savings_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TabungKu',
                              style: tema.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('Kelola kegiatan dan keuanganmu'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Preferensi',
                style: tema.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.savings_outlined),
                      title: const Text('Target tabungan harian'),
                      subtitle: Text(
                        formatRupiah(pengaturan.targetTabungan),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _aturTarget(context),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Mode gelap'),
                      subtitle: const Text(
                        'Gunakan tampilan gelap pada aplikasi',
                      ),
                      value: pengaturan.modeGelap,
                      onChanged: (aktif) {
                        pengaturan.ubahModeGelap(aktif);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.palette_outlined),
                      title: const Text('Warna tema'),
                      subtitle: const Text(
                        'Sesuaikan warna utama aplikasi',
                      ),
                      trailing: CircleAvatar(
                        radius: 13,
                        backgroundColor: pengaturan.warnaTema,
                      ),
                      onTap: () => _pilihWarna(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Tentang TabungKu'),
                  subtitle: const Text(
                    'Aplikasi pencatat kegiatan dan keuangan harian.',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'TabungKu • Kelola hari ini, rencanakan esok.',
                  textAlign: TextAlign.center,
                  style: tema.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
