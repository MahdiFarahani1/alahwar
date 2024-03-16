import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/gradient.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/extensions/string_ex.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

import 'package:flutter_application_1/features/favorite_feature/presentation/bloc/cubit/database_list_cubit.dart';
import 'package:flutter_application_1/features/favorite_feature/repository/operator_save.dart';
import 'package:flutter_application_1/features/home_feature/data/model/click_news_model.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/click_news_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/status_click_news.dart';
import 'package:flutter_application_1/features/home_feature/repositories/format_html.dart';
import 'package:flutter_application_1/features/search_feature/repository/light_content.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/theme_cubit/theme_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:share_plus/share_plus.dart';

import '../../../about_us_feature/widgets/widget_us.dart';

class NewsMainPage extends StatelessWidget {
  static String rn = "/NewsMainPage";

  const NewsMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as int;
    BlocProvider.of<ClickNewsCubit>(context).fetchData(arg);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarCommon.appBar("", context),
          body: BlocBuilder<ClickNewsCubit, ClickNewsState>(
            builder: (context, state) {
              const String baseUrl =
                  "https://alahwar-tv.com/upload_list/medium/";
              bool switchTheme = saveBox.get("switchTheme") ??
                  MediaQuery.platformBrightnessOf(context) == Brightness.light;
              if (state.status.state == StateClickNews.complate) {
                var view = state.status.data as List<NewsPost>;

                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: EsaySize.width(context) * 0.9,
                          height: EsaySize.height(context) / 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              width: EsaySize.width(context),
                              height: EsaySize.height(context) / 10,
                              fit: BoxFit.cover,
                              imageUrl: '$baseUrl${view[0].img!}',
                              placeholder: (context, url) {
                                return CostumLoading.loadCircle(context);
                              },
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: EsaySize.height(context) / 5 - 20,
                        right: EsaySize.width(context) * 0.05,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(top: 8),
                          width: EsaySize.width(context) * 0.9,
                          height: EsaySize.height(context) * 0.65,
                          child: Column(children: [
                            SizedBox(
                              width: EsaySize.width(context),
                              height: EsaySize.height(context) * 0.6,
                              child: Column(
                                children: [
                                  EsaySize.gap(30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: ConstColor.baseColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: FutureBuilder(
                                              future: "".getCategory(
                                                  view[0].categoryId!),
                                              initialData: "البند الأخبار",
                                              builder: (context, snapshot) {
                                                String? titleCategory =
                                                    snapshot.data;
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return FittedBox(
                                                    child: Text(
                                                      titleCategory ??
                                                          "البند الأخبار",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ).animate().fade().scale();
                                                } else {
                                                  return const Text(
                                                    "البند الأخبار",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  );
                                                }
                                              }),
                                        ),
                                      ),
                                      const CircleAvatar(
                                        radius: 2.5,
                                        backgroundColor:
                                            Color.fromARGB(169, 132, 82, 1),
                                      ),
                                      Container(
                                        width: EsaySize.width(context) * 0.44,
                                        height: 1.5,
                                        color: const Color.fromARGB(
                                            169, 132, 82, 1),
                                      ),
                                    ],
                                  ),
                                  EsaySize.gap(10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      view[0].title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    color: switchTheme
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade700,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "حجم الخط :",
                                                ),
                                                EsaySize.gap(8),
                                                Btn.btncircle(
                                                    context: context,
                                                    iconData:
                                                        FontAwesomeIcons.plus,
                                                    size: 10,
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  ThemeCubit>(
                                                              context)
                                                          .plusFontSize();
                                                      saveBox.put(
                                                          "fontsize",
                                                          BlocProvider.of<
                                                                      ThemeCubit>(
                                                                  context)
                                                              .state
                                                              .fontSize);
                                                    }),
                                                EsaySize.gap(5),
                                                Btn.btncircle(
                                                    context: context,
                                                    iconData:
                                                        FontAwesomeIcons.minus,
                                                    size: 10,
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  ThemeCubit>(
                                                              context)
                                                          .minesFontSize();
                                                      saveBox.put(
                                                          "fontsize",
                                                          BlocProvider.of<
                                                                      ThemeCubit>(
                                                                  context)
                                                              .state
                                                              .fontSize);
                                                    }),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                BlocBuilder<DatabaseListCubit,
                                                    DatabaseListState>(
                                                  builder: (context, state) {
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        bool isFavorite = box.get(
                                                            'favorite_${view[0].id}',
                                                            defaultValue:
                                                                false);
                                                        return Btn.btncircle(
                                                          context: context,
                                                          iconData: isFavorite
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_border,
                                                          size: 15,
                                                          onTap: () {
                                                            setState(
                                                              () {
                                                                isFavorite =
                                                                    !isFavorite;
                                                                box.put(
                                                                    'favorite_${view[0].id}',
                                                                    isFavorite);
                                                                if (isFavorite) {
                                                                  OperatorDatabase.addDatabase(
                                                                      context:
                                                                          context,
                                                                      view:
                                                                          view);
                                                                } else {
                                                                  OperatorDatabase.deleteDatabsae(
                                                                      id: view[
                                                                              0]
                                                                          .id!,
                                                                      context:
                                                                          context);
                                                                }
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                EsaySize.gap(5),
                                                Btn.btncircle(
                                                    context: context,
                                                    iconData: FontAwesomeIcons
                                                        .shareNodes,
                                                    size: 15,
                                                    onTap: () {
                                                      String shareTitle =
                                                          view[0]
                                                              .title!
                                                              .replaceAll(
                                                                  " ", "-");

                                                      Share.share(
                                                          "https://alahwar-tv.com/news/$shareTitle",
                                                          subject: "send news");
                                                    }),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          gradient: CostumGradient.linearGrey(
                                              context),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: SingleChildScrollView(child:
                                            BlocBuilder<ThemeCubit, ThemeState>(
                                          builder: (context, state) {
                                            if (view[0].content!.contains(
                                                    LightContent.swContent) &&
                                                LightContent
                                                    .swContent.isNotEmpty) {
                                              return TextHighlight(
                                                textAlign: TextAlign.justify,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: state.fontSize
                                                            .toDouble()),
                                                text:
                                                    FormatHtml.parseHtmlString(
                                                        view[0].content!),
                                                textDirection:
                                                    TextDirection.rtl,
                                                words: {
                                                  LightContent.swContent:
                                                      HighlightedWord(
                                                          textStyle: TextStyle(
                                                              color: ConstColor
                                                                  .objectColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                },
                                              );
                                            } else {
                                              return Text(
                                                  textAlign: TextAlign.justify,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontSize: state
                                                              .fontSize
                                                              .toDouble()),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  FormatHtml.parseHtmlString(
                                                      view[0].content!));
                                            }
                                          },
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state.status.state == StateClickNews.loading) {
                return Center(
                  child: CostumLoading.fadingCircle(context),
                );
              }
              if (state.status.state == StateClickNews.error) {
                return const Center(
                  child: Text("erorr"),
                );
              }
              return const SizedBox();
            },
          )),
    );
  }
}
