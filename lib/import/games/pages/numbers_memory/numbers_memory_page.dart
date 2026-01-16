import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../../helpers/phone_properties.dart';
import 'controllers/number_memory_value_controller.dart';
import 'controllers/numbers_memory_controller.dart';
import 'package:neuralboost/services/gamificate_service.dart'; // Import GamificateService

class NumbersMemory extends StatefulWidget {
  NumbersMemory({Key? key}) : super(key: key);

  @override
  _NumbersMemoryState createState() => _NumbersMemoryState();
}

class _NumbersMemoryState extends State<NumbersMemory> {
  late NumbersMemoryController controller;
  late NumbersMemoryValueController valueController;
  final GamificateService _gamificateService =
      GamificateService(); // Instantiate GamificateService

  @override
  void initState() {
    Phone.closeStatusBar();
    controller = Get.put(NumbersMemoryController());
    valueController = Get.put(NumbersMemoryValueController());
    super.initState();
  }

  @override
  void dispose() {
    controller.reset();
    _gamificateService.addPoints(10); // Award points when the game is completed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: () => _focusLostController(),
      child: Obx(
        () => Scaffold(
          body: Center(
            child: controller.pages[controller.page.value],
          ),
        ),
      ),
    );
  }

  _focusLostController() {
    if (controller.onShowNumberPage) {
      if (!controller.protectedFocusLost) {
        Get.back();
        Get.snackbar(
          "Game Over",
          "If you leave while playing, the game is over.",
          duration: Duration(seconds: 5),
        );
      } else {
        controller.protectedFocusLost = false;
      }
    }
  }
}
