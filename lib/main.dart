import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/drawer_cubit/drawer_cubit.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/indicatror_cubit/indicator_index_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app-routes.dart';
import 'features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_cubit.dart';
import 'features/home_feature/presentations/bloc/news_cubit/news_home_cubit.dart';
import 'features/splash_feature/presentations/screens/splash-Main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
