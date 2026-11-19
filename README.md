# MyPortfolio Mobile

Portofolio Flutter Jeudi Augusto Asadullah, NPM **2506656822**, kelas **PBP C**, Sistem Informasi Universitas Indonesia. Proyek mobile ini terpisah dari backend [Django](https://github.com/JeudiAugusto/myportofolio).

## Progres

- Tutorial 08: bootstrap `lib/main.dart`, halaman stateless `lib/screens/menu.dart`, model `ItemHomepage`, komponen `InfoCard` dan `ItemCard`, tema Material 3, serta SnackBar.
- Tugas 7: identitas pribadi, warna unik pada setiap aksi, menu Experience yang sesuai dengan backend, dan jawaban reflektif.
- Tambahan: layout responsif, halaman dapat digulir, dukungan ukuran teks besar, label aksesibilitas tombol, dan pengujian interaksi.

### Checklist Tugas 7

Pemeriksaan ulang pada 16 November 2026 mengikuti [instruksi resmi Tugas 7](https://pbp.cs.ui.ac.id/assignments/individual/tugas-7.html). Implementasi utama sudah tersedia dari pengerjaan Tutorial 08; sesi ini memeriksa kesesuaiannya dan melengkapi pengujian warna serta ikon.

| Persyaratan | Implementasi |
| --- | --- |
| Melanjutkan proyek Tutorial 08 di repo mobile terpisah | `myportofolio_mobile`, terpisah dari Django |
| Bootstrap dan halaman menu terpisah | `lib/main.dart` dan `lib/screens/menu.dart` |
| Halaman utama stateless | `MyHomePage extends StatelessWidget` |
| Tiga InfoCard dengan identitas pribadi | NPM 2506656822, Jeudi Augusto Asadullah, PBP C |
| Minimal tiga aksi dengan ikon dan teks | Lihat Proyek, Tambah Proyek, Lihat Experience, Logout |
| Warna latar berbeda untuk setiap aksi | Atribut `ItemHomepage.color`: biru, hijau, ungu, merah |
| Pesan SnackBar sesuai tombol | `Kamu telah menekan tombol [Nama Tombol]!` |
| Enam jawaban reflektif | Bagian `Pertanyaan Reflektif` > `Tugas 7` |
| Analisis kode tanpa isu | Jalankan `flutter analyze` dari root repo mobile |

Tes tambahan memeriksa warna yang benar-benar dirender pada `Material` setiap kartu, keunikan warna antaraksi, dan keberadaan ikon yang sesuai. Tes interaksi sebelumnya tetap memeriksa pesan keempat tombol serta layout pada layar sempit dan teks besar.

Tombol Lihat Proyek, Tambah Proyek, Lihat Experience, dan Logout menampilkan pesan sesuai tutorial. Tambah Proyek kini membuka form melalui Navigator.push. Belum ada autentikasi, penyimpanan, atau koneksi API; Logout belum mengakhiri sesi apa pun.

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
| `lib/screens/menu.dart` | MyHomePage, InfoCard, ItemHomepage |
| `lib/screens/project_form.dart` | Form proyek dan dialog hasil input |
| `lib/widgets/project_card.dart` | ItemCard dengan navigasi ke form |
| `lib/widgets/left_drawer.dart` | Navigasi drawer Home dan Add Project |
| `test/project_form_test.dart` | Navigasi, validasi, reset, dan layout form |
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

Saya menyiapkan basis proyek dan menentukan field portofolio. Dalam pengembangan proyek, saya juga melakukan pengujian aplikasi, perbaikan kode, dan mempelajari jawaban README. Codex (OpenAI) membantu mengembangkan dan merapikan implementasi, termasuk penulisan kode form dan navigasi, pengujian otomatis, serta draf dokumentasi. Rincian bantuan pada masing-masing tugas dan tutorial dijelaskan di bawah.

### Tutorial 08 - 11 November 2026

**Alat:** Codex (OpenAI).

**Prompt pengguna:** "https://pbp.cs.ui.ac.id/tutorial/tutorial-8.html selesaikan sesuai tutorial berikut dan tambahannya jika ada".

**Bantuan AI:** membaca panduan dan konteks proyek Django, menyiapkan SDK serta proyek Flutter terpisah, menulis halaman menu dan kartu profil/aksi, menambahkan pengujian, serta menyusun draf dokumentasi dan jawaban reflektif. Identitas dan konteks portofolio mengacu pada proyek pengguna.

**Pendekatan dan keterbatasan:** implementasi dicocokkan dengan panduan aktual dan konteks portofolio. Hasil pencarian sempat memuat jadwal lama sehingga tanggal diperiksa pada halaman resmi. Analisis kode, tes widget, dan build web digunakan untuk memeriksa hasil; pemeriksaan tersebut belum mencakup seluruh perangkat atau build Android/iOS.

## Referensi dan pengumpulan

### Hasil verifikasi sesi 16 November 2026

- `flutter analyze`: **No issues found**.
- `flutter test`: **8 tes lulus**, termasuk tes tambahan warna dan ikon kartu.
- `flutter build web`: **berhasil**, termasuk Wasm dry run bawaan.
- `git diff --check`: tanpa masalah whitespace.
- Perubahan sesi ini disimpan secara lokal; push dan pengumpulan tautan commit di SCELE dilakukan pengguna. Pengujian browser interaktif dan build Android/iOS tidak dilakukan pada sesi ini.

### Deklarasi bantuan AI - Tugas 7, 16 November 2026

**Alat:** Codex (OpenAI).

**Kontribusi saya:** basis proyek, pemilihan field, pengujian aplikasi, perbaikan kode, dan pemahaman README sebagaimana dijelaskan pada deklarasi umum proyek.

**Prompt pengguna:** `https://pbp.cs.ui.ac.id/assignments/individual/tugas-7.html selesain ya. yg push saya aja`.

**Bantuan AI:** membaca instruksi resmi, menemukan repo mobile Tutorial 08 yang sudah ada, mencocokkan kode dan enam jawaban reflektif dengan checklist, menambahkan tes warna/ikon kartu, dan memperbarui dokumentasi. Kode fitur utama tidak dibuat ulang karena sudah memenuhi kebutuhan tugas. Push diserahkan kepada pengguna sesuai permintaan.

**Pendekatan dan keterbatasan:** kode Tutorial 08 yang sudah tersedia diperiksa terhadap checklist Tugas 7, lalu pengujian warna dan ikon dilengkapi. Jadwal mengacu pada halaman resmi karena hasil pencarian memuat tanggal lama. Pemeriksaan mencakup analisis kode, tes widget, dan build web; status pengumpulan SCELE serta build Android/iOS tidak diverifikasi dalam sesi ini.

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


## Tutorial 09 - Navigasi, Layout, Form, dan Input

Implementasi mengikuti [Tutorial 09 resmi](https://pbp.cs.ui.ac.id/tutorial/tutorial-9.html), diakses 18 November 2026.

- `lib/screens/menu.dart`: halaman utama dengan drawer; tombol Tambah Proyek memakai `Navigator.push` sehingga route sebelumnya tetap tersedia untuk Back.
- `lib/screens/project_form.dart`: StatefulWidget dengan `Form`, `GlobalKey<FormState>`, dan input nama, deskripsi, kategori, teknologi, serta tautan proyek. Nama dan deskripsi wajib diisi (spasi saja ditolak); teknologi dan tautan opsional.
- `lib/widgets/left_drawer.dart`: header aplikasi dan navigasi Home/Add Project memakai `pushReplacement`. Drawer ditutup sebelum route halaman diganti.
- `lib/widgets/project_card.dart`: ItemCard dipisahkan dari halaman menu; semua impor diperbarui.
- Save memvalidasi dan menampilkan kelima nilai dalam AlertDialog yang dapat digulir. OK menutup dialog menggunakan `Navigator.pop`, mereset field serta state, dan mengembalikan kategori ke Web Development. Menutup dialog tanpa OK mempertahankan input.
- Dependensi dan impor `material_ui` ditambahkan sesuai catatan tutorial; SDK lokal Flutter 3.47.9.
- Tidak ada penyimpanan database pada tahap tutorial ini. Form Experience ditambahkan pada bagian Individual Assignment 8 di bawah.

### Pemeriksaan manual

1. Jalankan `flutter run -d chrome`; tekan Tambah Proyek dan gunakan Back untuk kembali.
2. Buka drawer, pilih Add Project, lalu coba Save dengan nama/deskripsi kosong.
3. Isi seluruh field, ganti kategori, lalu Save; periksa isi dialog.
4. Tekan OK; pastikan semua teks kosong dan kategori kembali ke Web Development.
5. Buka drawer dari form dan pilih Home.

### Deklarasi bantuan AI - Tutorial 09, 18 November 2026

**Alat:** Codex (OpenAI).

**Kontribusi saya:** basis proyek, pemilihan field, pengujian aplikasi, perbaikan kode, dan pemahaman README sebagaimana dijelaskan pada deklarasi umum proyek.

**Prompt pengguna:** "https://pbp.cs.ui.ac.id/ selesaikan tutorial 9. commitnya saya sendiri aja. tapi kasih saya commandnya biar saya tinggal commit terus kumpulin".

**Bantuan AI:** membaca panduan, menulis drawer dan form proyek, merapikan struktur file serta impor, menambahkan material_ui, menulis tes navigasi/validasi/reset/layout, dan menyusun pembaruan README.

**Pendekatan dan keterbatasan:** pola navigasi dan form mengikuti Tutorial 09 serta struktur menu yang sudah tersedia. Pemeriksaan otomatis mencakup validasi, dialog, reset, dan layout layar kecil. Pengujian browser interaktif serta build Android/iOS tidak dilakukan oleh Codex pada sesi ini.

**Pengumpulan:** halaman aktual menetapkan tenggat Tutorial 09 pada **18 November 2026 pukul 23.59 WIB**. Push ke repositori GitHub publik sebelum tenggat dan kumpulkan **tautan commit** ke slot Tutorial 09 di SCELE. Commit, push, dan submisi dilakukan pengguna.

```powershell
git add lib test pubspec.yaml pubspec.lock README.md
git commit -m "Complete Tutorial 09: navigation and project form"
git push origin main
$commit = git rev-parse HEAD
"https://github.com/JeudiAugusto/myportofolio_mobile/commit/$commit"
```

### Hasil verifikasi Tutorial 09

- `flutter analyze`: No issues found.
- `flutter test`: 12 tes lulus, termasuk navigasi push/pushReplacement, validasi, isi dialog, reset kategori dan input, serta layar 320px dengan skala teks 2x.
- `flutter build web`: berhasil setelah perbaikan akhir, termasuk Wasm dry run.
- `dart format --output=none --set-exit-if-changed lib test`: tidak ada perubahan format.
- `git diff --check`: tidak ada masalah whitespace.
- Browser interaktif dan build Android/iOS belum diuji. Commit, push, serta submisi SCELE belum dilakukan.

## Individual Assignment 8 — Form Experience

Implementasi 19 November 2026 mengikuti [panduan resmi Tugas 8](https://pbp.cs.ui.ac.id/assignments/individual/tugas-8.html). Melanjutkan Tutorial 09 tanpa menghapus form proyek atau jawaban sebelumnya.

| Persyaratan | Implementasi |
| --- | --- |
| Form baru terpisah | `lib/screens/experience_form.dart`: StatefulWidget, Form, GlobalKey<FormState> |
| Input sesuai model | Nama (`title`), deskripsi (`description`), dropdown kategori (`category`), path thumbnail opsional (`thumbnail`) |
| Validasi | Nama/deskripsi menolak kosong dan spasi; nama dan thumbnail maksimal 255 karakter Unicode; kategori harus termasuk tujuh pilihan backend |
| Kartu aksi | Tambah Experience memakai Navigator.push; Back mengembalikan halaman sebelumnya |
| Drawer bersama | Home, Add Project, Add Experience tersedia pada menu dan kedua form |
| Dialog | Simpan memvalidasi lalu menampilkan seluruh isian; Tutup kembali ke form dengan input tetap tersedia untuk diedit |
| Layout | SafeArea, SingleChildScrollView, batas lebar 720, input multiline, pesan error dapat membungkus, dialog scrollable |
| Pengujian | `test/experience_form_test.dart`: navigasi, input invalid/valid, batas panjang, kategori, thumbnail opsional, perubahan isian, layar 320px/teks 2x/keyboard |

Aturan mengacu ke `main/models.py` dan `main/forms.py` pada repo Django `myportofolio`: kategori `internship`, `research`, `volunteer`, `organization`, `part-time`, `full-time` (default), dan `freelance`. Thumbnail adalah CharField/path, bukan URLField, sehingga tidak dipaksa berformat URL. `started_at` memakai `auto_now_add`; `ended_at` tidak diekspos oleh ExperienceForm backend. Karena form ini mengikuti empat field editable backend, tidak ada input tanggal atau aturan urutan tanggal yang perlu diterapkan. ID dan relasi starred_by juga bukan input form. Tidak ada koneksi API atau penyimpanan database pada tugas ini; dialog menyatakan bahwa isian masih berupa pratinjau.

### Tugas 8

1. **Navigasi.** `Navigator.push()` menambah route di atas stack, sehingga route sebelumnya tetap dapat dikunjungi melalui `pop()`. Kartu Tambah Experience di `project_card.dart` memakai push ke ExperienceFormPage. `pushReplacement()` mengganti route aktif; route yang diganti tidak menjadi tujuan Back. Drawer memakai `_navigate`: mengambil Navigator, menutup drawer dengan pop, lalu pushReplacement ke halaman pilihan. Opsi Home mengganti halaman form dengan MyHomePage sehingga dapat dipakai juga di Chrome. Jika form sebelumnya dibuka lewat push, route Home lama masih berada di bawahnya; pushReplacement tidak menghapus seluruh stack. `pop()` mengeluarkan route paling atas atau menutup drawer/dialog, seperti tombol Tutup pada ringkasan.

2. **Struktur dan tema.** Scaffold menyediakan kerangka AppBar, body, drawer, dan penyesuaian ruang ketika keyboard tampil. AppBar memberi judul halaman, sedangkan LeftDrawer yang sama menyediakan tujuan navigasi konsisten pada Home, ProjectFormPage, dan ExperienceFormPage. AppBar ketiganya memakai `Theme.of(context).colorScheme.primary` sebagai latar dan `onPrimary` sebagai warna teks. Tombol Simpan pada form Experience juga menggunakan pasangan warna tersebut, mengikuti tema MaterialApp.

3. **Layout formulir.** Column menyusun input sesuai urutan baca. Padding memberi ruang dari tepi serta jarak antarkolom, dan SizedBox memisahkan petunjuk, input, serta tombol. Center dan ConstrainedBox membatasi lebar form pada desktop tanpa memaksakan lebar minimum pada ponsel. SingleChildScrollView memungkinkan field dan Simpan digulir saat tinggi layar berkurang karena keyboard; SafeArea menghindari area sistem. Dropdown memakai isExpanded dan teks ellipsis agar label pilihan tidak melebar keluar layar. AlertDialog yang scrollable menjaga ringkasan panjang tetap dapat dibaca dan tombol Tutup dapat diakses.

4. **Validasi.** GlobalKey<FormState> memberi akses ke state Form yang menaungi seluruh field. Ketika Simpan ditekan, `validate()` menjalankan validator setiap field dan menampilkan pesan pada kolom yang tidak valid. Jika ada kegagalan, `_submit()` berhenti sebelum dialog. Jika seluruhnya valid, `save()` menjalankan onSaved untuk mengambil nilai yang telah di-trim, lalu showDialog menampilkan ringkasan. Contohnya nama `'   '` ditolak karena kosong setelah trim, dan nama 256 karakter ditolak karena batas model 255. Keyboard hanya membantu memasukkan data; paste atau input lain tetap dapat menghasilkan nilai tidak valid. Dropdown membatasi pilihan normal, tetapi validator kategori tetap memastikan nilainya termasuk daftar backend. Thumbnail boleh kosong, namun tetap diperiksa panjangnya ketika diisi.

### Cara memeriksa Tugas 8

1. Jalankan `flutter pub get`, lalu `flutter run -d chrome` dari direktori ini.
2. Klik Tambah Experience; periksa form, lalu gunakan Back pada perangkat atau opsi Home di drawer pada Chrome.
3. Buka drawer > Add Experience. Pastikan Home dan Add Project tetap tersedia.
4. Tekan Simpan dengan input kosong/spasi, lalu coba nama dan thumbnail melebihi 255 karakter. Periksa pesan kesalahan dan tidak adanya dialog.
5. Isi nama/deskripsi, pilih kategori, dan isi path thumbnail. Simpan dan periksa seluruh nilai di ringkasan.
6. Tekan Tutup, ubah nama dan kosongkan thumbnail, lalu Simpan lagi untuk memeriksa nilai baru.
7. Ulangi pada layar ponsel dengan keyboard tampil; gulir sampai tombol Simpan.

### Deklarasi bantuan AI — Tugas 8

**Kontribusi saya:** basis proyek, pemilihan field, pengujian aplikasi, perbaikan kode, dan pemahaman README sebagaimana dijelaskan pada deklarasi umum proyek.

**Alat:** Codex (OpenAI).

**Prompt pengguna:** "https://pbp.cs.ui.ac.id/ selesain individual assignment 8 sesuai panduan web. dan biarkan saya yang commit. paling cariin link commitnya aja."

**Bantuan AI:** memeriksa panduan dan model/form Django lokal, menulis form Experience beserta navigasi, menambahkan tes otomatis, menyusun draf empat jawaban reflektif, serta menjalankan analisis, tes, dan build web.

**Pendekatan dan keterbatasan:** field dan aturan validasi dicocokkan dengan ExperienceForm backend serta checklist tugas, kemudian diterapkan pada struktur Tutorial 09. Tes widget mencakup input valid/tidak valid, navigasi, dan layout layar sempit. Pengujian browser interaktif serta build Android/iOS tidak dilakukan oleh Codex pada sesi ini. Commit, push, dan submisi SCELE diserahkan kepada pemilik repositori.

### Pengumpulan Tugas 8

Tenggat panduan: **Senin, 23 November 2026, pukul 23.59 WIB**. Tutorial 09 wajib sudah selesai paling lambat **18 November 2026 pukul 23.59 WIB**; kode tutorial tersedia dalam riwayat lokal, tetapi status pengumpulan SCELE tidak diverifikasi. Kumpulkan tautan commit hasil akhir yang sudah di-push ke repo publik, bukan tautan riwayat atau commit Tutorial 09.

Jalankan sendiri setelah meninjau perubahan:

```powershell
git add lib/screens/experience_form.dart lib/screens/menu.dart lib/widgets/left_drawer.dart lib/widgets/project_card.dart test/experience_form_test.dart README.md
git commit -m "feat: complete assignment 8 experience form and navigation"
git push origin main
$assignment8Commit = git rev-parse HEAD
"https://github.com/JeudiAugusto/myportofolio_mobile/commit/$assignment8Commit"
```

Tautan final baru dapat ditentukan setelah commit dibuat. Folder `.vscode/` yang sudah ada tidak termasuk perubahan tugas ini.

### Hasil verifikasi Tugas 8 — 19 November 2026

- `flutter analyze`: No issues found.
- `flutter test`: 17 tes lulus.
- `flutter build web`: berhasil, termasuk Wasm dry run.
- `dart format --output=none --set-exit-if-changed lib test`: tidak ada perubahan format.
- `git diff --check`: tidak ada masalah whitespace.
- Pemeriksaan oleh Codex terbatas pada analisis, tes widget, dan build web; browser interaktif serta build Android/iOS tidak dijalankan pada sesi ini.
