import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omran/core/models/user_profile.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _users {
    return _firestore.collection('users');
  }

  Future<UserProfile?> getUser(
      String userId,
      ) async {
    final document = await _users.doc(userId).get();

    if (!document.exists) {
      return null;
    }

    return UserProfile.fromFirestore(document);
  }

  Future<UserProfile?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return getUser(firebaseUser.uid);
  }

  Future<void> createUser(
      UserProfile user,
      ) async {
    await _users.doc(user.id).set(
      user.toFirestore(),
    );
  }

  Future<void> updateUser(
      UserProfile user,
      ) async {
    await _users.doc(user.id).update(
      user.toFirestore(),
    );
  }
}