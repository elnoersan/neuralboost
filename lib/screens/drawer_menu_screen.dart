// lib/screens/drawer_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/models/user.dart'; // Import the User model
import 'package:neuralboost/screens/login_sign_up_screen.dart'; // Import LoginSignUpScreen
import 'package:neuralboost/screens/profile_screen.dart';
import 'package:neuralboost/screens/questionnaire_screen.dart'; // Import QuestionnaireScreen
import 'package:neuralboost/screens/settings_screen.dart';
import 'package:neuralboost/screens/shop_screen.dart';
import 'package:neuralboost/services/auth_service.dart'; // Import AuthService

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
              color: Colors.blue,
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
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  user.email, // Display the user's email
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Points: ${user.points}', // Display the user's points
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
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
            subtitle: Text(user.hasADHD
                ? 'You may have ADHD'
                : 'You likely do not have ADHD'),
            onTap: () {
              // Show a dialog with ADHD status
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('ADHD Status'),
                  content: Text(user.hasADHD
                      ? 'Based on your responses, you may have ADHD.'
                      : 'Based on your responses, you likely do not have ADHD.'),
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
