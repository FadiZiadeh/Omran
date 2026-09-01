import 'package:flutter/material.dart';
import 'package:omran/core/localization/locale_controller.dart';
import 'package:omran/core/theme/theme_controller.dart';
import 'package:omran/features/authentication/view/login_view.dart';
import 'package:omran/features/authentication/viewmodel/login_viewmodel.dart';
import 'package:omran/l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final localization = AppLocalizations.of(context)!;

    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.logout),
          content: Text(localization.confirmLogout),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(localization.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(localization.logout),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true || !context.mounted) {
      return;
    }

    final viewModel = LoginViewModel();

    await viewModel.logout();

    if (!context.mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(title: const Text('Omran')),

      // =========================
      // DRAWER
      // =========================
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              // =========================
              // DRAWER LOGO
              // =========================
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/omran_logo_dark.png'
                          : 'assets/images/omran_logo.png',
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Omran',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // =========================
              // LANGUAGE
              // =========================
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(localization.language),
                trailing: DropdownButton<Locale>(
                  value: localeController.locale,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: Locale('en'), child: Text('EN')),
                    DropdownMenuItem(value: Locale('ar'), child: Text('AR')),
                  ],
                  onChanged: (Locale? locale) {
                    if (locale != null) {
                      localeController.setLocale(locale);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),

              // =========================
              // DARK / LIGHT MODE
              // =========================
              ListTile(
                leading: Icon(
                  themeController.isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: Text(
                  themeController.isDarkMode
                      ? localization.darkMode
                      : localization.lightMode,
                ),
                trailing: Switch(
                  value: themeController.isDarkMode,
                  onChanged: (value) {
                    themeController.toggleTheme(value);
                  },
                ),
              ),

              // =========================
              // LOGOUT
              // =========================
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(localization.logout),
                onTap: () {
                  Navigator.pop(context);
                  _confirmLogout(context);
                },
              ),

              const Spacer(),

              // =========================
              // FOOTER
              // =========================
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Omran', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),

      // =========================
      // HOME BODY
      // =========================
      body: Center(
        child: Text(
          localization.welcomeHome,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
