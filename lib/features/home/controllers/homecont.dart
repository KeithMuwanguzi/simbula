import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:some_ride/database/firebase_constants.dart';
import 'package:some_ride/features/home/model/car_model.dart';
import 'package:some_ride/features/home/services/export.dart';

import '../model/export.dart';

class ControllerHome extends GetxController {
  final databaseReference = FirebaseDatabase.instance.ref().child('cars');
  List<Car> cars = [];
  List<Dealer> dealers = [];
  late Car displayCar;
  late String uid;

  RxList<CarModel> carsList = <CarModel>[].obs;

  int length = 0;

  @override
  void onInit() {
    super.onInit();
    cars = CarService().getCarList();
    dealers = DealerService().getDealerList();
    displayCar = cars[3];
    length = cars.length;
    uid = auth.currentUser!.uid;
  }
}
