import 'package:get/get.dart';
import 'package:sgt/presentation/cubit/gps_status/gps_controller.dart';

class LocationDependencyInjection {
  static void init() {
    // final GPSController gpsController = Get.put(GPSController());
    Get.put<GPSController>(GPSController(), permanent: true);
    
  }
}
