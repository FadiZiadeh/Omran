import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/l10n/app_localizations.dart';

class PortfolioProgressCard extends StatelessWidget {
  final List<Project> projects;

  const PortfolioProgressCard({
    super.key,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    double progress = 0;

    if (projects.isNotEmpty) {
      double totalProgress = 0;

      for (final project in projects) {
        totalProgress += project.progress;
      }

      progress = totalProgress / projects.length;
    }

    final percentage = (progress * 100).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.portfolioProgress,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$percentage%',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.activeProjectsCount(
                    projects.length,
                  ),
                ),
                Text(
                  localizations.liveFromFirebase,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}