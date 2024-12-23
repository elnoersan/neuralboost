import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../controller/recation_time_controller.dart';

class GreenPage extends StatefulWidget {
  const GreenPage({Key? key}) : super(key: key);

  @override
  _GreenPageState createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> {
  Stopwatch stopWatch = Stopwatch();

  late ReactionTimeController c;

  @override
  Widget build(BuildContext context) {
    c = Get.find();
    _startTimer();
    return GestureDetector(
      onTap: () {
        c.valueController.millisecond = stopWatch.elapsedMilliseconds;
        c.selectShowMsPage();
      },
      child: Scaffold(
        backgroundColor: MyColors.myGreen,
        body: Center(
          child: FittedBox(
            child: Container(
              margin: EdgeInsets.all(50),
              child: Text(
                "CLICK",
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _startTimer() => stopWatch.start();
}
