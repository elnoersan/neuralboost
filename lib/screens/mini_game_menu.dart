// lib/screens/mini_game_menu.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/screens/memory_card_game.dart';
import 'package:neuralboost/screens/meditation_game.dart';
import 'package:neuralboost/screens/memorizer_number_game.dart';

class MiniGameMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Games'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryCardGame()),
                );
              },
              child: Text('Memory Card Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeditationGame()),
                );
              },
              child: Text('Meditation Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemorizerNumberGame()),
                );
              },
              child: Text('Memorizer Number Game'),
            ),
          ],
        ),
      ),
    );
  }
}
