import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:git_tracker/db/helpers/habit_records_dao.dart';

class HabitGraph extends StatefulWidget {
  final String interval;
  const HabitGraph({super.key, required this.interval});

  @override
  State<HabitGraph> createState() => _HabitGraphState();
}

class _HabitGraphState extends State<HabitGraph> {
  bool _isExpanded = true;
  List<FlSpot> _spots = [];
  final habitRecordDao = HabitRecordsDao();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final records =
        await habitRecordDao.getHabitRecordsOfLastWeek(widget.interval);

    final now = DateTime.now();
    final Map<int, int> groupedData = {};

    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: i)).day;
      groupedData[day] = 0;
    }

    for (final record in records) {
      final day = record.createdAt.day;
      if (groupedData.containsKey(day)) {
        groupedData[day] = groupedData[day]! + 1;
      }
    }

    final List<FlSpot> spots = groupedData.entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.toDouble()))
        .toList();

    setState(() {
      _spots = spots;
    });
  }

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
                          spots: _spots,
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
