import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/gradient.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

import 'package:flutter_application_1/features/favorite_feature/presentation/bloc/cubit/database_list_cubit.dart';
import 'package:flutter_application_1/features/favorite_feature/repository/operator_save.dart';
import 'package:flutter_application_1/features/home_feature/data/model/click_news_model.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/click_news_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/status_click_news.dart';
import 'package:flutter_application_1/features/home_feature/repositories/format_html.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/theme_cubit/theme_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../about_us_feature/widgets/widget_us.dart';

class NewsMainPage extends StatelessWidget {
  static String rn = "/NewsMainPage";

  const NewsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments! as int;
    BlocProvider.of<ClickNewsCubit>(context).fetchData(arg);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarCommon.appBar("", context),
          body: BlocBuilder<ClickNewsCubit, ClickNewsState>(
            builder: (context, state) {
              const String baseUrl =
                  "https://alahwar-tv.com/upload_list/medium/";

              if (state.status.state == StateClickNews.complate) {
                var view = state.status.data as List<NewsPost>;

                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ConstColor.greyWithShade,
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(top: 8),
                    width: EsaySize.width(context) * 0.9,
                    height: EsaySize.height(context) * 0.8,
                    child: Column(children: [
                      SizedBox(
                        width: double.infinity,
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
                      SizedBox(
                        width: EsaySize.width(context),
                        height: EsaySize.height(context) * 0.6,
                        child: Column(
                          children: [
                            EsaySize.gap(10),
                            Divider(
                              color: ConstColor.objectColor,
                              height: 2,
                              indent: 0,
                              endIndent: EsaySize.width(context) / 1.5,
                              thickness: 2,
                            ),
                            const Text(
                              "الاخبار",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: ConstColor.objectColor,
                              height: 2,
                              indent: EsaySize.width(context) / 1.5,
                              endIndent: 0,
                              thickness: 2,
                            ),
                            EsaySize.gap(10),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                view[0].title!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "حجم الخط",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        ),
                                        EsaySize.gap(8),
                                        Btn.btncircle(
                                            iconData: FontAwesomeIcons.plus,
                                            size: 10,
                                            onTap: () {
                                              BlocProvider.of<ThemeCubit>(
                                                      context)
                                                  .plusFontSize();
                                              saveBox.put(
                                                  "fontsize",
                                                  BlocProvider.of<ThemeCubit>(
                                                          context)
                                                      .state
                                                      .fontSize);
                                            }),
                                        EsaySize.gap(5),
                                        Btn.btncircle(
                                            iconData: FontAwesomeIcons.minus,
                                            size: 10,
                                            onTap: () {
                                              BlocProvider.of<ThemeCubit>(
                                                      context)
                                                  .minesFontSize();
                                              saveBox.put(
                                                  "fontsize",
                                                  BlocProvider.of<ThemeCubit>(
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
                                              builder: (context, setState) {
                                                bool isFavorite = box.get(
                                                    'favorite_${view[0].id}',
                                                    defaultValue: false);
                                                return Btn.btncircle(
                                                  iconData: isFavorite
                                                      ? Icons.star
                                                      : Icons.star_border,
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
                                                          OperatorDatabase
                                                              .addDatabase(
                                                                  context:
                                                                      context,
                                                                  view: view);
                                                        } else {
                                                          OperatorDatabase
                                                              .deleteDatabsae(
                                                                  id: view[0]
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
                                            iconData:
                                                FontAwesomeIcons.shareNodes,
                                            size: 15,
                                            onTap: () {
                                              String shareTitle = view[0]
                                                  .title!
                                                  .replaceAll(" ", "-");

                                              Share.share(
                                                  "https://alahwar-tv.com/news/$shareTitle",
                                                  subject: "send news");
                                            }),
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    gradient: CostumGradient.linearGrey(),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: SingleChildScrollView(
                                      child: Text(
                                          textAlign: TextAlign.justify,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          textDirection: TextDirection.rtl,
                                          FormatHtml.parseHtmlString(
                                              view[0].content!))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
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
