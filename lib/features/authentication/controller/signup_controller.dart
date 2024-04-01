import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  String selected = "Male";

  String? validateEmail(String? email) {
    if (email == null) {
      return "Email can not be empty";
    }
    return null;
  }
}
