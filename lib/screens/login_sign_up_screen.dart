import 'package:flutter/material.dart';
import 'package:neuralboost/models/user.dart'; // Import the User model
import 'package:neuralboost/screens/home_screen.dart';
import 'package:neuralboost/screens/questionnaire_screen.dart';
import 'package:neuralboost/services/auth_service.dart';
import 'package:neuralboost/utils/app_theme.dart'; // Import the custom theme

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleAuth() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      bool isSuccess;
      if (_isLogin) {
        isSuccess = await _authService.signInWithEmail(email, password);
        if (isSuccess) {
          // Fetch the User object after successful login
          User user = await _authService.getCurrentUser();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
          );
        }
      } else {
        isSuccess = await _authService.signUpWithEmail(email, password);
        if (isSuccess) {
          // Navigate to the questionnaire page after sign-up
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => QuestionnaireScreen()),
          );
        }
      }

      setState(() {
        _isLoading = false;
      });

      if (!isSuccess) {
        // Handle error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to authenticate. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: AppTheme.primaryColor,
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Neural Boost',
                        style: AppTheme.headlineSmall.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: AppTheme.scaffoldBackgroundColor,
                        ),
                        validator: _validateEmail,
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: AppTheme.scaffoldBackgroundColor,
                        ),
                        validator: _validatePassword,
                      ),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleAuth,
                        style: AppTheme.elevatedButtonStyle,
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                _isLogin ? 'Login' : 'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Don’t have an account? Register here'
                              : 'Already have an account? Sign in',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                bool isLoggedIn =
                                    await _authService.signInWithGoogle();
                                if (isLoggedIn) {
                                  // Fetch the User object after successful login
                                  User user =
                                      await _authService.getCurrentUser();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(user: user)),
                                  );
                                }

                                setState(() {
                                  _isLoading = false;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/icons/google.png',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: AppTheme.textColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
