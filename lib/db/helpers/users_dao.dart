import 'package:get/get.dart';
import 'package:git_tracker/db/database_helper.dart';

class UsersDao extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  // Current logged in user
  final RxMap<String, dynamic> currentUser = <String, dynamic>{}.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if user is already logged in (you might want to use shared preferences)
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Implement login persistence logic here if needed
    // For now, just initialize as not logged in
    isLoggedIn.value = false;
  }

  // Insert user with optional habits
  Future<int> insertUser(Map<String, dynamic> user, {List<String>? habits}) async {
    final db = await _databaseHelper.database;
    
    return await db.transaction((txn) async {
      try {
        // Validate required fields
        if (user['email'] == null || user['email'].toString().isEmpty) {
          throw Exception('Email is required');
        }
        if (user['password'] == null || user['password'].toString().isEmpty) {
          throw Exception('Password is required');
        }
        if (user['name'] == null || user['name'].toString().isEmpty) {
          throw Exception('Name is required');
        }

        // Check if email already exists
        final existingUser = await getUserByEmail(user['email']);
        if (existingUser != null) {
          throw Exception('Email already exists');
        }

        // Insert the user
        final userId = await txn.insert('users', user);
        print('User inserted with ID: $userId');

        // Insert habits if provided
        if (habits != null && habits.isNotEmpty) {
          for (String habit in habits) {
            await txn.insert('user_habits', {
              'user_id': userId,
              'habit': habit,
            });
            print('Habit inserted: $habit for user $userId');
          }
        }

        return userId;
      } catch (e) {
        print('Error inserting user: $e');
        rethrow;
      }
    });
  }

  // Insert single habit for a user
  Future<int> insertUserHabit(int userId, String habit) async {
    final db = await _databaseHelper.database;
    
    try {
      return await db.insert('user_habits', {
        'user_id': userId,
        'habit': habit,
      });
    } catch (e) {
      print('Error inserting user habit: $e');
      rethrow;
    }
  }

  // Insert multiple habits for a user
  Future<void> insertUserHabits(int userId, List<String> habits) async {
    final db = await _databaseHelper.database;
    
    try {
      final batch = db.batch();
      for (String habit in habits) {
        batch.insert('user_habits', {
          'user_id': userId,
          'habit': habit,
        });
      }
      
      await batch.commit();
      print('${habits.length} habits inserted for user $userId');
    } catch (e) {
      print('Error inserting user habits: $e');
      rethrow;
    }
  }

  // Get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await _databaseHelper.database;
    
    try {
      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Error getting user by email: $e');
      return null;
    }
  }

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await _databaseHelper.database;
    
    try {
      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Error getting user by ID: $e');
      return null;
    }
  }

  // Get user habits
  Future<List<String>> getUserHabits(int userId) async {
    final db = await _databaseHelper.database;
    
    try {
      List<Map<String, dynamic>> results = await db.query(
        'user_habits',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return results.map((habit) => habit['habit'] as String).toList();
    } catch (e) {
      print('Error getting user habits: $e');
      return [];
    }
  }

  // Get user with their habits
  Future<Map<String, dynamic>?> getUserWithHabits(int userId) async {
    try {
      // Get user data
      final user = await getUserById(userId);
      if (user == null) return null;
      
      // Get user's habits
      final habits = await getUserHabits(userId);
      
      // Combine user data with habits
      final userData = Map<String, dynamic>.from(user);
      userData['habits'] = habits;
      
      return userData;
    } catch (e) {
      print('Error getting user with habits: $e');
      return null;
    }
  }

  // Get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await _databaseHelper.database;
    
    try {
      return await db.query('users', orderBy: 'created_at DESC');
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }

  // Print users table for debugging
  Future<void> printUsersTable() async {
    try {
      final users = await getAllUsers();
      print('\n=== Users Table Contents ===');
      
      if (users.isEmpty) {
        print('No users found');
        return;
      }
      
      for (var user in users) {
        print('ID: ${user['id']}');
        print('Name: ${user['name']}');
        print('Email: ${user['email']}');
        print('Date of Birth: ${user['date_of_birth']}');
        print('Gender: ${user['gender']}');
        print('Created at: ${user['created_at']}');
        
        // Get and print user habits
        final habits = await getUserHabits(user['id']);
        if (habits.isNotEmpty) {
          print('Habits: ${habits.join(', ')}');
        } else {
          print('Habits: None');
        }
        print('------------------------');
      }
      print('Total users: ${users.length}\n');
    } catch (e) {
      print('Error printing users table: $e');
    }
  }

  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return {
          'success': false,
          'user': null,
          'message': 'Email and password are required'
        };
      }

      final db = await _databaseHelper.database;
      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (results.isNotEmpty) {
        final user = results.first;
        currentUser.value = user;
        isLoggedIn.value = true;
        
        // Get user habits
        final habits = await getUserHabits(user['id']);
        currentUser['habits'] = habits;
        
        Get.offNamed('/dashboard');
        print('Login successful for user: ${user['email']}');
        
        return {
          'success': true,
          'user': user,
          'message': 'Login successful'
        };
      } else {
        print('Login failed: Invalid credentials');
        return {
          'success': false,
          'user': null,
          'message': 'Invalid email or password'
        };
      }
    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        'user': null,
        'message': 'An error occurred during login: ${e.toString()}'
      };
    }
  }

  // Logout method
  Future<void> logout() async {
    currentUser.clear();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
    print('User logged out successfully');
  }

  // Update password
  Future<Map<String, dynamic>> updatePassword(String email, String newPassword) async {
    try {
      if (email.isEmpty || newPassword.isEmpty) {
        return {'success': false, 'message': 'Email and password are required'};
      }

      final user = await getUserByEmail(email);
      if (user == null) {
        return {'success': false, 'message': 'User not found'};
      }

      final db = await _databaseHelper.database;
      int updateRows = await db.update(
        'users',
        {'password': newPassword},
        where: 'email = ?',
        whereArgs: [email]
      );

      if (updateRows > 0) {
        print('Password updated for user: $email');
        return {'success': true, 'message': 'Password updated successfully'};
      } else {
        return {'success': false, 'message': 'Failed to update password'};
      }
    } catch (e) {
      print('Update password error: $e');
      return {'success': false, 'message': 'An error occurred: ${e.toString()}'};
    }
  }

  // Update user habits
  Future<bool> updateUserHabits(int userId, List<String> newHabits) async {
    final db = await _databaseHelper.database;
    
    try {
      await db.transaction((txn) async {
        // Delete existing habits
        await txn.delete(
          'user_habits',
          where: 'user_id = ?',
          whereArgs: [userId],
        );
        
        // Insert new habits
        for (String habit in newHabits) {
          await txn.insert('user_habits', {
            'user_id': userId,
            'habit': habit,
          });
        }
      });
      
      print('Habits updated for user $userId');
      return true;
    } catch (e) {
      print('Error updating user habits: $e');
      return false;
    }
  }

  // Delete user and their habits (cascade delete)
  Future<bool> deleteUser(int userId) async {
    final db = await _databaseHelper.database;
    
    try {
      await db.transaction((txn) async {
        // Delete user habits first
        await txn.delete(
          'user_habits',
          where: 'user_id = ?',
          whereArgs: [userId],
        );
        
        // Delete user
        await txn.delete(
          'users',
          where: 'id = ?',
          whereArgs: [userId],
        );
      });
      
      print('User $userId deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  // Get current user habits
  List<String> getCurrentUserHabits() {
    if (currentUser.containsKey('habits')) {
      return List<String>.from(currentUser['habits']);
    }
    return [];
  }

  // Check if email exists
  Future<bool> emailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }
}