import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class Btn {
  static Widget btnSocial({required IconData iconData}) {
    return GFIconButton(
      onPressed: null,
      shape: GFIconButtonShape.circle,
      boxShadow: BoxShadow(
          offset: const Offset(2, 2),
          color: ConstColor.bgColor,
          spreadRadius: 2),
      alignment: Alignment.center,
      icon: Icon(iconData),
    );
  }

  static Widget btncircle(
      {required IconData iconData,
      required double size,
      required VoidCallback onTap}) {
    return GFIconButton(
      size: size,
      iconSize: size,
      onPressed: onTap,
      shape: GFIconButtonShape.circle,
      boxShadow: BoxShadow(
          offset: const Offset(2, 2),
          color: ConstColor.bgColor,
          spreadRadius: 2),
      alignment: Alignment.center,
      icon: Icon(iconData),
    );
  }

  static List<Widget> allbtn() {
    return [
      Btn.btnSocial(iconData: FontAwesomeIcons.telegram),
      EsaySize.gap(10),
      Btn.btnSocial(iconData: FontAwesomeIcons.youtube),
      EsaySize.gap(10),
      Btn.btnSocial(iconData: FontAwesomeIcons.facebook),
      EsaySize.gap(10),
      Btn.btnSocial(iconData: FontAwesomeIcons.twitter),
    ];
  }
}
