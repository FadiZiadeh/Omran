import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectUpdate {
  final String id;
  final String projectId;
  final String message;
  final String createdBy;
  final String role;
  final DateTime createdAt;
  final String type;

  const ProjectUpdate({
    required this.id,
    required this.projectId,
    required this.message,
    required this.createdBy,
    required this.role,
    required this.createdAt,
    required this.type,
  });

  factory ProjectUpdate.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    final data = document.data()!;

    return ProjectUpdate(
      id: document.id,
      projectId: data['projectId'] ?? '',
      message: data['message'] ?? '',
      createdBy: data['createdBy'] ?? '',
      role: data['role'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      type: data['type'] ?? 'update',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'message': message,
      'createdBy': createdBy,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
      'type': type,
    };
  }
}