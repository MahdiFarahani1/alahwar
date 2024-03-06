import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';

import '../../../../core/common/loading.dart';

class Mobasher extends StatelessWidget {
  static String rn = "/mobasher";
  const Mobasher({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarCommon.appBar("البث المباشر", context),
        backgroundColor: Colors.grey.shade900,
        body: Center(
          child: CostumLoading.fadingCircle(context),
        ),
      ),
    );
  }
}
