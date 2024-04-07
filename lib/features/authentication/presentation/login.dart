import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/features/authentication/controller/login_controller.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:geolocator/geolocator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
                  Column(
                    children: loginPage(controller),
                  )
                ]),
              ),
              CustomButton(
                buttonText: 'Sign In',
                buttonFunction: () async {
                  if (!await Geolocator.isLocationServiceEnabled()) {
                    errorSnackBar(
                        duration: const Duration(seconds: 2),
                        icon: Icons.location_off,
                        title: 'Enable your Location',
                        text:
                            'Please make sure your device location is enabled!');
                    return;
                  } else {
                    if (controller.key.currentState!.validate()) {
                      AuthController.instance.signInWithEmailAndPassword(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: "Don't have an account? ",
                    size: 13,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  List<Widget> loginPage(
    controller,
  ) {
    return [
      const TextWidget(
        text: "Sign In with your email address or phone number.",
        size: 17,
      ),
      const SizedBox(height: 10),
      Form(
        key: controller.key,
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.email,
              hintText: "Email or Phone number",
              isPassword: false,
              validate: controller.validateEmail,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 55,
              child: Obx(
                () => CustomPasswordFormField(
                  controller: controller.password,
                  hintText: "Enter your password",
                  userFunction: () => controller.changeVisibility(),
                  isVisible: controller.isVisible.value,
                  validate: controller.validatePassword,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot password?",
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: Colors.blue[600],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ];
  }
}
