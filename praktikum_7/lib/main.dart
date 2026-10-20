import 'package:flutter/material.dart';

import 'pages/form_kegiatan_page.dart';
import 'pages/shell_page.dart';
import 'state/pengaturan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pengaturan = Pengaturan();
  await pengaturan.muat();

  runApp(TabungKuApp(pengaturan: pengaturan));
}

class TabungKuApp extends StatelessWidget {
  final Pengaturan pengaturan;

  const TabungKuApp({
    super.key,
    required this.pengaturan,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, child) {
        return MaterialApp(
          title: 'TabungKu',
          debugShowCheckedModeBanner: false,
          themeMode: pengaturan.modeGelap ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: pengaturan.warnaTema,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: pengaturan.warnaTema,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: ShellPage(pengaturan: pengaturan),
          onGenerateRoute: (settings) {
            if (settings.name == '/form') {
              return MaterialPageRoute<void>(
                builder: (_) => const FormKegiatanPage(),
                settings: settings,
              );
            }

            return null;
          },
        );
      },
    );
  }
}
