import 'package:flutter/material.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/l10n/app_localizations.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          CurvedHeader(
            title: localizations.about,
            onBack: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                children: [
                  Image.asset(
                    isDarkMode
                        ? 'assets/images/omran_logo_dark.png'
                        : 'assets/images/omran_logo.png',
                    height: 110,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Omran',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    localizations.aboutOmranDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(localizations.version),
                      trailing: const Text('1.0.0'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                      title: Text(localizations.date),
                      trailing: const Text('September 2026'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: Text(localizations.contact),
                      trailing: const Text(
                        '+972 59 752 8184',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}