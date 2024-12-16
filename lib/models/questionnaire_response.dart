// lib/models/questionnaire_response.dart
class QuestionnaireResponse {
  List<String> partAResponses;
  List<String> partBResponses;
  String adhdStatus; // Updated to store the ADHD status as a string

  QuestionnaireResponse({
    required this.partAResponses,
    required this.partBResponses,
    required this.adhdStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'partAResponses': partAResponses,
      'partBResponses': partBResponses,
      'adhdStatus': adhdStatus,
    };
  }
}
