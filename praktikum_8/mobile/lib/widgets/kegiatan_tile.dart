import 'package:flutter/material.dart';

import '../models/kegiatan.dart';
import '../utils/format.dart';

class KegiatanTile extends StatelessWidget {
  final Kegiatan kegiatan;
  final ValueChanged<bool> onStatusChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const KegiatanTile({
    super.key,
    required this.kegiatan,
    required this.onStatusChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final warnaTipe = switch (kegiatan.tipe) {
      Tipe.pemasukan => Colors.green,
      Tipe.pengeluaran => Colors.red,
      Tipe.tanpa => theme.colorScheme.primary,
    };

    final nominalText = switch (kegiatan.tipe) {
      Tipe.pemasukan => '+ ${formatRupiah(kegiatan.nominal)}',
      Tipe.pengeluaran => '- ${formatRupiah(kegiatan.nominal)}',
      Tipe.tanpa => 'Tanpa transaksi',
    };

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        leading: Checkbox(
          value: kegiatan.selesai,
          onChanged: (nilai) {
            if (nilai != null) onStatusChanged(nilai);
          },
        ),
        title: Text(
          kegiatan.judul,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: kegiatan.selesai
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: kegiatan.selesai ? theme.colorScheme.onSurfaceVariant : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kegiatan.tipe == Tipe.pengeluaran
                    ? '${kegiatan.kategori} • $nominalText'
                    : nominalText,
                style: TextStyle(
                  color: warnaTipe,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(formatTanggal(kegiatan.tanggal)),
            ],
          ),
        ),
        trailing: PopupMenuButton<String>(
          tooltip: 'Aksi kegiatan',
          onSelected: (aksi) {
            if (aksi == 'edit') onEdit();
            if (aksi == 'hapus') onDelete();
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'hapus',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Hapus'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
