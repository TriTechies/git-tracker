import 'package:flutter/material.dart';
import 'package:git_tracker/view/dashboard/widgets/summary_info_tile.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:git_tracker/db/helpers/habit_records_db_helper.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  bool _isExpanded = true;
  String _successRate = '0%';
  String _completed = '0';
  String _pointsEarned = '0';
  String _bestStreakDay = '0';
  String _skipped = '0';
  String _failed = '0';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final records =
        await HabitRecordsDbHelper.instance.getHabitRecordsOfLastWeek();

    // Process the records to calculate the required data
    final now = DateTime.now();
    int completed = 0;
    int skipped = 0;
    int failed = 0;
    int pointsEarned = 0;
    int bestStreakDay = 0;
    int currentStreak = 0;
    int successRate = 0;

    for (final record in records) {
      completed++;
      pointsEarned += 10; // Assuming each completed habit earns 10 points
      final day = record.createdAt.day;
      if (day == now.day) {
        currentStreak++;
      } else {
        if (currentStreak > bestStreakDay) {
          bestStreakDay = currentStreak;
        }
        currentStreak = 0;
      }
    }

    if (completed > 0) {
      successRate = (completed / (completed + skipped + failed) * 100).toInt();
    }

    setState(() {
      _successRate = '$successRate%';
      _completed = '$completed';
      _pointsEarned = '$pointsEarned';
      _bestStreakDay = '$bestStreakDay';
      _skipped = '$skipped';
      _failed = '$failed';
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
                            Icons.trending_up_sharp,
                          ),
                        ),
                      ), // Icon next to title
                      const SizedBox(width: 8),
                      const Column(
                        children: [
                          Text(
                            'All Habits',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Summary',
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
              if (_isExpanded) // Show the expanded content
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SummaryInfoTile(
                                title: 'Success Rate', value: _successRate)),
                        Expanded(
                            child: SummaryInfoTile(
                                title: 'Completed', value: _completed)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SummaryInfoTile(
                          title: 'Points Earned',
                          value: _pointsEarned,
                          icon: Icons.auto_awesome_sharp,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 243, 218),
                          textColor: const Color.fromARGB(255, 254, 168, 0),
                        )),
                        Expanded(
                            child: SummaryInfoTile(
                                title: 'Best Streak Day',
                                value: _bestStreakDay)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SummaryInfoTile(
                                title: 'Skipped', value: _skipped)),
                        Expanded(
                            child: SummaryInfoTile(
                                title: 'Failed', value: _failed)),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
