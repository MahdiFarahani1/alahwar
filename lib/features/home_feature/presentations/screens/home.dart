import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/home_feature/repositories/format_date.dart';
import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/drawer_cubit/drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_status.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';

import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/drawer_widgets.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/listview_builder_item.dart';
import 'package:flutter_application_1/features/search_feature/presentations/screens/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/drawer_cubit/deawer_status.dart';
import '../bloc/news_cubit/news_home_cubit.dart';
import '../bloc/news_cubit/status_news.dart';
import '../utils/drawer_onpress.dart';

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
    BlocProvider.of<NewsHomeCubit>(context).fetchDataFristTime(0);
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    BlocProvider.of<NewsHomeCubit>(context).loadMore(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context),
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
                  costumDrawer(),
                ],
              );
            }
            if (state.status is InitHome) {
              return Stack(
                children: [
                  sliderImages(context),
                  news(true),
                  category(context),
                  costumDrawer(),
                ],
              );
            }
            return const SizedBox();
          },
        ));
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, NewsMainPage.rn,
                                  arguments:
                                      view[(index + view.length) - 4].id!);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ConstColor.bgColor,
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          "$baseUrl${view[(index + view.length) - 4].img!}"))),
                              width: double.infinity,
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
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (state.hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
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
      actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<DrawerCubit>(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ],
      title: const Text("Alahwar"),
    );
  }

  Container category(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: EsaySize.height(context) / 3.8),
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: ConstColor.objectColor, width: 1),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Text("index $index"),
          );
        },
      ),
    );
  }

  BlocBuilder<DrawerCubit, DrawerState> costumDrawer() {
    return BlocBuilder<DrawerCubit, DrawerState>(
      builder: (context, state) {
        if (state.status is Open) {
          return Stack(
            children: [
              Container(
                color: Colors.white,
                width: EsaySize.width(context) / 1.5,
                height: double.infinity,
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<DrawerCubit>(context).openDrawer();
                      },
                      child: Image.asset(
                        "assets/images/oops.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.8,
                      height: 2,
                    ),
                  ],
                ),
              ).animate().moveX(
                  begin: EsaySize.width(context),
                  end: EsaySize.width(context) / 3),
              Padding(
                padding: EdgeInsets.only(top: EsaySize.height(context) / 3.8),
                child: ListView(
                        shrinkWrap: true,
                        children: DrawerWidgets.fullItems(
                          context: context,
                          onpress: OnPressDrawer.press(context),
                        ))
                    .animate()
                    .moveX(begin: EsaySize.width(context) / 3, end: 0),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.20, sigmaY: 3.2),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<DrawerCubit>(context).openDrawer();
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: EsaySize.width(context) / 3,
                        height: EsaySize.height(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (state.status is Close) {
          return Container(
            color: Colors.white,
            width: EsaySize.width(context) / 1.5,
            height: EsaySize.height(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/oops.jpg",
                  fit: BoxFit.contain,
                ),
                const Divider(color: Colors.black, thickness: 0.8, height: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: DrawerWidgets.fullItems(
                    context: context,
                    onpress: [() {}, () {}, () {}, () {}, () {}],
                  ),
                ),
              ],
            ),
          ).animate().moveX(
                begin: EsaySize.width(context) / 3,
                end: EsaySize.width(context),
              );
        }
        if (state.status is Init) {
          return const SizedBox();
        }
        return const SizedBox();
      },
    );
  }
}
