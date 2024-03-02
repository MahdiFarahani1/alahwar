import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';

part 'fontsize_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            fontSize: 21,
            titleColor: 50,
            contentColor: 50,
            fontFamily: "Salamat",
            titleFontSize: 19));
  Future<void> initialize() async {
    int savedFontSize = await saveBox.get("fontsize") ?? 21;
    int savedTitleColor = await saveBox.get("titleColor") ?? Colors.black.value;
    int savedContentColor =
        await saveBox.get("contentColor") ?? Colors.black.value;
    String fontfamily = await saveBox.get("fontfamily") ?? "Salamat";
    double fontSizeTitle = await saveBox.get("fontsizetitle") ?? 19;
    emit(state.copyWith(
        fontSize: savedFontSize,
        titleColor: savedTitleColor,
        contentColor: savedContentColor,
        fontFamily: fontfamily,
        titleFontSize: fontSizeTitle));
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

  settingFontSize(int size) {
    emit(state.copyWith(fontSize: size));
  }

  changeFontFamily(String font, double fontsize) {
    emit(state.copyWith(fontFamily: font, titleFontSize: fontsize));
  }
}
