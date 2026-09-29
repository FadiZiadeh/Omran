import 'package:flutter/material.dart';
import 'package:omran/core/models/user_profile.dart';
import 'package:omran/l10n/app_localizations.dart';

class DailyGreeting extends StatelessWidget {
  final UserProfile? user;

  const DailyGreeting({
    super.key,
    required this.user,
  });

  String _getGreeting(
      DateTime now,
      AppLocalizations localizations,
      ) {
    final hour = now.hour;

    if (hour < 12) {
      return localizations.goodMorning;
    }

    if (hour < 17) {
      return localizations.goodAfternoon;
    }

    return localizations.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final localizations = AppLocalizations.of(context)!;

    final greeting = _getGreeting(
      now,
      localizations,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${now.day}/${now.month}/${now.year}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          '$greeting, '
              '${user?.firstName ?? localizations.user} 👋',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          localizations.sitePulseToday,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}