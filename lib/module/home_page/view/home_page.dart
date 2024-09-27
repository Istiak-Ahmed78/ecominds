import 'package:ecominds/module/level_control/view/level_control_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Levels'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tile with Circle Avatar and Name
            ListTile(
              leading: const CircleAvatar(
                radius: 30, child: Icon(Icons.person),
                // backgroundImage: AssetImage(
                //     'assets/avatar.jpg'), // Use your image path or NetworkImage
              ),
              title: const Text(
                'Mobashsherul Islam',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Level Grid View
            Expanded(
              child: GridView.builder(
                itemCount: 4, // Number of levels
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1, // Square aspect ratio
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => LevelControllerScreen());
                      // Handle level click here
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Level ${index + 1}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
