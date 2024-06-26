import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      required VoidCallback onTap,
      required BuildContext context}) {
    return GFIconButton(
      size: size,
      iconSize: size,
      onPressed: onTap,
      shape: GFIconButtonShape.square,
      alignment: Alignment.center,
      icon: Icon(
        iconData,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      borderShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
