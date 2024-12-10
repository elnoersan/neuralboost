// lib/widgets/questionnaire_question/questionnaire_question_a.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/utils/constants.dart';

class QuestionnaireQuestionA extends StatelessWidget {
  final List<String?> responses;
  final Function(int, String?) onChanged;
  final VoidCallback onNext;

  QuestionnaireQuestionA({
    required this.responses,
    required this.onChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Part A: Symptoms of Inattention',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: partAQuestions.length,
                itemBuilder: (context, index) {
                  return _buildQuestion(index, partAQuestions[index]);
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(int index, String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 12.0),
          Column(
            children: [
              _buildRadioTile(index, 'Never'),
              _buildRadioTile(index, 'Rarely'),
              _buildRadioTile(index, 'Sometimes'),
              _buildRadioTile(index, 'Often'),
              _buildRadioTile(index, 'Very Often'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioTile(int index, String value) {
    return RadioListTile<String>(
      title: Text(
        value,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      value: value,
      groupValue: responses[index],
      onChanged: (String? answer) {
        onChanged(index, answer);
      },
      activeColor: Colors.blue,
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
