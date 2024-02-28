import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

class AppTheme {
  ThemeData themeData(
      {required BuildContext context,
      required int fontSize,
      required Color titleColor,
      required Color contentColor}) {
    return ThemeData(
      // sliderTheme: SliderThemeData(
      //   trackHeight: 10.0,
      //   trackShape: RoundedRectSliderTrackShape(),
      //   activeTrackColor: Colors.purple.shade800,
      //   inactiveTrackColor: Colors.purple.shade100,
      //   thumbShape: RoundSliderThumbShape(
      //     enabledThumbRadius: 14.0,
      //     pressedElevation: 8.0,
      //   ),
      //   thumbColor: Colors.pinkAccent,
      //   overlayColor: Colors.pink.withOpacity(0.2),
      //   overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
      //   tickMarkShape: RoundSliderTickMarkShape(),
      //   activeTickMarkColor: Colors.pinkAccent,
      //   inactiveTickMarkColor: Colors.white,
      //   valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      //   valueIndicatorColor: Colors.black,
      //   valueIndicatorTextStyle: TextStyle(
      //     color: Colors.white,
      //     fontSize: 20.0,
      //   ),
      // ),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.amber),
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
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
      iconTheme: IconThemeData(color: ConstColor.iconAppbarColor),
      titleTextStyle: TextStyle(
        color: ConstColor.iconAppbarColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
