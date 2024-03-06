import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/core/common/gradient.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/favorite_feature/date/local/database.dart';
import 'package:flutter_application_1/features/favorite_feature/presentation/bloc/cubit/database_list_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/home_feature/presentations/widgets/item_news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/appbar.dart';

class Favorite extends StatefulWidget {
  static String rn = "/Favorite";

  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    if (saveBox.values.isNotEmpty) {
      BlocProvider.of<DatabaseListCubit>(context).loadSavedItems();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBarCommon.appBar(" قایمة المفضلة", context),
        body: BlocBuilder<DatabaseListCubit, DatabaseListState>(
          builder: (context, state) {
            if (state.dataBaseList.isEmpty) {
              return SizedBox(
                child: Container(
                  width: EsaySize.width(context),
                  height: 80,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(gradient: CostumGradient.linearBlue()),
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    "لا توجد بیانات تمت اضافتها للمفضلة",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.dataBaseList.length,
                itemBuilder: (context, index) {
                  var save = box.get(state.dataBaseList[index]);
                  if (save != null && save is ObjectDataBase) {
                    return ItemNews(
                      title: save.title,
                      time: save.dateTime,
                      pathImages: save.pathImage,
                      onTap: () {
                        Navigator.pushNamed(context, NewsMainPage.rn,
                            arguments: state.dataBaseList[index]);
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
