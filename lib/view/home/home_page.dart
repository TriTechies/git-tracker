import 'package:flutter/material.dart';
import 'package:git_tracker/view/dashboard/dashboard_screen.dart';
import 'package:git_tracker/view/profile/user_profile.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(const Profile());
                    },
                    icon: const Icon(Icons.abc)),
                IconButton(
                    onPressed: () {
                      Get.to(const DashboardScreen());
                    },
                    icon: const Icon(Icons.home)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
