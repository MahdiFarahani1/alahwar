import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/common/divider.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/constans/const_searchbtn.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

import 'package:flutter_application_1/features/home_feature/repositories/format_date.dart';
import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_status.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';

import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/drawer_widgets.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/item_news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/news_cubit/news_home_cubit.dart';
import '../bloc/news_cubit/status_news.dart';
import '../utils/drawer_onpress.dart';

Map<int, String> categotyMap = {
  0: "جميع الأخبار",
  19: "منوعات محلية وعالمية",
  20: "العراق والعالم",
  23: "ذي قار",
  25: "اقتصاد",
  26: "ثقافة وفن",
  27: "محافظ",
  18: "رياضة",
};

final isSelect = List.generate(
  categotyMap.length,
  (index) => index == 0 ? true : false,
);
int categoryID = 0;

class Home extends StatefulWidget {
  static String rn = "/home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController controller;
  @override
  void initState() {
    BlocProvider.of<NewsHomeCubit>(context).fetchDataFristTime(0, 0);
    controller = ScrollController()..addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    BlocProvider.of<NewsHomeCubit>(context).loadMore(controller, categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appbar(context),
        endDrawer: costumDrawer(),
        body: BlocBuilder<HomeDrawerCubit, HomeDrawerState>(
          builder: (context, state) {
            if (state.status is LoadingHome) {
              return Center(
                child: CostumLoading.fadingCircle(context),
              );
            }

            if (state.status is DrawerHome) {
              return Stack(
                children: [
                  news(false),
                ],
              );
            }
            if (state.status is InitHome) {
              return Stack(
                children: [
                  sliderImages(context),
                  news(true),
                  category(context),
                ],
              );
            }
            return const SizedBox();
          },
        ));
  }

  Widget costumDrawer() {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        child: Container(
          width: EsaySize.width(context) * 0.7,
          height: EsaySize.height(context),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: 20,
                      color: Theme.of(context).highlightColor,
                    )),
              ),
              EsaySize.gap(35),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.bottomCenter,
                width: EsaySize.width(context),
                height: EsaySize.height(context) / 6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage("assets/images/logo-big.png"),
                  ),
                ),
              ),
              CostumDivider.div(),
              EsaySize.safeGap(30),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: DrawerWidgets.text.length,
                itemBuilder: (context, index) {
                  return DrawerWidgets.drawerItem(
                      index: index,
                      context: context,
                      text: DrawerWidgets.text[index],
                      iconData: DrawerWidgets.iconData[index],
                      onpress: OnPressDrawer.press(context)[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox sliderImages(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: EsaySize.height(context) / 3.3,
      child: BlocBuilder<NewsHomeCubit, NewsHomeState>(
        builder: (context, state) {
          if (state.status.state == StateNewsHome.loading) {
            return Center(child: CostumLoading.loadLine(context));
          }
          if (state.status.state == StateNewsHome.complate) {
            String baseUrl = "https://alahwar-tv.com/upload_list/medium/";
            var view = state.status.data as List<NewsGet>;
            return BlocBuilder<IndicatorIndexCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: 4,
                        itemBuilder: (context, index, realIndex) {
                          int actualIndex =
                              (index + view.length - 4) % view.length;
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, NewsMainPage.rn,
                                  arguments:
                                      view[(index + view.length) - 4].id!);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 8, left: 3, right: 3),
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: EsaySize.height(context),
                                      width: EsaySize.width(context),
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.error);
                                      },
                                      imageUrl:
                                          "$baseUrl${view[actualIndex].img}",
                                      placeholder: (context, url) {
                                        return Center(
                                          child: CostumLoading.fadingCircle(
                                              context),
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: IgnorePointer(
                                      child: Container(
                                        width: EsaySize.width(context),
                                        height: EsaySize.height(context) / 12,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12)),
                                            gradient: LinearGradient(colors: [
                                              Color.fromRGBO(16, 154, 211, 0.7),
                                              Color.fromRGBO(136, 94, 37, 0.7)
                                            ])),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            maxLines: 2,
                                            textAlign: TextAlign.right,
                                            view[actualIndex].title!,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                                fontSize: 19,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Salamat"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          viewportFraction: 0.9,
                          aspectRatio: 16 / 9,
                          onPageChanged: (index, reason) {
                            BlocProvider.of<IndicatorIndexCubit>(context)
                                .changeIndicator(index);
                          },
                          autoPlay: true,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: EsaySize.width(context) / 3.2,
                        child: AnimatedSmoothIndicator(
                            effect: ExpandingDotsEffect(
                              dotWidth: 12,
                              dotHeight: 3,
                              dotColor: ConstColor.dividerColor,
                              activeDotColor: ConstColor.baseColor,
                            ),
                            activeIndex: state,
                            count: 4),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          if (state.status.state == StateNewsHome.error) {
            return const Center(child: Icon(Icons.error_outline_outlined));
          }
          return const SizedBox();
        },
      ),
    );
  }

  BlocBuilder<NewsHomeCubit, NewsHomeState> news(bool ismargin) {
    return BlocBuilder<NewsHomeCubit, NewsHomeState>(
      builder: (context, state) {
        if (state.status.state == StateNewsHome.complate) {
          var view = state.news;

          String baseUrl = "https://alahwar-tv.com/upload_list/medium/";
          return Container(
            margin: EdgeInsets.only(
                top: ismargin ? EsaySize.height(context) / 2.7 : 8),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: view.length,
                    itemBuilder: (context, index) {
                      return ItemNews(
                        time: FormatData.result(view[index].dateTime!),
                        title: view[index].title!,
                        pathImages: "$baseUrl${view[index].img!}",
                        onTap: () {
                          Navigator.pushNamed(context, NewsMainPage.rn,
                              arguments: view[index].id);
                        },
                      );
                    },
                  ),
                ),
                if (state.isLoadMoreRunning == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CostumLoading.fadingCircle(context),
                    ),
                  ),
                if (state.hasNextPage == false) const SizedBox.shrink(),
              ],
            ),
          );
        }

        if (state.status.state == StateNewsHome.loading) {
          return Center(
            child: CostumLoading.fadingCircle(context),
          );
        }
        if (state.status.state == StateNewsHome.error) {
          return Container(
            margin: EdgeInsets.only(top: EsaySize.height(context) / 3.2),
            width: double.infinity,
            child: ItemNews(
              time: "404",
              title: state.status.erorr!,
              pathImages: "",
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      leading: SearchFeature.add(context),
      title: GestureDetector(
        onTap: () {
          BlocProvider.of<HomeDrawerCubit>(context).reBiuldHome();
        },
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }

  Widget category(BuildContext context) {
    return BlocBuilder<NewsHomeCubit, NewsHomeState>(
      builder: (context, state) {
        if (state.status.state == StateNewsHome.complate) {
          return Container(
            margin: EdgeInsets.only(top: EsaySize.height(context) / 3.3),
            width: double.infinity,
            color: Theme.of(context).primaryColorLight,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categotyMap.length,
                  itemBuilder: (context, index) {
                    return categotyItem(
                      index,
                      isSelect,
                      categotyMap.values.toList(),
                    );
                  },
                ),
              ),
            ),
          );
        }
        if (state.status.state == StateNewsHome.loading) {
          return const SizedBox.shrink();
        }
        if (state.status.state == StateNewsHome.error) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget categotyItem(int index, List<bool> isSelect, List<String> categoryList) {
  return BlocBuilder<NewsHomeCubit, NewsHomeState>(builder: (context, state) {
    bool colorCategory = saveBox.get("switchTheme") ??
        MediaQuery.platformBrightnessOf(context) == Brightness.light;
    return GestureDetector(
      onTap: () {
        int categoryId = categotyMap.keys.toList()[index];
        categoryID = categoryId;

        List<bool> updatedList = List.generate(
          categoryList.length,
          (i) => (i == index),
        );
        for (int i = 0; i < updatedList.length; i++) {
          updatedList[i] = (i == index);
        }

        isSelect.clear();
        isSelect.addAll(updatedList);

        BlocProvider.of<NewsHomeCubit>(context)
            .fetchDataFristTime(0, categoryId);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelect[index]
                ? ConstColor.baseColor
                : colorCategory
                    ? Colors.grey.shade300
                    : Colors.grey.shade700),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            categoryList[index],
            style: TextStyle(
              color: isSelect[index]
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).highlightColor,
            ),
          ),
        ),
      ),
    );
  });
}
