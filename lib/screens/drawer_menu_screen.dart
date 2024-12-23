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
                  backgroundColor: AppTheme.backgroundColor,
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
                    color: AppTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Points: ${user.points}', // Display the user's points
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.backgroundColor.withOpacity(0.3),
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
            title: Text('Exchange Your Coins'),
            onTap: () {
              // Navigate to Shop Screen and pass the User object
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShopScreen(user: user), // Pass the user object
                ),
              );
            },
          ),

          // ADHD Status Section
          ListTile(
            leading: Icon(Icons.info),
            title: Text('ADHD Status'),
            subtitle: Text(
                'Last updated: ${user.dateResponded != null ? user.dateResponded!.toLocal().toString().split(' ')[0] : 'Not available'}'), // Display the dateResponded
            onTap: () {
              // Show a dialog with ADHD status
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('ADHD Status'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Based on your responses, your ADHD status is: ${user.adhdStatus}'),
                      const SizedBox(height: 10),
                      Text(
                        'Last updated: ${user.dateResponded != null ? user.dateResponded!.toLocal().toString().split(' ')[0] : 'Not available'}',
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
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
              // Show a simple About dialog with a disclaimer
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('About NeuralBoost'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'NeuralBoost is a focus and productivity app designed to help users improve their attention and manage tasks effectively.'),
                      const SizedBox(height: 10),
                      Text(
                        'Disclaimer:',
                        style: AppTheme.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'The results from the ADHD questionnaire are not a diagnosis. They are intended for informational purposes only. If you suspect you have ADHD, please consult a licensed mental health professional for a proper evaluation.',
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
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
