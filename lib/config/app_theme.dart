import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      useMaterial3: true,
    );
  }
}
