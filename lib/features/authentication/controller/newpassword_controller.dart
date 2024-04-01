import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';

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

  String? validatePassword(String? password) {
    if (password == null) {
      return "Password can not be empty";
    }
    return null;
  }

  void signUpWithEmailAndPassword(
      {required String email, required String password}) {
    if (formKey.currentState!.validate()) {
      AuthController.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    }
  }
}
