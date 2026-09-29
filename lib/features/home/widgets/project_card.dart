import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectCard extends StatelessWidget {
  final String name;
  final String location;
  final String status;
  final double progress;
  final String dueDate;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.name,
    required this.location,
    required this.status,
    required this.progress,
    required this.dueDate,
    this.onTap,
  });

  Color _statusColor(BuildContext context) {
    switch (status) {
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

  String _localizedStatus(AppLocalizations localizations) {
    switch (status) {
      case 'On track':
        return localizations.onTrack;
      case 'At risk':
        return localizations.atRisk;
      case 'Planning':
        return localizations.planning;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final statusColor = _statusColor(context);
    final localizedStatus = _localizedStatus(localizations);

    return SizedBox(
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    localizedStatus,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(progress * 100).round()}% '
                          '${localizations.complete}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${localizations.due} $dueDate',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}