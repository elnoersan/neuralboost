import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/phone_properties.dart';
import 'controller/sequence_memory_controller.dart';
import 'controller/sequence_memory_value_controller.dart';
import 'package:neuralboost/services/gamificate_service.dart'; // Import GamificateService

class SequenceMemory extends StatefulWidget {
  SequenceMemory({Key? key}) : super(key: key);

  @override
  _SequenceMemoryState createState() => _SequenceMemoryState();
}

class _SequenceMemoryState extends State<SequenceMemory> {
  late SequenceMemoryController sequenceMemoryController;
  late SequenceMemoryValueController sequenceMemoryValueController;
  final GamificateService _gamificateService =
      GamificateService(); // Instantiate GamificateService

  @override
  void initState() {
    super.initState();
    Phone.closeStatusBar();
    sequenceMemoryController = Get.put(SequenceMemoryController());
    sequenceMemoryValueController = Get.put(SequenceMemoryValueController());
  }

  @override
  void dispose() {
    sequenceMemoryValueController.hardReset();
    _gamificateService.addPoints(10); // Award points when the game is completed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Obx(() =>
      sequenceMemoryController.pages[sequenceMemoryController.page.value]);
}
