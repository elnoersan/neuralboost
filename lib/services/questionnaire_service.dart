import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class QuestionnaireService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Map to convert response strings to scores
  static const Map<String, int> responseScoreMap = {
    'Never': 0,
    'Rarely': 1,
    'Sometimes': 2,
    'Often': 3,
    'Very Often': 4,
  };

  Future<void> saveResponses(
      List<String> partAResponses, List<String> partBResponses) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    // Calculate ADHD status based on Part A responses
    String adhdStatus = calculateADHDStatus(partAResponses);

    // Save data to Firebase
    await _database.child('questionnaire_responses').push().set({
      'partAResponses': partAResponses,
      'partBResponses': partBResponses,
      'userId': _auth.currentUser!.uid,
      'adhdStatus': adhdStatus,
    });

    // Update user profile with ADHD status
    await _updateUserProfile(adhdStatus);
  }

  // Public method to calculate ADHD status
  String calculateADHDStatus(List<String> partAResponses) {
    // Convert responses to scores
    List<int> partAScores = partAResponses.map((response) {
      return responseScoreMap[response] ?? 0;
    }).toList();

    // Calculate total score for Part A
    int totalScore = partAScores.reduce((value, element) => value + element);

    // Interpretation based on ASRS-v1.1 guidelines
    if (totalScore >= 12) {
      return 'Likely ADHD';
    } else if (totalScore >= 6) {
      return 'Possible ADHD';
    } else {
      return 'No issue or slightly affected';
    }
  }

  Future<void> _updateUserProfile(String adhdStatus) async {
    await _database.child('users').child(_auth.currentUser!.uid).update({
      'adhdStatus': adhdStatus,
    });
  }
}
