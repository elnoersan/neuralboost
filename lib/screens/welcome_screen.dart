// lib/screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/screens/create_account_screen.dart';
import 'package:neuralboost/screens/home_screen.dart';
import 'package:neuralboost/services/auth_service.dart';

class WelcomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateAccountScreen()),
                );
              },
              child: Text('Create Account'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool isLoggedIn = await _authService.signInWithGoogle();
                if (isLoggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
