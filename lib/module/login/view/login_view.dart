// lib/screens/login_screen.dart
import 'package:ecominds/module/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    // Initialize the LoginController
    // final LoginController controller = Get.put(LoginController());

    return Scaffold(
      body: Obx(() {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            // Gradient Background
            gradient: LinearGradient(
              colors: [Color(0xFF6D83F2), Color(0xFF0A2463)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
            child: Column(
              children: [
                // Logo/Icon
                const Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Login to your account",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 60,
                  ),
                ),
                const SizedBox(height: 40),
                // Email Field
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Password Field
                TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Login Button
                Obx(() {
                  return ElevatedButton(
                    onPressed: () {
                      // Get.put(LoginController());
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button color

                      padding: const EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Color(0xFF0A2463),
                              strokeWidth: 2.0,
                            ),
                          )
                        : Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
                const SizedBox(height: 30),
                // OR Divider
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white70,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white70,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Login
                    GestureDetector(
                      onTap: () {
                        // Handle Google Login
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Facebook Login
                    GestureDetector(
                      onTap: () {
                        // Handle Facebook Login
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF0A2463),
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Twitter Login
                    GestureDetector(
                      onTap: () {
                        // Handle Twitter Login
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          FontAwesomeIcons.twitter,
                          color: Color(0xFF0A2463),
                          size: 34,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Register Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/register'); // Navigate to Register Screen
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
