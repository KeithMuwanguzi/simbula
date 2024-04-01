import 'package:get/get.dart';
import 'package:some_ride/features/home/services/connectivity_plus.dart';

class InternetBinding {
  static void init() {
    Get.put<ConnectionController>(ConnectionController(), permanent: true);
  }
}
