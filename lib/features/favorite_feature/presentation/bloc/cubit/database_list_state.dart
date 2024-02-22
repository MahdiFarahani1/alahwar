part of 'database_list_cubit.dart';

class DatabaseListState {
  final List<int> dataBaseList;

  DatabaseListState({required this.dataBaseList});

  DatabaseListState copyWith({List<int>? dataBaseList}) {
    return DatabaseListState(dataBaseList: dataBaseList ?? this.dataBaseList);
  }
}
