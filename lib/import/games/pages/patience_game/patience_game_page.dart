import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/info_page.dart'; // Import the InfoPage

class PatienceGamePage extends StatelessWidget {
  PatienceGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              Get.to(() => PatienceGameInfoPage()), // Navigate to InfoPage
          child: Text('Start Patience Game'),
        ),
      ),
    );
  }
}
