import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';

class AppBarCommon {
  static AppBar appBar(String text) {
    return AppBar(
      centerTitle: true,
      backgroundColor: ConstColor.appbarColor,
      title: Text(text),
    );
  }
}
