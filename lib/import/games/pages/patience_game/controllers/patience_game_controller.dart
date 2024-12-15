import 'package:get/get.dart';
import 'dart:async';

import '../pages/fail_page.dart';
import '../pages/success_page.dart';

class PatienceGameController extends GetxController {
  var level = 1.obs;
  var timeRemaining = 0.obs;
  var isGameRunning = false.obs;
  late Timer _timer;
  late Stopwatch _stopwatch;

  void startGame() {
    isGameRunning.value = true;
    timeRemaining.value = level.value * 15; // Each level increases by 15 seconds
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_stopwatch.elapsed.inSeconds >= timeRemaining.value) {
        levelUp();
      }
    });
  }

  void resetGame() {
    _timer.cancel();
    _stopwatch.stop();
    isGameRunning.value = false;
    level.value = 1;
    timeRemaining.value = 0;
  }

  void levelUp() {
    level.value++;
    timeRemaining.value = level.value * 15;
    _stopwatch.reset();
    Get.to(() => PatienceGameSuccessPage()); // Navigate directly
  }

  void userInteracted() {
    if (isGameRunning.value) {
      _stopwatch.reset();
      Get.to(() => PatienceGameFailPage()); // Navigate directly
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    _stopwatch.stop();
    super.onClose();
  }
}