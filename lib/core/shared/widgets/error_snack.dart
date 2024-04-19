import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(
    {required Duration duration,
    required IconData icon,
    required String title,
    required String text}) {
  Get.snackbar(
    title,
    text,
    snackPosition: SnackPosition.BOTTOM,
    isDismissible: false,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: duration,
    icon: Icon(
      icon,
      color: Colors.white,
    ),
  );
}

successSnackBar(
    {required Duration duration,
    required IconData icon,
    required String title,
    required String text}) {
  Get.snackbar(
    title,
    text,
    snackPosition: SnackPosition.BOTTOM,
    isDismissible: false,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    duration: duration,
    icon: Icon(
      icon,
      color: Colors.white,
    ),
  );
}
