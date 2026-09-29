import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

enum ActionPriority {
  high,
  medium,
  low,
}

class RecentActionTile extends StatefulWidget {
  final String title;
  final String project;
  final String deadline;
  final ActionPriority priority;

  const RecentActionTile({
    super.key,
    required this.title,
    required this.project,
    required this.deadline,
    required this.priority,
  });

  @override
  State<RecentActionTile> createState() =>
      _RecentActionTileState();
}

class _RecentActionTileState extends State<RecentActionTile> {
  bool _isCompleted = false;

  Color _priorityColor(BuildContext context) {
    switch (widget.priority) {
      case ActionPriority.high:
        return Colors.red;
      case ActionPriority.medium:
        return Colors.orange;
      case ActionPriority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final priorityColor = _priorityColor(context);

    return Card(
      child: ListTile(
        onTap: () {
          setState(() {
            _isCompleted = !_isCompleted;
          });
        },
        leading: Checkbox(
          value: _isCompleted,
          onChanged: (value) {
            setState(() {
              _isCompleted = value ?? false;
            });
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration:
            _isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${widget.project} • '
                '${localizations.due} ${widget.deadline}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: priorityColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}