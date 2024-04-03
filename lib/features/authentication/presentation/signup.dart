import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/authentication/controller/signup_controller.dart';
import 'package:some_ride/features/authentication/presentation/export.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find<SignUpController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const TextWidget(
                    text: "SignUp with your phone number or email address.",
                    size: 17,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.name,
                          hintText: "Name",
                          isPassword: false,
                          validate: controller.validateField,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: controller.email,
                          hintText: "Email",
                          isPassword: false,
                          validate: controller.validateEmail,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: controller.number,
                          hintText: "Phone Number",
                          isPassword: false,
                          validate: controller.validateField,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => genderButton(controller),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => selectUserType(controller),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: privacyPolicy(context, 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CustomButton(
              buttonText: "Sign Up",
              buttonFunction: () {
                if (controller.key.currentState!.validate()) {
                  Get.to(
                    () => NewPassword(
                      emailAddress: controller.email.text.trim(),
                      name: controller.name.text.trim(),
                      phoneNumber: controller.number.text.trim(),
                      gender: controller.selected.value,
                      userType: controller.userType.value,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(
                  text: "Already have an account?",
                  size: 13,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Sign In",
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
      ),
    );
  }

  RichText privacyPolicy(BuildContext context, double fSize) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "By signing up, you agree to the ",
          style: GoogleFonts.roboto(
            fontSize: fSize,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
        TextSpan(
          text: "Terms of Service ",
          style: GoogleFonts.roboto(
            fontSize: fSize,
            fontWeight: FontWeight.bold,
            color: Colors.green[500],
          ),
        ),
        TextSpan(
          text: "and ",
          style: GoogleFonts.roboto(
            fontSize: fSize,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
        TextSpan(
          text: "Privacy Policy",
          style: GoogleFonts.roboto(
            fontSize: fSize,
            fontWeight: FontWeight.bold,
            color: Colors.green[500],
          ),
        ),
      ]),
    );
  }

  DropdownButtonFormField<String> genderButton(controller) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      value: controller.selected.value,
      onChanged: (newValue) {
        controller.selected.value = newValue.toString();
      },
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> selectUserType(controller) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'User-Type',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      value: controller.userType.value,
      onChanged: (newValue) {
        controller.userType.value = newValue.toString();
      },
      items: <String>['Driver', 'Customer']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select user type';
        }
        return null;
      },
    );
  }
}
