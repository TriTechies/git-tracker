import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TextController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Continue with E-mail",
          style: defaultstyle(
              fontFamily: "Segoe UI", size: 24, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
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
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {},
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
                onPressed: () {},
                child: const Text("Don’t have an account? Let’s create!"),
              ),
            ),
          ],
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
            Get.toNamed('/signup');
          },
        ),
      ),
    );
  }
}
