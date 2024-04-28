import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/features/ongoing/controllers/ongoing_controller.dart';
import 'package:some_ride/features/ongoing/models/ongoing_model.dart';

class OnGoing extends GetView<OnGoingController> {
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
              height: MediaQuery.of(context).size.height - 200,
              child: carController.ongoingList.isNotEmpty
                  ? Obx(
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
                    )
                  : const Center(
                      child: Text('No OnGoing Orders'),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Container buildCar(BuildContext context, CarOnModel car) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
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
                        car.id,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.grey,
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
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.dialog(
                                          AlertDialog(
                                            title: const Text('CAR PAYMENT'),
                                            content: const Text(
                                                'Payment Methods are yet to be added, for the meantime, please pay cash to the owner on car delivery. Sorry for any inconveniences. Thank you'),
                                            actions: [
                                              inAppButton(
                                                car,
                                                () {
                                                  controller.payOrder(
                                                    car.id,
                                                    car.ownerId,
                                                  );
                                                  Get.back();
                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: const Text(
                                                          'PAYMENT RECEIVED'),
                                                      content: const Text(
                                                          'Your Cash Payment has been received, thank you for choosing Simbula for your seemless travel solutions'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              'Close'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                'Pay Cash',
                                              ),
                                              const SizedBox(width: 35),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                        ),
                        child: Center(
                          child: car.isPaid
                              ? TextButton(
                                  onPressed: () {
                                    controller.returnOrder(car.id, car.ownerId);
                                  },
                                  child: Text(
                                    "RETURN CAR",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 24, 21, 189),
                                    ),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('CANCEL ORDER'),
                                        content: const Text(
                                            'If Continue you will cancel this order and the car will be available again, Do you want to continue?'),
                                        actions: [
                                          inAppButton(car, () {
                                            controller.cancelOrder(
                                                car.id, car.ownerId);
                                            Get.back();
                                          }, 'Continue'),
                                          const SizedBox(width: 40),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
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

  Container inAppButton(CarOnModel car, onTap, text) {
    return Container(
      height: 40,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset
          ),
        ],
      ),
      child: Center(
        child: TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 24, 21, 189),
            ),
          ),
        ),
      ),
    );
  }
}
