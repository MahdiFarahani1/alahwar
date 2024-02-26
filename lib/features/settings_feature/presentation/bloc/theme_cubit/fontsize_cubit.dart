import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';

part 'fontsize_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(fontSize: 19, titleColor: 50, contentColor: 50));
  Future<void> initialize() async {
    int savedFontSize = await saveBox.get("fontsize") ?? 19;
    int savedTitleColor = await saveBox.get("titleColor") ?? Colors.black.value;
    int savedContentColor =
        await saveBox.get("contentColor") ?? Colors.black.value;
    emit(state.copyWith(
        fontSize: savedFontSize,
        titleColor: savedTitleColor,
        contentColor: savedContentColor));
  }

  changeTitleColor(int color) {
    emit(state.copyWith(titleColor: color));
  }

  changeContentColor(int color) {
    emit(state.copyWith(contentColor: color));
  }

  plusFontSize() {
    if (state.fontSize < 25) {
      int fontSize = state.fontSize + 1;
      emit(state.copyWith(fontSize: fontSize));
    }
  }

  minesFontSize() {
    if (state.fontSize > 0 && state.fontSize > 15) {
      int fontSize = state.fontSize - 1;
      emit(state.copyWith(fontSize: fontSize));
    }
  }
}
