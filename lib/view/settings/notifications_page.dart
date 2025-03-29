import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Notifications'),
        ),
      ),
      body: const Center(
        child: Text('Manage Notifications Settings'),
      ),
    );
  }
}
