import 'package:flutter/material.dart';
import 'package:neuralboost/utils/app_theme.dart';

import '../models/user.dart'; // Import the User model
import '../services/auth_service.dart'; // Import AuthService
import '../services/questionnaire_service.dart';
import '../utils/constants.dart';
import '../widgets/questionnaire_question/questionnaire_question.dart'; // Import the merged widget
import 'home_screen.dart'; // Import HomeScreen

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final QuestionnaireService _service = QuestionnaireService();
  final AuthService _authService = AuthService(); // Add AuthService
  List<String?> _responses = List.filled(allQuestions.length, null);
  bool _showResult = false; // Flag to show the result widget
  String _adhdStatus = ''; // Result of the questionnaire

  void _saveResponses() async {
    print('Saving responses...');

    // Convert responses to non-nullable lists
    List<String> responses = _responses.whereType<String>().toList();

    // Save responses and calculate ADHD status
    await _service.saveResponses(
        responses, DateTime.now()); // Pass both responses and dateResponded
    print('Responses saved successfully.');

    // Calculate ADHD result (based on all responses)
    _adhdStatus = _service.calculateADHDStatus(responses);

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
                    : _adhdStatus == 'Possibly from stress or overwhelm'
                        ? 'Your symptoms may be related to stress or feeling overwhelmed. Consider managing stress and seeking support if needed.'
                        : 'You likely do not have ADHD. However, if you continue to experience symptoms, consider consulting a mental health professional.',
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
          style:
              AppTheme.headlineSmall.copyWith(color: AppTheme.backgroundColor),
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
                : QuestionnaireQuestion(
                    responses: _responses,
                    onChanged: (int index, String? answer) {
                      setState(() {
                        _responses[index] = answer;
                      });
                    },
                    onSubmit: _saveResponses,
                  ),
          ),
        ),
      ),
    );
  }
}
