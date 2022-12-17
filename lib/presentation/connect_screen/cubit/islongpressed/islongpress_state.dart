// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'islongpress_cubit.dart';

class IslongpressState extends Equatable {
  final List selectedChatTile;

  IslongpressState({required this.selectedChatTile});

  factory IslongpressState.initial() {
    return IslongpressState(selectedChatTile: []);
  }

  IslongpressState copyWith({
    List? selectedChatTile,
  }) {
    return IslongpressState(
      selectedChatTile: selectedChatTile ?? this.selectedChatTile,
    );
  }

  @override
  List<Object?> get props => [selectedChatTile];

  @override
  bool get stringify => true;
}
