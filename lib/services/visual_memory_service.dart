// NOT USED
import 'dart:math';

import 'package:flutter/foundation.dart';

class VisualMemoryService {
  List<int> activeIndices = [];

  void startNewGame() {
    activeIndices = [generateRandomIndex()];
  }

  void generateNextSequence() {
    activeIndices.add(generateRandomIndex());
  }

  bool validateSequence(List<int> userSequence) {
    return listEquals(activeIndices, userSequence);
  }

  int generateRandomIndex() {
    return Random().nextInt(9); // 0 to 8
  }
}
