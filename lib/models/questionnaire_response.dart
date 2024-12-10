// lib/models/questionnaire_response.dart
class QuestionnaireResponse {
  List<String> partAResponses;
  List<String> partBResponses;
  bool hasADHD;

  QuestionnaireResponse({
    required this.partAResponses,
    required this.partBResponses,
    required this.hasADHD,
  });

  Map<String, dynamic> toMap() {
    return {
      'partAResponses': partAResponses,
      'partBResponses': partBResponses,
      'hasADHD': hasADHD,
    };
  }
}
