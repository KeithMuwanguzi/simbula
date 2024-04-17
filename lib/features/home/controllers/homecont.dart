import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/database/firebase_constants.dart';
import 'package:some_ride/features/home/services/export.dart';

import '../model/export.dart';

class ControllerHome extends GetxController {
  List<Car> cars = [];
  List<Dealer> dealers = [];
  late Car displayCar;
  late String uid;

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

  Future<void> addCartoDB({
    required String uid,
    required String brand,
    required String model,
    required String price,
    required String condition,
    required String transmission,
    required String maxSpeed,
    required String engine,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('cars').doc(uid).set({
        'brand': brand,
        'model': model,
        'price': price,
        'condition': condition,
        'transmission': transmission,
        'maxSpeed': maxSpeed,
        'engine': engine,
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
