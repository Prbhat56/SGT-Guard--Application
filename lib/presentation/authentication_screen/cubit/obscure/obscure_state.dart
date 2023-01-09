// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'obscure_cubit.dart';

class ObscureState extends Equatable {
  final bool isObscure;
  final bool oldpasswordObscure;
  final bool newpasswordObscure;
  ObscureState({
    required this.isObscure,
    required this.oldpasswordObscure,
    required this.newpasswordObscure,
  });

  factory ObscureState.initial() {
    return ObscureState(
        isObscure: true, oldpasswordObscure: true, newpasswordObscure: true);
  }

  @override
  String toString() => 'ObscureState(isObscure: $isObscure)';

  @override
  int get hashCode => isObscure.hashCode;

  @override
  List<Object?> get props =>
      [isObscure, oldpasswordObscure, newpasswordObscure];

  ObscureState copyWith({
    bool? isObscure,
    bool? oldpasswordObscure,
    bool? newpasswordObscure,
  }) {
    return ObscureState(
      isObscure: isObscure ?? this.isObscure,
      oldpasswordObscure: oldpasswordObscure ?? this.oldpasswordObscure,
      newpasswordObscure: newpasswordObscure ?? this.newpasswordObscure,
    );
  }
}
