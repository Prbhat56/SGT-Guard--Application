import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'issearching_state.dart';

class IssearchingCubit extends Cubit<IssearchingState> {
  IssearchingCubit() : super(IssearchingState.initial());

  void searchingChecker() {
    emit(state.copyWith(isSearching: !state.isSearching));
  }
}
