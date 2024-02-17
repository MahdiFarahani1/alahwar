import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/home_drawer_cubit/home_drawer_status.dart';
import 'package:meta/meta.dart';

part 'home_drawer_state.dart';

class HomeDrawerCubit extends Cubit<HomeDrawerState> {
  HomeDrawerCubit() : super(HomeDrawerState(status: InitHome()));

  changeState() {
    emit(HomeDrawerState(status: LoadingHome()));

    Future.delayed(const Duration(seconds: 1), () {
      emit(HomeDrawerState(status: DrawerHome()));
    });
  }
}
