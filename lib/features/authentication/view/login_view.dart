import 'package:flutter/material.dart';
import 'package:omran/core/utils/validators.dart';
import 'package:omran/features/authentication/viewmodel/login_viewmodel.dart';
import 'package:omran/features/home/view/home_view.dart';
import 'package:omran/l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel _viewModel = LoginViewModel();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await _viewModel.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListenableBuilder(
            listenable: _viewModel,
            builder: (context, child) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // =========================
                    // OMRAN LOGO
                    // =========================
                    Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/omran_logo_dark.png'
                          : 'assets/images/omran_logo.png',
                    ),

                    const SizedBox(height: 24),

                    // =========================
                    // WELCOME
                    // =========================
                    Text(
                      localization.welcome,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 40),

                    // =========================
                    // ERROR MESSAGE
                    // =========================
                    if (_viewModel.errorMessageKey != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          localization.invalidEmailOrPassword,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    // =========================
                    // EMAIL
                    // =========================
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: localization.email,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        return Validators.email(
                          value,
                          requiredMessage: localization.emailRequired,
                          invalidMessage: localization.invalidEmail,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // =========================
                    // PASSWORD
                    // =========================
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        return Validators.password(
                          value,
                          requiredMessage: localization.passwordRequired,
                          tooShortMessage: localization.passwordTooShort,
                        );
                      },
                    ),

                    // =========================
                    // FORGOT PASSWORD
                    // =========================
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // We'll implement this later.
                        },
                        child: Text(localization.forgotPassword),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =========================
                    // LOGIN BUTTON
                    // =========================
                    ElevatedButton(
                      onPressed: _viewModel.isLoading ? null : _login,
                      child: _viewModel.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : Text(localization.login),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
