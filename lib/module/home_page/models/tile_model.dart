import 'package:ecominds/models/mcq_model.dart';

class TileModel {
  final String imagePath;
  final String title;
  final String lessons;
  final String puzzleImageLink;
  final bool isUnlocked;
  final double puzzlePoint;
  final List<double?> earnedPoints;
  final List<MCQModel> mcqData;
  final List<String> videoLinks;
  final Map<String, String> matchingImageData;

  TileModel({
    required this.imagePath,
    required this.title,
    required this.puzzleImageLink,
    required this.lessons,
    required this.isUnlocked,
    required this.earnedPoints,
    required this.mcqData,
    required this.videoLinks,
    required this.puzzlePoint,
    required this.matchingImageData,
  });
}
