import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/text/less_futured_text.dart';
import '../controller/sequence_memory_controller.dart';
import '../values/const_values.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    _initializeValues();
    return Obx(
      () => Scaffold(
        backgroundColor: controller.backGroundColor.value,
        body: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: controller.backGroundColor.value,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: _levelText(),
                ),
              ),
              Flexible(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: GridView.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 3,
                    children: widgetList,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _levelText() {
    return LessText.lessFuturedText(
      text: 'Level: ' +
          controller.sequenceMemoryValueController.levelCount.toString(),
      color: Colors.white,
    );
  }

  late SequenceMemoryController controller;
  late List<Widget> widgetList = [];

  _initializeValues() {
    controller = Get.find();
    widgetList = List.generate(9, (index) => _buildCard(index));
    controller.sequenceMemoryValueController.play();
  }

  Widget _buildCard(int index) {
    return Obx(
      () => InkWell(
        onTap: () => _cardClickController(index),
        child: AnimatedContainer(
          duration: Consts.cardAnimationDuration,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: controller.cardColors[index].value,
          ),
        ),
      ),
    );
  }

  _cardClickController(int index) {
    if (controller.clickable) {
      controller.sequenceMemoryValueController.userStepCheck(index);
    }
  }
}
