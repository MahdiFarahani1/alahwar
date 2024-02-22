import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

class CostumGradient {
  static linear() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ConstColor.bgColor,
          ConstColor.objectColor,
          ConstColor.bgColor,
        ]);
  }
}
