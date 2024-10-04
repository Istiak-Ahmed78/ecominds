import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationsScreen extends GetView<HomeController> {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.celebration,
                size: 100,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              const Text(
                'Awesome!!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You have cleared all the modules. Your quiz performance is great!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  PerformanceCard(
                    label: 'Score Earned',
                    value:
                        '${controller.tileData.fold<double>(0, (previousValue, element) => (element.earnedPoints.fold<double>(0, (previousValue, element) => (previousValue) + (element ?? 0))) + previousValue)} out of 100',
                    icon: Icons.emoji_events_outlined,
                    iconColor: Colors.amber,
                  ),
                ],
              ),
              ...controller.tileData.map<Widget>((e) => ListTile(
                    title: Text(e.title),
                    subtitle: Text(
                        'Total earned rewards: ${e.earnedPoints.fold<double>(0, (previousValue, element) => (previousValue) + (element ?? 0))}'),
                  )),
              const SizedBox(height: 30),
              const Text(
                'You are now climate fighter to save the world!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.offNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                child: const Text(
                  'Go back to Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const PerformanceCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: iconColor,
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
