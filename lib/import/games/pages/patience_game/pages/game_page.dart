import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controllers/patience_game_controller.dart';

class PatienceGamePage extends StatelessWidget {
  PatienceGamePage({Key? key}) : super(key: key);

  final PatienceGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: GestureDetector(
        onTap: () => controller.userInteracted(),
        child: Container(
          width: Phone.width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => LessText.lessFuturedText(
                    text: 'Level ${controller.level.value}',
                    color: Colors.white,
                    fontSize: 50,
                  )),
              SizedBox(height: 20),
              Obx(() => LessText.lessFuturedText(
                    text: 'Time Remaining: ${controller.timeRemaining.value}s',
                    color: Colors.white,
                    fontSize: 30,
                  )),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (controller.isGameRunning.value) {
                    controller.resetGame();
                  } else {
                    controller.startGame();
                  }
                },
                child: Obx(() => LessText.lessFuturedText(
                      text: controller.isGameRunning.value ? 'Reset' : 'Start',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.myYellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
