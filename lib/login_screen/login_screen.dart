import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimum/auth.dart';
import 'package:optimum/login_screen/signup_screen.dart';
import 'package:optimum/main_screen/home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService _auth = authService();
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLogin = true;
  String? err_msg = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: GoogleFonts.abel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _auth.signIn(
                    _emailController.text.toString(), _passwordController.text.toString());
                print(FirebaseAuth.instance.currentUser?.uid);
                if(FirebaseAuth.instance.currentUser!=null){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => GlassesScreen(),
                    ),
                        (route) => false,
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GlassesScreen()));
                }
              },
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
              ),

              child: Text('Login',style: GoogleFonts.abel(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Add your Google login logic here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
                padding: EdgeInsets.all(10)
              ),
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(FontAwesomeIcons.google),
              ),
              label: Text('Login with Google',style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20, wordSpacing: 5),),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.off(SignupScreen());
                // Add your sign-up screen navigation logic here
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
