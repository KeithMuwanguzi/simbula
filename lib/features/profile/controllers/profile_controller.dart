import 'dart:io';

import 'package:some_ride/core/shared/widgets/export.dart';

import '../../../database/firebase_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  var data;
  var selectedImagePath = ''.obs;
  var isSelected = false.obs;
  var isSaved = false.obs;
  String imageUrl = '';
  var nameTemp = ''.obs;
  final bioText = TextEditingController();
  final nameText = TextEditingController();
  final locationText = TextEditingController();
  final contactText = TextEditingController();
  var bioTemp = ''.obs;
  var profilePath = ''.obs;
  var profileName = ''.obs;
  final user = auth.currentUser!;
  var userData;

  @override
  void onInit() {
    super.onInit();
    data = getUserData(user.email);
  }

  toggleSelection() {
    selectedImagePath != ''
        ? isSelected.value = true
        : isSelected.value = false;
  }

  resetIsSelected() {
    isSaved.value ? isSelected.value = false : isSelected.value = true;
  }

  resetSelectedPath() {
    isSelected.value
        ? selectedImagePath = selectedImagePath
        : selectedImagePath.value = '';
  }

  Future pickImage(ImageSource imageSource) async {
    final imageFile = await ImagePicker().pickImage(source: imageSource);
    if (imageFile == null) {
      Get.snackbar('Error', 'No message Picked',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      selectedImagePath.value = imageFile.path;
      toggleSelection();
    }
  }

  void pushImageToDb(UserModel user) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirProfiles = referenceRoot.child('profiles');
    Reference referenceImageToUpload =
        referenceDirProfiles.child(selectedImagePath.value);
    try {
      await referenceImageToUpload.putFile(File(selectedImagePath.value));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      db.collection('users').doc(user.id).update({'imagePath': imageUrl});
    } catch (e) {
      errorSnackBar(
        duration: const Duration(seconds: 2),
        icon: Icons.error,
        title: "Error Saving",
        text: "There is nothing to save",
      );
    }
  }

  getUserData(email) async {
    final snapshot =
        await db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  void pushNameToDb(UserModel user, String name) async {
    await db.collection('users').doc(user.id).update({'fullName': name});
  }
}
