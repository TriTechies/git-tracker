import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/style/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Timer( const Duration(seconds: 5), () {
      Get.offAllNamed('/intro');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 880,
        width: 400,
        decoration: BoxDecoration(gradient: backgroundColor),
        child: Center(child: Image.asset('assets/Logo.png')),
      ),
    );
  }
}
