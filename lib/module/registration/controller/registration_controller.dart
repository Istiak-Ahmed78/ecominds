import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  // Controllers for input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var visibilityStatePass = false.obs;
  var visibilityStateConPass = false.obs;
  var errorMessage = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void changeVisibilityState() {
    visibilityStatePass.value = !visibilityStatePass.value;
    update();
  }

  void changeConfirmPassVisibilityState() {
    visibilityStateConPass.value = !visibilityStateConPass.value;
    update();
  }

  // Registration function
  Future<void> register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Basic validation
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage.value = "All fields are required.";
      return;
    }

    if (!GetUtils.isEmail(email)) {
      errorMessage.value = "Please enter a valid email.";
      return;
    }

    if (password.length < 6) {
      errorMessage.value = "Password must be at least 6 characters.";
      return;
    }

    if (password != confirmPassword) {
      errorMessage.value = "Passwords do not match.";
      return;
    }

    // Start loading
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Firebase registration
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success", "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM);
      // Navigate to home or login
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      if (e.code == 'email-already-in-use') {
        errorMessage.value = 'Email is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage.value = 'Password is too weak.';
      } else {
        errorMessage.value = 'Registration failed. Please try again.';
      }
    } catch (e) {
      // Handle other errors
      errorMessage.value = 'An unexpected error occurred.';
    } finally {
      isLoading.value = false;
    }
  }

  // Dispose controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
