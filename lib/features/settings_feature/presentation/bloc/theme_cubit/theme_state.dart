part of 'theme_cubit.dart';

class ThemeState {
  int fontSize;
  double titleFontSize;
  final int titleColor;
  final int contentColor;
  String fontFamily;
  ThemeData themeData;
  ThemeState(
      {required this.titleColor,
      required this.contentColor,
      required this.fontSize,
      required this.titleFontSize,
      required this.fontFamily,
      required this.themeData});

  ThemeState copyWith(
      {int? fontSize,
      int? titleColor,
      int? contentColor,
      String? fontFamily,
      double? titleFontSize,
      ThemeData? themeData}) {
    return ThemeState(
        fontSize: fontSize ?? this.fontSize,
        titleColor: titleColor ?? this.titleColor,
        contentColor: contentColor ?? this.contentColor,
        fontFamily: fontFamily ?? this.fontFamily,
        titleFontSize: titleFontSize ?? this.titleFontSize,
        themeData: themeData ?? this.themeData);
  }
}
