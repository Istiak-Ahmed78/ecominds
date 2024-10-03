import 'package:ecominds/module/hands_on_module/view/hands_on_module.dart';
import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/module/mcq/view/mcq_view.dart';
import 'package:ecominds/module/puzzle/view/puzzle2.dart';
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
  @override
  Widget build(BuildContext context) {
    final titile = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back)),
        title: Text(titile ?? 'Game Levels'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return GetBuilder<LavelController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Level Indicators
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      List.generate(controller.levelScores.length, (index) {
                    bool isActive = index == 0
                        ? true
                        : controller.levelScores[index - 1] != null;
                    return GestureDetector(
                      onTap: !isActive
                          ? null
                          : () => controller.changeCurrentLEvelIndex(
                              index, !isActive, context),
                      child: Column(
                        children: [
                          // Level Icon
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                isActive ? Colors.blueAccent : Colors.grey,
                            child: Icon(
                              isActive ? Icons.lock_open : Icons.lock,
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
                              color: index <= controller.currentLevelIndex.value
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
              Expanded(
                child: IndexedStack(
                  index: controller.currentLevelIndex.value,
                  children:
                      List.generate(controller.levelScores.length, (index) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Dummy content for each level
                          [
                            ClimateBasicsScreen(
                              onCompleteClick: _completeLevel,
                            ),
                            MCQView(
                              onCompleteClick: _completeLevel,
                            ),
                            PuzzleScreen(
                              onCompleteClick: _completeLevel,
                            ),
                            if (homeController.currentTopicIndex.value == 3)
                              HandsOnActivityScreen(
                                onCompleteClick: _completeLevel,
                              )
                            else
                              MatchingGameScreen(
                                onCompleteClick: _completeLevel,
                              )
                          ][index],
                          const SizedBox(height: 20),
                          // Button to simulate completing the level
                          // ElevatedButton(
                          //   onPressed: () {
                          //     _completeLevel(index);
                          //   },
                          //   child: Text('Complete Level ${index + 1}'),
                          // ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              // Navigation Buttons
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       // Previous Button
              //       ElevatedButton.icon(
              //         onPressed: currentLevel > 0
              //             ? () {
              //                 setState(() {
              //                   currentLevel--;
              //                 });
              //               }
              //             : null,
              //         icon: const Icon(Icons.arrow_back),
              //         label: const Text('Previous'),
              //       ),
              //       // Next Button
              //       ElevatedButton.icon(
              //         onPressed: currentLevel < totalLevels - 1 &&
              //                 unlockedLevels[currentLevel + 1]
              //             ? () {
              //                 setState(() {
              //                   currentLevel++;
              //                 });
              //               }
              //             : null,
              //         icon: const Icon(Icons.arrow_forward),
              //         label: const Text('Next'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );
        });
      }),
    );
  }

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
