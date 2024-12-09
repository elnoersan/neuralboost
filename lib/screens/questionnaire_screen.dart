import 'package:flutter/material.dart';
import 'package:neuralboost/screens/home_screen.dart'; // Import HomeScreen
import 'package:neuralboost/services/questionnaire_service.dart';
import 'package:neuralboost/utils/constants.dart';
import 'package:neuralboost/widgets/questionnaire_question.dart';

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final QuestionnaireService _service = QuestionnaireService();
  List<String?> _responses = List.filled(questionnaireQuestions.length, null);

  void _saveResponses() async {
    await _service.saveResponses(_responses.whereType<String>().toList());
    // Navigate to the main menu after completing the questionnaire
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
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
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: questionnaireQuestions.length,
                itemBuilder: (context, index) {
                  return QuestionnaireQuestion(
                    question: questionnaireQuestions[index],
                    selectedAnswer: _responses[index],
                    onChanged: (String? answer) {
                      setState(() {
                        _responses[index] = answer;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: _saveResponses,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
