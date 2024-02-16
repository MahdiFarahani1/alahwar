import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';

class BtnSocial {
  static Widget btn({required IconData iconData}) {
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

  static List<Widget> allbtn() {
    return [
      BtnSocial.btn(iconData: FontAwesomeIcons.telegram),
      EsaySize.gap(10),
      BtnSocial.btn(iconData: FontAwesomeIcons.youtube),
      EsaySize.gap(10),
      BtnSocial.btn(iconData: FontAwesomeIcons.facebook),
      EsaySize.gap(10),
      BtnSocial.btn(iconData: FontAwesomeIcons.twitter),
    ];
  }
}
