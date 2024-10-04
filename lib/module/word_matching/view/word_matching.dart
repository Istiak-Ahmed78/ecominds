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
  Map<int, int> correctMatches = {0: 0, 1: 1, 2: 2, 3: 3};

  // Track if a fact was already tried and failed
  List<bool> factTried = List<bool>.filled(4, false);

  // Track selected matches with possibility of storing mismatches as null
  List<int?> selectedMatches = List<int?>.filled(4, null);
  double points = 0;

  final homeController = HomeController.to;

  void loadIntialData() {
    points = 0;
    int currentTopicIndex = homeController.currentTopicIndex.value;

    // Load facts and images as pairs
    var factImagePairs = homeController
        .tileData[currentTopicIndex].matchingImageData.entries
        .toList();

    // Separate facts and images into their respective lists
    facts = factImagePairs.map((entry) => entry.key).toList();
    images = factImagePairs.map((entry) => entry.value).toList();
    images.shuffle();
    // After shuffling, update correctMatches based on the new indices
    correctMatches = {};
    for (int i = 0; i < factImagePairs.length; i++) {
      correctMatches[i] =
          images.indexWhere((pair) => pair == factImagePairs[i].value);
    }
  }

  @override
  void initState() {
    loadIntialData();
    super.initState();
  }

  // Reset game logic
  void resetGame() {
    setState(() {
      points = 0;
      selectedMatches = List<int?>.filled(facts.length, null);
      factTried = List<bool>.filled(facts.length, false); // Reset tried facts
    });
  }

  // Check if the match is correct and assign points
  void checkMatch(int factIndex, int imageIndex) {
    setState(() {
      if (correctMatches[factIndex] == imageIndex) {
        selectedMatches[factIndex] = imageIndex;
        points += 1.25; // Add point for correct match
      } else {
        factTried[factIndex] = true; // Mark the fact as tried and wrong
      }
    });
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
                        child:
                            factTried[index] || selectedMatches[index] != null
                                ? Opacity(
                                    opacity: 0.5,
                                    child: FactTile(
                                      fact: facts[index],
                                      matched: selectedMatches[index] != null,
                                      isMismatched:
                                          factTried[index], // Red if mismatched
                                    ),
                                  )
                                : Draggable<int>(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onCompleteClick(1);
                  LavelController.to.addPointToALevel(3, 5);
                  HomeController.to.inputACompleteTopic(
                      LavelController.to.levelScores, context);
                },
                child: const Text('Complete this course'),
              ),
              const SizedBox(width: 16),
              // Reset Button
              ElevatedButton(
                onPressed: resetGame,
                child: const Text('Reset Game'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FactTile extends StatelessWidget {
  final String fact;
  final bool matched;
  final bool isMismatched;

  const FactTile(
      {super.key,
      required this.fact,
      required this.matched,
      this.isMismatched = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        color: matched
            ? Colors.greenAccent
            : (isMismatched ? Colors.redAccent : Colors.white),
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
                ? Colors.redAccent
                : Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              // Image is fully loaded
              return child;
            } else {
              // Image is still loading, show progress indicator
              return SizedBox(
                height: 122,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Text(
                      'Image loading: ${(loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) * 100).toStringAsFixed(2)} %'),
                  // child: CircularProgressIndicator(
                  //   value: loadingProgress.expectedTotalBytes != null
                  //       ? loadingProgress.cumulativeBytesLoaded /
                  //           (loadingProgress.expectedTotalBytes ?? 1)
                  //       : null,
                  // ),
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            // If there is an error while loading the image, you can show a placeholder or error widget.
            return const Icon(Icons.error);
          },
          imagePath,
          height: 122,
          width: MediaQuery.of(context).size.width * 0.4,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
