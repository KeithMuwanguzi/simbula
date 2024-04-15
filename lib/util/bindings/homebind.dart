import 'package:get/get.dart';
import 'package:some_ride/features/home/controllers/home_controller.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/profile/controllers/profile_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ControllerHome>(() => ControllerHome());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
