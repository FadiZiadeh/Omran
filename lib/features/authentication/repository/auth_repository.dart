import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/storage_service.dart';

class AuthRepository {
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final StorageService _storageService = StorageService();

Future<bool> login({
required String email,
required String password,
}) async {
try {
await _firebaseAuth.signInWithEmailAndPassword(
email: email,
password: password,
);

await _storageService.setLoggedIn(true);

return true;
} on FirebaseAuthException {
return false;
}
}

Future<bool> isLoggedIn() async {
return await _storageService.isLoggedIn();
}

Future<void> logout() async {
await _firebaseAuth.signOut();
await _storageService.clearLogin();
}
}

