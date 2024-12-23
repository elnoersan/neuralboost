import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controller/recation_time_controller.dart';


class TooSoonPage extends StatefulWidget {
  TooSoonPage({Key? key}) : super(key: key);

  @override
  State<TooSoonPage> createState() => _TooSoonPageState();
}

class _TooSoonPageState extends State<TooSoonPage> {
  late ReactionTimeController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find();
    return GestureDetector(
      onTap: () {
        controller.valueController.reset();
        controller.selectRedPage();
      },
      child: Scaffold(
        backgroundColor: MyColors.myBlue,
        body: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: Phone.width(context),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Expanded(
                child: roofWdgt(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget roofWdgt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Icon(
            Icons.error_outline,
            size: 110,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        FittedBox(
          child: LessText.lessFuturedText(
            text: 'Too Soon!',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 70,
          ),
        ),
        SizedBox(height: 20),
        FittedBox(
          child: LessText.lessFuturedText(
            text: 'Click to try again',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
        ).marginOnly(bottom: 50),
      ],
    );
  }
}
