import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/error_snack.dart';
import 'package:some_ride/features/authentication/controller/newpassword_controller.dart';
import 'package:some_ride/core/shared/widgets/custom_password.dart';
import 'package:some_ride/core/shared/widgets/custombutton.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';

class NewPassword extends StatelessWidget {
  final String emailAddress;
  final String name;
  final String phoneNumber;
  final String gender;
  final String userType;
  const NewPassword({
    super.key,
    required this.emailAddress,
    required this.name,
    required this.gender,
    required this.userType,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final NewPasswordController controller = Get.put(NewPasswordController());
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 80, 25, 30),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 6),
                    Text(
                      "Set New Password",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Set a new password below",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Obx(
                            () => CustomPasswordFormField(
                              userFunction: () => controller.changeVisibility(),
                              controller: controller.password,
                              hintText: "Enter your password",
                              isVisible: controller.isVisible.value,
                              validate: controller.validatePassword,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => CustomPasswordFormField(
                              userFunction: () =>
                                  controller.changeConfirmVisibility(),
                              hintText: "Confirm your password",
                              controller: controller.confirmPassword,
                              isVisible: controller.isConfirmVisible.value,
                              validate: controller.validateConfirmPassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Ensure that the password has atleast 1 symbol (*#&!:@,...) and atleast 1 number (1,2,....)",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                buttonText: 'Register',
                buttonFunction: () async {
                  if (controller.formKey.currentState!.validate()) {
                    if (!await Geolocator.isLocationServiceEnabled()) {
                      errorSnackBar(
                          duration: const Duration(seconds: 2),
                          icon: Icons.location_off,
                          title: 'Enable your Location',
                          text:
                              'Please make sure your device location is enabled!');
                      return;
                    } else {
                      AuthController.instance.createUserWithEmailAndPassword(
                        email: emailAddress,
                        password: controller.password.text.trim(),
                        name: name,
                        phoneNumber: phoneNumber,
                        gender: gender,
                        userType: userType,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ));
  }
}
