// test/mini_game_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:neuralboost/services/mini_game_service.dart';

void main() {
  test('save and get scores', () async {
    MiniGameService miniGameService = MiniGameService();
    await miniGameService.saveScore('MemoryCardGame', 100);
    List<int> scores = await miniGameService.getScores('MemoryCardGame');
    expect(scores.contains(100), true);
  });
}
