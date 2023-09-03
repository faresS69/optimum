import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AppUser {
  String? uid;
  String? email;
  String? password;
  String? name;
  String? image;

  AppUser({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid' : uid,
      'email': email,
      'password': password,
      'name': name,
      'image': image,
    };
  }

  AppUser.fromJson(Map<String, dynamic> data) {
    uid = data['uid'];
    email = data['email'];
    password = data['password'];
    name = data['name'];
    image = data['image'];
  }

  factory AppUser.fromDocument(DocumentSnapshot snapshot) {
    String uid = "";
    String email = "";
    String password = "";
    String name = "";
    String image = "";

    try {
      uid = snapshot.get('uid');
      email = snapshot.get('email');
      password = snapshot.get('password');
      name = snapshot.get('name');
      image = snapshot.get('image');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return AppUser(
      uid: uid,
      email: email,
      password: password,
      name: name,
      image: image,
    );
  }

  AppUser copyWith({
    String? uid,
    String? email,
    String? password,
    String? name,
    String? image,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        image: image ?? this.image,
      );
}
AppUser currentUserInfo = AppUser(
  email: '',
  image: 'assets/images/profile.jpg',
  password: '',
  uid: ('1919'),
  name: '',
);