import 'package:ecominds/binding.dart';
import 'package:ecominds/firebase_options.dart';
import 'package:ecominds/module/home_page/home_binding.dart';
import 'package:ecominds/module/home_page/view/home_page.dart';
import 'package:ecominds/module/level_control/view/level_control_screen.dart';
import 'package:ecominds/module/login/login_binding.dart';
import 'package:ecominds/module/login/view/login_view.dart';
import 'package:ecominds/module/registration/registration_binding.dart';
import 'package:ecominds/module/registration/view/registration_view.dart';
import 'package:ecominds/module/splash_screen/splash_controller.dart';
import 'package:ecominds/module/splash_screen/splash_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'module/level_control/level_controller_binding.dart';

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
        GetPage(
            name: '/login', page: () => LoginScreen(), binding: LoginBinding()),
        GetPage(
            name: '/register',
            page: () => const RegistrationScreen(),
            binding: RegistrationBinding()),
        // GetPage(
        //     name: '/profile',
        //     page: () => ProfileScreen(),
        //     binding: ProfileBinding()),
        // GetPage(name: '/puzzle2', page: () => PuzzleGame()),
        GetPage(
            name: '/home',
            page: () => HomePage(),
            binding: HomeBinding()), // Define HomeScreen
        GetPage(
            name: '/LevelControllerScreen',
            page: () => const LevelControllerScreen(),
            binding: LevelControllerBinding()), // Define HomeScreen
      ],
      // home: HandsOnActivityScreen(
      //   onCompleteClick: (i) {},
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}
