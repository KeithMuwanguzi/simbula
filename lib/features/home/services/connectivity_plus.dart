import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/export.dart';

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
      errorSnackBar(
          duration: const Duration(days: 2),
          icon: Icons.wifi_off,
          title: 'No Internet Connection',
          text: 'Please check your internet connection and try again');
    } else {
      if (Get.isSnackbarOpen) {
        goAhead.value = true;
        Get.closeCurrentSnackbar();
      }
    }
  }
}
