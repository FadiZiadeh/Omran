import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/models/task.dart';
import 'package:omran/features/home/widgets/recent_action_tile.dart';
import 'package:omran/l10n/app_localizations.dart';

class RecentActionsSection extends StatelessWidget {
  final List<Task> tasks;
  final List<Project> projects;
  final VoidCallback onTaskBoardPressed;

  const RecentActionsSection({
    super.key,
    required this.tasks,
    required this.projects,
    required this.onTaskBoardPressed,
  });

  String _projectName(
      Task task,
      AppLocalizations localizations,
      ) {
    for (final project in projects) {
      if (project.id == task.projectId) {
        return project.name;
      }
    }

    return localizations.unknownProject;
  }

  String _formatDeadline(
      BuildContext context,
      DateTime date,
      ) {
    final localizations = AppLocalizations.of(context)!;

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final taskDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final difference = taskDate.difference(today).inDays;

    if (difference == 0) {
      return localizations.today;
    }

    if (difference == 1) {
      return localizations.tomorrow;
    }

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

  ActionPriority _getPriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return ActionPriority.high;

      case 'low':
        return ActionPriority.low;

      default:
        return ActionPriority.medium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final recentTasks = tasks.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.recentActions,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            TextButton(
              onPressed: onTaskBoardPressed,
              child: Text(
                localizations.openTaskBoard,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        if (recentTasks.isEmpty)
          Text(
            localizations.noRecentActions,
          )
        else
          for (int i = 0; i < recentTasks.length; i++) ...[
            RecentActionTile(
              title: recentTasks[i].title,
              project: _projectName(
                recentTasks[i],
                localizations,
              ),
              deadline: _formatDeadline(
                context,
                recentTasks[i].dueDate,
              ),
              priority: _getPriority(
                recentTasks[i].priority,
              ),
            ),

            if (i < recentTasks.length - 1)
              const SizedBox(height: 10),
          ],
      ],
    );
  }
}