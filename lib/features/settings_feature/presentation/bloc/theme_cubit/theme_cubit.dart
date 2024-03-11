import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_theme.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeData: AppTheme().lightTheme(
                baseColor: Colors.grey.shade200,
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

    String fontfamily = await saveBox.get("fontfamily") ?? "Salamat";
    double fontSizeTitle = await saveBox.get("fontsizetitle") ?? 19;
    bool switchTheme = saveBox.get("switchTheme") ?? true;
    int savedTitleColor = await saveBox.get("titleColor") ?? switchTheme
        ? Colors.black.value
        : Colors.white.value;
    int savedContentColor = await saveBox.get("contentColor") ?? switchTheme
        ? Colors.black.value
        : Colors.white.value;
    ThemeData theme = switchTheme
        ? AppTheme().lightTheme(
            baseColor: Colors.grey.shade200,
            titleFontsize: fontSizeTitle,
            fontSize: savedFontSize,
            titleColor: Color(savedTitleColor),
            contentColor: Color(savedContentColor),
            fontFamily: fontfamily)
        : AppTheme().darkTheme(
            baseColor: Colors.grey.shade900,
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

  changeThemeLight({
    Color? contentColor,
    String? fontFamily,
    double? titleFontsize,
    int? fontsize,
    Color? titleColor,
  }) {
    emit(
      state.copyWith(
        themeData: AppTheme().lightTheme(
          baseColor: Colors.grey.shade200,
          contentColor: contentColor ?? Color(state.contentColor),
          fontFamily: fontFamily ?? state.fontFamily,
          titleFontsize: titleFontsize ?? state.titleFontSize,
          fontSize: fontsize ?? state.fontSize,
          titleColor: titleColor ?? Color(state.titleColor),
        ),
      ),
    );
  }

  changeThemeDark() {
    emit(state.copyWith(
      themeData: AppTheme().darkTheme(
        baseColor: Colors.grey.shade900,
        contentColor: Color(state.contentColor),
        fontFamily: state.fontFamily,
        titleFontsize: state.titleFontSize,
        fontSize: state.fontSize,
        titleColor: Color(state.titleColor),
      ),
    ));
  }

  updateTheme() {
    if (saveBox.get("switchTheme")) {
      changeThemeLight();
    } else {
      changeThemeDark();
    }
  }
}
