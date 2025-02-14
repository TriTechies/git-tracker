import 'package:flutter/material.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/model/user.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';

import '../../db/database_helper.dart';

class SignUpContinue extends StatelessWidget {
  const SignUpContinue({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final controller = Get.find<TextController>();
    final serviceController = Get.find<DatabaseHelper>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustomTextField(
                  height: 20,
                  hintText: "Please enter your email",
                  width: 345,
                  type: TextInputType.emailAddress,
                  obsured: false,
                  controller: controller.signUpEmail,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustomTextField(
                  height: 20,
                  hintText: "Please enter your password",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: true,
                  controller: controller.signUpPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustomTextField(
                  height: 20,
                  hintText: "Please enter your password again",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: true,
                  controller: controller.signUpConfroimPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password again';
                    }

                    if (controller.signUpPassword.text !=
                        controller.signUpConfroimPassword.text) {
                      return 'Please enter the same password';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MyButton(
          name: "Next",
          height: 52,
          width: 345,
          color: Colors.blue,
          route: () async {
            if (formKey.currentState?.validate() ?? false) {
              try {
                final userData = {
                  'name':
                      '${controller.name.text} ${controller.surname.text}',
                  'email': controller.signUpEmail.text,
                  'password': controller.signUpPassword.text,
                  'date_of_birth': controller.dateofBirth.text,
                };

                final userId = await serviceController.insertUser(userData);
                print('User created with ID: $userId');

                // Print the entire users table
                await serviceController.printUsersTable();

                Get.toNamed('/gender');
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
          },
        ),
      ),
    );
  }
}
