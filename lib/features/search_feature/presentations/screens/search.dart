import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/home.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/listview_builder_item.dart';
import 'package:flutter_application_1/features/home_feature/repositories/format_date.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/search_cubit.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  static String rn = "/Search";
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int categoryID = 0;
  bool titleBool = true;
  bool contentBool = true;
  late ScrollController controller;

  final TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    BlocProvider.of<SearchCubit>(context).initPage();
    textEditingController.clear();
    super.initState();
  }

  void _scrollListener() {
    BlocProvider.of<SearchCubit>(context).loadMore(
        controller: controller,
        sctitle: titleBool ? 1 : 0,
        sctxt: contentBool ? 1 : 0,
        sw: textEditingController.text,
        categoryID: categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCommon.appBar("Search"),
      backgroundColor: Colors.grey.shade900,
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state.status is LoadingSearch) {
                return Column(
                  children: [
                    dropDown(context),
                    input(context),
                    Expanded(
                        child: Center(child: CostumLoading.loadCube(context))),
                  ],
                );
              }
              if (state.status is InitSearch) {
                return Column(
                  children: [
                    dropDown(context),
                    input(context),
                  ],
                );
              }
              if (state.status is ErrorSearch) {
                return Column(
                  children: [
                    dropDown(context),
                    input(context),
                    box(context, "There is a problem with your internet"),
                  ],
                );
              }
              if (state.status is ComplateSearch) {
                var view = state.news;

                return Column(
                  children: [
                    dropDown(context),
                    input(context),
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: view.length,
                        itemBuilder: (context, index) {
                          String baseUrl =
                              "https://alahwar-tv.com/upload_list/medium/";

                          return ItemHome(
                            isSearch: true,
                            searchWord: textEditingController.text,
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
                    if (state.isLoadMoreRunning)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CostumLoading.fadingCircle(context),
                        ),
                      ),
                    if (!state.hasNextPage) const SizedBox.shrink(),
                  ],
                );
              }

              return Container();
            },
          )),
    );
  }

  Container box(BuildContext context, String txt) {
    return Container(
      height: EsaySize.height(context) / 15,
      width: double.infinity,
      margin: const EdgeInsets.all(3),
      alignment: Alignment.center,
      color: Colors.white,
      child: const Text(
        "Error",
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }

  Container input(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: double.infinity,
      height: EsaySize.height(context) / 15,
      color: Colors.white,
      child: Row(children: [
        IconButton(
            onPressed: () {
              BlocProvider.of<SearchCubit>(context).search(
                  sw: textEditingController.text,
                  sctitle: titleBool ? 1 : 0,
                  sctxt: contentBool ? 1 : 0,
                  start: 0,
                  categoryID: categoryID);
            },
            icon: const Icon(Icons.search)),
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              BlocProvider.of<SearchCubit>(context).search(
                  sw: textEditingController.text,
                  categoryID: categoryID,
                  sctitle: titleBool ? 1 : 0,
                  sctxt: contentBool ? 1 : 0,
                  start: 0);
            },
            controller: textEditingController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
          ),
        )
      ]),
    );
  }

  Padding dropDown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: StatefulBuilder(builder: (context, setState) {
        return Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EsaySize.safeGap(EsaySize.width(context) / 2),
              Container(
                height: EsaySize.height(context) / 15,
                color: Colors.white,
                child: DropdownButton<int>(
                  value: categoryID,
                  items: [
                    DropdownMenuItem(
                      value: 18,
                      child: Text(categotyMap[18]!),
                    ),
                    DropdownMenuItem(
                      value: 19,
                      child: FittedBox(child: Text(categotyMap[19]!)),
                    ),
                    DropdownMenuItem(
                      value: 20,
                      child: Text(categotyMap[20]!),
                    ),
                    DropdownMenuItem(
                      value: 23,
                      child: Text(categotyMap[23]!),
                    ),
                    DropdownMenuItem(
                      value: 25,
                      child: Text(categotyMap[25]!),
                    ),
                    DropdownMenuItem(
                      value: 26,
                      child: Text(categotyMap[26]!),
                    ),
                    DropdownMenuItem(
                      value: 27,
                      child: Text(categotyMap[27]!),
                    ),
                    DropdownMenuItem(
                      value: 0,
                      child: Text(categotyMap[0]!),
                    ),
                  ],
                  onChanged: (value) {
                    categoryID = value!;
                    setState(
                      () {},
                    );
                  },
                  dropdownColor: Colors.white,
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      checkBox("النص", context, (val) {
                        setState(
                          () {
                            contentBool = val!;
                          },
                        );
                      }, contentBool),
                      EsaySize.gap(3),
                      checkBox("العنوان", context, (val) {
                        setState(
                          () {
                            titleBool = val!;
                          },
                        );
                      }, titleBool),
                    ],
                  )),
            ],
          ),
        );
      }),
    );
  }

  Container checkBox(
      String txt, BuildContext context, Function(bool?)? onChanged, bool val) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      height: EsaySize.height(context) / 15,
      child: Row(children: [
        Checkbox(
          value: val,
          onChanged: onChanged,
        ),
        EsaySize.gap(5),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(txt),
        ),
      ]),
    );
  }
}
