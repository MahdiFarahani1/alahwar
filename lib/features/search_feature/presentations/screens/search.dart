import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/item_news.dart';
import 'package:flutter_application_1/features/home_feature/repositories/format_date.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/search_cubit.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/status.dart';
import 'package:flutter_application_1/features/search_feature/repository/light_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

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
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controller.dispose();
    LightContent.swContent = "";
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

  void _validateForm() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<SearchCubit>(context).search(
          sw: textEditingController.text,
          categoryID: categoryID,
          sctitle: titleBool ? 1 : 0,
          sctxt: contentBool ? 1 : 0,
          start: 0);
    } else {
      BlocProvider.of<SearchCubit>(context).initPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarCommon.appBar("البحث", context, isSearchPage: true),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.status is LoadingSearch) {
                  return Column(
                    children: [
                      dropDown(context),
                      Expanded(
                          child: Center(
                              child: CostumLoading.fadingCircle(context))),
                    ],
                  );
                }
                if (state.status is InitSearch) {
                  return Column(
                    children: [
                      dropDown(context),
                    ],
                  );
                }
                if (state.status is ErrorSearch) {
                  return Column(
                    children: [
                      dropDown(context),
                      box(context, "There is a problem with your internet"),
                    ],
                  );
                }
                if (state.status is ComplateSearch) {
                  var view = state.news;

                  return Column(
                    children: [
                      dropDown(context),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: view.length,
                          itemBuilder: (context, index) {
                            String baseUrl =
                                "https://alahwar-tv.com/upload_list/medium/";

                            return ItemNews(
                              isSearch: true,
                              searchWord: textEditingController.text,
                              time: FormatData.result(view[index].dateTime!),
                              title: view[index].title!,
                              pathImages: "$baseUrl${view[index].img!}",
                              onTap: () {
                                LightContent.swContent =
                                    textEditingController.text;

                                Navigator.pushNamed(
                                  context,
                                  NewsMainPage.rn,
                                  arguments: view[index].id,
                                );
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
                      if (!state.hasNextPage) const SizedBox(),
                    ],
                  );
                }

                return Container();
              },
            )),
      ),
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
      decoration: commonDecor(),
      margin: const EdgeInsets.all(3),
      width: EsaySize.width(context) * 0.95,
      height: EsaySize.height(context) / 15,
      child: Row(children: [
        Expanded(
          child: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              onFieldSubmitted: (value) {
                _validateForm();
              },
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "البحث...",
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 15),
                contentPadding: const EdgeInsets.all(10),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              _validateForm();
            },
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Theme.of(context).highlightColor,
              size: 20,
            )),
      ]),
    );
  }

  Padding dropDown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: StatefulBuilder(builder: (context, setState) {
        return Container(
          color: Theme.of(context).primaryColorLight,
          width: EsaySize.width(context),
          height: EsaySize.height(context) * 0.18,
          child: Column(
            children: [
              EsaySize.safeGap(20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 40,
                    decoration: commonDecor(),
                    child: Row(
                      children: [
                        checkBox("النص", contentBool),
                        checkBox("العنوان", titleBool),
                        EsaySize.gap(5),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ConstColor.baseColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 2,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 40,
                    decoration: commonDecor(),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "التصنیف :",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: GFDropdown(
                            dropdownColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            underline: null,
                            border: BorderSide.none,
                            isExpanded: true,
                            dropdownButtonColor: Colors.transparent,
                            iconDisabledColor: ConstColor.baseColor,
                            iconEnabledColor: ConstColor.baseColor,
                            elevation: 0,
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("جمیع الأخبار",
                                            style: commonStyle(context)))),
                              ),
                              DropdownMenuItem(
                                value: 18,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("رياضة",
                                            style: commonStyle(context)))),
                              ),
                              DropdownMenuItem(
                                value: 19,
                                child: Center(
                                  child: FittedBox(
                                      child: Text("منوعات محلية وعالمية",
                                          style: commonStyle(context))),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 20,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("العراق والعالم",
                                            style: commonStyle(context)))),
                              ),
                              DropdownMenuItem(
                                value: 23,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("ذي قار",
                                            style: commonStyle(context)))),
                              ),
                              DropdownMenuItem(
                                value: 25,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("اقتصاد",
                                            style: commonStyle(context)))),
                              ),
                              DropdownMenuItem(
                                value: 26,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("ثقافة وفن",
                                            style: commonStyle(context)))),
                              ),
                              DropdownMenuItem(
                                value: 27,
                                child: Center(
                                    child: FittedBox(
                                        child: Text("محافظ",
                                            style: commonStyle(context)))),
                              ),
                            ],
                            value: categoryID,
                            onChanged: (value) {
                              categoryID = value!;
                              setState(
                                () {},
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              EsaySize.safeGap(20),
              input(context),
            ],
          ),
        );
      }),
    );
  }

  BoxDecoration commonDecor() {
    bool checkTheme = saveBox.get("switchTheme") ??
        MediaQuery.platformBrightnessOf(context) == Brightness.light;
    return BoxDecoration(
        color: checkTheme ? Colors.grey.shade300 : Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(6)));
  }

  Widget checkBox(String txt, bool val) {
    return SizedBox(
      height: EsaySize.height(context) / 15,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Text(
            txt,
            style:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: Transform.scale(
            scale: 0.75,
            child: Checkbox(
              side: BorderSide(color: ConstColor.baseColor),
              value: val,
              onChanged: (value) {
                setState(() {
                  val = value!;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  TextStyle commonStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!;
  }
}
