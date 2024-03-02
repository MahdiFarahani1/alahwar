import 'package:bloc/bloc.dart';

//part 'alert_cubit_state.dart';

class AlertCubit extends Cubit<bool> {
  AlertCubit() : super(true);

  changeAlertState(bool val) {
    final mystate = val;
    emit(mystate);
  }
}
