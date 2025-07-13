import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryImagePage extends StatefulWidget {
  @override
  _GalleryImagePageState createState() => _GalleryImagePageState();
}

class _GalleryImagePageState extends State<GalleryImagePage> {
  File? _image;

  Future<void> _pickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pickFromGallery(); // buka galeri langsung
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🖼️ Galeri → Gambar")),
      body: Center(
        child: _image == null ? Text("Belum ada gambar.") : Image.file(_image!),
      ),
    );
  }
}
