import 'package:flutter/material.dart';
import 'package:neuralboost/import/games/pages/reaction_time/reaction_time_page.dart';
import 'package:neuralboost/screens/todo_list_screen.dart';

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

  // Header Section: Progress Tracker
  Widget _buildHeaderSection(BuildContext context) {
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
            'Your Progress',
            style: AppTheme.titleMedium.copyWith(
              color: AppTheme.backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.7, // Example progress value
            backgroundColor: AppTheme.backgroundColor.withOpacity(0.3),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
          ),
          const SizedBox(height: 10),
          Text(
            '70% Focus Improved',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
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
