import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String projectId;
  final String location;
  final String status;
  final String priority;
  final DateTime dueDate;
  final String assignedTo;
  final DateTime createdAt;

  const Task({
    required this.id,
    required this.title,
    required this.projectId,
    required this.location,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.assignedTo,
    required this.createdAt,
  });

  factory Task.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    final data = document.data()!;

    return Task(
      id: document.id,
      title: data['title'] ?? '',
      projectId: data['projectId'] ?? '',
      location: data['location'] ?? '',
      status: data['status'] ?? 'Open',
      priority: data['priority'] ?? 'Medium',
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      assignedTo: data['assignedTo'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'projectId': projectId,
      'location': location,
      'status': status,
      'priority': priority,
      'dueDate': Timestamp.fromDate(dueDate),
      'assignedTo': assignedTo,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}