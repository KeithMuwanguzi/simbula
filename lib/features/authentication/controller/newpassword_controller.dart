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

  String? validateEmail(String? email) {
    if (email == null) {
      return "Email can not be empty";
    }
    return null;
  }
}
