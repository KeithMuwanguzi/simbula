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
    if (email == null) {
      return "Email can not be empty";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null) {
      return "Password can not be empty";
    }
    return null;
  }
}
