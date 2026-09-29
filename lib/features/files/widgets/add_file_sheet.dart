import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/l10n/app_localizations.dart';

class AddFileResult {
  final String name;
  final String type;
  final String size;
  final String projectId;

  const AddFileResult({
    required this.name,
    required this.type,
    required this.size,
    required this.projectId,
  });
}

class AddFileSheet extends StatefulWidget {
  final List<Project> projects;
  final String? selectedProjectId;

  const AddFileSheet({
    super.key,
    required this.projects,
    this.selectedProjectId,
  });

  @override
  State<AddFileSheet> createState() => _AddFileSheetState();
}

class _AddFileSheetState extends State<AddFileSheet> {
  late String? _selectedProjectId;

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _sizeController =
  TextEditingController();

  String _selectedType = 'pdf';

  @override
  void initState() {
    super.initState();
    _selectedProjectId = widget.selectedProjectId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _save() {
    final localizations = AppLocalizations.of(context)!;

    final name = _nameController.text.trim();
    final size = _sizeController.text.trim();

    if (name.isEmpty ||
        size.isEmpty ||
        _selectedProjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.pleaseCompleteAllFields,
          ),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      AddFileResult(
        name: name,
        type: _selectedType,
        size: size,
        projectId: _selectedProjectId!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                localizations.addFile,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: localizations.fileName,
                  hintText: localizations.fileNameHint,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                decoration: InputDecoration(
                  labelText: localizations.fileType,
                ),
                items: [
                  const DropdownMenuItem(
                    value: 'pdf',
                    child: Text('PDF'),
                  ),
                  DropdownMenuItem(
                    value: 'image',
                    child: Text(
                      localizations.image,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'document',
                    child: Text(
                      localizations.document,
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedProjectId,
                decoration: InputDecoration(
                  labelText: localizations.project,
                ),
                items: widget.projects.map((project) {
                  return DropdownMenuItem<String>(
                    value: project.id,
                    child: Text(project.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProjectId = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _sizeController,
                decoration: InputDecoration(
                  labelText: localizations.fileSize,
                  hintText: localizations.fileSizeHint,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: Text(
                    localizations.saveFile,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}