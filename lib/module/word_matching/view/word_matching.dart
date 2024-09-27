import 'package:flutter/material.dart';

class MatchingGameScreen extends StatefulWidget {
  @override
  _MatchingGameScreenState createState() => _MatchingGameScreenState();
}

class _MatchingGameScreenState extends State<MatchingGameScreen> {
  List<String> facts = [
    "Fastest land animal",
    "Largest ocean",
    "Tallest mountain",
    "Brightest star",
  ];

  List<String> images = [
    "https://www.shutterstock.com/image-photo/cheetah-close-view-naankuse-wildlife-260nw-377377450.jpg", // replace with real images
    "https://images.nationalgeographic.org/image/upload/v1652341068/EducationHub/photos/ocean-waves.jpg", // replace with real images
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGEu4pHOxMvHXDb6jQYvXhdjx1V0VPI7reYA&s", // replace with real images
    "https://cdn.britannica.com/07/186507-138-CCAD17CA/Overview-types-stars-red-dwarf-giant-supergiant.jpg?w=800&h=450&c=crop", // replace with real images
  ];

  // Correct matching between facts and images by index
  Map<int, int> correctMatches = {
    0: 0, // "Fastest land animal" -> "cheetah.png"
    1: 1, // "Largest ocean" -> "ocean.png"
    2: 2, // "Tallest mountain" -> "mountain.png"
    3: 3, // "Brightest star" -> "star.png"
  };

  List<int?> selectedMatches =
      List<int?>.filled(4, null); // Store selected matches
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Left side: List of interesting facts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(facts.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Draggable<int>(
                        data: index,
                        child: FactTile(
                          fact: facts[index],
                          matched: selectedMatches[index] != null,
                        ),
                        feedback: Material(
                          child: FactTile(
                            fact: facts[index],
                            matched: false,
                          ),
                          elevation: 3.0,
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: FactTile(
                            fact: facts[index],
                            matched: false,
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class FactTile extends StatelessWidget {
  final String fact;
  final bool matched;

  const FactTile({required this.fact, required this.matched});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: matched ? Colors.greenAccent : Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12),
      child: Text(
        fact,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  final String imagePath;
  final bool matched;

  const ImageTile({required this.imagePath, required this.matched});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: matched ? Colors.greenAccent : Colors.white,
      ),
      padding: EdgeInsets.all(12),
      child: Image.network(
        imagePath,
        height: 100,
        width: 100,
      ),
    );
  }
}
