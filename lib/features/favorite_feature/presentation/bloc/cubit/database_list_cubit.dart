import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/main.dart';

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

    for (var element in saveBox.values) {
      loadList.add(element);
    }

    // Update the state with the loaded list
    emit(state.copyWith(dataBaseList: loadList));
  }
}
