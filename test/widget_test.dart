import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  testWidgets('setiap kartu aksi merender warna unik dan ikon yang sesuai', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final cards = tester.widgetList<ItemCard>(find.byType(ItemCard)).toList();
    expect(cards.length, greaterThanOrEqualTo(3));
    expect(cards.map((card) => card.item.color).toSet().length, cards.length);
    for (final card in cards) {
      final finder = find.byWidget(card);
      final material = tester.widget<Material>(
        find.descendant(of: finder, matching: find.byType(Material)),
      );
      expect(material.color, card.item.color);
      expect(
        find.descendant(of: finder, matching: find.byIcon(card.item.icon)),
        findsOneWidget,
      );
    }
  });

  testWidgets('identitas pribadi dan semua aksi tampil', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('2506656822'), findsOneWidget);
    expect(find.text('Jeudi Augusto Asadullah'), findsOneWidget);
    expect(find.text('PBP C'), findsOneWidget);
    for (final item in MyHomePage.items) {
      expect(find.text(item.name), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  for (final item in MyHomePage.items) {
    testWidgets('${item.name} menampilkan pesan yang sesuai', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.ensureVisible(find.text(item.name));
      await tester.tap(find.text(item.name));
      await tester.pumpAndSettle();
      expect(
        find.text('Kamu telah menekan tombol ${item.name}!'),
        findsOneWidget,
      );
    });
  }

  for (final scale in [1.0, 2.0]) {
    testWidgets('layar 320px, skala teks $scale tanpa overflow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(const MyApp());
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Logout'));
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();
      expect(find.text('Kamu telah menekan tombol Logout!'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
