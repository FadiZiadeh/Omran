import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/features/home/widgets/project_card.dart';
import 'package:omran/features/projects/view/project_details_view.dart';
import 'package:omran/l10n/app_localizations.dart';

class ActiveProjectsSection extends StatelessWidget {
  final List<Project> projects;
  final VoidCallback onViewAllPressed;

  const ActiveProjectsSection({
    super.key,
    required this.projects,
    required this.onViewAllPressed,
  });

  String _formatDate(
      BuildContext context,
      DateTime date,
      ) {
    final localizations = AppLocalizations.of(context)!;

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

    return '${months[date.month - 1]} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.activeProjects,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              onPressed: onViewAllPressed,
              child: Text(localizations.viewAll),
            ),
          ],
        ),

        const SizedBox(height: 12),

        if (projects.isEmpty)
          Text(
            localizations.noActiveProjects,
          )
        else
          SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: projects.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemBuilder: (context, index) {
                final project = projects[index];

                return ProjectCard(
                  name: project.name,
                  location: project.location,
                  status: project.status,
                  progress: project.progress,
                  dueDate: _formatDate(
                    context,
                    project.dueDate,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailsView(
                              project: project,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}