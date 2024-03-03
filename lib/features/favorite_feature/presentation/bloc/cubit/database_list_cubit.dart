import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/config/setupMain.dart';

part 'database_list_state.dart';

class DatabaseListCubit extends Cubit<DatabaseListState> {
  DatabaseListCubit() : super(DatabaseListState(dataBaseList: []));

  addList(int id) {
    List<int> newSet = state.dataBaseList;
    newSet.add(id);
    emit(state.copyWith(dataBaseList: newSet));
  }

  removeList(int id) {
    List<int> newSet = state.dataBaseList;
    newSet.remove(id);
    emit(state.copyWith(dataBaseList: newSet));
  }

  Future<void> loadSavedItems() async {
    List<int> loadList = [];

    loadList = saveBox.values.whereType<int>().toList();
    for (var element in saveBox.values) {
      print(element);
    }
    emit(state.copyWith(dataBaseList: loadList));
  }
}
