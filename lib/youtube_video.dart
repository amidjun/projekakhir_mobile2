import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatelessWidget {
  static String videoID = 'clU8c2fpk2s';

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(autoPlay: false, mute: false),
  );

  YoutubeVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text("Play Video from Youtube"),
            SizedBox(height: 30),
            YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}
