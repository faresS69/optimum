import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:optimum/firebase_options.dart';
import 'package:optimum/models/user_model.dart';
import 'package:optimum/redirect.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'login_screen/login_screen.dart';
import 'main_screen/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: authService().user,
      initialData: AppUser(
          email: '', uid: '', password: '', name: 'Anonymous User', image: ''),
      child: GetMaterialApp(
        title: 'Optimim',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        home: const Redirect(),
      ),
    );
  }
}
