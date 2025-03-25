import 'package:git_tracker/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/habit.dart';

class HabitsDao {
  // Create
  Future<void> insertHabit(Habit habit) async {
    final db = await DatabaseHelper().database;

    await db.insert(
      'habits',
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<Habit?> getHabit(String id) async {
    final db = await DatabaseHelper().database;

    final maps = await db.query(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Habit.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Habit>> getAllHabits() async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps = await db.query('habits');

    return List.generate(maps.length, (i) {
      return Habit.fromMap(maps[i]);
    });
  }

  Future<List<Habit>> getAllHabitsWithInterval(String interval) async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps =
        await db.query('habits', where: 'interval = ?', whereArgs: [interval]);

    return List.generate(maps.length, (i) {
      return Habit.fromMap(maps[i]);
    });
  }

  // Update
  Future<void> updateHabit(Habit habit) async {
    final db = await DatabaseHelper().database;

    await db.update(
      'habits',
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  // Delete
  Future<void> deleteHabit(String id) async {
    final db = await DatabaseHelper().database;

    await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all habits
  Future<void> deleteAllHabits() async {
    final db = await DatabaseHelper().database;

    await db.delete('habits');
  }
}
