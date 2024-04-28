import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/error_snack.dart';
import 'package:some_ride/database/firebase_constants.dart';

class OnGoingController extends GetxController {
  final _databaseReference = FirebaseDatabase.instance.ref();

  late String uid;
  final RxInt remainingMinutes = 0.obs;

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

  int hoursInDay = 24;
  int daysInWeek = 7;
  int daysInMonth = 30;

  int convertToHours(String period, {int quantity = 1}) {
    switch (period.toLowerCase()) {
      case 'hourly':
        return quantity;
      case 'daily':
        return quantity * hoursInDay;
      case 'weekly':
        return quantity * daysInWeek * hoursInDay;
      case 'monthly':
        return quantity * daysInMonth * hoursInDay;
      case 'annualy':
        return quantity * 365 * hoursInDay;
      default:
        throw Exception('Unsupported period: $period');
    }
  }

  Future<void> cancelOrder(String carId, String ownerId) async {
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
              .child('cars')
              .child(ownerId)
              .child(carId)
              .set(carData);
          _databaseReference
              .child('ongoing_orders')
              .child(uid)
              .child(carId)
              .remove();

          // final returnDate =
          //     DateTime.now().add(Duration(hours: convertToHours(period)));
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

  void startCountdown(String period, databaseRef, String carId) {
    int totalMinutes = convertToHours(period) * 60;
    remainingMinutes.value = totalMinutes;

    updateDatabaseTimerValue(remainingMinutes.value, databaseRef, carId);

    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (remainingMinutes.value > 0) {
        remainingMinutes.value--;

        updateDatabaseTimerValue(remainingMinutes.value, databaseRef, carId);
      } else {
        timer.cancel();
      }
    });
  }

  void updateDatabaseTimerValue(int value, databaseReference, String carId) {
    databaseReference
        .child('ongoing_orders')
        .child(uid)
        .child(carId)
        .update({'timer_value': value});
  }

  Future<void> payOrder(String carId, String ownerId, String period) async {
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
              .child('ongoing_orders')
              .child(uid)
              .child(carId)
              .update({'isPaid': true});

          startCountdown(period, _databaseReference, carId);

          successSnackBar(
            duration: const Duration(seconds: 3),
            icon: Icons.attach_money,
            title: 'SUCCESS',
            text: 'Order Paid successfully',
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
