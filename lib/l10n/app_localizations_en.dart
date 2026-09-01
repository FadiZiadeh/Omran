// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome to Omran';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get logout => 'Logout';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get welcomeHome => 'Welcome to Omran!';

  @override
  String get language => 'Language';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get confirmLogout => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';
}
