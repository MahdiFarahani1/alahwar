part of 'fontsize_cubit.dart';

class ThemeState {
  int fontSize;
  final int titleColor;
  final int contentColor;
  ThemeState(
      {required this.titleColor,
      required this.contentColor,
      required this.fontSize});

  ThemeState copyWith({int? fontSize, int? titleColor, int? contentColor}) {
    return ThemeState(
      fontSize: fontSize ?? this.fontSize,
      titleColor: titleColor ?? this.titleColor,
      contentColor: contentColor ?? this.contentColor,
    );
  }
}
