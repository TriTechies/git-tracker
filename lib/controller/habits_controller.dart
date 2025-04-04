import 'package:get/get.dart';
import 'package:git_tracker/model/habit.dart';
import 'package:git_tracker/db/helpers/habits_dao.dart';

class HabitController extends GetxController {
  final RxList<Habit> habits = <Habit>[].obs;

  Future<void> loadHabits() async {
    final dbHelper = HabitsDao();
    habits.value = await dbHelper.getAllHabits();
  }

  Future<void> addHabit(Habit habit) async {
    final dbHelper = HabitsDao();
    await dbHelper.insertHabit(habit);
    await loadHabits();
  }
}
