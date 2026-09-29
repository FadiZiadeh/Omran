import 'package:flutter/material.dart';
import 'package:omran/core/models/project_update.dart';
import 'package:omran/core/services/project_update_service.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectSitePulse extends StatelessWidget {
  final String projectId;
  final bool isEnded;
  final VoidCallback onAddUpdate;

  const ProjectSitePulse({
    super.key,
    required this.projectId,
    required this.isEnded,
    required this.onAddUpdate,
  });

  static final ProjectUpdateService _updateService =
  ProjectUpdateService();

  String _monthName(
      int month,
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

    return months[month - 1];
  }

  String _formatUpdateDate(
      DateTime date,
      AppLocalizations localizations,
      ) {
    return '${_monthName(date.month, localizations)} ${date.day}, '
        '${date.year} · '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  IconData _updateIcon(String type) {
    switch (type) {
      case 'issue':
        return Icons.warning_amber_outlined;

      case 'milestone':
        return Icons.flag_outlined;

      case 'follow_up':
        return Icons.push_pin_outlined;

      default:
        return Icons.update_outlined;
    }
  }

  Color _updateColor(
      BuildContext context,
      String type,
      ) {
    switch (type) {
      case 'issue':
        return Colors.orange;

      case 'milestone':
        return Colors.green;

      case 'follow_up':
        return Colors.blue;

      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _updateTypeLabel(
      String type,
      AppLocalizations localizations,
      ) {
    switch (type) {
      case 'issue':
        return localizations.issue;

      case 'milestone':
        return localizations.milestone;

      case 'follow_up':
        return localizations.followUp;

      default:
        return localizations.update;
    }
  }

  Widget _buildUpdateItem(
      BuildContext context,
      ProjectUpdate update,
      bool isLast,
      ) {
    final localizations = AppLocalizations.of(context)!;

    final color = _updateColor(
      context,
      update.type,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _updateIcon(update.type),
                  size: 17,
                  color: color,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 100,
                  color: color.withValues(alpha: 0.18),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          update.createdBy,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.10),
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        child: Text(
                          _updateTypeLabel(
                            update.type,
                            localizations,
                          ),
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    update.role,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    update.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 15,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _formatUpdateDate(
                          update.createdAt,
                          localizations,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return StreamBuilder<List<ProjectUpdate>>(
      stream: _updateService.getUpdatesByProject(
        projectId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.sitePulse,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.unableToLoadProjectUpdates,
              ),
            ],
          );
        }

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.sitePulse,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }

        final updates = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.sitePulse,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isEnded)
                  TextButton.icon(
                    onPressed: onAddUpdate,
                    icon: const Icon(Icons.add),
                    label: Text(
                      localizations.addUpdate,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              localizations.latestProjectActivity,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
            const SizedBox(height: 20),
            if (updates.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    localizations.noSiteUpdatesYet,
                  ),
                ),
              )
            else
              ...updates.asMap().entries.map((entry) {
                final index = entry.key;
                final update = entry.value;

                final isLast =
                    index == updates.length - 1;

                return _buildUpdateItem(
                  context,
                  update,
                  isLast,
                );
              }),
          ],
        );
      },
    );
  }
}