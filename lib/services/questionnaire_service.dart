import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class QuestionnaireService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveResponses(
      List<String> partAResponses, List<String> partBResponses) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    // Calculate ADHD status based on Part A responses
    bool hasADHD = calculateADHDStatus(partAResponses);

    // Save data to Firebase
    await _database.child('questionnaire_responses').push().set({
      'partAResponses': partAResponses,
      'partBResponses': partBResponses,
      'userId': _auth.currentUser!.uid,
      'hasADHD': hasADHD,
    });

    // Update user profile with ADHD status
    await _updateUserProfile(hasADHD);
  }

  // Public method to calculate ADHD status
  bool calculateADHDStatus(List<String> partAResponses) {
    // Check for responses in shaded boxes
    const shadedAnswers = ['Often', 'Very Often'];
    int shadedCount =
        partAResponses.where((answer) => shadedAnswers.contains(answer)).length;

    return shadedCount >= 4; // Part A threshold as per ASRS guidelines
  }

  Future<void> _updateUserProfile(bool hasADHD) async {
    await _database.child('users').child(_auth.currentUser!.uid).update({
      'hasADHD': hasADHD,
    });
  }
}
