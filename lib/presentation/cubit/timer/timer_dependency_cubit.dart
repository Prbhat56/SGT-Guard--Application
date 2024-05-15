import 'package:get/get.dart';
import 'package:sgt/presentation/cubit/timer/timer_dependency_state.dart';

class TimerDependencyInjection {
  static void init() {
    Get.put<TimerController>(TimerController(), permanent: true);
  }
}
