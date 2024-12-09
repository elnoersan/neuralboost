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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text('Never'),
                value: 'Never',
                groupValue: selectedAnswer,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Rarely'),
                value: 'Rarely',
                groupValue: selectedAnswer,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Sometimes'),
                value: 'Sometimes',
                groupValue: selectedAnswer,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Often'),
                value: 'Often',
                groupValue: selectedAnswer,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Very Often'),
                value: 'Very Often',
                groupValue: selectedAnswer,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
