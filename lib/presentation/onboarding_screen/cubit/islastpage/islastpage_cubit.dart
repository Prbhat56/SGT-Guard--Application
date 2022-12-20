import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'islastpage_state.dart';

class IslastpageCubit extends Cubit<IslastpageState> {
  IslastpageCubit() : super(IslastpageState.initial());
  void lastpageChecker(int index) {
    emit(state.copyWith(isLastpage: index == 2));
  }
}
