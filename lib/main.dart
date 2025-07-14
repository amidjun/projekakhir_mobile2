import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';
import 'sign_in.dart'; // halaman login
import 'home_page.dart';


// Handler ketika app dalam background/terminated
Future<void> backgroundHandler(RemoteMessage message) async {
  print("Background Message Title: ${message.notification?.title}");
  print("Background Message Data: ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp();

  // Setup handler untuk background notification
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // Inisialisasi notifikasi lokal (tanpa context karena belum ada widget)
  LocalNotificationService.initialize(null);

  // Subscribe ke topik notifikasi
  await FirebaseMessaging.instance.subscribeToTopic('myTopic');

  // Jalankan aplikasi
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login with Google + FCM',
      debugShowCheckedModeBanner: false,
      // Langsung arahkan ke halaman SignIn
      home: HomePage(), // <--- tampilan login kamu
    );
  }
}
