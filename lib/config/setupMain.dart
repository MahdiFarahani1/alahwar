import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/config/firebase/firebase_api.dart';
import 'package:flutter_application_1/features/favorite_feature/date/local/database.dart';

import 'package:hive_flutter/adapters.dart';

late Box box;
late Box saveBox;

Future<void> setUp() async {
  await Hive.initFlutter();
  saveBox = await Hive.openBox("saveFinlalyList");
  Hive.registerAdapter(ObjectDataBaseAdapter());
  box = await Hive.openBox("news");
}

Future<void> setUpFirebase() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCfvRGjQ4vv610S3_baF0JwIZaIHzUkZPQ",
        appId: "1:57143280985:android:065886be53c4f1fb",
        messagingSenderId: "57143280985",
        projectId: "alahwartv-cfc28",
      ),
    );
    await saveBox.get("alert")
        ? await FirebaseMessaging.instance.subscribeToTopic("general")
        : await FirebaseMessaging.instance.unsubscribeFromTopic("general");
    await FirebaseApi().inintNotifications();
  }
}
