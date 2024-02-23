import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'package:flutter_application_1/features/mobasher_feature/presentation/screens/mobasher.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/screen/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../about_us_feature/presentations/screens/about_us_page.dart';
import '../../../favorite_feature/presentation/screen/favorite.dart';

class OnPressDrawer {
  static List<VoidCallback> press(BuildContext context) {
    return [
      () {
        Navigator.of(context).pop();

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
      () {
        Navigator.pushNamed(
          context,
          Setting.rn,
        );
      },
      () {
        Navigator.pushNamed(
          context,
          AboutUs.rn,
        );
      }
    ];
  }
}
