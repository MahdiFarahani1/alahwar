import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/main.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(
      (RemoteMessage message) async {
        debugPrint("title :${message.notification?.title}");
        debugPrint("body :${message.notification?.body}");
        debugPrint("payload :${message.data}");
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      int id = int.parse(message.data["id"]);
      if (id == 0) {
        //    print("notif");
        //  print("$id}");
      } else {
        //    print("news");
        //  print("$id");
        navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
      }
    });
  }
}
