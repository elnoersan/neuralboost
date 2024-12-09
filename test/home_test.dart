// test/home_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neuralboost/screens/home_screen.dart';

void main() {
  group('HomeScreen Tests', () {
    testWidgets('HomeScreen displays welcome text',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(),
      ));

      // Verify that the welcome text is displayed.
      expect(find.text('Welcome to NeuralBoost Home Screen'), findsOneWidget);
    });
  });
}
