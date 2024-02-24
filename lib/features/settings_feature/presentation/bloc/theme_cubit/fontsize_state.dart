part of 'fontsize_cubit.dart';

@immutable
class ThemeState {
  final int fontSize;
  final int titleColor;
  final int contentColor;
  const ThemeState(
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
