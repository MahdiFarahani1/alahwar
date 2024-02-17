import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/features/mobasher_feature/presentations/screens/mobasher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../about_us_feature/presentations/screens/about_us_page.dart';
import '../../../favorite_feature/presentations/screen/favorite.dart';
import '../bloc/drawer_cubit/drawer_cubit.dart';

class OnPressDrawer {
  
static List<VoidCallback> press (BuildContext context) {

  return [

       () {},
                            () {
                                  BlocProvider.of<DrawerCubit>(context).openDrawer();

                              Navigator.pushNamed(
                                context,
                                Mobasher.rn,
                              );
                            },
                            () {
                              BlocProvider.of<DrawerCubit>(context).openDrawer();

                              Navigator.pushNamed(
                                context,
                                Favorite.rn,
                              );
                            },
                            () {},
                            () {
BlocProvider.of<DrawerCubit>(context).openDrawer();
                              Navigator.pushNamed(
                                context,
                                AboutUs.rn,
                              );
                            }


  ];
}

}