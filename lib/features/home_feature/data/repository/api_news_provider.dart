import 'package:dio/dio.dart';

class ApiNewsProvider {
  provider() async {
    var res = await Dio().get("https://alahwar-tv.com/api/news");

    return res;
  }
}

