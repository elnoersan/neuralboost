import 'package:flutter/material.dart';
import 'package:neuralboost/utils/app_theme.dart';
import '../../utils/constants.dart';

class QuestionnaireQuestion extends StatelessWidget {
  final List<String?> responses;
  final Function(int, String?) onChanged;
  final VoidCallback onSubmit;

  QuestionnaireQuestion({
    required this.responses,
    required this.onChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ADHD Questionnaire',
          style: AppTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: allQuestions.length,
            itemBuilder: (context, index) {
              return _buildQuestionCard(index, allQuestions[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onSubmit,
          style: AppTheme.elevatedButtonStyle,
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(int index, String question) {
    return Card(
      elevation: AppTheme.cardTheme.elevation,
      shape: AppTheme.cardTheme.shape,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: AppTheme.bodyMedium,
            ),
            const SizedBox(height: 12.0),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildRadioTile(index, 'Never'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildRadioTile(index, 'Rarely'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildRadioTile(index, 'Sometimes'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildRadioTile(index, 'Often'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildRadioTile(index, 'Very Often'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(int index, String value) {
    return RadioListTile<String>(
      title: Text(
        value,
        style: AppTheme.bodySmall,
      ),
      value: value,
      groupValue: responses[index],
      onChanged: (String? answer) {
        onChanged(index, answer);
      },
      activeColor: AppTheme.primaryColor,
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
