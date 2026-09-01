import 'package:flutter/material.dart';
import 'package:omran/features/authentication/repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoading = false;
  String? errorMessageKey;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessageKey = null;
    notifyListeners();

    final success = await _authRepository.login(
      email: email,
      password: password,
    );

    isLoading = false;

    if (!success) {
      errorMessageKey = 'invalidEmailOrPassword';
    }

    notifyListeners();

    return success;
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}