import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class DatabaseHelper extends GetxController {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'git_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        gender TEXT,
        date_of_birth TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE user_habits(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        habit TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

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

    await db.execute('''
      CREATE TABLE habit_records(
        id TEXT PRIMARY KEY,
        habitId TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (habitId) REFERENCES habits (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }
}
