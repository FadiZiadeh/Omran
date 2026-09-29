import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omran/core/models/file_item.dart';

class FileService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _files {
    return _firestore.collection('files');
  }

  Stream<List<FileItem>> getFiles() {
    return _files
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return FileItem.fromFirestore(document);
      }).toList();
    });
  }

  Stream<List<FileItem>> getFilesByProject(
      String projectId,
      ) {
    return _files
        .where('projectId', isEqualTo: projectId)
        .snapshots()
        .map((snapshot) {
      final files = snapshot.docs.map((document) {
        return FileItem.fromFirestore(document);
      }).toList();

      files.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
      );

      return files;
    });
  }

  Future<void> addFile(FileItem file) async {
    final document = _files.doc();

    final fileWithId = FileItem(
      id: document.id,
      name: file.name,
      projectId: file.projectId,
      type: file.type,
      size: file.size,
      createdAt: file.createdAt,
      storageUrl: file.storageUrl,
      uploadedBy: file.uploadedBy,
    );

    await document.set(
      fileWithId.toFirestore(),
    );
  }

  Future<void> updateFile(FileItem file) async {
    await _files
        .doc(file.id)
        .update(file.toFirestore());
  }

  Future<void> deleteFile(String fileId) async {
    await _files.doc(fileId).delete();
  }
}