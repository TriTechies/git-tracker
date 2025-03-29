import 'package:flutter/material.dart';

class RateUsPage extends StatelessWidget {
  const RateUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Rate Us'),
        ),
      ),
      body: const Center(
        child: Text('Rate Us Page'),
      ),
    );
  }
}
