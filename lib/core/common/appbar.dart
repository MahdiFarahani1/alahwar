import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_searchbtn.dart';

class AppBarCommon {
  static AppBar appBar(String text, BuildContext context,
      {bool isSearchPage = false}) {
    return AppBar(
      actions: [
        !isSearchPage ? SearchFeature.add(context) : const SizedBox.shrink()
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Image.asset(
        "assets/images/logo.png",
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
