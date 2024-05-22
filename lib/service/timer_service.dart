import 'package:flutter/material.dart';

class TimerChangeNotifier with ChangeNotifier {
  final bool istimerOn;
  TimerChangeNotifier({
    required this.istimerOn,
  });

  factory TimerChangeNotifier.initial() {
    return TimerChangeNotifier(istimerOn: false);
  }

  @override
  List<Object> get props => [istimerOn];

 

  @override
  bool get stringify => true;

  TimerChangeNotifier copyWith({
    bool? istimerOn,
  }) {
    return TimerChangeNotifier(
      istimerOn: istimerOn ?? this.istimerOn,
    );
  }
}
