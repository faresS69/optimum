import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:optimum/models/user_model.dart';

import '../auth.dart';
import '../login_screen/login_screen.dart';
import '../profile/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  AppUser currentUser = currentUserInfo;
  final authService _auth = authService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.brown[50], // Setting the background color to beige
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header
            SizedBox(
              height: 200,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(currentUser.image),
                      radius: 50,
                      child: const Icon(Icons.account_circle, size: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? "Something went wrong",
                      style: const TextStyle(
                          fontFamily: 'GoogleFonts.abel',
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // List of ListTiles
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'GoogleFonts.abel',
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigate to the home screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'GoogleFonts.abel',
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Get.to(ProfileScreen(destination: FirebaseAuth.instance.currentUser!.uid));
                // Navigate to the profile screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'GoogleFonts.abel',
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigate to the settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'GoogleFonts.abel',
                  fontSize: 16,
                ),
              ),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
