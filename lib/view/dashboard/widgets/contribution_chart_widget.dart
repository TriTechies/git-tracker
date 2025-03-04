import 'package:flutter/material.dart';
import 'dart:math';
import 'package:uuid/uuid.dart'; // Add this import
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:git_tracker/model/habit.dart';
import 'package:git_tracker/db/helpers/habit_records_db_helper.dart'; // Add this import

class ContributionChartWidget extends StatefulWidget {
  final Habit habit;
  const ContributionChartWidget({super.key, required this.habit});

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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          widget.habit.icon,
                        ),
                      ),
                    ), // Icon next to title
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.habit.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '0/${widget.habit.frequency}',
                        ),
                      ],
                    ),
                  ],
                ),
                ChevronButton(
                  onPressed: () async {
                    const uuid = Uuid();
                    final String recordId = uuid.v4();
                    await HabitRecordsDbHelper.instance.insertHabitRecord(
                      recordId,
                      widget.habit.id,
                      DateTime.now(),
                    );
                    setState(() {
                      // Trigger rebuild to update the UI
                    });
                  },
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
