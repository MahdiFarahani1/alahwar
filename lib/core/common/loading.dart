

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constans/const_colors.dart';
import '../utils/esay_size.dart';


class CostumLoading {
  

  static Widget loadCube(BuildContext context){

   return  SpinKitCubeGrid(
              color: ConstColor.appbarColor,
              
              size: EsaySize.height(context) / 12,
            );
  }
}