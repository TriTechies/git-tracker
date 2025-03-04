import 'package:flutter/material.dart';
import 'package:git_tracker/model/habit_record.dart';
import 'package:uuid/uuid.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:git_tracker/model/habit.dart';
import 'package:git_tracker/db/helpers/habit_records_db_helper.dart';

class ContributionChartWidget extends StatefulWidget {
  final Habit habit;
  const ContributionChartWidget({super.key, required this.habit});

  @override
  State<ContributionChartWidget> createState() =>
      _ContributionChartWidgetState();
}

class _ContributionChartWidgetState extends State<ContributionChartWidget> {
  List<HabitRecord> _habitRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchHabitRecords();
  }

  Future<void> _fetchHabitRecords() async {
    final records =
        await HabitRecordsDbHelper.instance.getHabitRecords(widget.habit.id);
    setState(() {
      _habitRecords = records;
    });
  }

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
                          '${_habitRecords.length}/${widget.habit.frequency}',
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
                    _fetchHabitRecords(); // Refresh the records
                  },
                  direction: "left",
                  icon: Icons.add,
                )
              ],
            ),
            const SizedBox(height: 10),
            ContributionGrid(habitRecords: _habitRecords),
          ],
        ),
      ),
    );
  }
}

class ContributionGrid extends StatelessWidget {
  final List<HabitRecord> habitRecords;
  final int rows = 5;
  final int columns = 20;

  const ContributionGrid({super.key, required this.habitRecords});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(columns, (colIndex) {
            int index = rowIndex * columns + colIndex;
            bool isActive = index < habitRecords.length;
            return Container(
              margin: const EdgeInsets.all(2),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: isActive ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        );
      }),
    );
  }
}
