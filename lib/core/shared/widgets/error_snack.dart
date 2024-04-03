import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar({required String title, required String text}) {
  Get.snackbar(
    title,
    text,
    snackPosition: SnackPosition.BOTTOM,
    isDismissible: false,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(days: 1),
    icon: const Icon(
      Icons.wifi_off,
      color: Colors.white,
    ),
  );
}
