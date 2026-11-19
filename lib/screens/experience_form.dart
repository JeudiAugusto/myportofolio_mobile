import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Mirrors the editable fields in Django's ExperienceForm.
/// started_at is automatic; ended_at is not exposed by that form.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _category = 'full-time';
  String _thumbnail = '';

  static const _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'organization': 'Organization',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        scrollable: true,
        title: const Text('Ringkasan Experience'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Experience: $_title'),
            Text('Deskripsi: $_description'),
            Text('Kategori: ${_categories[_category]}'),
            Text(
              'Path Thumbnail: ${_thumbnail.isEmpty ? "Tidak diisi" : _thumbnail}',
            ),
            const SizedBox(height: 16),
            const Text('Pratinjau isian; belum disimpan ke database.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required String label,
    required FormFieldSetter<String> onSaved,
    bool required = true,
    int? limit,
    int maxLines = 1,
    String? hint,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        errorMaxLines: 3,
      ),
      maxLines: maxLines,
      keyboardType: maxLines > 1 ? TextInputType.multiline : TextInputType.text,
      onSaved: onSaved,
      validator: (value) {
        final text = value?.trim() ?? '';
        if (required && text.isEmpty) return '$label tidak boleh kosong!';
        // Django max_length counts Unicode code points, not UTF-16 units.
        if (limit != null && text.runes.length > limit) {
          return '$label maksimal $limit karakter!';
        }
        return null;
      },
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Tambah Experience'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    ),
    drawer: const LeftDrawer(),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Ceritakan pengalaman dan tanggung jawabmu.'),
                  const SizedBox(height: 16),
                  _textField(
                    label: 'Nama Experience',
                    limit: 255,
                    onSaved: (value) => _title = value!.trim(),
                  ),
                  _textField(
                    label: 'Deskripsi Experience',
                    maxLines: 5,
                    onSaved: (value) => _description = value!.trim(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: DropdownButtonFormField<String>(
                      initialValue: 'full-time',
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                        errorMaxLines: 3,
                      ),
                      items: _categories.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(
                                entry.value,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _category = value!),
                      onSaved: (value) => _category = value!,
                      validator: (value) => _categories.containsKey(value)
                          ? null
                          : 'Pilih kategori yang valid!',
                    ),
                  ),
                  _textField(
                    label: 'Path Thumbnail',
                    required: false,
                    limit: 255,
                    hint: 'img/experience/kegiatan.jpg (opsional)',
                    onSaved: (value) => _thumbnail = value?.trim() ?? '',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: _submit,
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
