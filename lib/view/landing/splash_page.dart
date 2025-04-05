import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:git_tracker/view/style/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = GetStorage();
 @override
void initState() {
  super.initState();

  Future.delayed(const Duration(seconds: 2), () {
    String? token = storage.read('token');
    if (token != null) {
      Get.offAllNamed('/dashboard'); 
    } else {
      Get.offAllNamed('/intro'); 
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
               width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: backgroundColor),
        child: Center(child: Image.asset('assets/Logo.png')),
      ),
    );
  }
}
