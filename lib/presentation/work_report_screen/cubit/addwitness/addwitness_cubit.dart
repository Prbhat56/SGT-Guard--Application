import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'addwitness_state.dart';

class AddwitnessCubit extends Cubit<AddwitnessState> {
  AddwitnessCubit() : super(AddwitnessState.initial());

  addwitness() {
    emit(state.copyWith(witness: state.witness + 1));
  }
}
