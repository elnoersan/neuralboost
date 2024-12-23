import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/game_page.dart';
import '../pages/info_page.dart';
import '../pages/wrong_answer_page.dart';
import '../../../helpers/colors.dart';
import 'sequence_memory_value_controller.dart';

class SequenceMemoryController extends GetxController {
  SequenceMemoryValueController get sequenceMemoryValueController =>
      Get.find<SequenceMemoryValueController>();
  var page = 0.obs;
  var clickable = true;
  var backGroundColor = MyColors.myBlue.obs;

  List<Rx<Color>> cardColors = [
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
  ];

  List<Widget> pages = [
    InfoPage(),
    GamePage(),
    WrongAnswer(),
  ];

  selectInfoPage() => page.value = 0;
  selectGamePage() => page.value = 1;
  selectWrongAnswerPage() => page.value = 2;

  selectCorrectAnswerBackground() =>
      backGroundColor.value = MyColors.myLightBlue;
  resetBackground() => backGroundColor.value = MyColors.myBlue;

  selectWhiteCard(int index) => cardColors[index].value = Colors.white;
  selectTransparentCard(int index) =>
      cardColors[index].value = MyColors.transparentBlackForCard;
}
