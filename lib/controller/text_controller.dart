import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController {
  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController dateofBirth = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpConfroimPassword = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();
  TextEditingController forgotPasswordNewPassword = TextEditingController();
  TextEditingController forgotPasswordNewPasswordConfirm =
      TextEditingController();
  var isSelected = false.obs;
  final RxBool loginError = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}
