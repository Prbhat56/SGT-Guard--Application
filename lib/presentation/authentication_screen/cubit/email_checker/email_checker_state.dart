// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'email_checker_cubit.dart';

class EmailCheckerState extends Equatable {
  final bool isemailValid;
  EmailCheckerState({
    required this.isemailValid,
  });

  factory EmailCheckerState.initial() {
    return EmailCheckerState(isemailValid: true);
  }
  @override
  List<Object> get props => [isemailValid];

  EmailCheckerState copyWith({
    bool? isemailValid,
  }) {
    return EmailCheckerState(
      isemailValid: isemailValid ?? this.isemailValid,
    );
  }

  @override
  bool get stringify => true;
}
