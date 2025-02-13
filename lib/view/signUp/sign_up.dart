import 'package:flutter/material.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/view/style/style.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import 'package:git_tracker/view/widgets/text_fields.dart';
class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
          "Create Account",
          style: defaultstyle(
              fontFamily: "Segoe UI", size: 24, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
             
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CustomTextField(
                height: 20,
                hintText: "Name",
                width: 345,
                type: TextInputType.emailAddress,
                obsured: false,
                controller: controller.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CustomTextField(
                height: 20,
                hintText: "SURNAME",
                width: 345,
                type: TextInputType.visiblePassword,
                obsured: true,
                controller: controller.surname,
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CustomTextField(
                height: 20,
                hintText: "02/02/2025",
                width: 345,
                type: TextInputType.visiblePassword,
                obsured: true,
                controller: controller.dateofBirth,
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
            Get.toNamed('/gender');
          },
        ),
      ),
    );
  }
}
