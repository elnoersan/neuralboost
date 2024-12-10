// lib/widgets/questionnaire_question.dart
import 'package:flutter/material.dart';

class QuestionnaireQuestion extends StatelessWidget {
  final String question;
  final String? selectedAnswer;
  final Function(String?) onChanged;

  QuestionnaireQuestion({
    required this.question,
    required this.selectedAnswer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 12.0),

          // Radio Buttons for Answers
          Column(
            children: [
              _buildRadioTile('Never'),
              _buildRadioTile('Rarely'),
              _buildRadioTile('Sometimes'),
              _buildRadioTile('Often'),
              _buildRadioTile('Very Often'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build individual RadioListTile
  Widget _buildRadioTile(String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: RadioListTile<String>(
        title: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        value: value,
        groupValue: selectedAnswer,
        onChanged: onChanged,
        activeColor: Colors.blue,
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
