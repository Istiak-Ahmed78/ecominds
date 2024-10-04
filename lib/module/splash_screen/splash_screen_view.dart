import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  void checkLoginStatus() async {
    // Delay added for demonstration purposes; remove in production
    await Future.delayed(Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in, navigate to Home
      Get.offAllNamed('/home');
    } else {
      // No user is signed in, navigate to Login
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
