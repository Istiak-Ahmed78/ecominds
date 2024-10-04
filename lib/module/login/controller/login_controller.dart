// lib/controllers/login_controller.dart
import 'package:ecominds/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  // Controllers for input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var errorMessage = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Login function
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = "Please enter both email and password.";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Firebase sign-in
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Success",
        "Logged in successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
      Get.offAllNamed('/home'); // Navigate to Home Screen
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      switch (e.code) {
        case 'invalid-email':
          errorMessage.value = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage.value = 'This user has been disabled.';
          break;
        case 'invalid-credential':
          errorMessage.value = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage.value = 'Incorrect password provided.';
          break;
        default:
          errorMessage.value = 'An unexpected error occurred.';
      }
      MyToast.showErrorToast(errorMessage.value);
    } catch (e) {
      // Handle other errors
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void logOut() {
    _auth.signOut();
  }

  // Dispose controllers
  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
