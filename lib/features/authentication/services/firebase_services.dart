import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/export.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());
    ever(_firebaseUser, initialScreen);
  }

  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    required String userType,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        addUserToFirestore(
          uid: user.uid,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          gender: gender,
          userType: userType,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
    }
  }

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        'Error signing in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.error,
        ),
        colorText: Colors.white,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
    }
  }

  initialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/');
    } else {
      Get.offAllNamed('/home');
    }
  }

  Future<void> addUserToFirestore(
      {required String uid,
      required String email,
      required String name,
      required String phoneNumber,
      required String gender,
      required String userType}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'userType': userType,
      });
    } catch (e) {
      errorSnackBar(
        duration: const Duration(seconds: 2),
        icon: Icons.error,
        title: 'Error Occured',
        text: e.toString(),
      );
    }
  }
}
