import 'package:bloc/bloc.dart';

enum ToggleMediaState { on, off }

class ToggleMediaCubit extends Cubit<ToggleMediaState> {
  ToggleMediaCubit() : super(ToggleMediaState.off);

  void toggle() {
    emit(state == ToggleMediaState.on
        ? ToggleMediaState.off
        : ToggleMediaState.on);
  }
}
