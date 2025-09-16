import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/db/helpers/users_dao.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:git_tracker/view/widgets/my_card_row.dart';

import '../widgets/my_button.dart';

class HabitsOptions extends StatelessWidget {
  const HabitsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TextController>();
    final serviceController = Get.find<UsersDao>();
   
    void handleCreateUser() async {
      try {
    
        final selectedHabits = controller.getSelectedCardNames();
        
        final selectedGenders = controller.selectedCards.entries
            .where((entry) => entry.value.value && (entry.key == 'Male' || entry.key == 'Female'))
            .map((entry) => entry.key)
            .toList();
        final selectedGender = selectedGenders.isNotEmpty 
            ? selectedGenders.first 
            : 'Not specified';

        final userData = {
          'name': '${controller.name.text} ${controller.surname.text}',
          'email': controller.signUpEmail.text,
          'password': controller.signUpPassword.text,
          'date_of_birth': controller.dateofBirth.text,
          'gender': selectedGender,
        };

        final userId = await serviceController.insertUser(userData, habits: selectedHabits);
        print('User created with ID: $userId');
        print('Selected habits: $selectedHabits');

        await serviceController.printUsersTable();

        Get.toNamed('/dashboard'); 
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Create Account",
          style: defaultstyle(
              fontFamily: "Segoe UI", size: 24, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Choose your first habits",
                style: defaultstyle(
                    fontFamily: "Segoe UI", size: 20, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "You may add more habits later or skip this step",
                style: defaultstyle(
                    fontFamily: "Segoe UI", size: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            
            // First row: Drink Water & Run
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyCardRow(
                      image: "water",
                      text: "Drink Water",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MyCardRow(
                      image: "run",
                      text: "Run",
                    ),
                  ),
                ],
              ),
            ),
            
            // Second row: Read Books & Meditate
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyCardRow(
                      image: "book",
                      text: "Read Books",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MyCardRow(
                      image: "meditate",
                      text: "Meditate",
                    ),
                  ),
                ],
              ),
            ),
            
            // Third row: Study & Journal
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyCardRow(
                      image: "study",
                      text: "Study",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MyCardRow(
                      image: "journal",
                      text: "Journal",
                    ),
                  ),
                ],
              ),
            ),
            
            // Fourth row: Grow Plants & Sleep
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyCardRow(
                      image: "plant",
                      text: "Grow Plants",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MyCardRow(
                      image: "sleep",
                      text: "Sleep",
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          final selectedHabits = controller.getSelectedCardNames();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            
              MyButton(
                name: selectedHabits.isNotEmpty ? "Create Account" : "Create Account (No Habits)",
                onPressed: handleCreateUser,
              ),
              
              // Skip Button
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  try {
                    final selectedGenders = controller.selectedCards.entries
                        .where((entry) => entry.value.value && (entry.key == 'Male' || entry.key == 'Female'))
                        .map((entry) => entry.key)
                        .toList();
                    final selectedGender = selectedGenders.isNotEmpty 
                        ? selectedGenders.first 
                        : 'Not specified';

                    final userData = {
                      'name': '${controller.name.text} ${controller.surname.text}',
                      'email': controller.signUpEmail.text,
                      'password': controller.signUpPassword.text,
                      'date_of_birth': controller.dateofBirth.text,
                      'gender': selectedGender,
                    };

                    // Create user without habits
                    final userId = await serviceController.insertUser(userData);
                    print('User created with ID: $userId (No habits selected)');

                    await serviceController.printUsersTable();

                    Get.toNamed('/dashboard');
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(
                  "Skip for now",
                  style: defaultstyle(
                    fontFamily: "Segoe UI",
                    size: 16,
                    color: Colors.grey[600]!
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}