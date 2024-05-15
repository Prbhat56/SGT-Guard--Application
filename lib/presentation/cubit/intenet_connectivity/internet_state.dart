import 'package:get/get.dart';
import 'package:sgt/presentation/cubit/intenet_connectivity/internet_cubit.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
