// lib/models/questionnaire_response.dart
class QuestionResponse {
  String answer;

  QuestionResponse({required this.answer});

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
    };
  }
}
