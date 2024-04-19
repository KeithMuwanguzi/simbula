import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:some_ride/core/shared/widgets/textwidget.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/features/profile/controllers/profile_controller.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.pushImageToDb();
        },
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              Get.bottomSheet(
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      const TextWidget(
                        size: 18,
                        text: 'Are you sure you want to logout?',
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              AuthController.instance.signOut();
                            },
                          ),
                          const SizedBox(width: 70),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 150, 50, 10),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        userProfilePic(controller, context),
                        Positioned(
                          bottom: 5,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  color: Colors.grey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller
                                              .pickImage(ImageSource.gallery);
                                        },
                                        child: const Icon(
                                          Icons.photo,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller
                                              .pickImage(ImageSource.camera);
                                        },
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.mode,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => richText(
                      text1: "Name: ",
                      text2: controller.name.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => richText(
                      text1: "Email: ",
                      text2: controller.email.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => richText(
                      text1: "UserType: ",
                      text2: controller.userType.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => richText(
                      text1: "Gender: ",
                      text2: controller.gender.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => richText(
                      text1: "Contact: ",
                      text2: controller.phoneNumber.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText richText({required text1, required text2}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text2,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  userCoverPhoto(ProfileController controller) => Container(
        color: Colors.grey[400],
        child: Image.network(
          'https://picsum.photos/200/300/?blur',
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  userProfilePic(ProfileController controller, BuildContext context) => Obx(
        () => controller.selectedImagePath != ''
            ? CircleAvatar(
                backgroundImage: FileImage(
                  File(controller.selectedImagePath.value),
                ),
                radius: 60,
              )
            : controller.selectedImagePath.value == ''
                ? controller.profilePath.value == ''
                    ? EmptyAvator(controller: controller)
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                            controller.profilePath.value.toString()),
                        radius: 60,
                      )
                : EmptyAvator(controller: controller),
      );
}

// ignore: must_be_immutable
class EmptyAvator extends StatelessWidget {
  EmptyAvator({super.key, required this.controller});
  ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 80,
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.pickImage(ImageSource.gallery);
                    },
                    child: const Icon(
                      Icons.photo,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  InkWell(
                    onTap: () {
                      controller.pickImage(ImageSource.camera);
                    },
                    child: const Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add_a_photo,
          size: 45,
          color: Colors.black,
        ),
      ),
    );
  }
}
