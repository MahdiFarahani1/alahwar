import 'package:flutter_application_1/features/home_feature/data/repository/api_category.dart';

extension StringEx on String {
  String titleFormatter() {
    String? updateTitle;
    if (length > 70) {
      String subTitle = substring(0, 70);
      updateTitle = subTitle;
      updateTitle += "...";
      return updateTitle;
    } else {
      return this;
    }
  }

  Future<String> getCategory(int id) async {
    var res = await ApiCategory().fetchData();
    var categories = res.data["categories"];

    for (var category in categories) {
      if (category["id"] == id) {
        return category["title"];
      }
    }
    return "";
  }
}
