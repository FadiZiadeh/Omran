import 'package:flutter/material.dart';

class ProjectFilterChips extends StatelessWidget {
  final String status;
  final String progress;
  final String location;
  final String date;
  final VoidCallback onClearStatus;
  final VoidCallback onClearProgress;
  final VoidCallback onClearLocation;
  final VoidCallback onClearDate;
  final VoidCallback onClearAll;

  const ProjectFilterChips({
    super.key,
    required this.status,
    required this.progress,
    required this.location,
    required this.date,
    required this.onClearStatus,
    required this.onClearProgress,
    required this.onClearLocation,
    required this.onClearDate,
    required this.onClearAll,
  });

  Widget _buildChip({required String label, required VoidCallback onDeleted}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 16),
        onDeleted: onDeleted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasFilters =
        status != 'All' ||
        progress != 'All' ||
        location != 'All' ||
        date != 'All';
    if (!hasFilters) {
      return const SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (status != 'All')
            _buildChip(label: status, onDeleted: onClearStatus),
          if (progress != 'All')
            _buildChip(label: progress, onDeleted: onClearProgress),
          if (location != 'All')
            _buildChip(label: location, onDeleted: onClearLocation),
          if (date != 'All') _buildChip(label: date, onDeleted: onClearDate),
          ActionChip(label: const Text('Clear all'), onPressed: onClearAll),
        ],
      ),
    );
  }
}
