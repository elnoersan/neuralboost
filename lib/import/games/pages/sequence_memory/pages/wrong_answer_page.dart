import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/button/elevated_button.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controller/sequence_memory_controller.dart';

class WrongAnswer extends StatefulWidget {
  WrongAnswer({Key? key}) : super(key: key);

  @override
  State<WrongAnswer> createState() => _WrongAnswerState();
}

class _WrongAnswerState extends State<WrongAnswer> {
  late SequenceMemoryController controller;

  @override
  Widget build(BuildContext context) {
    _initState();
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: _backButton(),
          ),
          Flexible(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(child: _levelText()),
                SizedBox(height: 20),
                _retryButton(context),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _initState() {
    controller = Get.find();
  }

  Widget _retryButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => _retry(),
      child: LessText.lessFuturedText(
        text: 'Retry',
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      primary: MyColors.mySemiDarkYellow,
      borderRadius: 10,
      borderSideWidth: 1.5,
      borderSideColor: Colors.white,
      size: Size(Phone.width(context) / 3.5, 20),
    );
  }

  _retry() {
    controller.selectInfoPage();
  }

  Widget _levelText() {
    var levelCount =
        controller.sequenceMemoryValueController.levelCount.toString();

    return LessText.lessFuturedText(
      text: 'Level $levelCount',
      fontSize: 70,
      color: MyColors.myRed,
    );
  }

  Widget _backButton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
