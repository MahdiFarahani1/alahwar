import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/drawer_cubit/drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/drawer_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bloc/drawer_cubit/deawer_status.dart';

class Home extends StatelessWidget {
  static String rn = "/home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.objectColor,
      appBar: AppBar(
        backgroundColor: ConstColor.appbarColor,
        centerTitle: true,
        leading: IconButton(onPressed: () {



        }, icon: const Icon(Icons.search)),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<DrawerCubit>(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
        title: const Text("Alahvar"),
      ),
      body: BlocBuilder<IndicatorIndexCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              Stack(
                children: [
                  CarouselSlider(

                    items: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.red,
                      ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.purple,
                      ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.blue,
                      ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.green,
                      ),
                    ],
                    options: CarouselOptions(
                      
                      onPageChanged: (index, reason) {
                        BlocProvider.of<IndicatorIndexCubit>(context)
                            .changeIndicator(index);
                      },
                      autoPlay: true,
                      viewportFraction: 1,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                  ), 
                    ),
                  Positioned(
                      top: EsaySize.height(context) * 0.324,
                      left: EsaySize.width(context) /3,
                      right: EsaySize.width(context) /3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        height: 30,
                        child: AnimatedSmoothIndicator(
                            effect: WormEffect(
                                dotWidth: 12,
                                dotHeight: 12,
                                dotColor: Colors.white,
                                activeDotColor: ConstColor.appbarColor,
                                type: WormType.thin),
                            activeIndex: state,
                            count: 4),
                      )),
                         Center(
                           child: Container(
                        
                                        margin: EdgeInsets.only(bottom: EsaySize.height(context) / 8),
                                          width: double.infinity,
                                          height: 50,
                            child: ListView.builder( shrinkWrap: true,scrollDirection: Axis.horizontal, itemCount: 7,itemBuilder: (context, index) {
                              
                                          return  Container( margin: const EdgeInsets.all(10),width: 80,height: 50,     decoration: const BoxDecoration(color: Colors.redAccent, ),child: Text("index $index"),);
                                          },),
                                        
                                      ),
                         ),
                         ElevatedButton(onPressed: ()async{
  
try {
 

     final response = await Dio().get(
      'https://alahwar-tv.com/api/news',
      options: Options(
      headers: {
     'Access-Control-Allow-Origin': '*',
    },
      ),
    );

 
  if (response.statusCode == 200) {
   
    for (var news in response.data['news']) {
      print('عنوان: ${news['title']}\nمحتوا: ${news['content']}\n');
    }
  } else {

    print('خطا: ${response.statusCode}');
  }
} catch (e) {
  print(e);
}

 
 

                         }, child: null)
                ],
                
              ),
           
              BlocBuilder<DrawerCubit, DrawerState>(
                buildWhen: (previous, current) {
                  if (previous.status == current.status) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state.status is Open) {
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(seconds: 1),
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<DrawerCubit>(context)
                                  .openDrawer();
                            },
                            child: Container(
                              color: Colors.white,
                              width: EsaySize.width(context) / 1.5,
                              height: double.infinity,
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/images/oops.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  const Divider(
                                      color: Colors.black,
                                      thickness: 0.8,
                                      height: 2),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: DrawerWidgets.fullItems(
                                          context: context)),
                                ],
                              ),
                            ).animate().moveX(begin: EsaySize.width(context)),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 3.20, sigmaY: 3.2),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<DrawerCubit>(context)
                                      .openDrawer();
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
                    return AnimatedPositioned(
                      duration: const Duration(seconds: 1),
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
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
                            const Divider(
                                color: Colors.black, thickness: 0.8, height: 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:
                                  DrawerWidgets.fullItems(context: context),
                            ),
                          ],
                        ),
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
              ),
          
         
            ],
          );
        },
      ),
    );
  }
}


