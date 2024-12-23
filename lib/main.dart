import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:neuralboost/services/todo_view_model.dart';
import 'package:provider/provider.dart';

import 'screens/login_sign_up_screen.dart';
import 'screens/todo_list_screen.dart'; // Import TodoListScreen
import 'utils/app_theme.dart'; // Import the custom theme

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TodoViewModel()), // Provide the TodoViewModel
      ],
      child: MyApp(), // Your app's entry point
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Replace MaterialApp with GetMaterialApp
      title: 'Neural Boost',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme, // Apply the custom theme here
      home: LoginSignUpScreen(), // Set LoginSignUpScreen as the home screen
      routes: {
        '/todo-list': (context) => TodoListScreen(), // Add TodoListScreen route
      },
    );
  }
}
