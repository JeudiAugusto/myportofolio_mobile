import 'package:flutter/material.dart';

/// Static menu; authentication and API navigation follow in later tutorials.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506656822';
  final String nama = 'Jeudi Augusto Asadullah';
  final String kelas = 'PBP C';

  static const items = [
    ItemHomepage('Lihat Proyek', Icons.folder_outlined, Color(0xFF2457A7)),
    ItemHomepage('Tambah Proyek', Icons.add_circle_outline, Color(0xFF216747)),
    ItemHomepage('Lihat Experience', Icons.work_outline, Color(0xFF7243A0)),
    ItemHomepage('Logout', Icons.logout, Color(0xFFAE3939)),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('MyPortfolio'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final largeText =
                    MediaQuery.textScalerOf(context).scale(16) > 24;
                final compact = constraints.maxWidth < 560 || largeText;
                final cards = [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'PORTOFOLIO / JEUDI',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mahasiswa Sistem Informasi · Universitas Indonesia',
                    ),
                    const SizedBox(height: 24),
                    if (compact)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: cards,
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: cards
                            .map((card) => Expanded(child: card))
                            .toList(),
                      ),
                    const SizedBox(height: 28),
                    Text(
                      'Jelajahi portofolio',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text('Proyek dan pengalaman, dalam satu tempat.'),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: largeText || constraints.maxWidth < 320
                          ? 1
                          : compact
                          ? 2
                          : 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: largeText ? 240 : 160,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: items.map((item) => ItemCard(item)).toList(),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Tutorial 08 · Basic Flutter',
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    ),
  );
}

class ItemHomepage {
  const ItemHomepage(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}

class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key});
  final ItemHomepage item;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: item.name,
    excludeSemantics: true,
    child: Material(
      color: item.color,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Kamu telah menekan tombol ${item.name}!'),
              behavior: SnackBarBehavior.floating,
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 32),
              const SizedBox(height: 12),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
