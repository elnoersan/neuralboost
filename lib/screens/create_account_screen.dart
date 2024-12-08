// lib/screens/create_account_screen.dart
import 'package:flutter/material.dart';
import 'package:neuralboost/services/auth_service.dart';

class CreateAccountScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                bool isCreated = await _authService.createAccount(
                  _emailController.text,
                  _passwordController.text,
                );
                if (isCreated) {
                  Navigator.pop(context);
                }
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
