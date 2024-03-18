import 'dart:core';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/config/firebase/helper_firebase.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/main.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();
    
    _firebaseMessaging.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      int id = int.parse(message.data["id"]);
      if (id != 0) {
        navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
      }
    });

    _firebaseMessaging
        .getInitialMessage()
        .then((RemoteMessage? initialMessage) {
      if (initialMessage != null) {
        HelperFireBase.checker = false;
        int id = int.parse(initialMessage.data["id"]);

        navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      int id = int.parse(message.data["id"]);
      if (id != 0) {
        navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
      }
    });
  }
}
