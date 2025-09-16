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
      version: 3,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await _createAllTables(db);
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Create habits table if it doesn't exist
      var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='habits'"
      );
      
      if (result.isEmpty) {
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
    }
    
    if (oldVersion < 3) {
      // Add any new tables or columns for version 3
      var userHabitsExists = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='user_habits'"
      );
      
      if (userHabitsExists.isEmpty) {
        await db.execute('''
          CREATE TABLE user_habits(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            habit TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
          )
        ''');
      }
    }
  }

  Future<void> _createAllTables(Database db) async {
    // Users table
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

    // User habits table (for selected habits during registration)
    await db.execute('''
      CREATE TABLE user_habits(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        habit TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Habits table (for detailed habit tracking)
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

    // Habit records table (for tracking completions)
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

  Future<List<String>> getTableNames() async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'"
    );
    return result.map((row) => row['name'].toString()).toList();
  }

  // Debug method to check table structure
  Future<void> printTableInfo(String tableName) async {
    final db = await database;
    final result = await db.rawQuery("PRAGMA table_info($tableName)");
    print('\n=== Table Info for $tableName ===');
    for (var column in result) {
      print('Column: ${column['name']}, Type: ${column['type']}, NotNull: ${column['notnull']}');
    }
    print('========================\n');
  }

  // Reset database (for development/testing)
  Future<void> resetDatabase() async {
    String path = join(await getDatabasesPath(), 'git_tracker.db');
    await deleteDatabase(path);
    _database = null;
    _database = await _initDatabase();
    print('Database reset successfully');
  }
}