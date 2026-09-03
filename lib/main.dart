import 'package:flutter/material.dart';
import 'package:omran/core/localization/locale_controller.dart';
import 'package:omran/core/theme/app_theme.dart';
import 'package:omran/core/view/splash_view.dart';
import 'package:omran/l10n/app_localizations.dart';
import 'package:omran/core/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:omran/core/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notificationService = NotificationService();
  await notificationService.initialize();

  await localeController.loadLocale();
  await themeController.loadTheme();

  runApp(const OmranApp());
}

class OmranApp extends StatelessWidget {
  const OmranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        localeController,
        themeController,
      ]),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          themeMode: themeController.themeMode,

          locale: localeController.locale,

          localizationsDelegates:
          AppLocalizations.localizationsDelegates,

          supportedLocales:
          AppLocalizations.supportedLocales,

          home: const SplashView(),
        );
      },
    );
  }
}