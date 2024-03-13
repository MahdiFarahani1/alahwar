import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

class CostumGradient {
  static linearBlue() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ConstColor.bgColor,
          ConstColor.objectColor,
          ConstColor.bgColor,
        ]);
  }

  static linearGrey(BuildContext context) {
    bool colorCategory = saveBox.get("switchTheme") ??
        MediaQuery.platformBrightnessOf(context) == Brightness.light;
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colorCategory
            ? [
                Colors.grey.shade100,
                Theme.of(context).primaryColorLight,
                Colors.grey.shade100
              ]
            : [
                Colors.grey.shade900,
                Colors.grey.shade800,
              ]);
  }
}
