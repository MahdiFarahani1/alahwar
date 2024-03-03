import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/config/setupMain.dart';

//part 'alert_cubit_state.dart';

class AlertCubit extends Cubit<bool> {
  AlertCubit() : super(true);

  Future<void> initialize() async {
    final bool myState = await saveBox.get("alert") ?? true;
    emit(myState);
  }

  changeAlertState(bool val) {
    final bool myState = val;
    emit(myState);
  }
}
