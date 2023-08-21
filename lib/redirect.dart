
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:optimum/login_screen/login_screen.dart';
import 'package:optimum/main_screen/home_page.dart';
import 'package:optimum/models/user_model.dart';
import 'package:provider/provider.dart';
class Redirect extends StatelessWidget {
  const Redirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = Provider.of<AppUser>(context);

    if(user!= null){
      return GlassesScreen();
    }else{
      return LoginScreen();
    }

  }
}
