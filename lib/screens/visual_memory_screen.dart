// NOT USED

import 'package:flutter/material.dart';
import '../services/visual_memory_service.dart';

class VisualMemoryScreen extends StatefulWidget {
  @override
  _VisualMemoryScreenState createState() => _VisualMemoryScreenState();
}

class _VisualMemoryScreenState extends State<VisualMemoryScreen> {
  final VisualMemoryService _service = VisualMemoryService();
  List<int> _userSequence = [];

  @override
  void initState() {
    super.initState();
    _service.startNewGame();
    _showNextSequence();
  }

  void _handleButtonPress(int index) {
    setState(() {
      _userSequence.add(index);
      if (!_service.validateSequence(_userSequence)) {
        _showGameOverDialog();
      } else if (_userSequence.length == _service.activeIndices.length) {
        _service.generateNextSequence();
        _userSequence.clear();
        _showNextSequence();
      }
    });
  }

  void _showNextSequence() async {
    await Future.delayed(Duration(seconds: 1));
    // ignore: unused_local_variable
    for (var index in _service.activeIndices) {
      setState(() {
        // Highlight the button
      });
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        // Unhighlight the button
      });
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score: ${_service.activeIndices.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _service.startNewGame();
                _userSequence.clear();
                _showNextSequence();
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
        title: Text('Visual Memory'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: 9,
          itemBuilder: (context, index) => ElevatedButton(
            onPressed: () => _handleButtonPress(index),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('${index + 1}'),
          ),
        ),
      ),
    );
  }
}
