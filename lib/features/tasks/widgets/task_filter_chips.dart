import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class TaskFilterChips extends StatelessWidget {
  final String status;
  final String date;
  final String project;
  final String location;
  final String priority;

  final VoidCallback onClearStatus;
  final VoidCallback onClearDate;
  final VoidCallback onClearProject;
  final VoidCallback onClearLocation;
  final VoidCallback onClearPriority;
  final VoidCallback onClearAll;

  const TaskFilterChips({
    super.key,
    required this.status,
    required this.date,
    required this.project,
    required this.location,
    required this.priority,
    required this.onClearStatus,
    required this.onClearDate,
    required this.onClearProject,
    required this.onClearLocation,
    required this.onClearPriority,
    required this.onClearAll,
  });

  Widget _buildChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(
          Icons.close,
          size: 16,
        ),
        onDeleted: onDeleted,
      ),
    );
  }

  String _localizedStatus(
      String value,
      AppLocalizations localizations,
      ) {
    switch (value) {
      case 'Open':
        return localizations.open;
      case 'In Progress':
        return localizations.inProgress;
      case 'Completed':
        return localizations.completed;
      default:
        return value;
    }
  }

  String _localizedDate(
      String value,
      AppLocalizations localizations,
      ) {
    switch (value) {
      case 'Today':
        return localizations.today;
      case 'This week':
        return localizations.thisWeek;
      case 'This month':
        return localizations.thisMonth;
      case 'Overdue':
        return localizations.overdue;
      default:
        return value;
    }
  }

  String _localizedPriority(
      String value,
      AppLocalizations localizations,
      ) {
    switch (value) {
      case 'High':
        return localizations.high;
      case 'Medium':
        return localizations.medium;
      case 'Low':
        return localizations.low;
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final hasFilters =
        status != 'All' ||
            date != 'All' ||
            project != 'All' ||
            location != 'All' ||
            priority != 'All';

    if (!hasFilters) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (status != 'All')
            _buildChip(
              label:
              '${localizations.status}: '
                  '${_localizedStatus(status, localizations)}',
              onDeleted: onClearStatus,
            ),
          if (date != 'All')
            _buildChip(
              label:
              '${localizations.date}: '
                  '${_localizedDate(date, localizations)}',
              onDeleted: onClearDate,
            ),
          if (project != 'All')
            _buildChip(
              label:
              '${localizations.project}: '
                  '$project',
              onDeleted: onClearProject,
            ),
          if (location != 'All')
            _buildChip(
              label:
              '${localizations.location}: '
                  '$location',
              onDeleted: onClearLocation,
            ),
          if (priority != 'All')
            _buildChip(
              label:
              '${localizations.priority}: '
                  '${_localizedPriority(priority, localizations)}',
              onDeleted: onClearPriority,
            ),
          ActionChip(
            label: Text(localizations.clearAll),
            onPressed: onClearAll,
          ),
        ],
      ),
    );
  }
}