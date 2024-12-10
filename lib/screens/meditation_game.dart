// lib/screens/meditation_game.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/services/game_service.dart'; // Import GameService

class MeditationGame extends StatefulWidget {
  @override
  _MeditationGameState createState() => _MeditationGameState();
}

class _MeditationGameState extends State<MeditationGame> {
  int secondsRemaining = 60;
  bool isMeditationActive = false;
  // ignore: unused_field
  final GameService _gameService = GameService();

  void startMeditation() {
    setState(() {
      isMeditationActive = true;
    });

    Future.delayed(Duration(seconds: secondsRemaining), () {
      setState(() {
        isMeditationActive = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Meditation Complete'),
          content: Text('You have completed the meditation session!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Meditation Timer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$secondsRemaining seconds remaining',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isMeditationActive ? null : startMeditation,
              child: Text('Start Meditation'),
            ),
          ],
        ),
      ),
    );
  }
}
