import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _seconds = 0;

  TimerProvider() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      notifyListeners();
    });
  }

  int get seconds => _seconds;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
