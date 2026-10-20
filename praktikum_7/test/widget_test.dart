import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabungku/main.dart';
import 'package:tabungku/state/pengaturan.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TabungKu menampilkan navigasi utama', (tester) async {
    SharedPreferences.setMockInitialValues({});

    final pengaturan = Pengaturan();
    await pengaturan.muat();

    await tester.pumpWidget(TabungKuApp(pengaturan: pengaturan));
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Laporan'), findsOneWidget);
    expect(find.text('Pengaturan'), findsOneWidget);
  });
}
