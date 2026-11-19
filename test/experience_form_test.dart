import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

Future<void> submit(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Simpan'));
  await tester.tap(find.text('Simpan'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Experience: kartu push, Back, drawer dan Home', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.text('Tambah Experience'));
    await tester.tap(find.text('Tambah Experience'));
    await tester.pumpAndSettle();
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    expect(navigator.canPop(), isTrue);
    navigator.pop();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    expect(find.text('Add Project'), findsOneWidget);
    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    expect(navigator.canPop(), isFalse);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
  });

  testWidgets('Experience: wajib, spasi dan batas 255 karakter', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ExperienceFormPage()));
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '   ');
    await submit(tester);
    expect(find.text('Nama Experience tidak boleh kosong!'), findsOneWidget);
    expect(
      find.text('Deskripsi Experience tidak boleh kosong!'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
    await tester.enterText(fields.at(0), 'a' * 256);
    await tester.enterText(fields.at(1), 'Deskripsi');
    await tester.enterText(fields.at(2), 'a' * 256);
    await submit(tester);
    expect(find.text('Nama Experience maksimal 255 karakter!'), findsOneWidget);
    expect(find.text('Path Thumbnail maksimal 255 karakter!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    await tester.enterText(fields.at(0), 'a' * 255);
    await tester.enterText(fields.at(2), 'a' * 255);
    await submit(tester);
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Experience: ringkasan lengkap, tutup dan edit ulang', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ExperienceFormPage()));
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '  Asisten Riset  ');
    await tester.enterText(fields.at(1), 'Analisis data');
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Research').last);
    await tester.pumpAndSettle();
    await tester.enterText(fields.at(2), 'img/experience/riset.jpg');
    await submit(tester);
    for (final text in [
      'Nama Experience: Asisten Riset',
      'Deskripsi: Analisis data',
      'Kategori: Research',
      'Path Thumbnail: img/experience/riset.jpg',
    ]) {
      expect(find.text(text), findsOneWidget);
    }
    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    await tester.enterText(fields.at(0), 'Pengalaman baru');
    await tester.enterText(fields.at(2), '   ');
    await submit(tester);
    expect(find.text('Nama Experience: Pengalaman baru'), findsOneWidget);
    expect(find.text('Path Thumbnail: Tidak diisi'), findsOneWidget);
  });

  testWidgets('Experience: layar sempit, teks besar dan keyboard', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.view.viewInsets = const FakeViewPadding(bottom: 200);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const MaterialApp(home: ExperienceFormPage()));
    await tester.enterText(find.byType(TextFormField).at(0), 'Pengalaman');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Deskripsi panjang ' * 30,
    );
    await submit(tester);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Tutup'));
    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
