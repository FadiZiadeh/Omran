import 'package:cloud_firestore/cloud_firestore.dart';

class FileItem {
  final String id;
  final String name;
  final String projectId;
  final String type;
  final String size;
  final DateTime createdAt;
  final String storageUrl;
  final String uploadedBy;

  const FileItem({
    required this.id,
    required this.name,
    required this.projectId,
    required this.type,
    required this.size,
    required this.createdAt,
    required this.storageUrl,
    required this.uploadedBy,
  });

  factory FileItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    final data = document.data()!;

    return FileItem(
      id: document.id,
      name: data['name'] ?? '',
      projectId: data['projectId'] ?? '',
      type: data['type'] ?? '',
      size: data['size'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      storageUrl: data['storageUrl'] ?? '',
      uploadedBy: data['uploadedBy'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'projectId': projectId,
      'type': type,
      'size': size,
      'createdAt': Timestamp.fromDate(createdAt),
      'storageUrl': storageUrl,
      'uploadedBy': uploadedBy,
    };
  }
}