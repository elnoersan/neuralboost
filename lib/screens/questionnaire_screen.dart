import 'package:flutter/material.dart';
import 'package:neuralboost/utils/app_theme.dart';
import '../models/user.dart'; // Import the User model
import '../services/auth_service.dart'; // Import AuthService
import '../services/questionnaire_service.dart';
import '../utils/constants.dart';
import '../widgets/questionnaire_question/questionnaire_question_a.dart'; // Import Part A widget
import '../widgets/questionnaire_question/questionnaire_question_b.dart'; // Import Part B widget
import 'home_screen.dart'; // Import HomeScreen

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
  String _adhdStatus = ''; // Result of the questionnaire

  void _saveResponses() async {
    print('Saving responses...');

    // Convert responses to non-nullable lists
    List<String> partAResponses = _partAResponses.whereType<String>().toList();
    List<String> partBResponses = _partBResponses.whereType<String>().toList();

    // Save responses and calculate ADHD status
    await _service.saveResponses(partAResponses, partBResponses);
    print('Responses saved successfully.');

    // Calculate ADHD result (based on Part A responses)
    _adhdStatus = _service.calculateADHDStatus(partAResponses);

    // Show the result dialog
    _showResultDialog();
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'ADHD Result',
            style: AppTheme.titleMedium,
          ),
          content: Text(
            _adhdStatus == 'Likely ADHD'
                ? 'You likely have ADHD. Please consult a mental health professional for a full evaluation.'
                : _adhdStatus == 'Possible ADHD'
                    ? 'You may have ADHD. Please consult a mental health professional for a full evaluation.'
                    : 'You likely do not have ADHD.',
            style: AppTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHomeScreen();
              },
              child: Text(
                'Continue',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        );
      },
    );
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
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          'ADHD Questionnaire',
          style: AppTheme.headlineSmall.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: AppTheme.backgroundColor,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _showResult
                ? Container() // Empty container since result is shown in AlertDialog
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
      ),
    );
  }
}
