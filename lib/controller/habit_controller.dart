import 'package:get/get.dart';
import 'package:git_tracker/model/habit.dart';
import 'package:git_tracker/db/helpers/habit_db_helper.dart';

class HabitController extends GetxController {
  final RxList<Habit> habits = <Habit>[].obs;

  Future<void> loadHabits() async {
    final dbHelper = HabitDbHelper.instance;
    habits.value = await dbHelper.getAllHabits();
  }

  Future<void> addHabit(Habit habit) async {
    final dbHelper = HabitDbHelper.instance;
    await dbHelper.insertHabit(habit);
    await loadHabits();
  }
}
