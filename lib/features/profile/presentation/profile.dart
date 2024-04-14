import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:some_ride/core/shared/widgets/custombutton.dart';
import 'package:some_ride/core/shared/widgets/textwidget.dart';
import 'package:some_ride/features/authentication/models/user_model.dart';
import 'package:some_ride/features/authentication/services/firebase_services.dart';
import 'package:some_ride/features/profile/controllers/profile_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmation"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          AuthController.instance.signOut();
                        },
                        child: const Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Cancel log out action
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      body: ListView(
        children: [
          FutureBuilder(
            future: controller.data,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userModel = snapshot.data as UserModel;
                  controller.nameTemp.value = userModel.name.toString();
                  controller.profilePath.value = userModel.imagePath.toString();
                  controller.profileName.value = userModel.name.toString();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          userCoverPhoto(controller),
                          Positioned(
                            top: 100,
                            child:
                                userProfilePic(controller, context, userModel),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: IconButton(
                              icon: const Icon(Icons.edit,
                                  size: 20, color: Colors.white),
                              onPressed: () {
                                Get.bottomSheet(Container(
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
                                          size: 40,
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
                                ));
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.person, size: 20),
                                const SizedBox(width: 40),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => TextWidget(
                                          size: 14,
                                          text: controller.nameTemp.value,
                                        )),
                                    TextWidget(
                                      size: 12,
                                      text: '${controller.user.email}',
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(Container(
                                      height:
                                          (MediaQuery.of(context).size.height) /
                                              4,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          const TextWidget(
                                            size: 15,
                                            text: 'Edit Full Name',
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller: controller.nameText,
                                            decoration: InputDecoration(
                                              hintText: "Your Fullname",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          CustomButton(
                                              buttonText: 'Save',
                                              buttonFunction: () {
                                                if (controller
                                                        .nameText.text.length >
                                                    25) {
                                                  Get.snackbar('Error',
                                                      'Name is too long');
                                                } else {
                                                  controller.nameTemp.value =
                                                      controller.nameText.text;
                                                  controller.pushNameToDb(
                                                      userModel,
                                                      controller.nameText.text);
                                                  controller.nameText.clear();
                                                  controller.profileName.value =
                                                      controller.nameText.text;
                                                }
                                              })
                                        ],
                                      ),
                                    ));
                                  },
                                  icon: const Icon(Icons.edit, size: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.home, size: 20),
                                const SizedBox(width: 40),
                                TextWidget(
                                  size: 14,
                                  text: '${userModel.userType}',
                                ),
                                Expanded(child: Container()),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit, size: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                userModel.gender == 'Male'
                                    ? const Icon(Icons.male, size: 20)
                                    : const Icon(Icons.female, size: 20),
                                const SizedBox(width: 40),
                                TextWidget(
                                  size: 14,
                                  text: '${userModel.gender}',
                                ),
                                Expanded(child: Container()),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit, size: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 20),
                                const SizedBox(width: 40),
                                TextWidget(
                                  size: 14,
                                  text: '${userModel.phoneNumber}',
                                ),
                                Expanded(child: Container()),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit, size: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 120),
                            CustomButton(
                              buttonText: 'Save Changes',
                              buttonFunction: () {
                                controller.pushImageToDb(userModel);
                                controller.resetIsSelected();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }
              return const LinearProgressIndicator();
            }),
          )
        ],
      ),
    );
  }

  userCoverPhoto(ProfileController controller) => Container(
        color: Colors.grey,
        child: Image.network(
          'https://picsum.photos/200/300/?blur',
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  userProfilePic(
          ProfileController controller, BuildContext context, UserModel user) =>
      Obx(
        () => controller.selectedImagePath != ''
            ? CircleAvatar(
                backgroundImage: FileImage(
                  File(controller.selectedImagePath.value),
                ),
                radius: 80,
              )
            : controller.selectedImagePath == ''
                ? user.imagePath == ''
                    ? EmptyAvator(controller: controller)
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(user.imagePath.toString()),
                        radius: 80,
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
          Get.bottomSheet(Container(
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
          ));
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
