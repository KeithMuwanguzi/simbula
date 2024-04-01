import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/features/home/controllers/home_controller.dart';
import 'package:some_ride/features/home/presentation/car_pool.dart';
import 'package:some_ride/features/home/presentation/home.dart';

class TogglePages extends StatelessWidget {
  const TogglePages({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              homeController.isRenting.value ? 'Rent a Car' : 'Share a Ride'),
        ),
        actions: [
          IconButton(
            onPressed: () => homeController.toggleRenting(),
            icon: Obx(
              () => Icon(
                homeController.isRenting.value
                    ? Icons.switch_left_rounded
                    : Icons.switch_right_rounded,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => homeController.isRenting.value
            ? const HomeView()
            : const CarPoolHome(),
      ),
    );
  }
}
