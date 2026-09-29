import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/l10n/app_localizations.dart';

class CreateTaskData {
  final String title;
  final Project project;
  final String priority;
  final DateTime dueDate;

  const CreateTaskData({
    required this.title,
    required this.project,
    required this.priority,
    required this.dueDate,
  });
}

class CreateTaskSheet extends StatefulWidget {
  final List<Project> projects;
  final Project? initialProject;
  final bool projectLocked;

  const CreateTaskSheet({
    super.key,
    required this.projects,
    required this.initialProject,
    required this.projectLocked,
  });

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final TextEditingController _titleController =
  TextEditingController();

  late Project? _selectedProject;
  DateTime? _selectedDueDate;
  String _selectedPriority = 'Medium';

  late final List<Project> _availableProjects;

  @override
  void initState() {
    super.initState();

    _selectedProject = widget.initialProject;

    _availableProjects = widget.projects.where((project) {
      return project.status != 'Ended';
    }).toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDueDate = pickedDate;
    });
  }

  void _createTask() {
    final localizations = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();

    if (title.isEmpty ||
        _selectedProject == null ||
        _selectedDueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.pleaseEnterAllTaskInformation,
          ),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      CreateTaskData(
        title: title,
        project: _selectedProject!,
        priority: _selectedPriority,
        dueDate: _selectedDueDate!,
      ),
    );
  }

  String _localizedPriority(
      String priority,
      AppLocalizations localizations,
      ) {
    switch (priority) {
      case 'High':
        return localizations.high;
      case 'Medium':
        return localizations.medium;
      case 'Low':
        return localizations.low;
      default:
        return priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    localizations.createTask,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: localizations.taskTitle,
                prefixIcon: const Icon(Icons.task_outlined),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Project>(
              initialValue: _selectedProject,
              decoration: InputDecoration(
                labelText: localizations.project,
                prefixIcon: const Icon(
                  Icons.business_outlined,
                ),
              ),
              items: _availableProjects.map((project) {
                return DropdownMenuItem<Project>(
                  value: project,
                  child: Text(project.name),
                );
              }).toList(),
              onChanged: widget.projectLocked
                  ? null
                  : (project) {
                setState(() {
                  _selectedProject = project;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedPriority,
              decoration: InputDecoration(
                labelText: localizations.priority,
                prefixIcon: const Icon(Icons.flag_outlined),
              ),
              items: [
                DropdownMenuItem(
                  value: 'High',
                  child: Text(
                    _localizedPriority(
                      'High',
                      localizations,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Medium',
                  child: Text(
                    _localizedPriority(
                      'Medium',
                      localizations,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Low',
                  child: Text(
                    _localizedPriority(
                      'Low',
                      localizations,
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _selectedPriority = value;
                });
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _selectDueDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: localizations.dueDate,
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
                child: Text(
                  _selectedDueDate == null
                      ? localizations.selectDueDate
                      : '${_selectedDueDate!.day.toString().padLeft(2, '0')}/'
                      '${_selectedDueDate!.month.toString().padLeft(2, '0')}/'
                      '${_selectedDueDate!.year}',
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createTask,
                child: Text(localizations.createTask),
              ),
            ),
          ],
        ),
      ),
    );
  }
}