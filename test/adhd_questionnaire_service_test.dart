// test/adhd_questionnaire_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:neuralboost/models/questionnaire_response.dart';
import 'package:neuralboost/services/adhd_questionnaire_service.dart';

void main() {
  test('calculate Part A score', () {
    ADHDQuestionnaireService service = ADHDQuestionnaireService();
    List<QuestionResponse> responses = [
      QuestionResponse(answer: 'Often'),
      QuestionResponse(answer: 'Very Often'),
      QuestionResponse(answer: 'Sometimes'),
      QuestionResponse(answer: 'Often'),
      QuestionResponse(answer: 'Rarely'),
      QuestionResponse(answer: 'Never'),
      // ... only first 6 answers matter for Part A
    ];
    int score = service.calculatePartAScore(responses);
    expect(score, 3);
  });
}
