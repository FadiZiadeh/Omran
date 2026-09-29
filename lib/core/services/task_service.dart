import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omran/core/models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _tasks {
    return _firestore.collection('tasks');
  }

  Stream<List<Task>> getTasks() {
    return _tasks
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return Task.fromFirestore(document);
      }).toList();
    });
  }

  Stream<List<Task>> getTasksByProject(
      String projectId,
      ) {
    return _tasks
        .where('projectId', isEqualTo: projectId)
        .snapshots()
        .map((snapshot) {
      final tasks = snapshot.docs.map((document) {
        return Task.fromFirestore(document);
      }).toList();

      tasks.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
      );

      return tasks;
    });
  }

  Future<String> addTask(Task task) async {
    final document = _tasks.doc();

    final taskWithId = Task(
      id: document.id,
      title: task.title,
      projectId: task.projectId,
      location: task.location,
      status: task.status,
      priority: task.priority,
      dueDate: task.dueDate,
      assignedTo: task.assignedTo,
      createdAt: task.createdAt,
    );

    await document.set(
      taskWithId.toFirestore(),
    );

    return document.id;
  }

  Future<void> updateTask(Task task) async {
    await _tasks.doc(task.id).update(
      task.toFirestore(),
    );
  }

  Future<void> deleteTask(String taskId) async {
    await _tasks.doc(taskId).delete();
  }
}