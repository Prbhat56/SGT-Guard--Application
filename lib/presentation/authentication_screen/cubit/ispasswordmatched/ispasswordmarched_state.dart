// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ispasswordmarched_cubit.dart';

class IspasswordmarchedState extends Equatable {
  final bool ispasswordmatched;

  IspasswordmarchedState({required this.ispasswordmatched});

  factory IspasswordmarchedState.initial() {
    return IspasswordmarchedState(ispasswordmatched: true);
  }

  @override
  List<Object?> get props => [ispasswordmatched];

  IspasswordmarchedState copyWith({
    bool? ispasswordmatched,
  }) {
    return IspasswordmarchedState(
      ispasswordmatched: ispasswordmatched ?? this.ispasswordmatched,
    );
  }
}
