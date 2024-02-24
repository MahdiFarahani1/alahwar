import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/home.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/theme_cubit/fontsize_cubit.dart';
import 'package:flutter_application_1/features/splash_feature/presentations/screens/splash_failed.dart';
import 'package:flutter_application_1/features/splash_feature/repositories/splash_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashMain extends StatefulWidget {
  const SplashMain({super.key});

  @override
  State<SplashMain> createState() => _SplashMainState();
}

class _SplashMainState extends State<SplashMain> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ConstColor.appbarColor,
    ));
    BlocProvider.of<ThemeCubit>(context).initialize();

    Future.delayed(const Duration(seconds: 2), () async {
      if (await SplashRepository().isConnect()) {
        //   ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Home.rn);
      } else {
        //  ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, SplashFailed.rn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: Image.asset(
            "assets/images/splash.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
