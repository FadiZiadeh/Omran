import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String> uploadFile({
    required File file,
    required String projectId,
    required String fileName,
  }) async {
    final storageReference = _storage
        .ref()
        .child('projects')
        .child(projectId)
        .child(fileName);

    await storageReference.putFile(file);

    return await storageReference.getDownloadURL();
  }
}