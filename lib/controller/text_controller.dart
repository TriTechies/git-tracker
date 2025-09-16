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
  
  // Changed from index-based to name-based selection
  final selectedCards = <String, RxBool>{}.obs;
  final isInSelectionMode = false.obs;
  final RxBool loginError = false.obs;

  void toggleSelection(String cardName) {
    if (!isInSelectionMode.value) {
      isInSelectionMode.value = true;
    }
    
    // Initialize the card if it doesn't exist
    if (!selectedCards.containsKey(cardName)) {
      selectedCards[cardName] = false.obs;
    }
    
    // Toggle the selection
    selectedCards[cardName]!.value = !selectedCards[cardName]!.value;

    // Exit selection mode if no cards are selected
    if (!selectedCards.values.any((card) => card.value)) {
      isInSelectionMode.value = false;
    }
  }

  bool isCardSelected(String cardName) {
    return selectedCards[cardName]?.value ?? false;
  }
  List<String> getSelectedCardNames() {
    return selectedCards.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();
  }
}