import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/phone_properties.dart';
import '../../../../widgets/text/less_futured_text.dart';
import '../../controllers/number_memory_value_controller.dart';
import '../../controllers/numbers_memory_controller.dart';
import 'helpers/wrong_numbers_detecetor.dart';

class WrongAnswer extends StatefulWidget {
  WrongAnswer({Key? key}) : super(key: key);

  @override
  State<WrongAnswer> createState() => _WrongAnswerState();
}

class _WrongAnswerState extends State<WrongAnswer> {
  late NumbersMemoryController c;
  late NumbersMemoryValueController vC;

  late BuildContext context;

  _initState() {
    c = Get.find();
    vC = c.valueController;
  }

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    _initState();
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: _backButton(),
            ),
            Flexible(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberText(),
                    SizedBox(height: 10),
                    _showNumberText(vC.number),
                    SizedBox(height: 20),
                    _yourAnswerText(),
                    SizedBox(height: 10),
                    _showYourAnswerText(vC.number, vC.usersAnswer),
                    SizedBox(height: 30),
                    _showLevelText(vC.levelCounter),
                    SizedBox(height: 20),
                    retryButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton() => Container(
        width: Phone.width(context),
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      );

  Text _numberText() => LessText.lessFuturedText(
        text: 'Number',
        color: Colors.grey.shade400,
      );

  Text _showNumberText(String number) => LessText.lessFuturedText(
        text: number,
        color: Colors.white,
        fontFamily: null,
        fontSize: 14,
      );

  Text _yourAnswerText() => LessText.lessFuturedText(
        text: 'Your Answer',
        color: Colors.grey.shade400,
      );

  Row _showYourAnswerText(String answer, String userAnswer) => WrongDetecetor(
        answer: answer,
        userAnswer: userAnswer,
      ).detect();

  Text _showLevelText(int level) => LessText.lessFuturedText(
        text: 'Level $level',
        color: Colors.red.shade400,
        fontSize: 50,
      );

  Widget retryButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Phone.width(context) / 4, 40),
          backgroundColor: Color.fromRGBO(244, 180, 0, 1),
        ),
        onPressed: () {
          c.valueController.reset();
          c.selectShowNumberPage();
        },
        child: Text(
          'Retry',
          textAlign: TextAlign.center,
        ),
      );
}
