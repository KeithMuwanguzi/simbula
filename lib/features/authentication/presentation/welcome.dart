import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:some_ride/core/shared/widgets/export.dart';

// ignore: must_be_immutable
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  LottieBuilder.asset(
                    'assets/animations/auth2.json',
                    repeat: true,
                    reverse: true,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Simbula",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextWidget(
                      text:
                          "Experience the best Ride Sharing and Car Rental Services at your convenience",
                      size: 15,
                      align: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              buttonText: "Create an Account",
              buttonFunction: () {
                Get.toNamed('/signup');
              },
            ),
            const SizedBox(height: 10),
            LightBorderButton(
                buttonText: 'Log In',
                buttonFunction: () {
                  Get.toNamed('/login');
                }),
          ],
        ),
      ),
    );
  }
}
