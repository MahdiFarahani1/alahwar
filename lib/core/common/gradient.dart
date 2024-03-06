import 'package:flutter/material.dart';
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

  static linearGrey() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey.shade100,
          ConstColor.greyWithShade,
          Colors.grey.shade100
        ]);
  }
}
