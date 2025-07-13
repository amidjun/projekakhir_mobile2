import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification_service.dart';

class NotificationDisplayPage extends StatefulWidget {
  const NotificationDisplayPage({super.key});

  @override
  _NotificationDisplayPageState createState() => _NotificationDisplayPageState();
}

class _NotificationDisplayPageState extends State<NotificationDisplayPage> {
  String? titleText;
  String? bodyText;

  @override
  void initState() {
    super.initState();

    // Inisialisasi notifikasi lokal
    LocalNotificationService.initialize(context);

    // State 1: App terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationService.createAndDisplayNotification(message);
        setState(() {
          titleText = message.notification?.title;
          bodyText = message.notification?.body;
        });
      }
    });

    // State 2: App foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.createAndDisplayNotification(message);
        setState(() {
          titleText = message.notification?.title;
          bodyText = message.notification?.body;
        });
      }
    });

    // State 3: App background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.createAndDisplayNotification(message);
        setState(() {
          titleText = message.notification?.title;
          bodyText = message.notification?.body;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tampilan Notifikasi"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (titleText != null && bodyText != null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Judul: $titleText",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Isi: $bodyText", style: const TextStyle(fontSize: 16)),
                  ],
                )
              : const Text("Belum ada notifikasi yang masuk"),
        ),
      ),
    );
  }
}
