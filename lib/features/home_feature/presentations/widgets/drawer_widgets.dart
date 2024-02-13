import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

class DrawerWidgets {
  static Widget drawerItem({
    required BuildContext context,
    required String text,
    required IconData iconData,
  }) {
    return GestureDetector(
      onTap: () {
        print(text);
      },
      child: Container(
        alignment: Alignment.centerRight,
      
        width: MediaQuery.of(context).size.width / 1.5 / 2,
        height: 40,
        
        child: Row(
        mainAxisAlignment: MainAxisAlignment.end, 
          children: [
            Text(text),
                        EsaySize.safeGap(12),

            Icon(iconData),
                        EsaySize.gap(10),

          ],
        ),
      ),
    );
  }

  static List<Widget> fullItems({required BuildContext context}) {
    return [
      drawerItem(
          context: context, text: "item1", iconData: Icons.home),
      drawerItem(context: context, text: "item2", iconData: Icons.tv),
      drawerItem(context: context, text: "item3", iconData: Icons.star_border_outlined),
      drawerItem(
          context: context, text: "item4", iconData: Icons.settings),
      drawerItem(context: context, text: "item5", iconData: Icons.phone_android),
    ];
  }
}
