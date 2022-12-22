// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ispasswordmarched_cubit.dart';

class IspasswordmarchedState extends Equatable {
  final bool ispasswordmatched;
  final bool isValid;

  IspasswordmarchedState(
      {required this.ispasswordmatched, required this.isValid});

  factory IspasswordmarchedState.initial() {
    return IspasswordmarchedState(ispasswordmatched: true, isValid: false);
  }

  @override
  List<Object?> get props => [ispasswordmatched, isValid];

  IspasswordmarchedState copyWith({
    bool? ispasswordmatched,
    bool? isValid,
  }) {
    return IspasswordmarchedState(
      ispasswordmatched: ispasswordmatched ?? this.ispasswordmatched,
      isValid: isValid ?? this.isValid,
    );
  }
}
