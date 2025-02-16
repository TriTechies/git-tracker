import 'package:flutter/material.dart';
import 'dart:math';

import 'package:git_tracker/view/widgets/chevron_button.dart';

class ContributionChartWidget extends StatefulWidget {
  const ContributionChartWidget({super.key});

  @override
  State<ContributionChartWidget> createState() =>
      _ContributionChartWidgetState();
}

class _ContributionChartWidgetState extends State<ContributionChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border.all(
            color: const Color.fromARGB(255, 243, 244, 246),
            width: 1), // Border
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(
                            255, 243, 244, 246), // Background color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.water,
                        ),
                      ),
                    ), // Icon next to title
                    const SizedBox(width: 8),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Water Plants',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '0/1',
                        ),
                      ],
                    ),
                  ],
                ),
                ChevronButton(
                  onPressed: () {},
                  direction: "left",
                  icon: Icons.add,
                )
              ],
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
  final int columns = 20;
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
