import 'package:flutter/material.dart';
import 'dart:math';

class ContributionChartWidget extends StatelessWidget {
  const ContributionChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Water Plants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ContributionGrid(),
          ],
        ),
      ),
    );
  }
}

class ContributionGrid extends StatelessWidget {
  final int rows = 5;
  final int columns = 22;
  final Random random = Random();

  ContributionGrid({super.key});

  Color getRandomGreen() {
    int intensity = random.nextInt(150); // Random green shade
    return Color.fromARGB(255, 0, intensity, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(columns, (colIndex) {
            return Container(
              margin: const EdgeInsets.all(2),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: getRandomGreen(),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        );
      }),
    );
  }
}
