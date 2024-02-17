import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'package:flutter_application_1/features/mobasher_feature/presentations/screens/mobasher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../about_us_feature/presentations/screens/about_us_page.dart';
import '../../../favorite_feature/presentations/screen/favorite.dart';
import '../bloc/drawer_cubit/drawer_cubit.dart';

class OnPressDrawer {
  static List<VoidCallback> press(BuildContext context) {
    return [
      () {
        BlocProvider.of<DrawerCubit>(context).openDrawer();

        BlocProvider.of<HomeDrawerCubit>(context).changeState();
      },
      () {
        Navigator.pushNamed(
          context,
          Mobasher.rn,
        );
      },
      () {
        Navigator.pushNamed(
          context,
          Favorite.rn,
        );
      },
      () {},
      () {
        Navigator.pushNamed(
          context,
          AboutUs.rn,
        );
      }
    ];
  }
}
