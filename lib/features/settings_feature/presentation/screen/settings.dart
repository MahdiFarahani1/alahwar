import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/gradient.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/alert_cubit/alert_cubit_cubit.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  static String rn = "/setting";
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> colorsList = [
      Colors.red.value,
      Colors.black.value,
      Colors.amber.value,
      Colors.pinkAccent.value,
      Colors.purple.value,
      Colors.brown.value,
      Colors.deepOrange.value,
      Colors.blue.value,
      Colors.green.value,
      Colors.yellow.value,
      Colors.indigo.value,
      Colors.teal.value,
      Colors.lime.value,
      Colors.blueGrey.value,
      Colors.lightBlue.shade200.value
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarCommon.appBar("الاعدادات"),
        body: Container(
          width: EsaySize.width(context),
          height: EsaySize.height(context),
          decoration: BoxDecoration(gradient: CostumGradient.linear()),
          child: Column(
            children: [
              boxFontFamily(context),
              boxFontSize(context),
              boxColor(context, colorsList),
              boxAlarm(context)
            ],
          ),
        ),
      ),
    );
  }

  Container boxAlarm(BuildContext context) {
    return Container(
      margin: symmetricMargin(),
      decoration: decorationBorder(),
      width: EsaySize.width(context),
      height: EsaySize.height(context) / 8,
      child: Column(
        children: [
          iconAvatar(Icons.alarm),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "تفعیل الاشعارات فی التطبیق ؟",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<AlertCubit, bool>(
                  builder: (context, state) {
                    return Checkbox(
                      value: state,
                      onChanged: (value) {
                        BlocProvider.of<AlertCubit>(context)
                            .changeAlertState(value!);
                        saveBox.put("alert", value);
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container boxFontFamily(BuildContext context) {
    double valueSlider = saveBox.get("fontvalue") ?? 0;
    String fontFamiliy = saveBox.get("fontfamily") ?? "Salamat";
    double fontSize = saveBox.get("fontsizetitle") ?? 19;
    return Container(
      margin: symmetricMargin(),
      width: EsaySize.width(context),
      height: EsaySize.height(context) / 6,
      decoration: decorationBorder(),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              iconAvatar(Icons.font_download_rounded),
              Slider(
                min: 0,
                max: 2,
                value: valueSlider,
                divisions: 2,
                onChanged: (value) async {
                  setState(() {
                    valueSlider = value;
                    switch (valueSlider) {
                      case 0.0:
                        fontFamiliy = "Salamat";
                        fontSize = 19;

                        break;
                      case 1.0:
                        fontFamiliy = "Arabic";
                        fontSize = 15;
                        break;
                      case 2.0:
                        fontFamiliy = "Vazir";
                        fontSize = 15;
                        break;
                      default:
                    }
                    BlocProvider.of<ThemeCubit>(context)
                        .changeFontFamily(fontFamiliy, fontSize);
                  });
                  await saveBox.put("fontvalue", valueSlider);
                  await saveBox.put("fontfamily", fontFamiliy);
                  await saveBox.put("fontsizetitle", fontSize);
                },
              ),
              Expanded(
                child: Text(
                  "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
                  style: TextStyle(fontFamily: fontFamiliy, fontSize: fontSize),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Container boxColor(BuildContext context, List<int> colorsList) {
    return Container(
      margin: symmetricMargin(),
      width: EsaySize.width(context),
      height: EsaySize.height(context) / 6,
      decoration: decorationBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconAvatar(Icons.color_lens),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    clickContainer(
                      color: state.titleColor,
                      onPress: () {
                        colorDialog(
                            colorsList: colorsList,
                            context: context,
                            isTitleMode: true);
                      },
                    ),
                    clickContainer(
                      color: state.contentColor,
                      onPress: () {
                        colorDialog(
                            colorsList: colorsList,
                            context: context,
                            isTitleMode: false);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("العنوان"),
                Text("النص"),
              ],
            ),
          ),
          const SizedBox.shrink()
        ],
      ),
    );
  }

  Container boxFontSize(BuildContext context) {
    return Container(
      margin: symmetricMargin(),
      width: EsaySize.width(context),
      height: EsaySize.height(context) / 8,
      decoration: decorationBorder(),
      child: Column(
        children: [
          iconAvatar(Icons.text_fields),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.blue,
                        inactiveTrackColor:
                            const Color.fromRGBO(158, 158, 158, 1),
                        thumbColor: ConstColor.objectColor,
                        inactiveTickMarkColor: Colors.grey,
                        activeTickMarkColor: Colors.transparent,
                      ),
                      child: Slider(
                        label: state.fontSize.toString(),
                        divisions: 10,
                        min: 15,
                        max: 25,
                        value: state.fontSize.toDouble(),
                        onChanged: (value) {
                          setState(
                            () {
                              state.fontSize = value.toInt();
                              BlocProvider.of<ThemeCubit>(context)
                                  .settingFontSize(value.toInt());
                            },
                          );
                          saveBox.put("fontsize", state.fontSize);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Padding iconAvatar(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CircleAvatar(
        child: Icon(iconData),
      ),
    );
  }

  EdgeInsets symmetricMargin() =>
      const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

  BoxDecoration decorationBorder() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ConstColor.objectColor, width: 4),
      color: Colors.white,
    );
  }

  Future<dynamic> colorDialog(
      {required List<int> colorsList,
      required BuildContext context,
      bool isTitleMode = false}) {
    return showDialog(
      builder: (context) {
        int? col;

        return AlertDialog(
          title: const Text("Choose a color"),
          content: Wrap(
            children: colorsList
                .map((e) => GestureDetector(
                      onTap: () {
                        col = e;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        color: Color(e),
                        width: 80,
                        height: 40,
                      ),
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (col != null) {
                  if (isTitleMode) {
                    BlocProvider.of<ThemeCubit>(context).changeTitleColor(col!);
                    saveBox.put('titleColor', col!);
                  } else {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeContentColor(col!);
                    saveBox.put('contentColor', col!);
                  }
                }
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cansel"),
            ),
          ],
        );
      },
      context: context,
    );
  }

  GestureDetector clickContainer(
      {required int color, required VoidCallback onPress}) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
              color: Color(color), borderRadius: BorderRadius.circular(8)),
          width: 40,
          height: 40,
        ));
  }
}
