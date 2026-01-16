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

  Future<void> saveResponses(List<String> responses, DateTime dateTime) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    // Calculate ADHD status based on all responses
    String adhdStatus = calculateADHDStatus(responses);

    // Save data to Firebase
    await _database.child('questionnaire_responses').push().set({
      'responses': responses,
      'userId': _auth.currentUser!.uid,
      'adhdStatus': adhdStatus,
    });

    // Update user profile with ADHD status
    await _updateUserProfile(adhdStatus);
  }

  // Public method to calculate ADHD status
  String calculateADHDStatus(List<String> responses) {
    // Convert responses to scores
    List<int> scores = responses.map((response) {
      return responseScoreMap[response] ?? 0;
    }).toList();

    // Calculate total score
    int totalScore = scores.reduce((value, element) => value + element);

    // Interpretation based on ASRS-v1.1 guidelines
    if (totalScore >= 48) {
      return 'Likely ADHD';
    } else if (totalScore >= 36) {
      return 'Possible ADHD';
    } else if (totalScore >= 24) {
      return 'Possibly from stress or overwhelm';
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
