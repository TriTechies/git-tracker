import 'package:flutter/material.dart';
import 'package:git_tracker/db/helpers/habit_records_dao.dart';
import 'package:git_tracker/model/habit.dart';
import 'package:git_tracker/model/habit_record.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:uuid/uuid.dart';

class ContributionChartWidget extends StatefulWidget {
  final Habit habit;
  const ContributionChartWidget({super.key, required this.habit});

  @override
  State<ContributionChartWidget> createState() =>
      _ContributionChartWidgetState();
}

class _ContributionChartWidgetState extends State<ContributionChartWidget> {
  List<HabitRecord> _habitRecords = [];
  int _todayRecordCount = 0;
  final habitRecordDao = HabitRecordsDao();

  @override
  void initState() {
    super.initState();
    _fetchHabitRecords();
  }

  Future<void> _fetchHabitRecords() async {
    final records = await habitRecordDao.getHabitRecords(widget.habit.id);
    final today = DateTime.now();
    final todayRecords = records
        .where((record) =>
            record.createdAt.year == today.year &&
            record.createdAt.month == today.month &&
            record.createdAt.day == today.day)
        .toList();
    setState(() {
      _habitRecords = records;
      _todayRecordCount = todayRecords.length;
    });
  }

  Future<void> _addHabitRecords() async {
    if (_todayRecordCount != widget.habit.frequency) {
      const uuid = Uuid();
      final String recordId = uuid.v4();
      await habitRecordDao.insertHabitRecord(
        recordId,
        widget.habit.id,
        DateTime.now(),
      );
      _fetchHabitRecords(); // Refresh the records
    }
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
                          '$_todayRecordCount/${widget.habit.frequency}',
                        ),
                      ],
                    ),
                  ],
                ),
                ChevronButton(
                  onPressed: _addHabitRecords,
                  direction: "left",
                  icon: _todayRecordCount == widget.habit.frequency
                      ? Icons.check
                      : Icons.add,
                  backgroundColor: widget.habit.color,
                  showBackgroundColor:
                      _todayRecordCount == widget.habit.frequency,
                )
              ],
            ),
            const SizedBox(height: 10),
            ContributionGrid(
                habitRecords: _habitRecords,
                habitColor: widget.habit.color,
                habitFrequency: widget.habit.frequency),
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
  final Color habitColor;
  final int habitFrequency;

  const ContributionGrid(
      {super.key,
      required this.habitRecords,
      required this.habitColor,
      required this.habitFrequency});

  // Group habit records by date and count their occurrences
  Map<String, int> _groupHabitRecordsByDate() {
    Map<String, int> groupedRecords = {};
    if (habitRecords.isEmpty) return groupedRecords;

    DateTime startDate = habitRecords.first.createdAt;
    DateTime endDate = habitRecords.last.createdAt;

    for (var record in habitRecords) {
      String dateKey = record.createdAt.toIso8601String().split('T')[0];
      groupedRecords[dateKey] = (groupedRecords[dateKey] ?? 0) + 1;
    }

    // Fill in missing dates with 0 count
    for (DateTime date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(const Duration(days: 1))) {
      String dateKey = date.toIso8601String().split('T')[0];
      groupedRecords[dateKey] = groupedRecords[dateKey] ?? 0;
    }

    return groupedRecords;
  }

  // Get color intensity based on record count and habit frequency
  Color _getColorBasedOnCount(int count) {
    double intensity =
        (count / habitFrequency).clamp(0.0, 1.0); // Ranges from 0.0 to 1.0
    return habitColor
        .withOpacity(intensity); // Adjust opacity based on intensity
  }

  @override
  Widget build(BuildContext context) {
    final groupedRecords = _groupHabitRecordsByDate();
    final recordDates = groupedRecords.keys
        .toList()
        .reversed
        .toList(); // Reverse the list of dates

    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(columns, (colIndex) {
            int index = rowIndex * columns + colIndex;
            bool isActive = index < recordDates.length;

            // Get saturation based on count
            final color = isActive
                ? _getColorBasedOnCount(groupedRecords[recordDates[index]]!)
                : habitColor
                    .withOpacity(0.05); // Lighter version of the habit color

            return Container(
              margin: const EdgeInsets.all(2),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        );
      }),
    );
  }
}
