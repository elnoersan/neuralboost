import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controllers/patience_game_controller.dart';
import 'game_page.dart'; // Import the game page

class PatienceGameFailPage extends StatelessWidget {
  PatienceGameFailPage({Key? key}) : super(key: key);

  final PatienceGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myRed,
      body: Container(
        width: Phone.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LessText.lessFuturedText(
              text: 'Failed!',
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
                text: 'Retry',
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
