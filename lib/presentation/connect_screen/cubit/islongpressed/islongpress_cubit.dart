import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'islongpress_state.dart';

class IslongpressCubit extends Cubit<IslongpressState> {
  IslongpressCubit() : super(IslongpressState.initial());

  void addtoList(int index) {
    emit(state.copyWith(selectedChatTile: state.selectedChatTile..add(index)));
    print("added index --->${state.selectedChatTile}");
  }

  void removefromList(int index) {
    emit(state.copyWith(
        selectedChatTile: state.selectedChatTile..removeAt(index)));
    print("removed index --->${state.selectedChatTile}");
  }

  void removeAll() {
    emit(state.copyWith(selectedChatTile: state.selectedChatTile..clear()));
    print("removed all --->${state.selectedChatTile}");
  }
}
