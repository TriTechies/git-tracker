import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:git_tracker/db/database_helper.dart';

class UsersDao extends GetxController{
  final storage = GetStorage();
  // User operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await DatabaseHelper().database;
    return await db.insert('users', user);
  }

  Future<int> insertUserHabit(int userId, String habit) async {
    final db = await DatabaseHelper().database;
    return await db.insert('user_habits', {
      'user_id': userId,
      'habit': habit,
    });
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await DatabaseHelper().database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<String>> getUserHabits(int userId) async {
    final db = await DatabaseHelper().database;
    List<Map<String, dynamic>> results = await db.query(
      'user_habits',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return results.map((habit) => habit['habit'] as String).toList();
  }

  // Get all users - for debugging/testing
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await DatabaseHelper().database;
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
  final db = await DatabaseHelper().database;

  try {
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      final user = results.first;

      
      String token = "token_${user['id']}_${DateTime.now().millisecondsSinceEpoch}";

    
      await storage.write('token', token);
      await storage.write('user_id', user['id']);
      await storage.write('email', user['email']);

      print('Login successful');
      Get.offNamed('/dashboard');

      return {
        'success': true,
        'user': user,
        'message': 'Login successful'
      };
    } else {
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

  Future<Map<String, dynamic>> updatePassword(
      String email, String newpasswod) async {
    final db = await DatabaseHelper().database;
    try {
      var user = await getUserByEmail(email);
      if (user == null) {
        return {'success': false, 'message': 'User not found'};
      }
      int updateRows = await db.update('users', {'password': newpasswod},
          where: 'email = ? ', whereArgs: [email]);
      if (updateRows > 0) {
        return {'success': true, 'message': 'Password Updated successfully'};
      } else {
        return {'success': false, 'message': 'Failed to update password'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occured pleas try agian'};
    }
  }
  void logout() {
  final storage = GetStorage();
  storage.remove('token');
  storage.remove('user_id');
  storage.remove('email');
  Get.offAllNamed('/login');
}
}
