// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'islongpress_cubit.dart';

// ignore: must_be_immutable
class IslongpressState extends Equatable {
  List<int> selectedChatTile;

  IslongpressState({required this.selectedChatTile});

  factory IslongpressState.initial() {
    return IslongpressState(selectedChatTile: []);
  }

  @override
  List<Object> get props => [selectedChatTile];

  @override
  bool get stringify => true;

  IslongpressState copyWith({
    List<int>? selectedChatTile,
  }) {
    return IslongpressState(
      selectedChatTile: selectedChatTile ?? this.selectedChatTile,
    );
  }
}
