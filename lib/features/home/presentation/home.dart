import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/core/shared/widgets/number_format.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/features/history/presentation/history.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/home/presentation/available.dart';
import 'package:some_ride/features/profile/controllers/profile_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeView extends GetView<ControllerHome> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final newController = Get.find<ProfileController>();
    final carController = AuthController.instance;
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
                Obx(
                  () => buildHeader(
                    context,
                    newController.profilePath.value,
                    carController,
                  ),
                ),
                buildAvailableCars(context),
                buildTopDeals(context),
                buildTopDealers(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, String image, carController) {
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
          _buildAppBar(context, image, carController),
          const SizedBox(height: 22),
          carController.ongoingList.length == 0
              ? CarImagesWidget(images: controller.displayCar.images)
              : CarImageWidget(
                  image: carController.ongoingList[0].imageUrl,
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                carController.ongoingList.length == 0
                    ? CarNameWidget(
                        model: controller.displayCar.model,
                        brand: controller.displayCar.brand,
                      )
                    : CarNameWidget(
                        model: carController.ongoingList[0].model,
                        brand: carController.ongoingList[0].brand,
                      ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => const History());
                        },
                        child: Text(
                          "My Recents",
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Theme.of(context).primaryColor,
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

  Widget _buildAppBar(BuildContext context, String imagePath, carController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: SizedBox(
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
                    child: Center(
                      child: imagePath == ''
                          ? const CircleAvatar(
                              maxRadius: 30,
                              child: Icon(Icons.image),
                            )
                          : CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: NetworkImage(imagePath),
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
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                      badgeColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(13),
                      elevation: 0,
                      badgeContent: Text(
                        "Gold",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, right: 3),
                      child: Text(
                        "UGX",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    carController.ongoingList.length == 0
                        ? Text(
                            formatSecondOption(controller.displayCar.price),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            carController.ongoingList[0].price,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                    color: Theme.of(context).primaryColor,
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

  Widget buildAvailableCars(context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/available-cars'),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(20),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Available Cars",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Long term and short term",
                    style: GoogleFonts.roboto(
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
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopDeals(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOP DEALS",
                style: GoogleFonts.poppins(
                  fontSize: 20,
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
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 282,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: controller.cars
                .map((car) => GestureDetector(
                    onTap: () => Get.to(
                          () => const AvailableCars(),
                        ),
                    child:
                        buildCar(context, car, controller.cars.indexOf(car))))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildTopDealers(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOP DEALERS",
                style: GoogleFonts.poppins(
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
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Theme.of(context).primaryColor,
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
