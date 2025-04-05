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
                    hintText: "Name",
                    width: 345,
                    type: TextInputType.emailAddress,
                    obsured: false,
                    controller: controller.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Name';
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
                  hintText: "SURNAME",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: false,
                  controller: controller.surname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Surname';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustomTextField(
                  height: 20,
                  hintText: "02/02/2025",
                  width: 345,
                  type: TextInputType.visiblePassword,
                  obsured: false,
                  controller: controller.dateofBirth,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }

                    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                    if (!dateRegex.hasMatch(value)) {
                      return 'Enter a valid date in DD/MM/YYYY format';
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
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              Get.toNamed('/signupcontinue');
            }
          },
        ),
      ),
    );
  }
}
