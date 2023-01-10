// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addwitness_cubit.dart';

class AddwitnessState extends Equatable {
  final int witness;
  AddwitnessState({
    required this.witness,
  });

  factory AddwitnessState.initial() {
    return AddwitnessState(witness: 1);
  }

  @override
  List<Object> get props => [witness];

  AddwitnessState copyWith({
    int? witness,
  }) {
    return AddwitnessState(
      witness: witness ?? this.witness,
    );
  }

  @override
  bool get stringify => true;
}
