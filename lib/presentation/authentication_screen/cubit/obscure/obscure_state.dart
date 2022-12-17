// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'obscure_cubit.dart';

class ObscureState extends Equatable {
  final bool isObscure;

  ObscureState({required this.isObscure});

  factory ObscureState.initial() {
    return ObscureState(isObscure: true);
  }

  @override
  String toString() => 'ObscureState(isObscure: $isObscure)';

  @override
  int get hashCode => isObscure.hashCode;

  @override
  List<Object?> get props => [isObscure];

  ObscureState copyWith({
    bool? isObscure,
  }) {
    return ObscureState(
      isObscure: isObscure ?? this.isObscure,
    );
  }
}
