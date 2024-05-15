import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'timer_on_state.dart';

class TimerOnCubit extends Cubit<TimerOnState> {
  TimerOnCubit() : super(TimerOnState.initial());

  void turnOffTimer() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('isTimer','1');
    emit(state.copyWith(istimerOn: false));
  }

  void turnOnTimer() async{
    emit(state.copyWith(istimerOn: true));
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('isTimer','0');
  }
}
