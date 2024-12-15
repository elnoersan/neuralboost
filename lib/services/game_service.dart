// lib/services/game_service.dart
// STILL DO'NOT Have idea with this code
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

class GameService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Generate a random sequence of numbers for the Memorizer Number Game
  List<int> generateSequence(int length) {
    return List.generate(length, (index) => Random().nextInt(10));
  }

  // Check if the user's answer matches the sequence
  bool checkAnswer(List<int> sequence, int currentIndex, int userAnswer) {
    return sequence[currentIndex] == userAnswer;
  }

  // Check if all cards are matched in the Memory Card Game
  bool areAllCardsMatched(List<bool> cardFlipped) {
    return cardFlipped.every((isFlipped) => isFlipped);
  }

  // Save the score for a game
  Future<void> saveScore(String gameName, int score) async {
    await _database.child('scores').child(gameName).push().set({
      'score': score,
    });
  }

  // Get all scores for a game
  Future<List<int>> getScores(String gameName) async {
    DataSnapshot snapshot =
        await _database.child('scores').child(gameName).get();
    List<int> scores = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        scores.add(value['score']);
      });
    }
    return scores;
  }
}
