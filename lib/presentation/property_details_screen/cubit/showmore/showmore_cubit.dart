import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'showmore_state.dart';

class ShowmoreCubit extends Cubit<ShowmoreState> {
  ShowmoreCubit() : super(ShowmoreState.initial());

  void showMore() {
    emit(state.copyWith(showmore: true));
  }
}
