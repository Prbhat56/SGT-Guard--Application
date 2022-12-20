import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ispasswordmarched_state.dart';

class IspasswordmarchedCubit extends Cubit<IspasswordmarchedState> {
  IspasswordmarchedCubit() : super(IspasswordmarchedState.initial());

  void passwordMatched() {
    emit(state.copyWith(ispasswordmatched: true));
  }

  void passwordnotMatched() {
    emit(state.copyWith(ispasswordmatched: false));
  }
}
