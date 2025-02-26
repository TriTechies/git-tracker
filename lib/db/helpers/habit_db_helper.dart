import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../model/habit.dart';

class HabitDbHelper {
  static final HabitDbHelper instance = HabitDbHelper._init();
  static Database? _database;

  HabitDbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habits.db');
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
      CREATE TABLE habits(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        durationMinutes INTEGER,
        icon INTEGER,
        color INTEGER,
        type TEXT,
        frequency INTEGER,
        interval TEXT,
        hasReminder BOOLEAN,
        createdAt TEXT,
        lastCompleted TEXT
      )
    ''');
  }

  // Create
  Future<void> insertHabit(Habit habit) async {
    final db = await database;
    await db.insert(
      'habits',
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<Habit?> getHabit(String id) async {
    final db = await database;
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
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('habits');

    return List.generate(maps.length, (i) {
      return Habit.fromMap(maps[i]);
    });
  }

  // Update
  Future<void> updateHabit(Habit habit) async {
    final db = await database;
    await db.update(
      'habits',
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  // Delete
  Future<void> deleteHabit(String id) async {
    final db = await database;
    await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all habits
  Future<void> deleteAllHabits() async {
    final db = await database;
    await db.delete('habits');
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
