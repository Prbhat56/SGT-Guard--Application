import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'issigninvalid_state.dart';

class IssigninvalidCubit extends Cubit<IssigninvalidState> {
  IssigninvalidCubit() : super(IssigninvalidState.initial());

  checkSignIn(bool isvalid) {
    emit(state.copyWith(issigninValid: isvalid));
  }
}
