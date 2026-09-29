import 'package:flutter/material.dart';
import 'package:omran/core/models/task.dart';
import 'package:omran/l10n/app_localizations.dart';

class EditTaskData {
  final String title;
  final String location;
  final String priority;
  final String status;
  final String assignedTo;
  final DateTime dueDate;

  const EditTaskData({
    required this.title,
    required this.location,
    required this.priority,
    required this.status,
    required this.assignedTo,
    required this.dueDate,
  });
}

class EditTaskSheet extends StatefulWidget {
  final Task task;

  const EditTaskSheet({super.key, required this.task});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _locationController;
  late final TextEditingController _assignedToController;
  late String _selectedPriority;
  late String _selectedStatus;
  late DateTime _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _locationController = TextEditingController(text: widget.task.location);
    _assignedToController = TextEditingController(
      text: widget.task.assignedTo,
    );
    _selectedPriority = widget.task.priority;
    _selectedStatus = widget.task.status;
    _selectedDueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _assignedToController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDueDate = pickedDate;
    });
  }

  void _saveChanges() {
    final localizations = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.pleaseEnterTaskTitle),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      EditTaskData(
        title: title,
        location: _locationController.text.trim(),
        priority: _selectedPriority,
        status: _selectedStatus,
        assignedTo: _assignedToController.text.trim(),
        dueDate: _selectedDueDate,
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

  String _localizedStatus(
      String status,
      AppLocalizations localizations,
      ) {
    switch (status) {
      case 'Open':
        return localizations.open;
      case 'In Progress':
        return localizations.inProgress;
      case 'Completed':
        return localizations.completed;
      default:
        return status;
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
                    localizations.editTask,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: localizations.location,
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),
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
                    _localizedPriority('High', localizations),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Medium',
                  child: Text(
                    _localizedPriority('Medium', localizations),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Low',
                  child: Text(
                    _localizedPriority('Low', localizations),
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
            DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: InputDecoration(
                labelText: localizations.status,
                prefixIcon: const Icon(Icons.check_circle_outline),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Open',
                  child: Text(
                    _localizedStatus('Open', localizations),
                  ),
                ),
                DropdownMenuItem(
                  value: 'In Progress',
                  child: Text(
                    _localizedStatus('In Progress', localizations),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Completed',
                  child: Text(
                    _localizedStatus('Completed', localizations),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _selectedStatus = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _assignedToController,
              decoration: InputDecoration(
                labelText: localizations.assignedTo,
                prefixIcon: const Icon(Icons.person_outline),
              ),
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
                  '${_selectedDueDate.day.toString().padLeft(2, '0')}/'
                      '${_selectedDueDate.month.toString().padLeft(2, '0')}/'
                      '${_selectedDueDate.year}',
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                child: Text(localizations.saveChanges),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}