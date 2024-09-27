import 'package:ecominds/module/mcq/view/mcq_view.dart';
import 'package:ecominds/module/puzzle/view/Board.dart';
import 'package:ecominds/module/word_matching/view/word_matching.dart';
import 'package:ecominds/module/youtube_tutorial/view/you_tube_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelControllerScreen extends StatefulWidget {
  const LevelControllerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LevelControllerScreenState createState() => _LevelControllerScreenState();
}

class _LevelControllerScreenState extends State<LevelControllerScreen> {
  // Total number of levels
  final int totalLevels = 4;

  // Current active level index
  int currentLevel = 0;

  // List to track unlocked levels
  List<bool> unlockedLevels = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: const Text('Game Levels'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Level Indicators
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(totalLevels, (index) {
                return GestureDetector(
                  onTap: () {
                    if (unlockedLevels[index]) {
                      setState(() {
                        currentLevel = index;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Level ${index + 1} is locked.'),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      // Level Icon
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: unlockedLevels[index]
                            ? Colors.blueAccent
                            : Colors.grey,
                        child: Icon(
                          unlockedLevels[index] ? Icons.lock_open : Icons.lock,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Level Label
                      Text(
                        'Level ${index + 1}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: unlockedLevels[index]
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const Divider(),
          // Level Content Area using IndexedStack
          Expanded(
            child: IndexedStack(
              index: currentLevel,
              children: List.generate(totalLevels, (index) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dummy content for each level
                        [
                          VideoScreen(),
                          const MCQView(),
                          PuzzleScreen(),
                          MatchingGameScreen()
                        ][index],
                        const SizedBox(height: 20),
                        // Button to simulate completing the level
                        ElevatedButton(
                          onPressed: () {
                            _completeLevel(index);
                          },
                          child: Text('Complete Level ${index + 1}'),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous Button
                ElevatedButton.icon(
                  onPressed: currentLevel > 0
                      ? () {
                          setState(() {
                            currentLevel--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                ),
                // Next Button
                ElevatedButton.icon(
                  onPressed: currentLevel < totalLevels - 1 &&
                          unlockedLevels[currentLevel + 1]
                      ? () {
                          setState(() {
                            currentLevel++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to handle level completion
  void _completeLevel(int index) {
    if (index == totalLevels - 1) {
      // Last level completed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Congratulations! All levels completed.'),
        ),
      );
      return;
    }

    setState(() {
      // Unlock the next level
      if (index + 1 < totalLevels) {
        unlockedLevels[index + 1] = true;
      }
      // Optionally, navigate to the next level automatically
      currentLevel = index + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Level ${index + 1} completed! Level ${index + 2} unlocked.'),
      ),
    );
  }
}
