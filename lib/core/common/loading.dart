import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constans/const_colors.dart';
import '../utils/esay_size.dart';

class CostumLoading {
  static Widget loadCube(BuildContext context) {
    return SpinKitCubeGrid(
      color: ConstColor.appbarColor,
      size: EsaySize.height(context) / 12,
    );
  }

  static Widget loadCircle(BuildContext context) {
    return SpinKitRipple(
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ConstColor.appbarColor,
          ),
        );
      },
    );
  }

  static Widget loadLine(BuildContext context) {
    return SpinKitThreeInOut(
      size: 35,
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: ConstColor.appbarColor,
          ),
        );
      },
    );
  }

  static Widget fadingCircle(BuildContext context) {
    return SpinKitFadingCircle(
      size: 35,
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: ConstColor.appbarColor,
          ),
        );
      },
    );
  }
}
