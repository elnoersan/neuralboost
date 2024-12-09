// lib/models/questionnaire_response.dart
class QuestionnaireResponse {
  List<String> responses;

  QuestionnaireResponse({required this.responses, required String answer});

  Map<String, dynamic> toMap() {
    return {
      'responses': responses,
    };
  }
}
