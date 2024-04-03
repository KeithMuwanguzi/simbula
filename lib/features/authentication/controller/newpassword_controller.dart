import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String selected = "Male";

  var isVisible = true.obs;
  var isConfirmVisible = true.obs;

  changeVisibility() {
    isVisible.value = !isVisible.value;
  }

  changeConfirmVisibility() {
    isConfirmVisible.value = !isConfirmVisible.value;
  }

  String? validateConfirmPassword(String? pass) {
    if (password.text != confirmPassword.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 8) {
      return "Password is too short";
    }
    return null;
  }
}
