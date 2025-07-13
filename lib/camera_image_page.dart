import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraImagePage extends StatefulWidget {
  @override
  _CameraImagePageState createState() => _CameraImagePageState();
}

class _CameraImagePageState extends State<CameraImagePage> {
  File? _image;

  Future<void> _takePicture() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _takePicture(); // ambil gambar langsung saat halaman dibuka
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📸 Kamera → Gambar")),
      body: Center(
        child: _image == null ? Text("Belum ada gambar.") : Image.file(_image!),
      ),
    );
  }
}
