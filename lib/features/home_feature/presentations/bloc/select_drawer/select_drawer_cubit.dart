import 'package:bloc/bloc.dart';

part 'select_drawer_state.dart';

class SelectDrawerCubit extends Cubit<SelectDrawerState> {
  SelectDrawerCubit() : super(SelectDrawerState(selectedIndex: -1));

  void changeIndex(int index) {
    emit(SelectDrawerState(selectedIndex: index));
  }
}
