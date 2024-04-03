import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String selected = "Male";

  var isVisible = true.obs;

  changeVisibility() {
    isVisible.value = !isVisible.value;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email can not be empty';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp reg = RegExp(pattern);
    if (!reg.hasMatch(email)) {
      return 'Invalid Email format';
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
