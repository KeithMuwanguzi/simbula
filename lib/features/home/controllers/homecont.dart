import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/error_snack.dart';
import 'package:some_ride/database/firebase_constants.dart';
import 'package:some_ride/features/home/model/car_model.dart';
import 'package:some_ride/features/home/services/export.dart';

import '../model/export.dart';

class ControllerHome extends GetxController {
  final databaseReference = FirebaseDatabase.instance.ref().child('users');
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  List<Car> cars = [];
  List<Dealer> dealers = [];
  late Car displayCar;
  late String uid;

  var userName = ''.obs;
  var userContact = ''.obs;

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

  Future<void> placeOrder(String carId, String ownerId) async {
    try {
      await _databaseReference
          .child('cars')
          .child(ownerId)
          .child(carId)
          .once()
          .then((event) async {
        var carData = event.snapshot.value;
        await _databaseReference
            .child('ongoing_orders')
            .child(uid)
            .once()
            .then((snap) {
          var data = snap.snapshot.value;
          if (data != null) {
            errorSnackBar(
              duration: const Duration(seconds: 10),
              icon: Icons.error,
              title: 'Failed to place Order',
              text: "There is/are existing order(s), Clear to make new order.",
            );
          } else {
            _databaseReference
                .child('ongoing_orders')
                .child(uid)
                .child(carId)
                .set(carData);
            _databaseReference
                .child('ongoing_orders')
                .child(uid)
                .child(carId)
                .update({
              'isPaid': false,
            });

            _databaseReference
                .child('cars')
                .child(ownerId)
                .child(carId)
                .remove();
            successSnackBar(
              duration: const Duration(seconds: 3),
              icon: Icons.check_rounded,
              title: 'SUCCESS',
              text: 'Rented Successfully',
            );
          }
        });
      });
    } catch (error) {
      errorSnackBar(
        duration: const Duration(seconds: 10),
        icon: Icons.error,
        title: 'Failed to place Order',
        text: error.toString(),
      );
    }
  }

  String? fetchUserName(uid) {
    try {
      databaseReference.child(uid).once().then((snap) {
        if (snap.snapshot.value != null) {
          Map<dynamic, dynamic>? userDetails =
              snap.snapshot.value as Map<dynamic, dynamic>?;
          userName.value = userDetails!['name'];
        }
        return userName.value;
      });
    } catch (e) {
      errorSnackBar(
        duration: const Duration(seconds: 2),
        icon: Icons.error,
        title: 'Error Occured',
        text: e.toString(),
      );
    }
    return userName.value;
  }

  String? fetchUserContact(uid) {
    try {
      databaseReference.child(uid).once().then((snap) {
        if (snap.snapshot.value != null) {
          Map<dynamic, dynamic>? userDetails =
              snap.snapshot.value as Map<dynamic, dynamic>?;
          userContact.value = userDetails!['phoneNumber'];
        }
        return userContact.value;
      });
    } catch (e) {
      errorSnackBar(
        duration: const Duration(seconds: 2),
        icon: Icons.error,
        title: 'Error Occured',
        text: e.toString(),
      );
    }
    return userContact.value;
  }
}
