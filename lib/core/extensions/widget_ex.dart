import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

extension WidgetEx on Text {
  Text withStyle(
      {required String text,
      required double fontsize,
      Color? color,
      TextDecoration? textDecoration,
      FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: color,
          fontWeight: fontWeight,
          decoration: textDecoration,
          decorationColor: ConstColor.baseColor),
    );
  }
}
