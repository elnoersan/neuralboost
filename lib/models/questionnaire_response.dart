// lib/models/questionnaire_response.dart
class QuestionnaireResponse {
  List<String> responses; // Single list for all responses
  String adhdStatus; // Updated to store the ADHD status as a string
  DateTime dateResponded; // Date when the questionnaire was responded to

  QuestionnaireResponse({
    required this.responses,
    required this.adhdStatus,
    required this.dateResponded,
  });

  Map<String, dynamic> toMap() {
    return {
      'responses': responses, // Use the single list of responses
      'adhdStatus': adhdStatus,
      'dateResponded': dateResponded
          .toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
}
