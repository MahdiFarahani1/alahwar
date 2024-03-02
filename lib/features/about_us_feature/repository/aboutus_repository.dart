import 'package:url_launcher/url_launcher_string.dart';

class AboutRepository {
  static const String urlYoutube = "https://www.youtube.com/@alahwartv";
  static const String urlTwitter =
      "https://twitter.com/tv_alahwar/status/1706027687410569267?s=52";
  static const String urlTelegram = "https://t.me/tv_alahwar/1116";
  static const String urlFacebook =
      "https://www.facebook.com/Alahwartv3?locale=ar_AR";
  static const String urlInstagram = "https://www.instagram.com/tv_ahwar/";
  static const String urlSite = "https://alahwar-tv.com/";

  static Future<void> launchUrl(String url) async {
    await launchUrlString(url);
  }
}
