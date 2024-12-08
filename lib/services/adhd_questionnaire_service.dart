// lib/services/adhd_questionnaire_service.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:neuralboost/models/questionnaire_response.dart';

class ADHDQuestionnaireService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> saveResponses(List<QuestionResponse> responses) async {
    await _database.child('questionnaire_responses').push().set({
      'responses': responses.map((response) => response.toMap()).toList(),
    });
  }

  int calculatePartAScore(List<QuestionResponse> responses) {
    int score = 0;
    for (int i = 0; i < 6; i++) {
      if (responses[i].answer == 'Often' ||
          responses[i].answer == 'Very Often') {
        score++;
      }
    }
    return score;
  }
}
