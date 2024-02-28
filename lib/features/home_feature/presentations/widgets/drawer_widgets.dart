import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

class DrawerWidgets {
  static Widget drawerItem({
    required BuildContext context,
    required String text,
    required IconData iconData,
    required Function onpress,
  }) {
    return Container(
      alignment: Alignment.centerRight,
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                onpress();
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )),
          EsaySize.safeGap(2),
          IconButton(
              onPressed: () {
                onpress();
              },
              icon: Icon(iconData)),
          EsaySize.gap(10),
        ],
      ),
    );
  }

  static List<Widget> fullItems(
      {required BuildContext context, required List<VoidCallback> onpress}) {
    return [
      drawerItem(
          context: context,
          text: "الصفحة الرئيسية",
          iconData: Icons.home,
          onpress: onpress[0]),
      drawerItem(
          context: context,
          text: "البث المباشر",
          iconData: Icons.tv,
          onpress: onpress[1]),
      drawerItem(
          context: context,
          text: "المفضلة",
          iconData: Icons.star_border_outlined,
          onpress: onpress[2]),
      drawerItem(
          context: context,
          text: "الاعدادات",
          iconData: Icons.settings,
          onpress: onpress[3]),
      drawerItem(
          context: context,
          text: "حول التطبیق",
          iconData: Icons.phone_android,
          onpress: onpress[4]),
    ];
  }
}
