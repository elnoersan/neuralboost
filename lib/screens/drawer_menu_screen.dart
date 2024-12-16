import 'package:flutter/material.dart';

import '../models/user.dart'; // Import the User model
import '../services/auth_service.dart'; // Import AuthService
import '../utils/app_theme.dart'; // Import the AppTheme
import 'login_sign_up_screen.dart'; // Import LoginSignUpScreen
import 'profile_screen.dart';
import 'questionnaire_screen.dart'; // Import QuestionnaireScreen
import 'settings_screen.dart';
import 'shop_screen.dart';

class DrawerMenu extends StatelessWidget {
  final User user; // Pass the User model as a parameter
  final AuthService _authService = AuthService();

  DrawerMenu({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header: Profile
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.email, // Display the user's email
                  style: AppTheme.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Points: ${user.points}', // Display the user's points
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Profile Section
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to Profile Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),

          // Shop Section
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shop'),
            onTap: () {
              // Navigate to Shop Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopScreen()),
              );
            },
          ),

          // ADHD Status Section
          ListTile(
            leading: Icon(Icons.info),
            title: Text('ADHD Status'),
            subtitle: Text(user.adhdStatus),
            onTap: () {
              // Show a dialog with ADHD status
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('ADHD Status'),
                  content: Text(
                      'Based on your responses, your ADHD status is: ${user.adhdStatus}'),
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
            },
          ),

          // Retake Questionnaire Section
          ListTile(
            leading: Icon(Icons.quiz),
            title: Text('Retake Questionnaire'),
            onTap: () {
              // Navigate to QuestionnaireScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionnaireScreen()),
              );
            },
          ),

          // Settings Section
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to Settings Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),

          // About Section
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Show a simple About dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('About NeuralBoost'),
                  content: Text(
                      'NeuralBoost is a focus and productivity app designed to help users improve their attention and manage tasks effectively.'),
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
            },
          ),

          // Logout Section
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              // Sign out the user
              await _authService.signOut();
              // Navigate to the LoginSignUpScreen after logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
