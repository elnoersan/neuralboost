// NOT USED
import 'package:flutter/material.dart';

import '../services/number_memory_service.dart';

class NumberMemoryScreen extends StatefulWidget {
  @override
  _NumberMemoryScreenState createState() => _NumberMemoryScreenState();
}

class _NumberMemoryScreenState extends State<NumberMemoryScreen> {
  final NumberMemoryService _service = NumberMemoryService();
  String _userInput = '';

  @override
  void initState() {
    super.initState();
    _service.startNewGame();
  }

  void _handleInput(String value) {
    setState(() {
      _userInput = value;
      if (_userInput.length == _service.number.length) {
        if (_service.validateNumber(_userInput)) {
          _service.generateNextNumber();
          _userInput = '';
        } else {
          _showGameOverDialog();
        }
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score: ${_service.number.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _service.startNewGame();
                _userInput = '';
              });
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Memory'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Memorize this number:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _service.number,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            TextField(
              onChanged: _handleInput,
              decoration: InputDecoration(
                labelText: 'Enter the number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
