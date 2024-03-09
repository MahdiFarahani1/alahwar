import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_searchbtn.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCommon {
  static AppBar appBar(String text, BuildContext context,
      {bool isSearchPage = false}) {
    return AppBar(
      actions: [
        !isSearchPage ? SearchFeature.add(context) : const SizedBox.shrink()
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Home.rn);
          BlocProvider.of<HomeDrawerCubit>(context).reBiuldHome();
        },
        child: Image.asset(
          "assets/images/logo.png",
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
