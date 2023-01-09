import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'obscure_state.dart';

class ObscureCubit extends Cubit<ObscureState> {
  ObscureCubit() : super(ObscureState.initial());

  void changeVisibility() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void changeoldpasswordVisibility() {
    emit(state.copyWith(oldpasswordObscure: !state.oldpasswordObscure));
  }

  void changenewpasswordVisibility() {
    emit(state.copyWith(newpasswordObscure: !state.newpasswordObscure));
  }
}
