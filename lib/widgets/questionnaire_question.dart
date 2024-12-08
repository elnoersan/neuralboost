// lib/widgets/questionnaire_question.dart
import 'package:flutter/material.dart';

class QuestionnaireQuestion extends StatelessWidget {
  final String question;
  final String? groupValue;
  final Function(String?) onChanged;

  QuestionnaireQuestion({
    required this.question,
    required this.groupValue,
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
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Rarely'),
                value: 'Rarely',
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Sometimes'),
                value: 'Sometimes',
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Often'),
                value: 'Often',
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Very Often'),
                value: 'Very Often',
                groupValue: groupValue,
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
