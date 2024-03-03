import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/favorite_feature/presentation/screen/favorite.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/home.dart';
import 'package:flutter_application_1/features/splash_feature/presentations/widgets/btn_lose_net.dart';
import 'package:flutter_application_1/features/splash_feature/repositories/splash_repository.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SplashFailed extends StatelessWidget {
  static String rn = "/splashfailed";
  const SplashFailed({super.key});

  @override
  Widget build(BuildContext context) {
    String tryAgain = "! لیس لدیک اتصال بالانترنت حالیا، حاول مجددا ";
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColor.bgColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  tryAgain,
                  style: splashStyle(color: Colors.black, fontsize: 17),
                ),
                EsaySize.gap(10),
                BtnSplash.btn(context, "المحاولة مرة أخرى", () async {
                  if (await SplashRepository().isConnect()) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, Home.rn);
                  } else {
                    showTopSnackBar(
                      // ignore: use_build_context_synchronously
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: tryAgain,
                      ),
                    );
                  }
                }, splashStyle()),
                EsaySize.gap(10),
                BtnSplash.btn(context, "الاخبار المحفوظة (المفضلة)", () {
                  Navigator.pushNamed(context, Favorite.rn);
                }, splashStyle()),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "الاهوار",
                    style: splashStyle(
                        color: ConstColor.objectColor, fontsize: 23),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  TextStyle splashStyle({Color? color = Colors.white, double? fontsize = 20}) {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: fontsize, color: color);
  }
}
