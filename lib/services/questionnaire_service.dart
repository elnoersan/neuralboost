// lib/services/questionnaire_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class QuestionnaireService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveResponses(List<String> responses) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    await _database.child('questionnaire_responses').push().set({
      'responses': responses,
      'userId': _auth.currentUser!.uid,
    });
  }
}
