import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/select_drawer/select_drawer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidgets {
  static Widget drawerItem(
      {required BuildContext context,
      required String text,
      required IconData iconData,
      required Function onpress,
      required int index}) {
    return InkWell(
      onTap: () {
        onpress();

        BlocProvider.of<SelectDrawerCubit>(context).changeIndex(index);
      },
      child: BlocBuilder<SelectDrawerCubit, SelectDrawerState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: state.selectedIndex == index
                    ? ConstColor.baseColor
                    : Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(8)),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: EsaySize.width(context) / 2.3,
                  height: 40,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: state.selectedIndex == index
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).highlightColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                EsaySize.safeGap(2),
                Icon(
                  iconData,
                  color: state.selectedIndex == index
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).highlightColor,
                ),
                EsaySize.safeGap(10),
              ],
            ),
          );
        },
      ),
    );
  }

  static List<String> text = [
    "الصفحة الرئيسية",
    "المفضلة",
    "الاعدادات",
    "حول التطبیق"
  ];

  static List<IconData> iconData = [
    Icons.home,
    Icons.star_border_outlined,
    Icons.settings,
    Icons.phone_android,
  ];
}
