import 'package:flutter/material.dart';
import 'package:git_tracker/view/style/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
