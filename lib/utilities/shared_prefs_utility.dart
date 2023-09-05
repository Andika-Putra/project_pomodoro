import 'package:project_pomodoro/utilities/print_debug_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String? key;

  SharedPrefs({
    this.key,
  });
  static SharedPreferences? _sharedPrefs;

  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    PrintDebug()
        .printSharedPrefsInit("Shared Preferences is done initialized!");
  }

  String get getSharedPrefsValue => _sharedPrefs!.getString(key!) ?? "";

  void setSharedPrefs(String key, String value) {
    _sharedPrefs!.setString(key, value);
  }

  void deleteSharedPrefs(String key) {
    _sharedPrefs!.remove(key);
  }

  void clearSharedPrefs() {
    _sharedPrefs!.clear();
  }
}
