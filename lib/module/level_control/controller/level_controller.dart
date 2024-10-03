import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LavelController extends GetxController {
  static LavelController get to => Get.find<LavelController>();

  RxList<double?> levelScores = <double?>[null, null, null, null].obs;
  RxInt currentLevelIndex = 0.obs;
  void changeCurrentLEvelIndex(int l, bool isLocked, BuildContext context) {
    if (!isLocked) {
      currentLevelIndex.value = l;
      update();
    }
  }

  void addPointToALevel(int levelIndex, double point) {
    if (levelIndex + 1 <= levelScores.length) {
      levelScores[levelIndex] = point;
      if (levelIndex + 1 < levelScores.length) {
        currentLevelIndex.value = levelIndex + 1;
      }

      update();
    }
  }

  void clearLevelScores() {
    levelScores.value = <double?>[null, null, null, null];
    update();
  }

  // Method to handle level completion
  void _completeLevel(int index) {
    // if (index == totalLevels - 1) {
    //   // Last level completed
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Congratulations! All levels completed.'),
    //     ),
    //   );
    //   return;
    // }

    // setState(() {
    //   // Unlock the next level
    //   if (index + 1 < totalLevels) {
    //     unlockedLevels[index + 1] = true;
    //   }
    //   // Optionally, navigate to the next level automatically
    //   currentLevel = index + 1;
    // });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content:
    //         Text('Level ${index + 1} completed! Level ${index + 2} unlocked.'),
    //   ),
    // );
  }
}
