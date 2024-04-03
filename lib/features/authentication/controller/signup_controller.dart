import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  Rx<String> selected = "Male".obs;
  Rx<String> userType = "Driver".obs;

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

  String? validateField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Field can not be empty';
    }

    return null;
  }
}
