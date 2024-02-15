import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/drawer_cubit/deawer_status.dart';
import 'package:meta/meta.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  bool check = true;

  DrawerCubit() : super(DrawerState(status: Init()));

  openDrawer() {
    if (check) {
      emit(DrawerState(status: Open()));
      check = !check;
    } else {
      emit(DrawerState(status: Close()));
      check = !check;
    }
  }
}
