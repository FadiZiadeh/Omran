import 'package:flutter/material.dart';
import 'package:omran/core/models/task.dart';
import 'package:omran/l10n/app_localizations.dart';

class TodaysFocusCard extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback onTasksPressed;

  const TodaysFocusCard({
    super.key,
    required this.tasks,
    required this.onTasksPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    final now = DateTime.now();

    int todayTasks = 0;

    for (final task in tasks) {
      final isSameDay =
          task.dueDate.year == now.year &&
              task.dueDate.month == now.month &&
              task.dueDate.day == now.day;

      final isOpen =
          task.status.toLowerCase() != 'completed';

      if (isSameDay && isOpen) {
        todayTasks++;
      }
    }

    return Card(
      child: InkWell(
        onTap: onTasksPressed,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.primary
                      .withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.priority_high,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.todaysFocus,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      localizations.openActionsDueToday(
                        todayTasks,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}