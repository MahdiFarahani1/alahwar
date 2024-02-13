import 'package:bloc/bloc.dart';

class IndicatorIndexCubit extends Cubit<int> {
  IndicatorIndexCubit() : super(0);

  changeIndicator(int index) {
    emit(index);
  }
}
