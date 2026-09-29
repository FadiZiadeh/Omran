import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omran/core/models/project_update.dart';

class ProjectUpdateService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _updates {
    return _firestore.collection('projectUpdates');
  }

  Stream<List<ProjectUpdate>> getUpdatesByProject(
      String projectId,
      ) {
    return _updates
        .where('projectId', isEqualTo: projectId)
        .snapshots()
        .map((snapshot) {
      final updates = snapshot.docs.map((document) {
        return ProjectUpdate.fromFirestore(document);
      }).toList();

      updates.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
      );

      return updates;
    });
  }

  Future<void> addUpdate(
      ProjectUpdate update,
      ) async {
    final document = _updates.doc();

    final updateWithId = ProjectUpdate(
      id: document.id,
      projectId: update.projectId,
      message: update.message,
      createdBy: update.createdBy,
      role: update.role,
      createdAt: update.createdAt,
      type: update.type,
    );

    await document.set(
      updateWithId.toFirestore(),
    );
  }

  Future<void> deleteUpdate(
      String updateId,
      ) async {
    await _updates.doc(updateId).delete();
  }
}