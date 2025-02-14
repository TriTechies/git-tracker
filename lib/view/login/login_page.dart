import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';
import 'package:git_tracker/db/database_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          "Continue with E-mail",
          style: defaultstyle(
              fontFamily: "Segoe UI", size: 24, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomTextField(
                  height: 20,
                  hintText: "Password",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: true,
                  controller: controller.passwordLogin,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('/signup');
                  },
                  child: const Text("Don’t have an account? Let’s create!"),
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
          route: () {
            if (formKey.currentState?.validate() ?? false) {
              serviceController.login(
                  controller.emailLogin.text, controller.passwordLogin.text);
            }
          },
        ),
      ),
    );
  }
}
