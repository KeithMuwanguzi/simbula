import 'package:get/get.dart';
import 'package:some_ride/features/authentication/controller/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    ;
  }
}
