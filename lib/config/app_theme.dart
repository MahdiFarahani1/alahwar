import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

class AppTheme {
  ThemeData lightTheme({
    required double titleFontsize,
    required int fontSize,
    required Color titleColor,
    required Color contentColor,
    required String fontFamily,
    required Color baseColor,
  }) {
    return ThemeData(
        highlightColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Arabic",
        sliderTheme: SliderThemeData(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: const Color.fromRGBO(158, 158, 158, 1),
            thumbColor: ConstColor.objectColor,
            inactiveTickMarkColor: Colors.grey,
            activeTickMarkColor: Colors.black,
            trackHeight: 1,
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 1)),
        popupMenuTheme: const PopupMenuThemeData(color: Colors.amber),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          labelMedium: const TextStyle(color: Colors.black),
          bodyLarge: TextStyle(
            color: contentColor,
            fontFamily: fontFamily,
            fontSize: fontSize.toDouble(),
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            fontFamily: fontFamily,
            fontSize: titleFontsize,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
        primaryColorLight: baseColor);
  }

  ThemeData darkTheme({
    required double titleFontsize,
    required int fontSize,
    required Color titleColor,
    required Color contentColor,
    required String fontFamily,
    required Color baseColor,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColorLight: baseColor,
      highlightColor: Colors.white,
      fontFamily: "Arabic",
      sliderTheme: SliderThemeData(
          activeTrackColor: Colors.blue,
          inactiveTrackColor: const Color.fromRGBO(158, 158, 158, 1),
          thumbColor: ConstColor.objectColor,
          inactiveTickMarkColor: Colors.grey,
          activeTickMarkColor: Colors.black,
          trackHeight: 1,
          tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 1)),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.amber),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        labelMedium: const TextStyle(color: Colors.white),
        bodyLarge: TextStyle(
          color: contentColor,
          fontFamily: fontFamily,
          fontSize: fontSize.toDouble(),
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: titleFontsize,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
    );
  }
}
