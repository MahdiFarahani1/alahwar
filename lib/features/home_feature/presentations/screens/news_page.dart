import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/home_feature/data/model/click_news_model.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/click_news_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/status_click_news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../about_us_feature/widgets/widget_us.dart';

class NewsMainPage extends StatefulWidget {
  static String rn = "/NewsMainPage";

  const NewsMainPage({super.key});

  @override
  State<NewsMainPage> createState() => _NewsMainPageState();
}

class _NewsMainPageState extends State<NewsMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments! as int;
    BlocProvider.of<ClickNewsCubit>(context).fetchData(arg);

    return Scaffold(
        appBar: AppBarCommon.appBar("the news"),
        body: BlocBuilder<ClickNewsCubit, ClickNewsState>(
          builder: (context, state) {
            const String baseUrl = "https://alahwar-tv.com/upload_list/medium/";

            if (state.status.state == StateClickNews.complate) {
              var view = state.status.data as List<NewsPost>;

              return Column(children: [
                Container(
                  width: double.infinity,
                  height: EsaySize.height(context) / 5,
                  decoration: BoxDecoration(
                    gradient: grad(),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '$baseUrl${view[0].img!}',
                    placeholder: (context, url) {
                      return CostumLoading.loadCircle(context);
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                EsaySize.gap(10),
                Divider(
                  color: ConstColor.objectColor,
                  height: 2,
                  indent: 0,
                  endIndent: EsaySize.width(context) / 1.5,
                  thickness: 2,
                ),
                const Text("The News"),
                Divider(
                  color: ConstColor.objectColor,
                  height: 2,
                  indent: EsaySize.width(context) / 1.5,
                  endIndent: 0,
                  thickness: 2,
                ),
                EsaySize.gap(10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(view[0].title!),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "font size",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            EsaySize.gap(8),
                            Btn.btncircle(
                                iconData: FontAwesomeIcons.plus,
                                size: 10,
                                onTap: () {}),
                            EsaySize.gap(5),
                            Btn.btncircle(
                                iconData: FontAwesomeIcons.minus,
                                size: 10,
                                onTap: () {}),
                          ],
                        ),
                        Row(
                          children: [
                            Btn.btncircle(
                                iconData: FontAwesomeIcons.star,
                                size: 15,
                                onTap: () async {}),
                            EsaySize.gap(5),
                            Btn.btncircle(
                                iconData: FontAwesomeIcons.share,
                                size: 15,
                                onTap: () {}),
                          ],
                        ),
                      ],
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        gradient: grad(),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child:
                          SingleChildScrollView(child: Text(view[0].content!)),
                    ),
                  ),
                ),
              ]);
            }
            if (state.status.state == StateClickNews.loading) {
              return Center(
                child: CostumLoading.loadCube(context),
              );
            }
            if (state.status.state == StateClickNews.error) {
              return const Center(
                child: Text("erorr"),
              );
            }
            return const SizedBox();
          },
        ));
  }

  LinearGradient grad() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ConstColor.bgColor,
          ConstColor.objectColor,
          ConstColor.bgColor,
        ]);
  }
}
