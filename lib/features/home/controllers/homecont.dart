import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/error_snack.dart';
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
    fetchCars();
  }

  void fetchCars() {
    try {
      databaseReference.onValue.listen((event) {
        final List<CarModel> fetchedCars = [];
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? carsMap =
              event.snapshot.value as Map<dynamic, dynamic>?;
          carsMap?.forEach((userID, userCars) {
            userCars.forEach((licensePlate, value) {
              fetchedCars.add(
                CarModel(
                  id: value['licensePlate'],
                  ownerId: value['id'],
                  brand: value['brand'],
                  model: value['model'],
                  transmission: value['transmission'],
                  imageUrl: value['imagePath'] ?? "",
                  maxSpeed: value['maxSpeed'],
                  price: value['price'],
                  availability: value['availability'] ?? "",
                ),
              );
            });
          });
        }
        carsList.value = fetchedCars;
        print(fetchedCars);
      });
    } catch (e) {
      errorSnackBar(
        duration: const Duration(seconds: 2),
        icon: Icons.error,
        title: 'Error Occured',
        text: e.toString(),
      );
    }
  }
}
