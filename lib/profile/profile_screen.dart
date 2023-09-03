import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimum/profile/profile_edit.dart';

import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  String destination;
  ProfileScreen({Key? key, required this.destination}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser currentUser = currentUserInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown[50],
        actions: [
          widget.destination == FirebaseAuth.instance.currentUser?.uid ? IconButton(onPressed: (){Get.to(EditProfilePage());},
              padding: EdgeInsets.all(8),tooltip: 'edit my infos',
              icon: const Icon(Icons.edit)) : IconButton(onPressed: (){Fluttertoast.showToast(
              msg: "Your uid: ${currentUserInfo.uid} \n this account uid: ${widget.destination}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);}, icon: Icon(Icons.close)),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.brown[50],
      body: FutureBuilder(
        future: getCurrentUserInfo(widget.destination),
        builder: (context, AsyncSnapshot snapshot) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(currentUser.image!), // Use your `currentUser.image` here
                    backgroundColor: Colors.grey[300], // Default image background color
                    child: currentUser.image == null
                        ? Icon(
                      Icons.account_circle,
                      size: 150,
                      color: Colors.grey[400],
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Email:',
                  style: GoogleFonts.abel(fontSize: 18),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'UID:',
                  style: GoogleFonts.abel(fontSize: 18),
                ),
                snapshot.data != null
                    ? Text(
                  snapshot.data['uid'],
                  style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.bold),
                )
                    : Text(
                  'Unable to get data ',
                  style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Name:',
                  style: GoogleFonts.abel(fontSize: 18),
                ),
                snapshot.data != null
                    ? Text(
                  snapshot.data['name'],
                  style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.bold),
                )
                    : Text(
                  'Unable to get data ',
                  style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    // Implement edit user details functionality here
                  },
                  child: const Text('Edit User Details'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement log out functionality here
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          ),
        );}
      ),
    );
  }
}
Future getCurrentUserInfo(String user) async {
  if (!FirebaseAuth.instance.currentUser!.isAnonymous) {
    DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user)
        .get();

    return data;
  }
  return null;
}