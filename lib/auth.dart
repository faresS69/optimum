
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimum/models/user_model.dart';
class authService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebase(User? user) {
    return AppUser(
      uid: user!.uid,
      name: user.displayName!,
      image: user.photoURL!,
      password: '',
      email: user.email!,
    );
  }

  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signUp(String email, String pw) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pw);
      User? user = result.user;
      getCU(user!);
      print(currentUserInfo.name);
      return _userFromFirebase(user);
    } catch (e) {
      return Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  Future<AppUser?> signIn(String email, String pw) async {
    try {
      UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: pw);
      User? user = result.user;
      getCU(user!);
      return _userFromFirebase(user);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
    return null;
  }

  Future<AppUser?> getCU(User user) async {
    Map<String, dynamic>? data = (await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get())
        .data();
    if (data != null) {
      AppUser currentUser = AppUser.fromJson(data);
      currentUserInfo = currentUser;
      print(currentUserInfo.toJson());
      return currentUser;
    }
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      currentUserInfo.uid = user!.uid;
      currentUserInfo.name = 'Guest';
      return user;
    } catch (e) {
      return Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
