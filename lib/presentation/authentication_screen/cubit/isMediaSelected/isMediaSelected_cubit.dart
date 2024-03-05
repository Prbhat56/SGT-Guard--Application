import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'isMediaSelected_state.dart';

class IsMediaSelectedCubit extends Cubit<IsMediaSelectedState> {
  IsMediaSelectedCubit() : super(IsMediaSelectedState.initial());

  void mediaSelected() {
    emit(state.copyWith(isMedias: true));
  }

  void mediaNotSelected() {
    emit(state.copyWith(isMedias: false));
  }
}
