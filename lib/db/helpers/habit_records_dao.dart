import 'package:git_tracker/db/database_helper.dart';
import 'package:git_tracker/model/habit_record.dart';
import 'package:sqflite/sqflite.dart';

class HabitRecordsDao {
  // Create
  Future<void> insertHabitRecord(
      String id, String habitId, DateTime createdAt) async {
    final db = await DatabaseHelper().database;

    await db.insert(
      'habit_records',
      {
        'id': id,
        'habitId': habitId,
        'createdAt': createdAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<HabitRecord>> getHabitRecords(String habitId) async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps = await db.query(
      'habit_records',
      where: 'habitId = ?',
      whereArgs: [habitId],
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return HabitRecord.fromMap(maps[i]);
    });
  }

  // Get habit records of the last week
  Future<List<HabitRecord>> getHabitRecordsOfLastWeek(String interval) async {
    final db = await DatabaseHelper().database;
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT habit_records.*, habits.interval 
    FROM habit_records
    JOIN habits ON habit_records.habitId = habits.id
    WHERE habit_records.createdAt >= ? AND habits.interval = ?
    ORDER BY habit_records.createdAt DESC
  ''', [lastWeek.toIso8601String(), interval]);

    return List.generate(maps.length, (i) {
      return HabitRecord.fromMap(maps[i]);
    });
  }

  // Delete
  Future<void> deleteHabitRecord(String id) async {
    final db = await DatabaseHelper().database;

    await db.delete(
      'habit_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all records for a specific habit
  Future<void> deleteHabitRecords(String habitId) async {
    final db = await DatabaseHelper().database;

    await db.delete(
      'habit_records',
      where: 'habitId = ?',
      whereArgs: [habitId],
    );
  }

  // Delete all records for a specific habit
  Future<void> deleteAllHabitRecords() async {
    final db = await DatabaseHelper().database;

    await db.delete(
      'habit_records',
    );
  }
}
