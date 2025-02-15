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
  final selectedCards = [
    false.obs,
    false.obs
  ]; 
  final isInSelectionMode = false.obs;
  final RxBool loginError = false.obs;

  void toggleSelection(int index) {
    if (!isInSelectionMode.value) {
      isInSelectionMode.value = true;
    }
    selectedCards[index].value = !selectedCards[index].value;

    
    if (!selectedCards.any((card) => card.value)) {
      isInSelectionMode.value = false;
    }
  }
}
