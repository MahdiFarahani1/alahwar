import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/firebase_api.dart';
import 'package:flutter_application_1/features/favorite_feature/date/local/database.dart';
import 'package:hive_flutter/adapters.dart';

late Box box;
late Box saveBox;

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyA492wcft3OF7q7rXQlquiCU6bhXdNuiPA",
              appId: "1:295475604369:android:63b6aa12f1dd75a350c830",
              messagingSenderId: "295475604369",
              projectId: "alahwar"))
      : await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await Hive.initFlutter();
  saveBox = await Hive.openBox("saveFinlalyList");
  Hive.registerAdapter(ObjectDataBaseAdapter());
  box = await Hive.openBox("news");
}
