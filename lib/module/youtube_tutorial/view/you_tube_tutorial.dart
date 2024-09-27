import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // YouTube video controller
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    const videoURL =
        "https://www.youtube.com/watch?v=dQw4w9WgXcQ"; // Example video

    // Extract video ID
    final videoId = YoutubePlayer.convertUrlToId(videoURL);

    // Initialize YouTube Player controller
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the YouTube player controller when not in use
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // YouTube video player
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
          SizedBox(height: 20),
          // Option buttons in tile form
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Text('Write a summery on the video'),
              TextField(
                maxLength: 250,
                maxLines: 3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter text here'),
              ),
              // _buildOptionTile('Puzzle Game', Icons.extension, () {
              //   // Handle Puzzle Game action
              // }),
              // _buildOptionTile('Action Game', Icons.games, () {
              //   // Handle Action Game action
              // }),
              // _buildOptionTile('Quiz Game', Icons.question_answer, () {
              //   // Handle Quiz Game action
              // }),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to create option tiles
  Widget _buildOptionTile(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
