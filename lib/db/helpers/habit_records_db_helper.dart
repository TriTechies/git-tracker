import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HabitRecordsDbHelper {
  static final HabitRecordsDbHelper instance = HabitRecordsDbHelper._init();
  static Database? _database;

  HabitRecordsDbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habit_records.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE habit_records(
        id TEXT PRIMARY KEY,
        habitId TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (habitId) REFERENCES habits (id) ON DELETE CASCADE
      )
    ''');
  }

  // Create
  Future<void> insertHabitRecord(String id, String habitId, DateTime createdAt) async {
    final db = await database;
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
  Future<List<Map<String, dynamic>>> getHabitRecords(String habitId) async {
    final db = await database;
    return await db.query(
      'habit_records',
      where: 'habitId = ?',
      whereArgs: [habitId],
      orderBy: 'createdAt DESC',
    );
  }

  // Delete
  Future<void> deleteHabitRecord(String id) async {
    final db = await database;
    await db.delete(
      'habit_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all records for a specific habit
  Future<void> deleteHabitRecords(String habitId) async {
    final db = await database;
    await db.delete(
      'habit_records',
      where: 'habitId = ?',
      whereArgs: [habitId],
    );
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}