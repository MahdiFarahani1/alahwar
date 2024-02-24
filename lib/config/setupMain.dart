import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/favorite_feature/date/local/database.dart';
import 'package:hive_flutter/adapters.dart';

late Box box;
late Box saveBox;

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  saveBox = await Hive.openBox("saveFinlalyList");
  Hive.registerAdapter(ObjectDataBaseAdapter());
  box = await Hive.openBox("news");
}
