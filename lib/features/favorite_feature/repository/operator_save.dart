import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/features/favorite_feature/date/local/database.dart';
import 'package:flutter_application_1/features/favorite_feature/presentation/bloc/cubit/database_list_cubit.dart';
import 'package:flutter_application_1/features/home_feature/data/model/click_news_model.dart';
import 'package:flutter_application_1/features/home_feature/repositories/format_date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorSave {
  static addDatabase(
      {required BuildContext context, required List<NewsPost> view}) {
    const String baseUrl = "https://alahwar-tv.com/upload_list/medium/";
    if (!saveBox.values.contains(view[0].id)) {
      saveBox.add(view[0].id);
    }

    box
        .put(
            view[0].id,
            ObjectDataBase(
                pathImage: '$baseUrl${view[0].img!}',
                title: view[0].title!,
                dateTime: FormatData.result(view[0].dateTime!)))
        .then((value) async {
      BlocProvider.of<DatabaseListCubit>(context).addList(view[0].id!);
    });
  }

  static deleteDatabsae(
      {required int id, required BuildContext context}) async {
    for (var value in saveBox.values) {
      if (value == id) {
        var keyToRemove = saveBox.keys
            .firstWhere((key) => saveBox.get(key) == value, orElse: () => null);
        if (keyToRemove != null) {
          saveBox.delete(keyToRemove);
        }
      }
    }

    box.delete(id).then((value) {
      BlocProvider.of<DatabaseListCubit>(context).removeList(id);
    });
  }
}
