import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/phone_properties.dart';
import '../controller/recation_time_controller.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late BuildContext context;

  late ReactionTimeController controller;

  @override
  Widget build(BuildContext buildContext) {
    this.context = buildContext;
    controller = Get.find();
    return GestureDetector(
      onTap: () => controller.selectRedPage(),
      child: Scaffold(
        backgroundColor: MyColors.myBlue,
        body: SafeArea(
          child: Container(
            width: Phone.width(context),
            height: Phone.heigth(context),
            child: Column(
              children: [
                backButton(),
                Expanded(
                  child: infoText(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoText() {
    return Container(
      padding: EdgeInsets.all(35),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "When the red color turns green, click on the screen fast as possible.",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Text(
              "Click anwhere to start.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return Container(
      alignment: Alignment.bottomLeft,
      width: Phone.width(context),
      child: IconButton(
        color: Colors.white,
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
