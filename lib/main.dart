import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:optimum/firebase_options.dart';
import 'package:optimum/models/user_model.dart';
import 'package:optimum/providers/home_provider.dart';
import 'package:optimum/redirect.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'login_screen/login_screen.dart';
import 'main_screen/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => StreamProvider<AppUser>.value(
        value: authService().user,
        initialData: AppUser(
            email: null.toString(), uid: null.toString(), password: null.toString(), name: null.toString(), image: null.toString()),
        child: MultiProvider(
          providers: [
            Provider<HomeProvider>(
                create: (_) =>
                    HomeProvider(firebaseFirestore: firebaseFirestore)),

          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Optimum',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
              useMaterial3: true,
            ),
            home: const Redirect(),
          ),
        ),
      ),
    );
  }
}
