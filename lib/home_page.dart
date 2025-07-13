import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_info.dart';
import 'musik.dart';
import 'youtube_video.dart';
import 'camera_image_page.dart';
import 'camera_video_page.dart';
import 'gallery_image_page.dart';
import 'gallery_video_page.dart';
import 'notification_display_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ukuran layar
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
           icon: Icon(Icons.notifications),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationDisplayPage()),
        );
      },
    ),
  ],
),
      body: Center(
        child: SizedBox(
          height: screenHeight * 0.8, // supaya tidak full 100% dari atas ke bawah
          width: screenWidth * 0.95,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(), // Tidak bisa di-scroll
            crossAxisCount: 3, // 3 kolom
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildMenuItem(context, icon: Icons.list, label: 'CRUD', onTap: () {}),
              _buildMenuItem(context, icon: Icons.image, label: 'Galeri Gambar', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => GalleryImagePage()));
              }),
              _buildMenuItem(context, icon: Icons.video_library, label: 'Galeri Video', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => GalleryVideoPage()));
              }),
              _buildMenuItem(context, icon: Icons.video_call, label: 'Play YT Video', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => YoutubeVideo()));
              }),
              _buildMenuItem(context, icon: Icons.music_note, label: 'Play Music', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MusikPage()));
              }),
              _buildMenuItem(context, icon: Icons.camera_alt, label: 'Kamera Gambar', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CameraImagePage()));
              }),
              _buildMenuItem(context, icon: Icons.videocam, label: 'Kamera Video', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CameraVideoPage()));
              }),
              _buildMenuItem(context, icon: Icons.map, label: 'Maps', onTap: () {
                // Tambahkan navigasi maps
              }),
              _buildMenuItem(context, icon: Icons.account_circle, label: 'User Info', onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => UserInfoScreen(user: FirebaseAuth.instance.currentUser),
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String label, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
