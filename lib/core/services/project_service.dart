import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omran/core/models/project.dart';

class ProjectService {
final FirebaseFirestore _firestore =
FirebaseFirestore.instance;

final FirebaseAuth _auth =
FirebaseAuth.instance;

CollectionReference<Map<String, dynamic>>
get _projects {
return _firestore.collection('projects');
}

Stream<List<Project>> getProjects() {
return _projects
    .orderBy('createdAt', descending: true)
    .snapshots()
    .map((snapshot) {
return snapshot.docs.map((document) {
return Project.fromFirestore(document);
}).toList();
});
}

Future<String> addProject(Project project) async {
final document = _projects.doc();

final projectWithId = project.copyWith(
id: document.id,
);

await document.set(
projectWithId.toFirestore(),
);

return document.id;
}

Future<String> createProject({
required String name,
required String location,
required DateTime dueDate,
}) async {
final currentUser = _auth.currentUser;

if (currentUser == null) {
throw Exception(
'You must be logged in to create a project.',
);
}

final project = Project(
id: '',
name: name,
location: location,
status: 'Planning',
progress: 0.0,
dueDate: dueDate,
ownerId: currentUser.uid,
createdAt: DateTime.now(),
);

return addProject(project);
}

Future<void> updateProject(Project project) async {
await _projects
    .doc(project.id)
    .update(project.toFirestore());
}

Future<void> deleteProject(String projectId) async {
await _projects.doc(projectId).delete();
}
}

