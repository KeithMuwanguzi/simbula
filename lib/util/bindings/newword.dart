import 'package:get/get.dart';
import 'package:some_ride/features/authentication/controller/newpassword_controller.dart';

class NewPassBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordController>(() => NewPasswordController());
  }
}
