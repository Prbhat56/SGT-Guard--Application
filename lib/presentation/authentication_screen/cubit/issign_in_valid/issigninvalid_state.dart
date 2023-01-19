part of 'issigninvalid_cubit.dart';

class IssigninvalidState extends Equatable {
  final bool issigninValid;
  IssigninvalidState({
    required this.issigninValid,
  });

  factory IssigninvalidState.initial() {
    return IssigninvalidState(issigninValid: false);
  }
  @override
  List<Object> get props => [issigninValid];

  IssigninvalidState copyWith({
    bool? issigninValid,
  }) {
    return IssigninvalidState(
      issigninValid: issigninValid ?? this.issigninValid,
    );
  }
}
