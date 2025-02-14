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
  }

  // User operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<int> insertUserHabit(int userId, String habit) async {
    Database db = await database;
    return await db.insert('user_habits', {
      'user_id': userId,
      'habit': habit,
    });
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<String>> getUserHabits(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'user_habits',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return results.map((habit) => habit['habit'] as String).toList();
  }

  // Get all users - for debugging/testing
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  // Print users table - helper method
  Future<void> printUsersTable() async {
    try {
      final users = await getAllUsers();
      print('\n=== Users Table Contents ===');
      for (var user in users) {
        print('ID: ${user['id']}');
        print('Name: ${user['name']}');
        print('Email: ${user['email']}');
        print('Date of Birth: ${user['date_of_birth']}');
        print('Gender: ${user['gender']}');
        print('Created at: ${user['created_at']}');
        print('------------------------');
      }
      print('Total users: ${users.length}\n');
    } catch (e) {
      print('Error printing users table: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Database db = await database;
    try {
      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (results.isNotEmpty) {
         Get.offNamed('/gender');
         print('Login successful');
        return {
          'success': true,
          'user': results.first,
          'message': 'Login successful'
        };
      } else {
        print('Login Failed');
        return {
          'success': false,
          'user': null,
          'message': 'Invalid email or password'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'user': null,
        'message': 'An error occurred during login'
      };
    }
  }
}
