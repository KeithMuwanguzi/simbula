import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(
    {required IconData icon, required String title, required String text}) {
  Get.snackbar(
    title,
    text,
    snackPosition: SnackPosition.BOTTOM,
    isDismissible: false,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(days: 1),
    icon: Icon(
      icon,
      color: Colors.white,
    ),
  );
}
