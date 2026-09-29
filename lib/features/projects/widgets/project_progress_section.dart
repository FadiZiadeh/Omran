import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectProgressSection extends StatelessWidget {
  final Project project;
  final String Function(DateTime) formatDate;

  const ProjectProgressSection({
    super.key,
    required this.project,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations.overallProgress,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(project.progress * 100).round()}%',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: project.progress,
                    minHeight: 10,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        Card(
          child: ListTile(
            leading: const Icon(
              Icons.event_outlined,
            ),
            title: Text(
              localizations.dueDate,
            ),
            subtitle: Text(
              formatDate(project.dueDate),
            ),
          ),
        ),
      ],
    );
  }
}