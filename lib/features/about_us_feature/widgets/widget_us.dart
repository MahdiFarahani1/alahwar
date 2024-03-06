import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/about_us_feature/repository/aboutus_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class Btn {
  static Widget btnSocial(
      {required IconData iconData, required VoidCallback onPress}) {
    return GFIconButton(
      onPressed: onPress,
      alignment: Alignment.center,
      icon: Icon(
        iconData,
        size: 22,
      ),
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
      Btn.btnSocial(
        iconData: FontAwesomeIcons.earthAmericas,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlSite);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.instagram,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlInstagram);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.telegram,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlTelegram);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.youtube,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlYoutube);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.facebook,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlFacebook);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.xTwitter,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlTwitter);
        },
      ),
    ];
  }
}
