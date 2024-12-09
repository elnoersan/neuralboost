// lib/screens/mini_game_menu.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/screens/meditation_game.dart';
import 'package:neuralboost/screens/memorizer_number_game.dart';
import 'package:neuralboost/screens/memory_card_game.dart';

class MiniGameMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Games'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Memory Card Game'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemoryCardGame()),
              );
            },
          ),
          ListTile(
            title: Text('Meditation Game'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeditationGame()),
              );
            },
          ),
          ListTile(
            title: Text('Memorizer Number Game'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemorizerNumberGame()),
              );
            },
          ),
        ],
      ),
    );
  }
}
