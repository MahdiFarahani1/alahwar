import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      appBarTheme: appBarTheme(),
      useMaterial3: true,
    );
  }

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));
  }
}
