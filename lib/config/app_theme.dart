import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

class AppTheme {
  ThemeData themeData(
      {required BuildContext context,
      required double titleFontsize,
      required int fontSize,
      required Color titleColor,
      required Color contentColor,
      required String fontFamily}) {
    return ThemeData(
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
      appBarTheme: appBarTheme(),
      useMaterial3: true,
      textTheme: TextTheme(
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

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
