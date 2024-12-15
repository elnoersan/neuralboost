// NOT USED
// lib/screens/memorizer_number_game.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neuralboost/services/game_service.dart'; // Import GameService

class MemorizerNumberGame extends StatefulWidget {
  @override
  _MemorizerNumberGameState createState() => _MemorizerNumberGameState();
}

class _MemorizerNumberGameState extends State<MemorizerNumberGame> {
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
      sequence.add(i + 1);
    }
    isShowingSequence = true;
    showSequence();
  }

  void showSequence() async {
    // ignore: unused_local_variable
    for (int number in sequence) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        // Display the number
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        // Hide the number
      });
    }
    isShowingSequence = false;
  }

  void checkUserSequence(int number) {
    if (isShowingSequence) return;

    setState(() {
      userSequence.add(number);
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
        title: Text('Memorizer Number Game'),
      ),
      body: Column(
        children: [
          Text(
            'Level $currentLevel',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (isShowingSequence)
            Text(
              sequence.join(' '),
              style: TextStyle(fontSize: 32),
            ),
          if (!isShowingSequence)
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => checkUserSequence(index + 1),
                    child: Card(
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: 24),
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
