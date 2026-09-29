import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omran/core/models/notification_model.dart';
import 'package:omran/core/notifications/notification_service.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/l10n/app_localizations.dart';

class CreateProjectSheet extends StatefulWidget {
  final ProjectService projectService;
  final NotificationService notificationService;

  const CreateProjectSheet({
    super.key,
    required this.projectService,
    required this.notificationService,
  });

  @override
  State<CreateProjectSheet> createState() =>
      _CreateProjectSheetState();
}

class _CreateProjectSheetState
    extends State<CreateProjectSheet> {
  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _locationController =
  TextEditingController();

  DateTime? _selectedDueDate;

  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
      _selectedDueDate ?? DateTime.now(),
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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> _createProject() async {
    final localizations =
    AppLocalizations.of(context)!;

    final name =
    _nameController.text.trim();

    final location =
    _locationController.text.trim();

    if (name.isEmpty ||
        location.isEmpty ||
        _selectedDueDate == null) {
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

    final currentUser =
        FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            localizations
                .mustBeLoggedInToCreateProject,
          ),
        ),
      );
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      final projectId =
      await widget.projectService
          .createProject(
        name: name,
        location: location,
        dueDate: _selectedDueDate!,
      );

      final notification =
      NotificationModel(
        id: '',
        userId: currentUser.uid,
        title: localizations.projectCreated,
        body: localizations.newProjectCreated(
          name,
        ),
        type: 'project',
        projectId: projectId,
        taskId: '',
        isRead: false,
        createdAt: DateTime.now(),
      );

      await widget.notificationService
          .createNotification(
        notification,
      );

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isCreating = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToCreateProject(
              error.toString(),
            ),
          ),
        ),
      );
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
                    localizations.createProject,
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
                  onPressed: _isCreating
                      ? null
                      : () {
                    Navigator.pop(
                      context,
                    );
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
              enabled: !_isCreating,
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
              enabled: !_isCreating,
              decoration: InputDecoration(
                labelText:
                localizations.location,
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                ),
              ),
            ),

            const SizedBox(height: 16),

            InkWell(
              onTap: _isCreating
                  ? null
                  : _selectDueDate,
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
                  _selectedDueDate == null
                      ? localizations
                      .selectDueDate
                      : _formatDate(
                    _selectedDueDate!,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isCreating
                    ? null
                    : _createProject,
                child: _isCreating
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  localizations
                      .createProject,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}