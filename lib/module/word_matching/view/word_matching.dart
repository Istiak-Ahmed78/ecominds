import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:flutter/material.dart';

class MatchingGameScreen extends StatefulWidget {
  final ValueChanged<int> onCompleteClick;

  const MatchingGameScreen({super.key, required this.onCompleteClick});
  @override
  _MatchingGameScreenState createState() => _MatchingGameScreenState();
}

class _MatchingGameScreenState extends State<MatchingGameScreen> {
  List<String> facts = [];

  List<String> images = [];

  Map<int, int> correctMatches = {
    0: 0,
    1: 1,
    2: 2,
  };

  List<int?> selectedMatches = List<int?>.filled(4, null);
  int points = 0;

  void checkMatch(int factIndex, int imageIndex) {
    setState(() {
      if (correctMatches[factIndex] == imageIndex) {
        selectedMatches[factIndex] = imageIndex;
        points++;
      } else {
        selectedMatches[factIndex] = null;
      }
    });
  }

  final homeController = HomeController.to;
  void loadIntialData() {
    int currentTopicIndex = homeController.currentTopicIndex.value;
    facts = homeController.tileData[currentTopicIndex].matchingImageData.keys
        .toList();
    images = homeController.tileData[currentTopicIndex].matchingImageData.values
        .toList();
  }

  @override
  void initState() {
    loadIntialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: List of interesting facts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(facts.length, (index) {
                    return SizedBox(
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Draggable<int>(
                          data: index,
                          feedback: Material(
                            elevation: 3.0,
                            child: FactTile(
                              fact: facts[index],
                              matched: false,
                            ),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.5,
                            child: FactTile(
                              fact: facts[index],
                              matched: false,
                            ),
                          ),
                          child: FactTile(
                            fact: facts[index],
                            matched: selectedMatches[index] != null,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                // Right side: List of images
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(images.length, (index) {
                    return DragTarget<int>(
                      onAccept: (factIndex) {
                        checkMatch(factIndex, index);
                      },
                      builder: (context, acceptedData, rejectedData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageTile(
                            imagePath: images[index],
                            matched: selectedMatches.contains(index),
                            isMismatched: selectedMatches[index] == null &&
                                acceptedData.isNotEmpty,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          // Display points
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Points: $points',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                widget.onCompleteClick(1);
                LavelController.to.addPointToALevel(3, 5);
                HomeController.to.inputACompleteTopic(
                    LavelController.to.levelScores, context);
              },
              child: const Text('Complete this course'))
        ],
      ),
    );
  }
}

class FactTile extends StatelessWidget {
  final String fact;
  final bool matched;

  const FactTile({super.key, required this.fact, required this.matched});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        color: matched ? Colors.greenAccent : Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          fact,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  final String imagePath;
  final bool matched;
  final bool isMismatched;

  const ImageTile(
      {super.key,
      required this.imagePath,
      required this.matched,
      required this.isMismatched});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: matched
            ? Colors.greenAccent
            : isMismatched
                ? Colors.redAccent // Color for mismatched images
                : Colors.white,
      ),
      // padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imagePath,
          height: 122,
          width: MediaQuery.of(context).size.width * 0.4,
          fit: BoxFit.cover, // To ensure the image fits well
        ),
      ),
    );
  }
}
