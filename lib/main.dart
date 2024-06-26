import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/features/favorite_feature/presentation/bloc/cubit/database_list_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/click_news_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/select_drawer/select_drawer_cubit.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/search_cubit.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/alert_cubit/alert_cubit_cubit.dart';
import 'package:flutter_application_1/features/settings_feature/presentation/bloc/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app-routes.dart';
import 'features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'features/home_feature/presentations/bloc/news_cubit/news_home_cubit.dart';
import 'features/splash_feature/presentations/screens/splash-Main.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => IndicatorIndexCubit(),
          ),
          BlocProvider(
            create: (context) => NewsHomeCubit(),
          ),
          BlocProvider(
            create: (context) => HomeDrawerCubit(),
          ),
          BlocProvider(
            create: (context) => ClickNewsCubit(),
          ),
          BlocProvider(
            create: (context) => SearchCubit(),
          ),
          BlocProvider(
            create: (context) => DatabaseListCubit(),
          ),
          BlocProvider(
            create: (context) => AlertCubit(),
          ),
          BlocProvider(
            create: (context) => SelectDrawerCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: "/",
              routes: RoutesApp.routes,
              theme: state.themeData,
              home: const SplashMain(),
            );
          },
        ));
  }
}
