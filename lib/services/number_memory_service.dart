import 'dart:math';

class NumberMemoryService {
  String number = '';

  void startNewGame() {
    number = generateRandomNumber(3);
  }

  void generateNextNumber() {
    number = generateRandomNumber(number.length + 1);
  }

  bool validateNumber(String userInput) {
    return userInput == number;
  }

  String generateRandomNumber(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }
}
