import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusikPage extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  MusikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Play Musik")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Play Musik", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Image.asset("assets/musik.jpg"),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Play'),
              onPressed: () {
                player.play(AssetSource('satusatuwoi.mp3'));
              },
            ),
            ElevatedButton(
              child: const Text('Pause'),
              onPressed: () {
                player.pause();
              },
            ),
            ElevatedButton(
              child: const Text('Resume'),
              onPressed: () {
                player.resume();
              },
            ),
            ElevatedButton(
              child: const Text('Stop'),
              onPressed: () {
                player.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
