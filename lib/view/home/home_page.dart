import 'package:flutter/material.dart';
import 'package:git_tracker/view/profile/user_profile.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Center(
            child: IconButton(
                onPressed: () {
                  Get.to(Profile());
                },
                icon: Icon(Icons.abc)),
          )
        ],
      ),
    );
  }
}
