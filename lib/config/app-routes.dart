import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/features/about_us_feature/presentations/screens/about_us_page.dart';
import 'package:flutter_application_1/features/favorite_feature/presentation/screen/favorite.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/home.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/news_page.dart';
import 'package:flutter_application_1/features/search_feature/presentations/screens/search.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/screen/settings.dart';
import 'package:flutter_application_1/features/splash_feature/presentations/screens/splash-Main.dart';
import 'package:flutter_application_1/features/splash_feature/presentations/screens/splash_failed.dart';

class RoutesApp {
  static Map<String, Widget Function(BuildContext)> routes = {
    Home.rn: (p0) => Home(),
    SplashFailed.rn: (p0) => const SplashFailed(),
    AboutUs.rn: (p0) => const AboutUs(),
    Favorite.rn: (p0) => const Favorite(),
//    Mobasher.rn: (p0) => const Mobasher(),
    Search.rn: (p0) => const Search(),
    NewsMainPage.rn: (p0) => const NewsMainPage(),
    Setting.rn: (p0) => const Setting(),
    SplashMain.rn: (p0) => const SplashMain(),
  };
}
