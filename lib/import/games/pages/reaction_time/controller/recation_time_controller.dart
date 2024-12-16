import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reaction_timer_value_controller.dart';
import '../../sequence_memory/pages/info_page.dart';
import '../pages/green_page.dart';
import '../pages/red_page.dart';
import '../pages/show_ms_page.dart';
import '../pages/too_soon_page.dart';

class ReactionTimeController extends GetxController {
  ReactionTimeValueController get valueController =>
      Get.find<ReactionTimeValueController>();

  var page = 0.obs;

  List<Widget> pages = [
    InfoPage(),
    GreenPage(),
    TooSoonPage(),
    RedPage(),
    ShowMsPage(),
  ];

  void selectInfoPage() => page.value = 0;

  void selectGreenPage() => page.value = 1;

  void selectTooSoonPage() => page.value = 2;

  void selectRedPage() => page.value = 3;

  void selectShowMsPage() => page.value = 4;
}
