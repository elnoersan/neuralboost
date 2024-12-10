// lib/widgets/sequence_display.dart
import 'package:flutter/material.dart';

class SequenceDisplay extends StatelessWidget {
  final List<int> sequence;

  SequenceDisplay({required this.sequence});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Memorize the sequence:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          sequence.join(' '),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}