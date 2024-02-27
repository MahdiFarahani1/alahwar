import 'package:dio/dio.dart';

class ApiNewsProvider {
  providerGet(int number, int categoryID) async {
    var res = await Dio().get(
        "https://alahwar-tv.com/api/news/?start=$number&limit=20&gid=$categoryID");

    return res;
  }

  providerPost(
    int id,
  ) async {
    var res =
        await Dio().post("https://alahwar-tv.com/api/news/content?id=$id");

    return res;
  }
}
