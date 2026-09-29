import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/models/project_update.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/core/services/project_update_service.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/features/projects/widgets/add_project_update_sheet.dart';
import 'package:omran/features/projects/widgets/project_details_header.dart';
import 'package:omran/features/projects/widgets/project_progress_section.dart';
import 'package:omran/features/projects/widgets/project_resources_section.dart';
import 'package:omran/features/projects/widgets/project_site_pulse.dart';
import 'package:omran/features/projects/widgets/edit_project_sheet.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectDetailsView extends StatefulWidget {
  final Project project;

  const ProjectDetailsView({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailsView> createState() =>
      _ProjectDetailsViewState();
}

class _ProjectDetailsViewState
    extends State<ProjectDetailsView> {
  bool get _isEnded =>
      widget.project.status == 'Ended';

  final ProjectUpdateService _updateService =
  ProjectUpdateService();

  final ProjectService _projectService =
  ProjectService();

  Color _statusColor(BuildContext context) {
    switch (widget.project.status) {
      case 'On track':
        return Colors.green;

      case 'At risk':
        return Colors.orange;

      case 'Planning':
        return Theme.of(context).colorScheme.primary;

      default:
        return Colors.grey;
    }
  }

  String _monthName(
      int month,
      AppLocalizations localizations,
      ) {
    final months = [
      localizations.jan,
      localizations.feb,
      localizations.mar,
      localizations.apr,
      localizations.may,
      localizations.jun,
      localizations.jul,
      localizations.aug,
      localizations.sep,
      localizations.oct,
      localizations.nov,
      localizations.dec,
    ];

    return months[month - 1];
  }

  String _formatDate(
      DateTime date,
      AppLocalizations localizations,
      ) {
    return '${_monthName(date.month, localizations)} '
        '${date.day}, ${date.year}';
  }

  Future<void> _showAddUpdateSheet() async {
    if (_isEnded) {
      return;
    }

    final result =
    await showModalBottomSheet<AddProjectUpdateResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return const AddProjectUpdateSheet();
      },
    );

    if (result == null) {
      return;
    }

    final update = ProjectUpdate(
      id: '',
      projectId: widget.project.id,
      message: result.message,
      createdBy: 'Fadi Ziadeh',
      role: 'Project Manager',
      createdAt: DateTime.now(),
      type: result.type,
    );

    await _updateService.addUpdate(update);
  }

  void _showEditProjectSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return EditProjectSheet(
          project: widget.project,
        );
      },
    );
  }

  Future<void> _deleteProject() async {
    final localizations =
    AppLocalizations.of(context)!;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            localizations.deleteProject,
          ),
          content: Text(
            localizations.deleteProjectConfirmation(
              widget.project.name,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: Text(
                localizations.cancel,
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: Text(
                localizations.delete,
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    try {
      await _projectService.deleteProject(
        widget.project.id,
      );

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToDeleteProject(
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

    final statusColor =
    _statusColor(context);

    return Scaffold(
      body: Column(
        children: [
          CurvedHeader(
            title: localizations.projectDetails,
            onBack: () {
              Navigator.pop(context);
            },
          ),

          Expanded(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                24,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  ProjectDetailsHeader(
                    project: widget.project,
                    isEnded: _isEnded,
                    statusColor: statusColor,
                    onEdit: _showEditProjectSheet,
                    onDelete: _deleteProject,
                  ),

                  const SizedBox(height: 28),

                  ProjectProgressSection(
                    project: widget.project,
                    formatDate: (date) {
                      return _formatDate(
                        date,
                        localizations,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  ProjectResourcesSection(
                    projectId: widget.project.id,
                    projectName: widget.project.name,
                    isEnded: _isEnded,
                  ),

                  const SizedBox(height: 28),

                  ProjectSitePulse(
                    projectId: widget.project.id,
                    isEnded: _isEnded,
                    onAddUpdate:
                    _showAddUpdateSheet,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}