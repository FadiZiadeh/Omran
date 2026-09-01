import '../../../core/services/storage_service.dart';

class AuthRepository {
  final StorageService _storageService = StorageService();

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@test.com' && password == '123456') {
      await _storageService.setLoggedIn(true);
      return true;
    }

    return false;
  }

  Future<bool> isLoggedIn() async {
    return await _storageService.isLoggedIn();
  }

  Future<void> logout() async {
    await _storageService.clearLogin();
  }
}