# MyPortfolio Mobile

Portofolio Flutter Jeudi Augusto Asadullah, NPM **2506656822**, kelas **PBP C**, Sistem Informasi Universitas Indonesia. Proyek mobile ini terpisah dari backend [Django](https://github.com/JeudiAugusto/myportofolio).

## Progres

- Tutorial 08: bootstrap `lib/main.dart`, halaman stateless `lib/menu.dart`, model `ItemHomepage`, komponen `InfoCard` dan `ItemCard`, tema Material 3, serta SnackBar.
- Tugas 7: identitas pribadi, warna unik pada setiap aksi, menu Experience yang sesuai dengan backend, dan jawaban reflektif.
- Tambahan: layout responsif, halaman dapat digulir, dukungan ukuran teks besar, label aksesibilitas tombol, dan pengujian interaksi.

Tombol Lihat Proyek, Tambah Proyek, Lihat Experience, dan Logout menampilkan pesan sesuai tutorial. Belum ada autentikasi, penyimpanan, navigasi halaman fitur, atau koneksi API; Logout belum mengakhiri sesi apa pun.

## Menjalankan

Pasang Flutter stable dari [sumber resmi](https://docs.flutter.dev/install), lalu tambahkan folder `flutter/bin` ke PATH. Dart sudah disertakan.

```powershell
cd C:\Users\jeudi\myportofolio_mobile
flutter pub get
flutter doctor
flutter run -d chrome
```

SDK lokal sesi pengerjaan: `C:\Users\jeudi\dev\flutter`. Jika terminal belum mengenali Flutter, jalankan `& C:\Users\jeudi\dev\flutter\bin\flutter.bat` menggantikan `flutter` pada perintah. Edge juga dapat dipakai dengan `flutter run -d edge`.

```powershell
dart run tool/halo_burhan.dart
flutter analyze
flutter test
flutter build web
```

Untuk Android, pasang Android Studio, Android SDK Command-line Tools, Build-Tools, Platform-Tools, dan emulator. Tinjau serta setujui lisensi melalui `flutter doctor --android-licenses`, lalu jalankan perangkat yang muncul pada `flutter devices`. Folder iOS disediakan untuk pengembangan pada macOS dengan Xcode. Build web tidak membuktikan build Android/iOS sudah berhasil.

## Struktur

| Berkas | Tujuan |
| --- | --- |
| `lib/main.dart` | Entry point dan tema MaterialApp |
| `lib/menu.dart` | MyHomePage, InfoCard, ItemHomepage, ItemCard |
| `test/widget_test.dart` | Identitas, seluruh SnackBar, layar sempit dan teks besar |
| `tool/halo_burhan.dart` | Percobaan Dart mandiri sesuai tutorial |
| `android/`, `ios/`, `web/` | Runner platform dari Flutter |
| `pubspec.yaml` | Dependensi dan metadata |

## Pertanyaan Reflektif

### Tugas 7

1. **Widget tree dan hubungan induk-anak.** Widget tree adalah susunan deklaratif widget yang membentuk antarmuka. Induk menerima anak lewat `child` atau `children`; misalnya `Scaffold` memiliki `AppBar` dan body, sedangkan `Column` memiliki beberapa anak vertikal. Constraint ukuran turun dari induk, anak menentukan ukuran dalam constraint itu, lalu induk menentukan posisi anak. Pada proyek ini alurnya `MyApp → MaterialApp → MyHomePage → Scaffold → SafeArea → SingleChildScrollView → Center → ConstrainedBox → LayoutBuilder → Column`. Theme dan MediaQuery tersedia bagi keturunan melalui context. Widget adalah konfigurasi immutable; Flutter mempertahankan element tree untuk mencocokkan konfigurasi baru ketika rebuild.

2. **Widget yang digunakan.** `MyApp` menyusun aplikasi; `MyHomePage` menyusun menu; `InfoCard` menampilkan pasangan judul dan identitas; `ItemCard` menampilkan aksi. `MaterialApp` menyediakan infrastruktur aplikasi Material; `Scaffold` menyediakan struktur halaman dan tempat SnackBar; `AppBar` menampilkan judul; `SafeArea` menghindari area sistem; `SingleChildScrollView` membuat konten dapat digulir; `Center` memusatkan konten; `ConstrainedBox` membatasi lebar desktop; `LayoutBuilder` membaca constraint untuk memilih layout; `Column` dan `Row` menyusun anak vertikal/horizontal; `Expanded` membagi ruang horizontal; `GridView.count` menyusun kisi aksi; `Card` memberi permukaan kartu informasi; `Padding` memberi ruang dalam; `SizedBox` memberi jarak; `Text` menampilkan tulisan; `Icon` menampilkan ikon; `Material` memberi permukaan warna dan ink; `InkWell` menangani klik, fokus keyboard, dan ripple; `Semantics` memberi nama serta peran tombol kepada pembaca layar; `SnackBar` memberi umpan balik. `ScaffoldMessenger` yang disediakan MaterialApp dipakai untuk mengelola SnackBar. `Theme` dan `MediaQuery` dibaca melalui context; bukan widget yang diinstansiasi langsung di halaman. `ItemHomepage`, `ThemeData`, `ColorScheme`, dan `TextStyle` adalah objek data/konfigurasi, bukan widget.

3. **MaterialApp.** Widget ini menyediakan konfigurasi aplikasi Material seperti tema, judul, routing/Navigator, lokalisasi dasar, serta ScaffoldMessenger. Karena halaman-halaman membutuhkan layanan bersama tersebut, MaterialApp umumnya diletakkan dekat akar. Dalam proyek ini root yang diberikan ke runApp adalah MyApp, yang membangun MaterialApp. `home` memilih MyHomePage sebagai halaman awal. MaterialApp bukan keharusan bagi setiap aplikasi Flutter: WidgetsApp atau CupertinoApp sesuai untuk kebutuhan lain.

4. **StatelessWidget dan StatefulWidget.** StatelessWidget tidak memiliki objek State mutable sendiri, tetapi masih bisa rebuild saat konfigurasi induk atau inherited dependency berubah. StatefulWidget juga immutable; perubahan lokal disimpan dalam objek State dan biasanya dijadwalkan melalui setState. Menu ini memakai StatelessWidget karena identitas dan daftar aksinya tetap; SnackBar dikelola ScaffoldMessenger sehingga tidak memerlukan state lokal halaman. Gunakan StatefulWidget ketika mengelola input form, counter, pilihan filter, atau lifecycle controller yang berubah selama halaman hidup. State eksternal juga dapat membuat widget stateless bereaksi melalui rebuild.

5. **BuildContext.** Context adalah handle posisi widget dalam element tree, bukan variabel global aplikasi. Dalam build, `Theme.of(context)` mencari tema dari ancestor; `MediaQuery.textScalerOf(context)` membaca skala teks; dan `ScaffoldMessenger.of(context)` menemukan pengelola pesan terdekat. Context harus berada di bawah provider yang dicari. Context milik widget yang membuat provider belum otomatis menjadi keturunan provider tersebut; Builder atau widget anak dapat menyediakan context yang tepat. Setelah operasi async, periksa `context.mounted` sebelum mengakses context yang mungkin sudah dilepas.

6. **Hot reload, hot restart, full restart.** Hot reload memasukkan perubahan kode Dart dan melakukan rebuild sambil mempertahankan state; `main()` dan `initState()` tidak dijalankan ulang. Cocok untuk mengubah teks, warna, dan layout. Hot restart memulai ulang aplikasi Dart sehingga state hilang dan inisialisasi diulang, berguna saat mengubah initializer atau struktur yang tidak dapat diterapkan hot reload. Full restart menghentikan aplikasi dan menjalankan/build kembali; diperlukan misalnya untuk perubahan kode native, plugin native, atau konfigurasi platform. Perubahan dependensi juga memerlukan pub get, dan perubahan native perlu build ulang. Hot reload bukan pengganti tes atau verifikasi build rilis.

## Deklarasi Penggunaan AI

| Alat | Kontribusi sesi ini | Basis pengguna |
| --- | --- | --- |
| Codex (OpenAI) | Membaca tutorial dan tugas resmi, menyiapkan SDK/proyek Flutter, menulis implementasi, tes, dan README, menjalankan verifikasi | Permintaan menyelesaikan Tutorial 8 dan tambahannya; identitas dan konteks Experience diambil dari README proyek Django pengguna |

**Prompt pengguna:** “https://pbp.cs.ui.ac.id/tutorial/tutorial-8.html selesaikan sesuai tutorial berikut dan tambahannya jika ada”.

**Ringkasan respons/tindakan:** AI memeriksa proyek Django, membaca Tutorial 08 serta Tugas 7, membuat proyek Flutter terpisah, menerapkan kartu profil dan aksi dengan warna unik, serta menyiapkan dokumentasi reflektif dan uji. Pengembangan kode Flutter sesi ini dibantu AI secara langsung, bukan hanya debugging. Tidak ada klaim bahwa pengguna telah menulis ulang atau melakukan review manual.

**Keterbatasan:** akses awal sumber mendapat tantangan sesi/429, kemudian berhasil melalui cookie HTTP normal. Ringkasan pencarian memiliki jadwal lama, sehingga requirement mengikuti halaman tutorial aktual. Tes otomatis tidak menggantikan penilaian visual di seluruh perangkat. Jawaban reflektif perlu dipahami dan ditinjau pengguna; AI tidak dapat membuktikan pemahaman pribadi atau menjamin nilai tugas. Status push dan pengumpulan SCELE harus dibedakan dari implementasi lokal.

## Referensi dan pengumpulan

### Hasil verifikasi sesi 11 November 2026

- Flutter stable 3.47.9 terpasang; direktori SDK ditambahkan ke User PATH (buka terminal baru).
- `flutter analyze`: **No issues found**. Contoh Dart memakai `stdout.writeln` agar sesuai lint tanpa mematikan aturan `avoid_print`.
- `flutter test`: **7 tes lulus**, meliputi identitas, empat aksi, viewport 320px, dan skala teks 2x.
- `flutter build web`: **berhasil**, termasuk Wasm dry run bawaan.
- `dart run tool/halo_burhan.dart`: menghasilkan sapaan yang sesuai tutorial.
- `flutter doctor`: Flutter dan Chrome siap. Android SDK belum terpasang, sehingga Android belum diuji. Toolchain desktop Windows juga belum terpasang; bukan target tutorial ini.
- Repository publik: [JeudiAugusto/myportofolio_mobile](https://github.com/JeudiAugusto/myportofolio_mobile). Commit awal telah di-push; hasil verifikasi disimpan sebagai commit lanjutan.

- [Tutorial 08: Basic Flutter](https://pbp.cs.ui.ac.id/tutorial/tutorial-8.html)
- [Individual Assignment 7](https://pbp.cs.ui.ac.id/assignments/individual/tugas-7.html)
- [Dokumentasi Flutter](https://docs.flutter.dev/)

Tutorial meminta repositori GitHub publik terpisah dan **tautan commit**, bukan hanya tautan repo, untuk slot SCELE. Tenggat pada halaman aktual: Tutorial 08 **11 November 2026 23.59 WIB**, Tugas 7 **16 November 2026 23.59 WIB**. Pengumpulan SCELE belum dilakukan oleh AI.
