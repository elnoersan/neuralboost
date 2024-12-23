import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controller/sequence_memory_controller.dart';


class InfoPage extends StatefulWidget {
  InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late SequenceMemoryController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find();

    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Container(
        width: Phone.width(context),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: _backButton(),
            ),
            Flexible(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(bottom: 50, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: _gameNameText(),
                    ),
                    SizedBox(height: 25),
                    FittedBox(child: _infoText()),
                    SizedBox(height: 25),
                    _startButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _gameNameText() => LessText.lessFuturedText(
        text: 'Sequence Memory\nTest',
        color: Colors.white,
        fontSize: 50,
      );

  Text _infoText() => LessText.lessFuturedText(
        text: 'Memorize the pattern.',
        color: Colors.white,
        fontSize: 20,
      );

  Widget _backButton() => Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      );

  ElevatedButton _startButton() {
    controller.sequenceMemoryValueController.hardReset();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: MyColors.myYellow),
      onPressed: () => controller.selectGamePage(),
      child: LessText.lessFuturedText(
        text: 'Start',
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
