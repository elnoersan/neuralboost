//lib\services\questionnaire_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class QuestionnaireService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveResponses(List<String> responses) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    // Calculate ADHD status
    bool hasADHD = _calculateADHDStatus(responses);

    // Save responses to Firebase
    await _database.child('questionnaire_responses').push().set({
      'responses': responses,
      'userId': _auth.currentUser!.uid,
      'hasADHD': hasADHD, // Save ADHD status
    });

    // Update user profile with ADHD status
    await _updateUserProfile(hasADHD);
  }

  bool _calculateADHDStatus(List<String> responses) {
    // Example logic: If more than 4 responses are "Often" or "Very Often", the user has ADHD
    int oftenCount = responses
        .where((answer) => answer == 'Often' || answer == 'Very Often')
        .length;
    return oftenCount >= 4;
  }

  Future<void> _updateUserProfile(bool hasADHD) async {
    // Update user profile in Firebase
    await _database.child('users').child(_auth.currentUser!.uid).update({
      'hasADHD': hasADHD,
    });
  }
}
