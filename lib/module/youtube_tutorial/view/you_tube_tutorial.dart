import 'package:ecominds/models/meta_model.dart';
import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:ecominds/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

// class VideoScreen extends StatefulWidget {
//   final ValueChanged<int> onCompleteClick;

//   const VideoScreen({super.key, required this.onCompleteClick});

//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//   // YouTube video controller
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     const videoURL =
//         "https://www.youtube.com/watch?v=dQw4w9WgXcQ"; // Example video

//     // Extract video ID
//     final videoId = YoutubePlayer.convertUrlToId(videoURL);
//     // Initialize YouTube Player controller
//     _controller = YoutubePlayerController(
//       initialVideoId: videoId ?? "",
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose the YouTube player controller when not in use
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // YouTube video player
//           YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             onReady: () {
//               print('Player is ready.');
//             },
//           ),
//           const SizedBox(height: 20),
//           // Option buttons in tile form
//           ListView(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             children: const [
//               Text(
//                 'Write a summery on the video',
//                 style: TextStyle(color: Colors.green),
//               ),
//               TextField(
//                 maxLength: 250,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(),
//                     hintText: 'Enter text here'),
//               ),
//             ],
//           ),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               onPressed: () {
//                 McqController.to.resetInputs();
//                 LavelController.to.addPointToALevel(0, 5);
//                 widget.onCompleteClick(0);
//               },
//               child: const Text(
//                 'Submit',
//                 style: TextStyle(color: Colors.white),
//               ))
//         ],
//       ),
//     );
//   }

//   // Helper method to create option tiles
//   Widget _buildOptionTile(String title, IconData icon, VoidCallback onTap) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(icon, size: 40, color: Colors.blueAccent),
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }

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
    print(topicIndex);
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
    setState(() {});
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
      child: Column(
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
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: videoMetaData
                .map((e) =>
                    _buildVideoItem(e, scoreData.keys.contains(e?.videoID)))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              ElevatedButton(
                onPressed: () {
                  _youtubeController.pause();
                  // if (currentScore != 8) {
                  //   MyToast.showErrorToast('Complete seeing all videos please');
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
        ],
      ),
    );
  }

  Widget _buildVideoItem(MyMetaDataModel? metaData, bool isCompleted) {
    return ListTile(
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
    );
  }
}
