import 'package:ecominds/binding.dart';
import 'package:ecominds/firebase_options.dart';
import 'package:ecominds/module/home_page/view/home_page.dart';
import 'package:ecominds/module/login/view/login_view.dart';
import 'package:ecominds/module/profile_page/view/profile_page.dart';
import 'package:ecominds/module/registration/view/registration_view.dart';
import 'package:ecominds/module/splash_screen/controller/splash_controller.dart';
import 'package:ecominds/module/splash_screen/splash_controller.dart';
import 'package:ecominds/module/splash_screen/splash_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Auth',
      initialRoute: '/splash',
      initialBinding: GlobalBinding(),
      getPages: [
        GetPage(
            name: '/splash',
            page: () => const SplashScreenView(),
            binding: SplashBinding()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => const RegistrationScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(
            name: '/home',
            page: () => const LevelScreen()), // Define HomeScreen
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
