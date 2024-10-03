import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/view/level_control_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final tileData = controller.tileData;
    final levelLockInformation = controller.lockUnlockStatuses;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Modules',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings,
                color: Colors.orange), // Settings Icon
            onPressed: () {},
          ),
        ],
      ),
      drawerScrimColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Add logout functionality here
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: tileData.length,
            itemBuilder: (context, index) {
              final tile = tileData[index];

              return Column(
                children: [
                  moduleItem(
                    context,
                    tile.imagePath,
                    tile.title,
                    tile.lessons,
                    tile.isUnlocked,
                    index,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  // Widget for Module Items
  Widget moduleItem(BuildContext context, String image, String title,
      String lessons, bool isUnlocked, int moduleIndex) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
              print(moduleIndex);
              Get.toNamed('/LevelControllerScreen');
              HomeController.to.onEnterAModule(moduleIndex);

              // Handle level click here
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image on the left
            Image.asset(image, height: 60, width: 60), // Adjust size as needed
            const SizedBox(width: 16),
            // Title and Lessons
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lessons,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Icon on the right
            if (isUnlocked)
              const Icon(
                Icons.play_circle_fill,
                color: Colors.green,
                size: 30,
              )
            else
              const Icon(
                Icons.lock,
                color: Colors.blue,
                size: 30,
              ),
          ],
        ),
      ),
    );
  }
}
