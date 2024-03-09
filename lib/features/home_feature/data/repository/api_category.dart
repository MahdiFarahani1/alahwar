import 'package:dio/dio.dart';

class ApiCategory {
  Future<dynamic> fetchData() async {
    var res = await Dio().get("https://alahwar-tv.com/api/news/category");

    return res;
  }
}
