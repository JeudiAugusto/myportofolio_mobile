import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _projectName = '';
  String _description = '';
  String _category = 'Web Development';
  String _technologies = '';
  String _projectLink = '';

  static const _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        scrollable: true,
        title: const Text('Proyek berhasil ditambahkan!'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Proyek: $_projectName'),
              Text('Deskripsi: $_description'),
              Text('Kategori: $_category'),
              Text('Teknologi: $_technologies'),
              Text('Tautan: $_projectLink'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    _formKey.currentState!.reset();
    setState(() {
      _projectName = '';
      _description = '';
      _category = _categories.first;
      _technologies = '';
      _projectLink = '';
    });
  }

  Widget _textField(
    String label,
    FormFieldSetter<String> onSaved, {
    String? hint,
    String? requiredMessage,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) => Padding(
    padding: const EdgeInsets.all(8),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        errorMaxLines: 3,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: (value) =>
          requiredMessage != null && (value == null || value.trim().isEmpty)
          ? requiredMessage
          : null,
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Add Project Form'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    ),
    drawer: const LeftDrawer(),
    body: SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textField(
                    'Nama Proyek',
                    (v) => _projectName = v!.trim(),
                    requiredMessage: 'Nama proyek tidak boleh kosong!',
                  ),
                  _textField(
                    'Deskripsi Proyek',
                    (v) => _description = v!.trim(),
                    maxLines: 5,
                    requiredMessage: 'Deskripsi proyek tidak boleh kosong!',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<String>(
                      initialValue: _categories.first,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Kategori Proyek',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        _category = value ?? _categories.first;
                      }),
                      onSaved: (value) =>
                          _category = value ?? _categories.first,
                    ),
                  ),
                  _textField(
                    'Teknologi yang Digunakan',
                    (v) => _technologies = v?.trim() ?? '',
                    hint: 'Contoh: Flutter, Django, Figma',
                  ),
                  _textField(
                    'Tautan Proyek',
                    (v) => _projectLink = v?.trim() ?? '',
                    hint: 'URL Proyek (opsional)',
                    keyboardType: TextInputType.url,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary,
                          foregroundColor: Theme.of(context)
                              .colorScheme
                              .onPrimary,
                        ),
                        onPressed: _submit,
                        child: const Text('Save'),
                      ),
                    ),
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
