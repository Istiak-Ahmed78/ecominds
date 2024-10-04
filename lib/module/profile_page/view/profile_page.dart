import 'package:ecominds/module/all_complete_con_screen/all_complete_con_screen.dart';
import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final User? userData;
  // You can replace these with dynamic data as needed
  final String avatarUrl =
      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'; // Placeholder avatar
  final String userName = 'John Doe';
  final int earnedPoints = 38;

  const ProfileScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true, // Centers the title
      ),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return Padding(
          padding:
              const EdgeInsets.all(16.0), // Adds padding around the content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers children horizontally
            children: [
              const SizedBox(height: 20), // Spacer
              // Circle Avatar
              CircleAvatar(
                radius: 60, // Size of the avatar
                backgroundImage: NetworkImage(avatarUrl),
                backgroundColor: Colors.grey.shade200, // Placeholder color
              ),
              const SizedBox(height: 20), // Spacer
              // User Name
              Text(
                userData?.email ?? '(Email address not found)',
                style: const TextStyle(
                  fontSize: 24, // Font size
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),

              const SizedBox(height: 10), // Spacer
              // Earned Points
              Align(
                child: PerformanceCard(
                  label: 'Score Earned',
                  value:
                      '${homeController.tileData.fold<double>(0, (previousValue, element) => (element.earnedPoints.fold<double>(0, (previousValue, element) => (previousValue) + (element ?? 0))) + previousValue)} out of 100',
                  icon: Icons.emoji_events_outlined,
                  iconColor: Colors.amber,
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       LoginController.to.logOut();
              //       Get.offNamed('/login');
              //     },
              //     child: const Text('Logout'))
              // Additional Content (Optional)
              // You can add more widgets here, such as buttons or user details
            ],
          ),
        );
      }),
    );
  }
}
