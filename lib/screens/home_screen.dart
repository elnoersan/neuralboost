import 'package:flutter/material.dart';
import 'package:neuralboost/import/games/pages/reaction_time/reaction_time_page.dart';
import 'package:neuralboost/screens/todo_list_screen.dart';
import 'package:neuralboost/services/gamificate_service.dart';

import '../import/games/pages/numbers_memory/numbers_memory_page.dart';
import '../import/games/pages/sequence_memory/sequence_memory_page.dart';
import '../models/user.dart'; // Import the User model
import '../utils/app_theme.dart';
import 'drawer_menu_screen.dart'; // Import DrawerMenu

class HomeScreen extends StatelessWidget {
  final User user; // Pass the User model as a parameter

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Neural Boost',
          style: AppTheme.headlineSmall.copyWith(
            color: AppTheme.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      drawer: DrawerMenu(user: user), // Pass the User model to DrawerMenu
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section: Progress Tracker
            _buildHeaderSection(context),

            const SizedBox(height: 20),

            // Mini-Games Section
            _buildSectionTitle(context, 'Mini-Games'),
            _buildMiniGamesSection(context),

            const SizedBox(height: 20),

            // To-Do List Section
            _buildSectionTitle(context, 'To-Do List'),
            _buildTodoListSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final GamificateService _gamificateService = GamificateService();

    // Dynamically calculate the current level based on points
    String currentLevel = _gamificateService.calculateLevel(user.points);

    // Calculate the next level points
    int nextLevelPoints = _getNextLevelPoints(currentLevel);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Points: ${user.points}',
            style: AppTheme.titleMedium.copyWith(
              color: AppTheme.backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Your Level: $currentLevel', // Use dynamically calculated level
            style: AppTheme.titleMedium.copyWith(
              color: AppTheme.backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: user.points / nextLevelPoints, // Progress towards next level
            backgroundColor: AppTheme.backgroundColor.withOpacity(0.3),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
          ),
          const SizedBox(height: 10),
          Text(
            '${(user.points / nextLevelPoints * 100).toStringAsFixed(2)}% to next level',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

// Helper method to calculate the points required for the next level
  int _getNextLevelPoints(String currentLevel) {
    switch (currentLevel) {
      case 'Rookie I':
        return 200; // Next level is Rookie II
      case 'Rookie II':
        return 400; // Next level is Rookie III
      case 'Rookie III':
        return 600; // Next level is Senior I
      case 'Senior I':
        return 900; // Next level is Senior II
      case 'Senior II':
        return 1200; // Next level is Senior III
      case 'Senior III':
        return 1500; // Next level is Master I
      case 'Master I':
        return 2000; // Next level is Master II
      case 'Master II':
        return 2500; // Next level is Master III
      case 'Master III':
        return 3000; // Next level is Mind Focus
      case 'Mind Focus':
        return 3000; // Infinite progression, no next level
      default:
        return 3000; // Default to 3000 points
    }
  }

  // Section Title
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTheme.titleMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
      ),
    );
  }

  // Mini-Games Section
  Widget _buildMiniGamesSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildGameBox(
                  context: context,
                  icon: Icons.now_widgets,
                  title: 'Sequence Memory',
                  onTap: () {
                    // Navigate to Memory Card Game
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SequenceMemory()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildGameBox(
                  context: context,
                  icon: Icons.numbers,
                  title: 'Number Memory',
                  onTap: () {
                    // Navigate to Memorizer Number Game
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NumbersMemory()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildGameBox(
                  context: context,
                  icon: Icons.speed,
                  title: 'Reaction Time',
                  onTap: () {
                    // Navigate to Meditation Game
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReactionTime()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // To-Do List Section
  Widget _buildTodoListSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
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
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
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
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.lightTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
