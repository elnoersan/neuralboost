import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../../../helpers/random_number_generator.dart';
import '../../../helpers/timer.dart';
import '../controller/recation_time_controller.dart';

class RedPage extends StatefulWidget {
  RedPage({Key? key}) : super(key: key);

  @override
  _RedPageState createState() => _RedPageState();
}

late ReactionTimeController c;
late Timer timer;

class _RedPageState extends State<RedPage> {
  @override
  Widget build(BuildContext context) {
    _startTimer();
    c = Get.find();
    return GestureDetector(
      onTap: () {
        timer.cancel();
        c.selectTooSoonPage();
      },
      child: Scaffold(
        backgroundColor: MyColors.myRed,
        body: Container(
          width: Phone.width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pending_outlined,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(height: 30),
              _waitForGreenText(),
            ],
          ),
        ),
      ),
    );
  }

  _startTimer() {
    var rnd = RandomNumber.minMax(2500, 6001).randomNumber;
    timer = MyTimer.startTimer(
        milliseconds: rnd, onFinished: () => c.selectGreenPage());
  }

  Widget _waitForGreenText() {
    return Text(
      "Wait For Green",
      style: TextStyle(
        fontSize: 50,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
