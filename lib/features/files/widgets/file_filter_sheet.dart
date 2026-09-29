import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/l10n/app_localizations.dart';

class FileFilterResult {
  final String type;
  final String project;
  final String date;

  const FileFilterResult({
    required this.type,
    required this.project,
    required this.date,
  });
}

class FileFilterSheet extends StatefulWidget {
  final List<Project> projects;
  final String selectedType;
  final String selectedProject;
  final String selectedDate;

  const FileFilterSheet({
    super.key,
    required this.projects,
    required this.selectedType,
    required this.selectedProject,
    required this.selectedDate,
  });

  @override
  State<FileFilterSheet> createState() => _FileFilterSheetState();
}

class _FileFilterSheetState extends State<FileFilterSheet> {
  late String _selectedType;
  late String _selectedProject;
  late String _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedType = widget.selectedType;
    _selectedProject = widget.selectedProject;
    _selectedDate = widget.selectedDate;
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(
                _localizedOption(option),
              ),
              selected: selected == option,
              onSelected: (_) {
                onChanged(option);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  String _localizedOption(String option) {
    final localizations = AppLocalizations.of(context)!;

    switch (option) {
      case 'All':
        return localizations.all;
      case 'PDF':
        return 'PDF';
      case 'Image':
        return localizations.image;
      case 'Document':
        return localizations.document;
      case 'Today':
        return localizations.today;
      case 'This Week':
        return localizations.thisWeek;
      case 'This Month':
        return localizations.thisMonth;
      default:
        return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final projectNames = widget.projects
        .map((project) => project.name)
        .toSet()
        .toList();

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            24,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      localizations.filters,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedType = 'All';
                        _selectedProject = 'All';
                        _selectedDate = 'All';
                      });
                    },
                    child: Text(
                      localizations.reset,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    tooltip: localizations.close,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      _buildFilterSection(
                        title: localizations.fileType,
                        options: const [
                          'All',
                          'PDF',
                          'Image',
                          'Document',
                        ],
                        selected: _selectedType,
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFilterSection(
                        title: localizations.project,
                        options: [
                          'All',
                          ...projectNames,
                        ],
                        selected: _selectedProject,
                        onChanged: (value) {
                          setState(() {
                            _selectedProject = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFilterSection(
                        title: localizations.date,
                        options: const [
                          'All',
                          'Today',
                          'This Week',
                          'This Month',
                        ],
                        selected: _selectedDate,
                        onChanged: (value) {
                          setState(() {
                            _selectedDate = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      FileFilterResult(
                        type: _selectedType,
                        project: _selectedProject,
                        date: _selectedDate,
                      ),
                    );
                  },
                  child: Text(
                    localizations.applyFilters,
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