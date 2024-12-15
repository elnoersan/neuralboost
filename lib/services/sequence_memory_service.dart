// NOT USED
import 'dart:math';

import 'package:flutter/foundation.dart';

class SequenceMemoryService {
  List<int> sequence = [];

  void startNewGame() {
    sequence = [generateRandomIndex()];
  }

  void generateNextSequence() {
    sequence.add(generateRandomIndex());
  }

  bool validateSequence(List<int> userSequence) {
    return listEquals(sequence.sublist(0, userSequence.length), userSequence);
  }

  int generateRandomIndex() {
    return Random().nextInt(9); // 0 to 8
  }
}
