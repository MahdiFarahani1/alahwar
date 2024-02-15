import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';

class BtnSocial {
  static Widget btn({required IconData iconData}) {
    return GFIconButton(
      onPressed: null,
      borderSide: BorderSide(color: ConstColor.appbarColor.withOpacity(0.5)),
      icon: Icon(iconData),
    );
  }

  static List<Widget> allbtn() {
    return [
      BtnSocial.btn(iconData: FontAwesomeIcons.telegram),
      BtnSocial.btn(iconData: FontAwesomeIcons.youtube),
      BtnSocial.btn(iconData: FontAwesomeIcons.facebook),
      BtnSocial.btn(iconData: FontAwesomeIcons.twitter),
    ];
  }
}
