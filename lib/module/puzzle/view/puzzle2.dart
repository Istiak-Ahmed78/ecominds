import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:ecominds/data/repo/nasa_api.dart';
import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PuzzleScreen extends StatefulWidget {
  final ValueChanged<int> onCompleteClick;
  const PuzzleScreen({
    super.key,
    required this.onCompleteClick,
  });
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  bool showNextLevelNavigateOption = false;
  List<ImagePiece> pieces = [];
  final int gridSize = 4; // 4x4 puzzle
  final homeController = HomeController.to;
  String? imageUrl;
  final Random random = Random();
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final data = await getPicturesOfTheDayForPuzzle();

    if (data?.url != null) {
      imageUrl = data!.url!;
      setState(() {});
      final response = await http.get(Uri.parse(imageUrl!));
      final Uint8List bytes = response.bodyBytes;
      final Completer<ui.Image> completer = Completer();
      ui.decodeImageFromList(bytes, completer.complete);
      image = await completer.future;

      _createPuzzlePieces();
      _shufflePieces();
      // shuffleOneTile();
    }
  }

  void _createPuzzlePieces() {
    if (image == null) return;

    int pieceWidth = (image!.width / gridSize).round();
    int pieceHeight = (image!.height / gridSize).round();

    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        pieces.add(ImagePiece(
          x: x,
          y: y,
          image: image!,
          pieceWidth: pieceWidth,
          pieceHeight: pieceHeight,
          gridSize: gridSize,
          isEmpty:
              (x == gridSize - 1 && y == gridSize - 1), // Last piece is empty
        ));
      }
    }
  }

  void shuffleOneTile() {
    // Find the index of the empty tile
    int emptyIndex = pieces.indexWhere((piece) => piece.isEmpty);

    // Determine the possible moves based on the empty tile's position
    List<int> possibleMoves = [];

    // Check left
    if (emptyIndex % gridSize > 0) {
      possibleMoves.add(emptyIndex - 1); // Move from left
    }
    // Check right
    if (emptyIndex % gridSize < gridSize - 1) {
      possibleMoves.add(emptyIndex + 1); // Move from right
    }
    // Check up
    if (emptyIndex ~/ gridSize > 0) {
      possibleMoves.add(emptyIndex - gridSize); // Move from above
    }
    // Check down
    if (emptyIndex ~/ gridSize < gridSize - 1) {
      possibleMoves.add(emptyIndex + gridSize); // Move from below
    }

    // Select one random possible move to shuffle
    if (possibleMoves.isNotEmpty) {
      int moveIndex = possibleMoves[random.nextInt(possibleMoves.length)];

      // Swap the empty tile with the selected tile
      setState(() {
        final temp = pieces[moveIndex];
        pieces[moveIndex] = pieces[emptyIndex];
        pieces[emptyIndex] = temp;
      });
    }
  }

  void _shufflePieces() {
    pieces.shuffle();
    setState(() {});
  }

  bool _isPuzzleCompleted() {
    for (int i = 0; i < pieces.length; i++) {
      // The correct position should match the original piece position
      if (pieces[i].x != i % gridSize || pieces[i].y != i ~/ gridSize) {
        return false;
      }
    }
    return true;
  }

  void _movePiece(int index) {
    if (pieces[index].isEmpty) return;

    int emptyIndex = pieces.indexWhere((piece) => piece.isEmpty);
    if (_canMove(index, emptyIndex)) {
      setState(() {
        // Swap pieces
        final temp = pieces[index];
        pieces[index] = pieces[emptyIndex];
        pieces[emptyIndex] = temp;
      });
    }
    // Check for completion
    if (_isPuzzleCompleted()) {
      showNextLevelNavigateOption = true;
      setState(() {});
      _showCompletionDialog();
    } else {
      showNextLevelNavigateOption = false;
      setState(() {});
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You completed the puzzle!'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _shufflePieces();
                showNextLevelNavigateOption = false;
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  bool _canMove(int index, int emptyIndex) {
    int row1 = index ~/ gridSize;
    int col1 = index % gridSize;
    int row2 = emptyIndex ~/ gridSize;
    int col2 = emptyIndex % gridSize;
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.to;
    double pointToOptain = homeController
        .tileData[homeController.currentTopicIndex.value].puzzlePoint;
    return image == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('You will get $pointToOptain points on completing this.'),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius:
                        const BorderRadius.all(ui.Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Match the following image:'),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: imageUrl == null
                          ? const Icon(Icons.image)
                          : Image.network(imageUrl!),
                    )
                  ],
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                ),
                itemCount: pieces.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _movePiece(index),
                    child: Container(
                      margin: const EdgeInsets.all(1.0),
                      color:
                          pieces[index].isEmpty ? Colors.white : Colors.black,
                      child: pieces[index].isEmpty
                          ? Container()
                          : ClipRect(
                              child: CustomPaint(
                                painter: PiecePainter(pieces[index]),
                                size: Size(
                                  pieces[index].pieceWidth.toDouble(),
                                  pieces[index].pieceHeight.toDouble(),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              if (showNextLevelNavigateOption)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.green.shade100,
                          ),
                          onPressed: () {
                            widget.onCompleteClick(2);

                            LavelController.to
                                .addPointToALevel(2, pointToOptain);
                          },
                          child: const Text('Navigate to next level')),
                    ),
                  ),
                )
            ],
          );
  }
}

class ImagePiece {
  final int x;
  final int y;
  final ui.Image image;
  final int pieceWidth;
  final int pieceHeight;
  final int gridSize;
  bool isEmpty;

  ImagePiece({
    required this.x,
    required this.y,
    required this.image,
    required this.pieceWidth,
    required this.pieceHeight,
    required this.gridSize,
    required this.isEmpty,
  });
}

class PiecePainter extends CustomPainter {
  final ImagePiece piece;

  PiecePainter(this.piece);

  @override
  void paint(Canvas canvas, Size size) {
    Rect srcRect = Rect.fromLTWH(
      piece.x * piece.pieceWidth.toDouble(),
      piece.y * piece.pieceHeight.toDouble(),
      piece.pieceWidth.toDouble(),
      piece.pieceHeight.toDouble(),
    );
    Rect dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(piece.image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
