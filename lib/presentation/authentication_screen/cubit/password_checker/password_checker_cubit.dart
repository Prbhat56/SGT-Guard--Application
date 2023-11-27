import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sgt/helper/validator.dart';

part 'password_checker_state.dart';

class PasswordCheckerCubit extends Cubit<PasswordCheckerState> {
  PasswordCheckerCubit() : super(PasswordCheckerState.initial());

  checkPassword(String password) {
    emit(state.copyWith(password: password.isValidPassword));
    // print(password);
  }
}
