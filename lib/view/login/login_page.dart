import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/db/helpers/users_dao.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final controller = Get.find<TextController>();
    final serviceController = Get.find<UsersDao>();

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
          "Continue with E-mail",
          style: defaultstyle(
            fontFamily: "Segoe UI",
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Added spacing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  height: 20,
                  hintText: "E-mail",
                  width: 345,
                  type: TextInputType.emailAddress,
                  obsured: false,
                  controller: controller.emailLogin,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  height: 20,
                  hintText: "Password",
                  showPasswordToggle: true,
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: true,
                  controller: controller.passwordLogin,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Obx(() => controller.loginError.value
                  ? const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 40.0),
                        child: Text(
                          'Invalid email or password',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('/forgotpassword');
                    },
                    child: Text(
                      "I forgot my password",
                      style: fontWeightStyle(
                        fontFamily: "Segoe UI",
                        size: 14,
                        color: Colors.grey,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('/signup');
                  },
                  child: const Text("Don't have an account? Let's create!"),
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
          color: Colors.blue,
          onPressed: () async {
            controller.loginError.value = false;
            if (formKey.currentState?.validate() ?? false) {
              var result = await serviceController.login(
                  controller.emailLogin.text, controller.passwordLogin.text);
              if (!result['success']) {
                controller.loginError.value = true;
                formKey.currentState?.validate();
              }
            }
            serviceController.printUsersTable();
          },
        ),
      ),
    );
  }
}
