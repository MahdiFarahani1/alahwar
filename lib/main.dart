import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/setupMain.dart';
import 'package:flutter_application_1/features/favorite_feature/presentation/bloc/cubit/database_list_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/click_news_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/drawer_cubit/drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'config/app-routes.dart';
import 'features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'features/home_feature/presentations/bloc/news_cubit/news_home_cubit.dart';
import 'features/splash_feature/presentations/screens/splash-Main.dart';

late Box box;
late Box saveBox;
Future<void> main() async {
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
          create: (context) => DrawerCubit(),
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: RoutesApp.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashMain(),
      ),
    );
  }
}
