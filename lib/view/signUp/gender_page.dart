import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/widgets/my_card_row.dart';

import '../style/style.dart';
import '../widgets/my_button.dart';

class GenderPage extends StatelessWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Create Account",
          style: defaultstyle(
              fontFamily: "Segoe UI", size: 24, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Choose your gender",
              style: withoutFontWeight(
                  fontFamily: "Segoe UI", size: 14, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const MyCardRow(
              imageFirst: "male",
              textFirst: "Male",
              imageSecond: "female",
              textSecond: "Female")
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MyButton(
          name: "Next",
          height: 52,
          width: 345,
          color: Colors.blue,
          route: () {
            Get.toNamed('/options');
          },
        ),
      ),
    );
  }
}
