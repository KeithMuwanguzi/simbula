import 'package:get/get.dart';
import 'package:some_ride/features/authentication/controller/login_controller.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ControllerHome>(() => ControllerHome());
    ;
  }
}
