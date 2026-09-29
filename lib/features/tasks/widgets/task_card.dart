import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String project;
  final String dueDate;
  final String priority;
  final bool isCompleted;
  final bool isReadOnly;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.title,
    required this.project,
    required this.dueDate,
    required this.priority,
    required this.isCompleted,
    this.isReadOnly = false,
    required this.onChanged,
    this.onEdit,
    this.onDelete,
  });

  Color _priorityColor() {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _localizedPriority(AppLocalizations localizations) {
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
    final priorityColor = _priorityColor();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: isReadOnly ? null : onChanged,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        project,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: priorityColor.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: Text(
                              _localizedPriority(localizations),
                              style: TextStyle(
                                color: priorityColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            dueDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isReadOnly) ...[
                  const SizedBox(width: 4),
                  Column(
                    children: [
                      IconButton(
                        tooltip: localizations.editTask,
                        onPressed: onEdit,
                        icon: const Icon(
                          Icons.edit_outlined,
                        ),
                      ),
                      IconButton(
                        tooltip: localizations.deleteTask,
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          if (isCompleted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withValues(
                  alpha: 0.15,
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.green.withValues(
                      alpha: 0.25,
                    ),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    localizations.completed,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}