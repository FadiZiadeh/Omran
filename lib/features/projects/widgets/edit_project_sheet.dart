import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/l10n/app_localizations.dart';

class EditProjectSheet extends StatefulWidget {
  final Project project;

  const EditProjectSheet({
    super.key,
    required this.project,
  });

  @override
  State<EditProjectSheet> createState() =>
      _EditProjectSheetState();
}

class _EditProjectSheetState
    extends State<EditProjectSheet> {
  final ProjectService _projectService =
  ProjectService();

  late final TextEditingController _nameController;
  late final TextEditingController
  _locationController;

  late String _selectedStatus;
  late double _selectedProgress;
  late DateTime _selectedDueDate;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.project.name,
    );

    _locationController =
        TextEditingController(
          text: widget.project.location,
        );

    _selectedStatus = widget.project.status;
    _selectedProgress = widget.project.progress;
    _selectedDueDate = widget.project.dueDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate,
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

  Future<void> _saveChanges() async {
    final localizations =
    AppLocalizations.of(context)!;

    final name =
    _nameController.text.trim();

    final location =
    _locationController.text.trim();

    if (name.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            localizations
                .pleaseEnterAllProjectInformation,
          ),
        ),
      );
      return;
    }

    final updatedProject = Project(
      id: widget.project.id,
      name: name,
      location: location,
      status: _selectedStatus,
      progress: _selectedProgress,
      dueDate: _selectedDueDate,
      ownerId: widget.project.ownerId,
      createdAt: widget.project.createdAt,
    );

    try {
      await _projectService.updateProject(
        updatedProject,
      );

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToUpdateProject(
              error.toString(),
            ),
          ),
        ),
      );
    }
  }

  String _localizedStatus(
      String status,
      AppLocalizations localizations,
      ) {
    switch (status) {
      case 'Planning':
        return localizations.planning;
      case 'On track':
        return localizations.onTrack;
      case 'At risk':
        return localizations.atRisk;
      case 'Ended':
        return localizations.ended;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        MediaQuery.of(context)
            .viewInsets
            .bottom +
            24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    localizations.editProject,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText:
                localizations.projectName,
                prefixIcon: const Icon(
                  Icons.business_outlined,
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
              _locationController,
              decoration: InputDecoration(
                labelText:
                localizations.location,
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                ),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: InputDecoration(
                labelText:
                localizations.status,
                prefixIcon: const Icon(
                  Icons.flag_outlined,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Planning',
                  child: Text(
                    localizations.planning,
                  ),
                ),
                DropdownMenuItem(
                  value: 'On track',
                  child: Text(
                    localizations.onTrack,
                  ),
                ),
                DropdownMenuItem(
                  value: 'At risk',
                  child: Text(
                    localizations.atRisk,
                  ),
                ),
                DropdownMenuItem(
                  value: 'Ended',
                  child: Text(
                    localizations.ended,
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

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.progress,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
                Text(
                  '${(_selectedProgress * 100).round()}%',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),

            Slider(
              value: _selectedProgress,
              min: 0,
              max: 1,
              divisions: 100,
              label:
              '${(_selectedProgress * 100).round()}%',
              onChanged: (value) {
                setState(() {
                  _selectedProgress = value;
                });
              },
            ),

            const SizedBox(height: 12),

            InkWell(
              onTap: _pickDueDate,
              borderRadius:
              BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText:
                  localizations.dueDate,
                  prefixIcon: const Icon(
                    Icons
                        .calendar_today_outlined,
                  ),
                ),
                child: Text(
                  '${_selectedDueDate.day.toString().padLeft(2, '0')}/'
                      '${_selectedDueDate.month.toString().padLeft(2, '0')}/'
                      '${_selectedDueDate.year}',
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                child: Text(
                  localizations.saveChanges,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}