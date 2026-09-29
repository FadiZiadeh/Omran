import 'package:flutter/material.dart';
import 'package:omran/features/tasks/view/project_tasks_view.dart';
import 'package:omran/features/files/view/project_files_view.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectResourcesSection extends StatelessWidget {
  final String projectId;
  final String projectName;
  final bool isEnded;

  const ProjectResourcesSection({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.isEnded,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.check_circle_outline,
            ),
            title: Text(
              localizations.tasks,
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectTasksView(
                    projectId: projectId,
                    projectName: projectName,
                    isEnded: isEnded,
                  ),
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(
              Icons.folder_outlined,
            ),
            title: Text(
              localizations.files,
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectFilesView(
                    projectId: projectId,
                    projectName: projectName,
                    isEnded: isEnded,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}