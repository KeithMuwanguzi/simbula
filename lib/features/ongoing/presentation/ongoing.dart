import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/features/home/controllers/homecont.dart';
import 'package:some_ride/features/ongoing/models/ongoing_model.dart';

class OnGoing extends GetView<ControllerHome> {
  final bool isBackAvailable;
  const OnGoing({
    super.key,
    this.isBackAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    final carController = AuthController.instance;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: [
            const AppBarWidget(
              title: "OnGoing Orders",
              isBackButton: false,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height - 144,
              child: Obx(
                () => ListView.builder(
                  itemCount: carController.ongoingList.length,
                  itemBuilder: (context, index) {
                    final car = carController.ongoingList[index];
                    return GestureDetector(
                      onTap: () {},
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildCar(BuildContext context, CarOnModel car) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Paid Status:',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      car.isPaid
                          ? Text(
                              ' Cleared',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            )
                          : Text(
                              ' Pending',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !car.isPaid
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5), // Shadow color
                                          spreadRadius: 5, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: const Offset(0, 3), // Offset
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "PAY",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 24, 21, 189),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: const Offset(0, 3), // Offset
                              ),
                            ],
                          ),
                          child: Center(
                            child: car.isPaid
                                ? Text(
                                    "RETURN CAR",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 24, 21, 189),
                                    ),
                                  )
                                : Text(
                                    "CANCEL",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 24, 21, 189),
                                    ),
                                  ),
                          ),
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
