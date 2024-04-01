import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/home/model/car.dart';
import 'package:some_ride/features/home/presentation/selected_car.dart';

class AvailableCars extends GetView<ControllerHome> {
  final bool isBackAvailable;
  const AvailableCars({
    super.key,
    this.isBackAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              title: "Available Cars(${controller.length})",
              isBackButton: true,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height - 122.28574,
              child: GridView.builder(
                itemCount: controller.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final car = controller.cars[index];
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => SelectedCar(
                        brand: car.brand,
                        model: car.model,
                        price: car.price,
                        condition: car.condition,
                        images: car.images,
                      ),
                    ),
                    child: buildCar(car),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildCar(Car car) {
    return Container(
      height: 200,
      width: double.infinity / 2,
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Hero(
            tag: car.model,
            child: Image.asset(
              car.images[0],
              fit: BoxFit.fitWidth,
            ),
          ),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                "Per ${car.condition == "Daily" ? "day" : car.condition == "Weekly" ? "week" : "month"}",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$ ${car.price.toString()}',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
