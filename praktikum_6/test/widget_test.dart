import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_6/main.dart';

void main() {
  testWidgets('Galeri Interaktif tampil dengan benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(
        modeGelapAwal: false,
        warnaTemaAwal: 0,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Galeri Interaktif'), findsOneWidget);
    expect(find.text('Galeri'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);
    expect(find.text('Pengaturan'), findsOneWidget);
  });
}
