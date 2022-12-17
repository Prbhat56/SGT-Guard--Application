import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'islongpress_state.dart';

class IslongpressCubit extends Cubit<IslongpressState> {
  IslongpressCubit() : super(IslongpressState.initial());

  void addtoList(int index) {
    state.selectedChatTile.add(index);
   emit(state.copyWith(selectedChatTile: state.selectedChatTile));
    //emit(IslongpressState(selectedChatTile: state.selectedChatTile));
    print("added index --->${state.selectedChatTile}"); 
  }

  void removefromList(int index) {
    state.selectedChatTile.remove(index);
    emit(state.copyWith(selectedChatTile: state.selectedChatTile));
    print("removed index --->${state.selectedChatTile}");
  }

  void removeAll() {
    state.selectedChatTile.clear();
    emit(state.copyWith(selectedChatTile: state.selectedChatTile));
    print("removed all --->${state.selectedChatTile}");
  }
}
