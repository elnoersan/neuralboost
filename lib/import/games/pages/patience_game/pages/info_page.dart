import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controllers/patience_game_controller.dart';
import 'game_page.dart'; // Import the game page

class PatienceGameInfoPage extends StatelessWidget {
  PatienceGameInfoPage({Key? key}) : super(key: key);

  final PatienceGameController controller = Get.put(PatienceGameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Container(
        width: Phone.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LessText.lessFuturedText(
              text: 'Patience Game',
              color: Colors.white,
              fontSize: 50,
            ),
            SizedBox(height: 20),
            LessText.lessFuturedText(
              text: 'Stay still for increasing durations to level up!',
              color: Colors.white,
              fontSize: 20,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => PatienceGamePage()), // Navigate directly
              child: LessText.lessFuturedText(
                text: 'Start',
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.myYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
