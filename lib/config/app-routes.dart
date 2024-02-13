import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/features/home_feature/presentations/screens/home.dart';
import 'package:flutter_application_1/features/splash_feature/presentations/screens/splash_failed.dart';

class RoutesApp {
  static Map<String, Widget Function(BuildContext)> routes = {
    Home.rn: (p0) => const Home(),
    SplashFailed.rn: (p0) => const SplashFailed(),
  };
}
