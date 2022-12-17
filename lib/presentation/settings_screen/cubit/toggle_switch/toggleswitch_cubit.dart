import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggleswitch_state.dart';

class ToggleSwitchCubit extends Cubit<ToggleSwitchState> {
  ToggleSwitchCubit() : super(ToggleSwitchState.initial());

  void changingToggleSwitch() {
    emit(state.copyWith(isSwitched: !state.isSwitched));
  }
}
