import 'package:ecominds/module/current_location_s_image/current_location_s_image.dart';
import 'package:ecominds/module/flood_view_data/flood_view_data.dart';
import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/login/controller/login_controller.dart';
import 'package:ecominds/module/profile_page/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final tileData = controller.tileData;

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
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://t4.ftcdn.net/jpg/03/86/82/73/360_F_386827376_uWOOhKGk6A4UVL5imUBt20Bh8cmODqzx.jpg',
                      ))),
              child: Text(
                'Eco minds',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ProfileScreen(userData: LoginController.to.user));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.satellite),
              title: const Text('Landsat 8 satellite image'),
              onTap: () {
                Get.to(() => const ImageScreen());
                // Add navigation functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.water),
              title: const Text('Check out current flood data'),
              onTap: () {
                Get.to(() => FloodEventScreen());
                // Add navigation functionality here
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.logout),
            //   title: Text('Logout'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     // Add logout functionality here
            //   },
            // ),
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
              Get.toNamed('/LevelControllerScreen', arguments: title);
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
