// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_checker_cubit.dart';

class PasswordCheckerState extends Equatable {
  final bool password;
  PasswordCheckerState({
    required this.password,
  });

  factory PasswordCheckerState.initial() {
    return PasswordCheckerState(password: true);
  }
  List<Object> get props => [password];

  PasswordCheckerState copyWith({
    bool? password,
  }) {
    return PasswordCheckerState(
      password: password ?? this.password,
    );
  }
}
