import 'package:get/get.dart';
import 'package:some_ride/features/home/services/export.dart';

import '../model/export.dart';

class ControllerHome extends GetxController {
  List<Car> cars = [];
  List<Dealer> dealers = [];
  late Car displayCar;

  int length = 0;

  @override
  void onInit() {
    super.onInit();
    cars = CarService().getCarList();
    dealers = DealerService().getDealerList();
    displayCar = cars[4];
    length = cars.length;
  }
}
