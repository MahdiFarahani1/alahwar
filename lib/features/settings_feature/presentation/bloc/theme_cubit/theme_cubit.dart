import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_theme.dart';
import 'package:flutter_application_1/config/setupMain.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeData: AppTheme().lightTheme(
                titleFontsize: 19,
                fontSize: 21,
                titleColor: Colors.black,
                contentColor: Colors.black,
                fontFamily: "Salamat"),
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
    bool switchTheme = saveBox.get("switchTheme") ?? true;
    ThemeData theme = switchTheme
        ? AppTheme().lightTheme(
            titleFontsize: fontSizeTitle,
            fontSize: savedFontSize,
            titleColor: Color(savedTitleColor),
            contentColor: Color(savedContentColor),
            fontFamily: fontfamily)
        : AppTheme().darkTheme(
            titleFontsize: fontSizeTitle,
            fontSize: savedFontSize,
            titleColor: Color(savedTitleColor),
            contentColor: Color(savedContentColor),
            fontFamily: fontfamily);
    emit(state.copyWith(
        fontSize: savedFontSize,
        titleColor: savedTitleColor,
        contentColor: savedContentColor,
        fontFamily: fontfamily,
        titleFontSize: fontSizeTitle,
        themeData: theme));
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

  changeThemeLight() {
    emit(state.copyWith(
        themeData: AppTheme().lightTheme(
      contentColor: Color(state.contentColor),
      fontFamily: state.fontFamily,
      titleFontsize: state.titleFontSize,
      fontSize: state.fontSize,
      titleColor: Color(state.titleColor),
    )));
  }

  changeThemeDark() {
    emit(state.copyWith(
        themeData: AppTheme().darkTheme(
      contentColor: Color(state.contentColor),
      fontFamily: state.fontFamily,
      titleFontsize: state.titleFontSize,
      fontSize: state.fontSize,
      titleColor: Color(state.titleColor),
    )));
  }
}
