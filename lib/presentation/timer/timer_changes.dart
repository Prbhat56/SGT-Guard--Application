import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValueController extends GetxController {
  var value = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    value.value = prefs.getInt('storedValue') ?? 0;
  }

  Future<void> updateValue(int newValue) async {
    final prefs = await SharedPreferences.getInstance();
    value.value = newValue;
    await prefs.setInt('storedValue', newValue);
  }
}
