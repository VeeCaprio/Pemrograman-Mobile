import 'package:flutter/material.dart';

import 'beranda_page.dart';
import 'laporan_page.dart';
import 'pengaturan_page.dart';
import '../state/pengaturan.dart';

class ShellPage extends StatefulWidget {
  final Pengaturan pengaturan;

  const ShellPage({
    super.key,
    required this.pengaturan,
  });

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _indeks = 0;

  @override
  Widget build(BuildContext context) {
    final halaman = [
      const BerandaPage(),
      const LaporanPage(),
      PengaturanPage(pengaturan: widget.pengaturan),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _indeks,
        children: halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (indeks) {
          setState(() {
            _indeks = indeks;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
