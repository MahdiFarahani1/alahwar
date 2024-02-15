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
      width: MediaQuery.of(context).size.width / 1.5 / 2,
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
                style: const TextStyle(color: Colors.black),
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
      {required BuildContext context, required VoidCallback onpress}) {
    return [
      drawerItem(
          context: context,
          text: "item1",
          iconData: Icons.home,
          onpress: onpress),
      drawerItem(
          context: context,
          text: "item2",
          iconData: Icons.tv,
          onpress: onpress),
      drawerItem(
          context: context,
          text: "item3",
          iconData: Icons.star_border_outlined,
          onpress: onpress),
      drawerItem(
          context: context,
          text: "item4",
          iconData: Icons.settings,
          onpress: onpress),
      drawerItem(
          context: context,
          text: "item5",
          iconData: Icons.phone_android,
          onpress: onpress),
    ];
  }
}
