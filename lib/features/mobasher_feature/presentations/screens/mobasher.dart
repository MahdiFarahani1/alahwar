import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';


import '../../../../core/common/loading.dart';

class Mobasher extends StatelessWidget {
  static String rn = "/mobasher";
  const Mobasher({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon.appBar("Mobasher"),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: CostumLoading.loadCube(context),
      ),
    );
  }
}