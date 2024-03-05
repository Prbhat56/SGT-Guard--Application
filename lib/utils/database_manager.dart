
class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  DataManager._internal();

  String _data = '';

  String get data => _data;

  // This method allows you to set data asynchronously
  Future<void> setData(String newData) async {
    // Simulate an asynchronous operation (e.g., saving to Firebase)
    await Future.delayed(Duration(seconds: 1));

    // Set the data after the asynchronous operation completes
    _data = newData.toString();
  }
}
