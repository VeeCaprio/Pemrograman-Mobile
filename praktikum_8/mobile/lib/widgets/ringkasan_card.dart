import 'package:flutter/material.dart';

import '../models/kegiatan.dart';
import '../utils/format.dart';

class RingkasanCard extends StatelessWidget {
  final Ringkasan ringkasan;

  const RingkasanCard({
    super.key,
    required this.ringkasan,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan Hari Ini',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _ItemRingkasan(
                    label: 'Kegiatan',
                    nilai: '${ringkasan.jumlahKegiatan}',
                    ikon: Icons.checklist_rounded,
                    warna: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _ItemRingkasan(
                    label: 'Pemasukan',
                    nilai: formatRupiah(ringkasan.pemasukan),
                    ikon: Icons.trending_up_rounded,
                    warna: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _ItemRingkasan(
                    label: 'Pengeluaran',
                    nilai: formatRupiah(ringkasan.pengeluaran),
                    ikon: Icons.trending_down_rounded,
                    warna: Colors.red,
                  ),
                ),
                Expanded(
                  child: _ItemRingkasan(
                    label: 'Tabungan',
                    nilai: formatRupiah(ringkasan.tabungan),
                    ikon: Icons.savings_rounded,
                    warna: ringkasan.tabungan >= 0 ? Colors.teal : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemRingkasan extends StatelessWidget {
  final String label;
  final String nilai;
  final IconData ikon;
  final Color warna;

  const _ItemRingkasan({
    required this.label,
    required this.nilai,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, color: warna, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            nilai,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: warna,
            ),
          ),
        ],
      ),
    );
  }
}
