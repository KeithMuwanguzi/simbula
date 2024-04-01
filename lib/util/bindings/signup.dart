import 'package:get/get.dart';
import 'package:some_ride/features/authentication/controller/signup_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
    ;
  }
}
