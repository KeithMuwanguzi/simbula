import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:some_ride/core/shared/widgets/export.dart';
import 'package:some_ride/features/home/model/car_model.dart';
import 'package:some_ride/features/ongoing/models/ongoing_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final databaseReference = FirebaseDatabase.instance.ref().child('cars');
  final databaseReferenceOngoing =
      FirebaseDatabase.instance.ref().child('ongoing_orders');
  final databaseReferenceHistory =
      FirebaseDatabase.instance.ref().child('history');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser;

  RxList<CarModel> carsList = <CarModel>[].obs;
  RxList<CarOnModel> ongoingList = <CarOnModel>[].obs;
  RxList<CarOnModel> historyList = <CarOnModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());
    ever(_firebaseUser, initialScreen);
    fetchCars();
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
      Get.dialog(
        const AlertDialog(
          title: Text('Loading'),
          actions: [
            Row(
              children: [
                CircularProgressIndicator(),
                Text('Registering your account'),
              ],
            )
          ],
        ),
      );

      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(uid);
      Map userData = {
        'id': uid,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'userType': userType,
        'imagePath': '',
      };

      await userRef.set(userData);
      Get.back();
    } catch (e) {
      errorSnackBar(
        duration: const Duration(seconds: 2),
        icon: Icons.error,
        title: 'Error Occured',
        text: e.toString(),
      );
    }
  }

  void fetchCars() {
    try {
      databaseReference.onValue.listen((event) {
        final List<CarModel> fetchedCars = [];
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? carsMap =
              event.snapshot.value as Map<dynamic, dynamic>?;
          carsMap?.forEach((userID, userCars) {
            userCars.forEach((licensePlate, value) {
              fetchedCars.add(
                CarModel(
                  id: value['licensePlate'],
                  ownerId: value['id'],
                  brand: value['brand'],
                  model: value['model'],
                  transmission: value['transmission'],
                  imageUrl: value['imagePath'] ?? "",
                  maxSpeed: value['maxSpeed'],
                  price: value['price'],
                  availability: value['availability'] ?? "",
                ),
              );
            });
          });
        }
        carsList.value = fetchedCars;
      });

      databaseReferenceOngoing
          .child(_auth.currentUser!.uid)
          .onValue
          .listen((event) {
        final List<CarOnModel> fetchCars = [];
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? onGoingMap =
              event.snapshot.value as Map<dynamic, dynamic>?;
          onGoingMap?.forEach((licensePlate, value) {
            fetchCars.add(
              CarOnModel(
                id: value['licensePlate'],
                ownerId: value['id'],
                brand: value['brand'],
                model: value['model'],
                transmission: value['transmission'],
                imageUrl: value['imagePath'] ?? "",
                maxSpeed: value['maxSpeed'],
                price: value['price'],
                availability: value['availability'] ?? "",
                isPaid: value['isPaid'] ?? false,
                timerValue: value['timer_value'] ?? 0,
              ),
            );
          });
        }
        ongoingList.value = fetchCars;
      });

      databaseReferenceHistory
          .child(_auth.currentUser!.uid)
          .onValue
          .listen((event) {
        final List<CarOnModel> gottenCars = [];
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? historyMap =
              event.snapshot.value as Map<dynamic, dynamic>?;
          historyMap?.forEach((licensePlate, value) {
            gottenCars.add(
              CarOnModel(
                id: value['licensePlate'],
                ownerId: value['id'],
                brand: value['brand'],
                model: value['model'],
                transmission: value['transmission'],
                imageUrl: value['imagePath'] ?? "",
                maxSpeed: value['maxSpeed'],
                price: value['price'],
                availability: value['availability'] ?? "",
                isPaid: value['isPaid'] ?? false,
                timerValue: value['timer_value'] ?? 0,
              ),
            );
          });
        }
        historyList.value = gottenCars;
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
