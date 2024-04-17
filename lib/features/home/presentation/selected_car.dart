import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/number_format.dart';
import 'package:some_ride/features/ongoing/presentation/ongoing.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/home/model/car.dart';

import '../../../core/shared/widgets/export.dart';

class SelectedCar extends GetView<ControllerHome> {
  final Car car;
  const SelectedCar({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
            ],
          ),
        ),
      ),
    ));
  }

  buildHeader(BuildContext context) {
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
          AppBarWidget(
            title: "",
            isBackButton: true,
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.upload,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 22),
          CarImagesWidget(images: car.images),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CarNameWidget(
                  model: car.model,
                  brand: car.brand,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSpecs(
                  context,
                  'Engine',
                  Icons.engineering,
                  car.engine,
                ),
                buildSpecs(
                  context,
                  'Max Speed',
                  Icons.speed,
                  '${car.maxSpeed.toString()} KPH',
                ),
                buildSpecs(
                  context,
                  'Transmission',
                  Icons.mediation,
                  car.transmission,
                ),
                buildSpecs(
                  context,
                  'Recharge',
                  car.recharge ? Icons.electric_bolt : Icons.gas_meter,
                  car.recharge ? 'Electric' : 'Fuel',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  'Price: ',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatNumber(car.price),
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                Text(
                  ' @ ${car.condition}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue[800]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Book Later',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.addCartoDB(
                      uid: controller.uid,
                      brand: car.brand,
                      model: car.model,
                      price: car.price.toString(),
                      condition: car.condition,
                      transmission: car.transmission,
                      maxSpeed: car.maxSpeed.toString(),
                      engine: car.engine,
                    );
                    Get.to(() => const OnGoing());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[800]!,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Order Now',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildSpecs(context, String s, IconData icon, String u) {
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(height: 5),
          TextWidget(text: s, size: 12),
          TextWidget(
            text: u,
            size: 10,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
