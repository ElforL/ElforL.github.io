import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laith_shono/models/Project.dart';

class FirestoreServices {
  FirebaseFirestore get db => FirebaseFirestore.instance;

  List<Project> projects = [];
  Map<String, dynamic>? urls;

  bool initiated = false;

  // OCD
  String? get stackOverflowURL => urls?['stackOverflow'];
  String? get linkedInURL => urls?['LinkedIn'];
  String? get emailAddress => urls?['email'];
  String? get gitHubURL => urls?['github'];
  String? get cvURL => urls?['cv'];

  Future<void> load([bool? signInAnonymously]) async {
    if (initiated) return;
    if (signInAnonymously ?? true) await FirebaseAuth.instance.signInAnonymously();
    await _loadProjects();
    await loadUrls();
    initiated = true;
  }

  /// sorts the projects keeping the full apps at the start
  List<Project>? _sortProjects() {
    for (var i = 0; i < projects.length; i++) {
      for (var j = i + 1; j < projects.length; j++) {
        if (projects[i].isSmall! && !projects[j].isSmall!) {
          var temp = projects[i];
          projects[i] = projects[j];
          projects[j] = temp;
        }
      }
    }
    return projects;
  }

  Future<Project?> getProject(String projectTitle) async {
    var result = await db.collection('projects').where('title', isEqualTo: projectTitle).get();

    if (result.docs.isNotEmpty) {
      final out = Project.fromJson(result.docs.first.data());
      return out;
    }

    return null;
  }

  Future<QuerySnapshot<Object>> _loadProjects() async {
    var result = await db.collection('projects').get();
    projects.clear();

    for (var doc in result.docs) {
      var project = Project.fromJson(doc.data());
      projects.add(project);
    }
    _sortProjects();
    return result;
  }

  Future<DocumentSnapshot<Object>?> loadUrls([bool? force]) async {
    if (urls != null && force != true) return null;
    var result = await db.collection('urls').doc('socials').get();
    urls = result.data();
    return result;
  }

  Future<DocumentReference<Map<String, dynamic>>> sendMessage(String emailAddress, String subject, String message) {
    return db.collection('messages').add({
      'email': emailAddress,
      'subject': subject,
      'message': message,
      'time': FieldValue.serverTimestamp(),
    });
  }
}
