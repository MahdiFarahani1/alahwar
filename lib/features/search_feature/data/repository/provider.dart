import 'package:dio/dio.dart';

class ApiSearchProvider {
  providerGet(
      {required int start,
      required String sw,
      required int sctitle,
      required int sctxt,
      required int categoryId}) async {
    var res = await Dio().get(
        "https://alahwar-tv.com/api/news/?start=$start&limit=20&sw=$sw&sctitle=$sctitle&sctxt=$sctxt&gid=$categoryId");

    return res;
  }
}
