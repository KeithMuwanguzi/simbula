import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  static var goAhead = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      goAhead.value = false;
      Get.snackbar(
        'No Internet Connection',
        'Please check your internet connection and try again',
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
    } else {
      if (Get.isSnackbarOpen) {
        goAhead.value = true;
        Get.closeCurrentSnackbar();
      }
    }
  }
}
