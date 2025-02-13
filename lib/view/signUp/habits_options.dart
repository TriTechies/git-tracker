import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:git_tracker/view/widgets/my_card_row.dart';

import '../widgets/my_button.dart';

class HabitsOptions extends StatelessWidget {
  const HabitsOptions({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Choose your first habits",
                style: defaultstyle(
                    fontFamily: "Segoe UI", size: 20, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "You may add more habits later",
                style: defaultstyle(
                    fontFamily: "Segoe UI", size: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const MyCardRow(
                imageFirst: "water",
                textFirst: "Drink Water",
                imageSecond: "run",
                textSecond: "Run"),
            const MyCardRow(
                imageFirst: "book",
                textFirst: "Read Books",
                imageSecond: "meditate",
                textSecond: "Meditate"),
            const MyCardRow(
                imageFirst: "study",
                textFirst: "Study",
                imageSecond: "journal",
                textSecond: "Journal"),
            const MyCardRow(
                imageFirst: "plant",
                textFirst: "Grow Plants",
                imageSecond: "sleep",
                textSecond: "Sleep")
          ],
        ),
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
