import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controllers/patience_game_controller.dart';
import 'game_page.dart'; // Import the game page

class PatienceGameSuccessPage extends StatelessWidget {
  PatienceGameSuccessPage({Key? key}) : super(key: key);

  final PatienceGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGreen,
      body: Container(
        width: Phone.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LessText.lessFuturedText(
              text: 'Success!',
              color: Colors.white,
              fontSize: 50,
            ),
            SizedBox(height: 20),
            Obx(() => LessText.lessFuturedText(
                  text: 'You reached Level ${controller.level.value}',
                  color: Colors.white,
                  fontSize: 30,
                )),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => PatienceGamePage()), // Navigate directly
              child: LessText.lessFuturedText(
                text: 'Continue',
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
