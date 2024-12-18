import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/phone_properties.dart';
import 'controller/reaction_timer_value_controller.dart';
import 'controller/recation_time_controller.dart';
import 'package:neuralboost/services/gamificate_service.dart'; // Import GamificateService

class ReactionTime extends StatefulWidget {
  ReactionTime({Key? key}) : super(key: key);

  @override
  _ReactionTimeState createState() => _ReactionTimeState();
}

class _ReactionTimeState extends State<ReactionTime> {
  late ReactionTimeController reactionTimeController;
  late ReactionTimeValueController reactionTimeValueController;
  final GamificateService _gamificateService =
      GamificateService(); // Instantiate GamificateService

  @override
  void dispose() {
    Phone.closeStatusBar();
    reactionTimeValueController.reset();
    _gamificateService.addPoints(10); // Award points when the game is completed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    reactionTimeController = Get.put(ReactionTimeController());
    reactionTimeValueController = Get.put(ReactionTimeValueController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => reactionTimeController.pages[reactionTimeController.page.value]);
  }
}
