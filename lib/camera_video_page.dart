import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CameraVideoPage extends StatefulWidget {
  @override
  _CameraVideoPageState createState() => _CameraVideoPageState();
}

class _CameraVideoPageState extends State<CameraVideoPage> {
  File? _video;
  VideoPlayerController? _controller;

  Future<void> _recordVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (picked != null) {
      _video = File(picked.path);
      _controller = VideoPlayerController.file(_video!)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _recordVideo(); // buka kamera video langsung
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🎥 Kamera → Video")),
      body: Center(
        child: _controller == null
            ? Text("Belum ada video.")
            : AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
      ),
    );
  }
}
