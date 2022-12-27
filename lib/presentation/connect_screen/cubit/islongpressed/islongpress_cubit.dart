import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'islongpress_state.dart';

class IslongpressCubit extends Cubit<IslongpressState> {
  IslongpressCubit() : super(IslongpressState.initial());

  void addtoList(int index) {
    var selectedTile = state.selectedChatTile;

    selectedTile.add(index);

    emit(state.copyWith(selectedChatTile: selectedTile));
    print("added index --->${state.selectedChatTile}");
  }

  void removefromList(int index) {
    emit(state.copyWith(
        selectedChatTile: state.selectedChatTile..remove(index)));
    print("removed index --->${state.selectedChatTile}");
  }

  void removeAll() {
    emit(state.copyWith(selectedChatTile: state.selectedChatTile..clear()));
    print("removed all --->${state.selectedChatTile}");
  }
}
