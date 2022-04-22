import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laith_shono/models/Project.dart';

class FirestoreServices {
  FirebaseFirestore get db => FirebaseFirestore.instance;

  List<Project> projects = [];
  Map<String, dynamic>? /*?*/ urls;

  // OCD
  String? get stackOverflowURL => urls!['stackOverflow'];
  String? get linkedInURL => urls!['LinkedIn'];
  String? get emailAddress => urls!['email'];
  String? get gitHubURL => urls!['github'];
  String? get cvURL => urls!['cv'];

  load() async {
    await _loadUrls();
    await _loadProjects();
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

  Future<QuerySnapshot<Object>> _loadProjects() async {
    var result = await db.collection('projects').get();
    for (var doc in result.docs) {
      var project = Project.fromJson(doc.data());
      projects.add(project);
    }
    _sortProjects();
    return result;
  }

  Future<DocumentSnapshot<Object>> _loadUrls() async {
    var result = await db.collection('urls').doc('socials').get();
    urls = result.data();
    return result;
  }

  Future<void> sendMessage(String emailAddress, String subject, String message) async {
    await db.collection('messages').add({
      'email': emailAddress,
      'subject': subject,
      'message': message,
      'time': FieldValue.serverTimestamp(),
    });
  }
}
