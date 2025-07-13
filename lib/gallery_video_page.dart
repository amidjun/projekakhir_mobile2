import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoPage extends StatefulWidget {
  @override
  _GalleryVideoPageState createState() => _GalleryVideoPageState();
}

class _GalleryVideoPageState extends State<GalleryVideoPage> {
  File? _video;
  VideoPlayerController? _controller;

  Future<void> _pickVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
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
    _pickVideo(); // buka galeri video langsung
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🎞️ Galeri → Video")),
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
