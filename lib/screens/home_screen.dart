import 'package:flutter/material.dart';
import 'package:neuralboost/import/games/pages/patience_game/pages/game_page.dart';
import 'package:neuralboost/models/user.dart'; // Import the User model
import 'package:neuralboost/screens/drawer_menu_screen.dart'; // Import DrawerMenu
import 'package:neuralboost/screens/todo_list_menu.dart';

import '../import/games/pages/numbers_memory/numbers_memory_page.dart';
import '../import/games/pages/reaction_time/reaction_time_page.dart';
import '../import/games/pages/sequence_memory/sequence_memory_page.dart';

class HomeScreen extends StatelessWidget {
  final User user; // Pass the User model as a parameter

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NeuralBoost',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      drawer: DrawerMenu(user: user), // Pass the User model to DrawerMenu
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section: Progress Tracker
            _buildHeaderSection(),

            SizedBox(height: 20),

            // Mini-Games Section
            _buildSectionTitle('Mini-Games'),
            _buildMiniGamesSection(context),

            SizedBox(height: 20),

            // To-Do List Section
            _buildSectionTitle('To-Do List'),
            _buildTodoListSection(context),
          ],
        ),
      ),
    );
  }

  // Header Section: Progress Tracker
  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.6, // Example progress value
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(height: 10),
          Text(
            '60% Focus Improved',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

// Mini-Games Section
  Widget _buildMiniGamesSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Ensures space between items
        children: [
          Expanded(
            child: _buildGameBox(
              context: context,
              icon: Icons.games,
              title: 'Memory Card Game',
              onTap: () {
                // Navigate to Memory Card Game
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SequenceMemory()),
                );
              },
            ),
          ),
          SizedBox(width: 10), // Adds spacing between the game boxes
          Expanded(
            child: _buildGameBox(
              context: context,
              icon: Icons.psychology,
              title: 'Memorizer Number Game',
              onTap: () {
                // Navigate to Memorizer Number Game
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NumbersMemory()),
                );
              },
            ),
          ),
          SizedBox(width: 10), // Adds spacing between the game boxes
          Expanded(
            child: _buildGameBox(
              context: context,
              icon: Icons.spa,
              title: 'Meditation Game for Patience',
              onTap: () {
                // Navigate to Meditation Game
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatienceGamePage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // To-Do List Section
  Widget _buildTodoListSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: _buildCard(
        context: context,
        icon: Icons.list,
        title: 'To-Do List',
        subtitle: 'Manage your tasks and stay organized.',
        onTap: () {
          // Navigate to To-Do List
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoListScreen()),
          );
        },
      ),
    );
  }

  // Reusable Game Box Widget
  Widget _buildGameBox({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Card Widget
  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
