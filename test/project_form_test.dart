import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

Future<void> save(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Save'));
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('tombol push dapat kembali; drawer mengganti route', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.text('Tambah Proyek'));
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    expect(navigator.canPop(), isTrue);
    navigator.pop();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(navigator.canPop(), isFalse);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(navigator.canPop(), isFalse);
  });

  testWidgets('input kosong dan spasi ditolak', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProjectFormPage()));
    await tester.enterText(find.byType(TextFormField).at(0), '   ');
    await save(tester);
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('pop-up memuat seluruh data; OK mereset field dan kategori', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ProjectFormPage()));
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Portfolio');
    await tester.enterText(fields.at(1), 'Aplikasi pribadi');
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Other').last);
    await tester.pumpAndSettle();
    await tester.enterText(fields.at(2), 'Flutter, Django');
    await tester.enterText(fields.at(3), 'https://example.com');
    await save(tester);
    for (final text in [
      'Nama Proyek: Portfolio',
      'Deskripsi: Aplikasi pribadi',
      'Kategori: Other',
      'Teknologi: Flutter, Django',
      'Tautan: https://example.com',
    ]) {
      expect(find.text(text), findsOneWidget);
    }
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    for (final field in tester.widgetList<EditableText>(
      find.byType(EditableText),
    )) {
      expect(field.controller.text, isEmpty);
    }
    expect(
      tester
          .state<FormFieldState<String>>(
            find.byType(DropdownButtonFormField<String>),
          )
          .value,
      'Web Development',
    );
    // A second submission must not reuse optional values or the old category.
    await tester.enterText(fields.at(0), 'Baru');
    await tester.enterText(fields.at(1), 'Deskripsi baru');
    await save(tester);
    expect(find.text('Kategori: Web Development'), findsOneWidget);
    expect(find.text('Teknologi: '), findsOneWidget);
    expect(find.text('Tautan: '), findsOneWidget);
  });

  testWidgets('form dan dialog di layar kecil dengan teks besar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const MaterialApp(home: ProjectFormPage()));
    await tester.enterText(find.byType(TextFormField).at(0), 'Proyek');
    await tester.enterText(find.byType(TextFormField).at(1), 'Deskripsi ' * 30);
    await save(tester);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    expect(find.text('Add Project'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
