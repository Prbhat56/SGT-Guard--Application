// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'timer_on_cubit.dart';

class TimerOnState extends Equatable {
  final bool istimerOn;
  TimerOnState({
    required this.istimerOn,
  });

  factory TimerOnState.initial() {
    return TimerOnState(istimerOn: false);
  }

  @override
  List<Object> get props => [istimerOn];

 

  @override
  bool get stringify => true;

  TimerOnState copyWith({
    bool? istimerOn,
  }) {
    return TimerOnState(
      istimerOn: istimerOn ?? this.istimerOn,
    );
  }
}
