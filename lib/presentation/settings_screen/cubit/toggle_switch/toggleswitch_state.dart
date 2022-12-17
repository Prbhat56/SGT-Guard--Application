// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'toggleswitch_cubit.dart';

class ToggleSwitchState extends Equatable {
  final bool isSwitched;

  ToggleSwitchState({required this.isSwitched});

  factory ToggleSwitchState.initial() {
    return ToggleSwitchState(isSwitched: false);
  }
  @override
  List<Object?> get props => [isSwitched];

  ToggleSwitchState copyWith({
    bool? isSwitched,
  }) {
    return ToggleSwitchState(
      isSwitched: isSwitched ?? this.isSwitched,
    );
  }

  @override
  bool get stringify => true;
}
