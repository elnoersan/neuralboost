import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/phone_properties.dart';
import '../../../../widgets/text/less_futured_text.dart';
import '../../controllers/numbers_memory_controller.dart';

class CorrectAnswer extends StatefulWidget {
  CorrectAnswer({Key? key}) : super(key: key);

  @override
  State<CorrectAnswer> createState() => _CorrectAnswerState();
}

class _CorrectAnswerState extends State<CorrectAnswer> {
  late NumbersMemoryController c;

  late BuildContext context;

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    c = Get.find();
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LessText.lessFuturedText(
              text: 'Number',
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 10),
            LessText.lessFuturedText(
              text: c.valueController.number,
              color: Colors.white,
              fontFamily: null,
              fontSize: 14,
            ),
            SizedBox(height: 20),
            LessText.lessFuturedText(
              text: 'Your Answer',
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 10),
            LessText.lessFuturedText(
              text: c.valueController.usersAnswer,
              color: Colors.white,
              fontFamily: null,
              fontSize: 14,
            ),
            SizedBox(height: 30),
            LessText.lessFuturedText(
              text: 'Level ${c.valueController.levelCounter}',
              color: Colors.green.shade400,
              fontSize: 50,
            ),
            SizedBox(
              height: 20,
            ),
            nextButton(),
          ],
        ),
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(Phone.width(context) / 4, 40),
        backgroundColor: Color.fromRGBO(244, 180, 0, 1),
      ),
      onPressed: () {
        c.valueController.incrementLevel();
        c.selectShowNumberPage();
      },
      child: Text(
        'Next',
        textAlign: TextAlign.center,
      ),
    );
  }
}
