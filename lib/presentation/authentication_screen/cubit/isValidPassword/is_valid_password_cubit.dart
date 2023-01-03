import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sgt/helper/validator.dart';

part 'is_valid_password_state.dart';

class IsValidPasswordCubit extends Cubit<IsValidPasswordState> {
  IsValidPasswordCubit() : super(IsValidPasswordState.initial());

  void ispasswordValid(String password) {
    emit(state.copyWith(ispasswordvalid: password.isValidPassword));
  }
}
