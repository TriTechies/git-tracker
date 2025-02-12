import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HabitGraph extends StatelessWidget {
  const HabitGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Performance Chart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 1),
                        const FlSpot(1, 3),
                        const FlSpot(2, 2),
                        const FlSpot(3, 5),
                        const FlSpot(4, 4),
                      ],
                      isCurved: true,
                      // colors: [Colors.blue],
                      dotData: const FlDotData(show: false),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
