import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
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

    super.initState();
  }

  void _scrollListener() {
    BlocProvider.of<SearchCubit>(context).loadMore(
        controller: controller,
        sctitle: 1,
        sctxt: 0,
        sw: textEditingController.text);
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
                    if (!state.hasNextPage)
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color: Colors.amber,
                        child: const Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      ),
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
        "txt",
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
                  sctitle: 1,
                  sctxt: 1,
                  start: 0);
            },
            icon: const Icon(Icons.search)),
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              BlocProvider.of<SearchCubit>(context).search(
                  sw: textEditingController.text,
                  sctitle: 1,
                  sctxt: 1,
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
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EsaySize.safeGap(EsaySize.width(context) / 2),
            Expanded(
              child: Container(
                height: EsaySize.height(context) / 15,
                color: Colors.white,
                child: DropdownButton<String>(
                  value: "item1",
                  items: const [
                    DropdownMenuItem(
                      value: 'item1',
                      child: Text('آیتم 1'),
                    ),
                    DropdownMenuItem(
                      value: 'item2',
                      child: Text('آیتم 2'),
                    ),
                    DropdownMenuItem(
                      value: 'item3',
                      child: Text('آیتم 3'),
                    ),
                    DropdownMenuItem(
                      value: 'item4',
                      child: Text('آیتم 4'),
                    ),
                  ],
                  onChanged: (value) {},
                  dropdownColor: Colors.white,
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
                color: Colors.white,
                child: Row(
                  children: [
                    checkBox("cads", context),
                    EsaySize.gap(3),
                    checkBox("sadsa", context),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Container checkBox(String txt, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      height: EsaySize.height(context) / 15,
      child: Row(children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
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
