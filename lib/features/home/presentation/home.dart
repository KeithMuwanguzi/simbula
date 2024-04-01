import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/styles/colors.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/home/presentation/selected_car.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeView extends GetView<ControllerHome> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                buildAvailableCars(),
                buildTopDeals(),
                buildTopDealers(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 22),
          CarImagesWidget(images: controller.displayCar.images),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CarNameWidget(
                  model: controller.displayCar.model,
                  brand: controller.displayCar.brand,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "My Recents",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 23,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 90,
            child: Stack(
              children: [
                CircularStepProgressIndicator(
                  padding: 0,
                  currentStep: 78,
                  totalSteps: 100,
                  selectedStepSize: 4,
                  width: 80,
                  height: 80,
                  startingAngle: 2.3,
                  selectedColor: Colors.yellow[600],
                  unselectedColor: Colors.white,
                  roundedCap: (_, __) => true,
                  child: const Center(
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundImage:
                          AssetImage("assets/images/users/passport.jpg"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: badges.Badge(
                    shape: badges.BadgeShape.square,
                    animationType: badges.BadgeAnimationType.scale,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2.2),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    badgeColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(13),
                    elevation: 0,
                    badgeContent: const Text(
                      "Gold",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2, right: 3),
                      child: Text(
                        "IDR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    Text(
                      "17,7jt",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 23,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAvailableCars() {
    return GestureDetector(
      onTap: () => Get.toNamed('/available-cars'),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(24),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Available Cars",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Long term and short term",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopDeals() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOP DEALS",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed('/available-cars'),
                child: Row(
                  children: [
                    Text(
                      "More",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: controller.cars
                .map((car) => GestureDetector(
                    onTap: () => Get.to(
                          () => SelectedCar(
                            brand: car.brand,
                            model: car.model,
                            price: car.price,
                            condition: car.condition,
                            images: car.images,
                          ),
                        ),
                    child: buildCar(car, controller.cars.indexOf(car))))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildTopDealers() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOP DEALERS",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              GestureDetector(
                // onTap: () => Get.toNamed(Routes.UPCOMING),
                child: Row(
                  children: [
                    Text(
                      "More",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: controller.dealers
                .map((dealer) =>
                    buildDealer(dealer, controller.dealers.indexOf(dealer)))
                .toList(),
          ),
        ),
      ],
    );
  }
}
