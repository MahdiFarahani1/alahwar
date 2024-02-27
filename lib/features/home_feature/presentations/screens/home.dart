import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/gradient.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

import 'package:flutter_application_1/features/home_feature/repositories/format_date.dart';
import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_status.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';

import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/drawer_widgets.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/listview_builder_item.dart';
import 'package:flutter_application_1/features/search_feature/presentations/screens/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/news_cubit/news_home_cubit.dart';
import '../bloc/news_cubit/status_news.dart';
import '../utils/drawer_onpress.dart';

Map<int, String> categotyMap = {
  18: "رياضة",
  19: "منوعات محلية وعالمية",
  20: "العراق والعالم",
  23: "ذي قار",
  25: "اقتصاد",
  26: "ثقافة وفن",
  27: "محافظ",
  0: "جميع الأخبار"
};

final isSelect = List.generate(
  categotyMap.length,
  (index) => index == 7 ? true : false,
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
        backgroundColor: Colors.white,
        appBar: appbar(context),
        endDrawer: costumDrawer(),
        body: BlocBuilder<HomeDrawerCubit, HomeDrawerState>(
          builder: (context, state) {
            if (state.status is LoadingHome) {
              return Center(
                child: CostumLoading.loadCube(context),
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

  Builder costumDrawer() {
    return Builder(builder: (context) {
      var appBarHeight = Scaffold.of(context).appBarMaxHeight!;
      return Container(
        width: EsaySize.width(context) * 0.7,
        margin: EdgeInsets.only(top: appBarHeight),
        height: EsaySize.height(context) - appBarHeight,
        decoration: BoxDecoration(gradient: CostumGradient.linear()),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: EsaySize.width(context),
              height: EsaySize.height(context) / 4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/images/oops.jpg"))),
              child:
                  const Divider(color: Colors.black, height: 2, thickness: 1.5),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: EsaySize.width(context),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: DrawerWidgets.fullItems(
                        context: context,
                        onpress: OnPressDrawer.press(context))),
              ),
            ),
          ],
        ),
      );
    });
  }

  SizedBox sliderImages(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: EsaySize.height(context) / 3.8,
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
                return Stack(
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
                              width: double.infinity,
                              color: ConstColor.bgColor,
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                                imageUrl: "$baseUrl${view[actualIndex].img}",
                                placeholder: (context, url) {
                                  return Center(
                                    child: CostumLoading.fadingCircle(context),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          onPageChanged: (index, reason) {
                            BlocProvider.of<IndicatorIndexCubit>(context)
                                .changeIndicator(index);
                          },
                          autoPlay: true,
                          viewportFraction: 1,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        height: 30,
                        width: EsaySize.width(context) / 3.2,
                        child: AnimatedSmoothIndicator(
                            effect: WormEffect(
                                dotWidth: 12,
                                dotHeight: 12,
                                dotColor: Colors.white,
                                activeDotColor: ConstColor.appbarColor,
                                type: WormType.thin),
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
                top: ismargin ? EsaySize.height(context) / 3.2 : 8),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: view.length,
                    itemBuilder: (context, index) {
                      return ItemHome(
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
            child: CostumLoading.loadCube(context),
          );
        }
        if (state.status.state == StateNewsHome.error) {
          return Container(
            margin: EdgeInsets.only(top: EsaySize.height(context) / 3.2),
            width: double.infinity,
            child: ItemHome(
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
      backgroundColor: ConstColor.appbarColor,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Search.rn,
            );
          },
          icon: const Icon(Icons.search)),
      title: const Text("Alahwar"),
    );
  }

  Widget category(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: EsaySize.height(context) / 3.8),
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
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
    );
  }
}

Widget categotyItem(int index, List<bool> isSelect, List<String> categoryList) {
  return BlocBuilder<NewsHomeCubit, NewsHomeState>(builder: (context, state) {
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
        margin: const EdgeInsets.all(10),
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: ConstColor.objectColor, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: isSelect[index] ? Colors.redAccent : Colors.white,
        ),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              categoryList[index],
              style: TextStyle(
                color: isSelect[index] ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  });
}
