import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone" :phone,
      "Password": password,
    };
  }

  //Map user Fetched data From Firebase to user model
  factory UserModel.fromSnapshot (DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data()!;
  return UserModel(
  id: document.id,
  email: data["Email"],
  password: data["Password"],
  fullName: data["FullName"],
  phone: data["Phone"],
  );
  }
}