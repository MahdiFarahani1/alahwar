import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

class BtnSplash {
  static Widget btn(BuildContext context, String txt, VoidCallback onpress,
      TextStyle textStyle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(EsaySize.width(context) * 0.65,
                EsaySize.height(context) * 0.08),
            shape: const LinearBorder(),
            backgroundColor: ConstColor.objectColor),
        child: FittedBox(
          child: Text(
            txt,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
