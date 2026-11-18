import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

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
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          if (item.name == 'Tambah Proyek') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          }
        },
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
