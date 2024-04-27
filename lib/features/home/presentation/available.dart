import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/home/model/car_model.dart';
import 'package:some_ride/features/home/presentation/selected_car.dart';

class AvailableCars extends GetView<ControllerHome> {
  final bool isBackAvailable;
  const AvailableCars({
    super.key,
    this.isBackAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    final carController = AuthController.instance;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              title: "Available Cars(${carController.carsList.length})",
              isBackButton: true,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height - 144,
              child: ListView.builder(
                itemCount: carController.carsList.length,
                itemBuilder: (context, index) {
                  final car = carController.carsList[index];
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => SelectedCar(
                        car: car,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5,
                      ),
                      child: buildCar(context, car),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildCar(BuildContext context, CarModel car) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.teal,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        car.model,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.brand,
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${car.transmission} | ${car.availability}',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "UgShs. ${car.price}",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 24, 21, 189),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Hero(
                tag: car.id,
                child: Image.network(
                  car.imageUrl,
                  fit: BoxFit.fitWidth,
                  height: 60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
