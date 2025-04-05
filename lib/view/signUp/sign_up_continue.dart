import 'package:flutter/material.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';

class SignUpContinue extends StatelessWidget {
  const SignUpContinue({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final controller = Get.find<TextController>();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
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
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              Get.toNamed('/gender');
            }
          },
        ),
      ),
    );
  }
}
