import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';

class HabitGraph extends StatefulWidget {
  const HabitGraph({super.key});

  @override
  State<HabitGraph> createState() => _HabitGraphState();
}

class _HabitGraphState extends State<HabitGraph> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Toggle accordion state
        });
      },
      child: Container(
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
                            Icons.auto_graph,
                          ),
                        ),
                      ), // Icon next to title
                      const SizedBox(width: 8),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Habits',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Comparison by week',
                          ),
                        ],
                      ),
                    ],
                  ),
                  ChevronButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle accordion state
                      });
                    },
                    direction: _isExpanded ? "up" : "down",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isExpanded)
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
      ),
    );
  }
}
