import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themeData(
      {required BuildContext context,
      required int fontSize,
      required Color titleColor,
      required Color contentColor}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      appBarTheme: appBarTheme(),
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: contentColor,
          fontFamily: "Salamat",
          fontSize: fontSize.toDouble(),
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          fontFamily: "Salamat",
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
    );
  }

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
