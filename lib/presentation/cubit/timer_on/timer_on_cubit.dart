import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_on_state.dart';

class TimerOnCubit extends Cubit<TimerOnState> {
  TimerOnCubit() : super(TimerOnState.initial());

  void turnOffTimer() {
    emit(state.copyWith(istimerOn: false));
  }

  void turnOnTimer() {
    emit(state.copyWith(istimerOn: true));
  }
}
