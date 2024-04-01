import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/authentication/controller/signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selected = "Male";

  final SignUpController signUpController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const TextWidget(
                    text: "SignUp with your phone number or email address.",
                    size: 17,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    child: Column(
                      key: signUpController.formKey,
                      children: [
                        CustomTextFormField(
                          controller: signUpController.name,
                          hintText: "Name",
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: signUpController.email,
                          hintText: "Email",
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: signUpController.number,
                          hintText: "Phone Number",
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
                        genderButton(),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: privacyPolicy(13),
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
                Get.toNamed('/newpassword');
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

  RichText privacyPolicy(double fSize) {
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

  DropdownButtonFormField<String> genderButton() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      value: selected,
      onChanged: (newValue) {
        setState(() {
          selected = newValue.toString();
        });
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
}
