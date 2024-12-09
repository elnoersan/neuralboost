// lib/services/game_service.dart
import 'package:firebase_database/firebase_database.dart';

class GameService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> saveScore(String gameName, int score) async {
    await _database.child('scores').child(gameName).push().set({
      'score': score,
    });
  }

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
