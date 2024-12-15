// NOT USED
// lib/screens/memory_card_game.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neuralboost/services/game_service.dart'; // Import GameService

class MemoryCardGame extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MemoryCardGameState createState() => _MemoryCardGameState();
}

class _MemoryCardGameState extends State<MemoryCardGame> {
  List<int> sequence = [];
  List<int> userSequence = [];
  int currentLevel = 1;
  bool isShowingSequence = true;
  // ignore: unused_field
  final GameService _gameService = GameService();

  @override
  void initState() {
    super.initState();
    generateSequence();
  }

  void generateSequence() {
    sequence.clear();
    for (int i = 0; i < currentLevel; i++) {
      sequence.add(i);
    }
    isShowingSequence = true;
    showSequence();
  }

  void showSequence() async {
    // ignore: unused_local_variable
    for (int card in sequence) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        // Highlight the card
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        // Unhighlight the card
      });
    }
    isShowingSequence = false;
  }

  void checkUserSequence(int card) {
    if (isShowingSequence) return;

    setState(() {
      userSequence.add(card);
    });

    if (userSequence.length == sequence.length) {
      if (listEquals(userSequence, sequence)) {
        setState(() {
          currentLevel++;
          userSequence.clear();
          generateSequence();
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Game Over'),
            content: Text('You made a mistake. Try again!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentLevel = 1;
                    userSequence.clear();
                    generateSequence();
                  });
                },
                child: Text('Retry'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Card Game'),
      ),
      body: Column(
        children: [
          Text(
            'Level $currentLevel',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => checkUserSequence(index),
                  child: Card(
                    color: sequence.contains(index) && isShowingSequence
                        ? Colors.blue
                        : Colors.grey,
                    child: Center(
                      child: Text(
                        'Card ${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
