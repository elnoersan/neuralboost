import 'package:flutter/material.dart';
import 'package:neuralboost/utils/app_theme.dart';
import '../../utils/constants.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Part A: Symptoms of Inattention',
          style: AppTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: partAQuestions.length,
            itemBuilder: (context, index) {
              return _buildQuestionCard(index, partAQuestions[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onNext,
          style: AppTheme.elevatedButtonStyle,
          child: const Text('Next'),
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
                _buildRadioTile(index, 'Never'),
                _buildRadioTile(index, 'Rarely'),
                _buildRadioTile(index, 'Sometimes'),
                _buildRadioTile(index, 'Often'),
                _buildRadioTile(index, 'Very Often'),
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
