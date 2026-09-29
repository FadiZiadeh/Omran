import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String name;
  final String location;
  final String status;
  final double progress;
  final DateTime dueDate;
  final String ownerId;
  final DateTime createdAt;

  const Project({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.progress,
    required this.dueDate,
    required this.ownerId,
    required this.createdAt,
  });

  Project copyWith({
    String? id,
    String? name,
    String? location,
    String? status,
    double? progress,
    DateTime? dueDate,
    String? ownerId,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      dueDate: dueDate ?? this.dueDate,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Project.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;

    return Project(
      id: document.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      status: data['status'] ?? '',
      progress: (data['progress'] ?? 0).toDouble(),
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      ownerId: data['ownerId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'location': location,
      'status': status,
      'progress': progress,
      'dueDate': Timestamp.fromDate(dueDate),
      'ownerId': ownerId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
