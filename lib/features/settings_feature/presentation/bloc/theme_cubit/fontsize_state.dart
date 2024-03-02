part of 'fontsize_cubit.dart';

class ThemeState {
  int fontSize;
  double titleFontSize;
  final int titleColor;
  final int contentColor;
  String fontFamily;
  ThemeState(
      {required this.titleColor,
      required this.contentColor,
      required this.fontSize,
      required this.titleFontSize,
      required this.fontFamily});

  ThemeState copyWith(
      {int? fontSize,
      int? titleColor,
      int? contentColor,
      String? fontFamily,
      double? titleFontSize}) {
    return ThemeState(
        fontSize: fontSize ?? this.fontSize,
        titleColor: titleColor ?? this.titleColor,
        contentColor: contentColor ?? this.contentColor,
        fontFamily: fontFamily ?? this.fontFamily,
        titleFontSize: titleFontSize ?? this.titleFontSize);
  }
}
