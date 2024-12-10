import 'package:flutter/material.dart';
import 'package:neuralboost/models/user.dart'; // Import the User model
import 'package:neuralboost/screens/home_screen.dart'; // Import HomeScreen
import 'package:neuralboost/services/auth_service.dart'; // Import AuthService
import 'package:neuralboost/services/questionnaire_service.dart';
import 'package:neuralboost/utils/constants.dart';
import 'package:neuralboost/widgets/adhd_result_widget.dart'; // Import the new widget
import 'package:neuralboost/widgets/questionnaire_question/questionnaire_question_a.dart'; // Import Part A widget
import 'package:neuralboost/widgets/questionnaire_question/questionnaire_question_b.dart'; // Import Part B widget

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final QuestionnaireService _service = QuestionnaireService();
  final AuthService _authService = AuthService(); // Add AuthService
  List<String?> _partAResponses = List.filled(partAQuestions.length, null);
  List<String?> _partBResponses = List.filled(partBQuestions.length, null);
  bool _showPartB = false; // Flag to show Part B
  bool _showResult = false; // Flag to show the result widget
  bool _hasADHD = false; // Result of the questionnaire

  void _saveResponses() async {
    print('Saving responses...');

    // Convert responses to non-nullable lists
    List<String> partAResponses = _partAResponses.whereType<String>().toList();
    List<String> partBResponses = _partBResponses.whereType<String>().toList();

    // Save responses and calculate ADHD status
    await _service.saveResponses(partAResponses, partBResponses);
    print('Responses saved successfully.');

    // Calculate ADHD result (based on Part A responses)
    _hasADHD = _service.calculateADHDStatus(partAResponses);

    // Show the result widget
    setState(() {
      _showResult = true;
    });
  }

  // Mark the method as async to use await
  Future<void> _navigateToHomeScreen() async {
    // Fetch the User object after questionnaire completion
    User user = await _authService
        .getCurrentUser(); // Use AuthService to fetch the user
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(user: user)), // Pass the User object
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text(
          'ADHD Questionnaire',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Center(
          child: _showResult
              ? ADHDResultWidget(
                  hasADHD: _hasADHD,
                  onContinue: _navigateToHomeScreen, // Use the async method
                )
              : _showPartB
                  ? QuestionnaireQuestionB(
                      responses: _partBResponses,
                      onChanged: (int index, String? answer) {
                        setState(() {
                          _partBResponses[index] = answer;
                        });
                      },
                      onSubmit: _saveResponses,
                    )
                  : QuestionnaireQuestionA(
                      responses: _partAResponses,
                      onChanged: (int index, String? answer) {
                        setState(() {
                          _partAResponses[index] = answer;
                        });
                      },
                      onNext: () {
                        setState(() {
                          _showPartB = true; // Move to Part B
                        });
                      },
                    ),
        ),
      ),
    );
  }
}
