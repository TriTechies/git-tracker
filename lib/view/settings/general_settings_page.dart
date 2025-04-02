import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:git_tracker/view/settings/settings.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('General Settings'),
        ),
      ),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
