import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/features/projects/view/project_details_view.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectListCard extends StatelessWidget {
  final Project project;

  const ProjectListCard({
    super.key,
    required this.project,
  });

  Color _statusColor(BuildContext context) {
    switch (project.status) {
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

  String _formatDate(
      DateTime date,
      AppLocalizations localizations,
      ) {
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

  String _localizedStatus(
      AppLocalizations localizations,
      ) {
    switch (project.status) {
      case 'On track':
        return localizations.onTrack;
      case 'At risk':
        return localizations.atRisk;
      case 'Planning':
        return localizations.planning;
      case 'Ended':
        return localizations.ended;
      default:
        return project.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final statusColor = _statusColor(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsView(
                project: project,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(project.location),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(
                        alpha: 0.12,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _localizedStatus(localizations),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    _formatDate(
                      project.dueDate,
                      localizations,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.progress,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                  Text(
                    '${(project.progress * 100).round()}%',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: project.progress,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}