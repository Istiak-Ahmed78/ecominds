import 'package:ecominds/models/meta_model.dart';
import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class ClimateBasicsScreen extends StatefulWidget {
  final ValueChanged<int> onCompleteClick;

  const ClimateBasicsScreen({super.key, required this.onCompleteClick});

  @override
  _ClimateBasicsScreenState createState() => _ClimateBasicsScreenState();
}

class _ClimateBasicsScreenState extends State<ClimateBasicsScreen> {
  late YoutubePlayerController _youtubeController;

  final TextEditingController _commentController = TextEditingController();
  String? videoURL;
  List<String> videoLinks = [];
  List<MyMetaDataModel?> videoMetaData = [];
  Map<String, int> scoreData = {};
  MyMetaDataModel? currentlyBeingPlayed;
  final topicIndex = HomeController.to.currentTopicIndex;
  int get currentScore => scoreData.values.fold(0, (sum, value) => sum + value);
  int get totalVideos => videoMetaData.length;

  void initialData() {
    videoLinks = HomeController.to.tileData[topicIndex.value].videoLinks;

    videoURL = videoLinks.firstOrNull; // Example video

    videoURL = videoLinks.firstOrNull; // Example video

    if (videoURL != null) {
      // Extract video ID
      final videoId = YoutubePlayer.convertUrlToId(videoURL!);

      // Initialize YouTube Player controller
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  bool isLoading = true;
  void loadVideos() async {
    for (var v in videoLinks) {
      var metadata = await getPreviewData(v);
      videoMetaData.add(MyMetaDataModel(
        title: metadata.title,
        imageLink: metadata.image?.url,
        videoID: YoutubePlayer.convertUrlToId(v),
      ));
      setState(() {});
    }
    currentlyBeingPlayed = videoMetaData.firstOrNull;
    isLoading = false;
    setState(() {});
    if (currentlyBeingPlayed?.videoID != null) {
      _youtubeController.load(currentlyBeingPlayed!.videoID!);
    }
  }

  @override
  void initState() {
    super.initState();
    initialData();
    loadVideos();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Column(
                children: [
                  Text(
                      'Your score: $currentScore/${HomeController.to.tileData[topicIndex.value].videoLinks.length * 2}'),
                  if (videoLinks.isNotEmpty)
                    Text(
                        'You watched: ${scoreData.length}/${HomeController.to.tileData[topicIndex.value].videoLinks.length}'),
                ],
              ),
            ),
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              onEnded: (youtubeMetaData) {
                String? curerntPlayID = currentlyBeingPlayed?.videoID;
                if (curerntPlayID != null) {
                  scoreData[curerntPlayID] = 2;
                  int? currentPlayingIndex = videoMetaData.indexWhere(
                      (e) => e?.videoID == currentlyBeingPlayed?.videoID);
                  if (currentPlayingIndex != -1 &&
                      currentPlayingIndex + 1 != totalVideos) {
                    if (!scoreData.keys.contains(
                        videoMetaData[currentPlayingIndex + 1]?.videoID)) {
                      var nextVideoVideoID =
                          videoMetaData[currentPlayingIndex + 1]?.videoID;
                      if (nextVideoVideoID != null) {
                        _youtubeController.load(nextVideoVideoID);
                        currentlyBeingPlayed =
                            videoMetaData[currentPlayingIndex + 1];
                      }
                    }
                  }
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: videoMetaData
                  .map((e) =>
                      _buildVideoItem(e, scoreData.keys.contains(e?.videoID)))
                  .toList(),
            ),
            if (!isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      _youtubeController.pause();
                      // if (currentScore != 8) {
                      //   MyToast.showErrorToast(
                      //       'Complete seeing all videos please');
                      // } else {
                      widget.onCompleteClick.call(0);
                      LavelController.to.addPointToALevel(0, 8);
                      int curentTopicIndex =
                          HomeController.to.currentTopicIndex.value;
                      McqController.to.loadMCQList(
                          HomeController.to.tileData[curentTopicIndex].mcqData);
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            else if (videoMetaData.isEmpty)
              const Text('Videos are being loaded. Please wait...')
          ],
        ),
      ),
    );
  }

  Widget _buildVideoItem(MyMetaDataModel? metaData, bool isCompleted) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tileColor: Colors.green.shade100,
        leading: Icon(currentlyBeingPlayed?.videoID == metaData?.videoID
            ? Icons.pause_circle
            : isCompleted
                ? Icons.check_circle
                : Icons.play_circle),
        title: Text(metaData?.title ?? ''),
        subtitle: Text('6s'),
        // trailing: Icon(Icons.play_circle),
        onTap: () {
          if (metaData?.videoID != null) {
            currentlyBeingPlayed = metaData;
            _youtubeController.load(metaData!.videoID!);
            setState(() {});
          }
        },
      ),
    );
  }
}
