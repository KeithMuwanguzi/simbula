import 'package:get/get.dart';
import 'package:some_ride/features/home/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    ;
  }
}
