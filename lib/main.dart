import 'package:device_preview/device_preview.dart'; // Import DevicePreview
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neuralboost/screens/login_sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBIQQh8NMXUI6vZorI1X8-dsX35TntRwUs",
        authDomain: "pabdatabase.firebaseapp.com",
        databaseURL:
            "https://pabdatabase-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "pabdatabase",
        storageBucket: "pabdatabase.firebasestorage.app",
        messagingSenderId: "708053224224",
        appId: "1:708053224224:web:f0f1c3d948e0ece3b0a545",
        measurementId: "G-NYFV53YNGE"),
  );
  runApp(
    DevicePreview(
      enabled: true, // Enable preview by default for web demo
      defaultDevice: Devices.ios.iPhone13ProMax, // Start with iPhone 13 Pro Max
      isToolbarVisible:
          true, // Show toolbar to let users test different devices
      availableLocales: [
        Locale('en', 'US')
      ], // Keep English only to avoid confusion in demos
      tools: const [
        DeviceSection(
          model: true, // Option to change device model to fit your needs
          orientation: false, // Lock to portrait for consistent demo
          frameVisibility: false, // Hide frame options
          virtualKeyboard: false, // Hide keyboard
        ),
      ],
      devices: [
        // Popular Android Devices
        Devices.android.samsungGalaxyA50,
        Devices.android.samsungGalaxyNote20,
        Devices.android.samsungGalaxyS20,
        Devices.android.samsungGalaxyNote20Ultra,
        Devices.android.onePlus8Pro,
        Devices.android.sonyXperia1II,

        // Popular iOS Devices
        Devices.ios.iPhoneSE,
        Devices.ios.iPhone12,
        Devices.ios.iPhone12Mini,
        Devices.ios.iPhone12ProMax,
        Devices.ios.iPhone13,
        Devices.ios.iPhone13ProMax,
        Devices.ios.iPhone13Mini,
        Devices.ios.iPhoneSE,
      ],
      builder: (context) => MyApp(), // Your app's entry point
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuralBoost',
      locale: DevicePreview.locale(context), // Add this line
      builder: DevicePreview.appBuilder, // Add this line
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpScreen(),
    );
  }
}
