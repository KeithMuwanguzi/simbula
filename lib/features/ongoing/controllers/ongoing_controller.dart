import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/error_snack.dart';
import 'package:some_ride/database/firebase_constants.dart';

class OnGoingController extends GetxController {
  final _databaseReference = FirebaseDatabase.instance.ref();

  late String uid;

  int length = 0;

  @override
  void onInit() {
    super.onInit();

    uid = auth.currentUser!.uid;
  }

  Future<void> returnOrder(String carId, String ownerId) async {
    try {
      await _databaseReference
          .child('ongoing_orders')
          .child(uid)
          .child(carId)
          .once()
          .then((event) async {
        var carData = event.snapshot.value;

        if (carData == null) {
          errorSnackBar(
            duration: const Duration(seconds: 10),
            icon: Icons.error,
            title: 'Order Doesn\'t exist',
            text: "That Order doesn't exist",
          );
        } else {
          _databaseReference
              .child('history')
              .child(uid)
              .child(carId)
              .set(carData);

          _databaseReference
              .child('ongoing_orders')
              .child(uid)
              .child(carId)
              .remove();
          successSnackBar(
            duration: const Duration(seconds: 3),
            icon: Icons.check_rounded,
            title: 'SUCCESS',
            text: 'Removed successfully',
          );
        }
      });
    } catch (error) {
      errorSnackBar(
        duration: const Duration(seconds: 10),
        icon: Icons.error,
        title: 'Failed to clear Order',
        text: error.toString(),
      );
    }
  }
}
