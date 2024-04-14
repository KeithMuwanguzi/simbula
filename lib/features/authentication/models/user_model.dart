import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? userType;
  String? imagePath;

  UserModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.userType,
    this.id,
    this.imagePath,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    imagePath = json['imagePath'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    userType = json['userType'];
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      userType: data['userType'],
      imagePath: data['imagePath'],
      phoneNumber: data['phoneNumber'],
      name: data['name'],
      gender: data['gender'],
      email: data['email'],
    );
  }

  toJson() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "userType": userType,
      "email": email,
      "imagePath": imagePath,
      "gender": gender,
    };
  }
}
