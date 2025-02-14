import 'package:flutter/material.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';

import '../../db/database_helper.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final controller = Get.find<TextController>();
    final serviceController = Get.find<DatabaseHelper>();

    // Add Rx variable for message
    final RxString message = ''.obs;
    final RxBool isError = false.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: defaultstyle(
              fontFamily: "Segoe UI", size: 24, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                  controller: controller.forgotPasswordEmail,
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
                  hintText: "Please enter your New  password",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: true,
                  controller: controller.forgotPasswordNewPassword,
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
                  hintText: "Please enter your Updated password again",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: true,
                  controller: controller.forgotPasswordNewPasswordConfirm,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Updated password again';
                    }

                    if (controller.forgotPasswordNewPassword.text !=
                        controller.forgotPasswordNewPasswordConfirm.text) {
                      return 'Please enter the same password';
                    }

                    return null;
                  },
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: message.value.isNotEmpty
                        ? Text(
                            message.value,
                            style: TextStyle(
                              color: isError.value ? Colors.red : Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox.shrink(),
                  )),
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
              print('Attempting to update password...');

              var result = await serviceController.updatePassword(
                  controller.forgotPasswordEmail.text,
                  controller.forgotPasswordNewPassword.text);

              print('Update Password Result: $result');
              print('Success: ${result['success']}');
              print('Message: ${result['message']}');

              // Update message and isError
              message.value = result['message'].toString();
              isError.value = !result['success'];

              if (result['success']) {
                // Wait for a moment to show success message before going back
                await Future.delayed(const Duration(seconds: 2));
                Get.back();
              }
            }
          },
        ),
      ),
    );
  }
}
