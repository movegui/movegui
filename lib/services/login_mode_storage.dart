import 'package:shared_preferences/shared_preferences.dart';

class LoginModeStorage {
  static Future<void> saveLoginMode(int loginMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("loginMode", loginMode.toString());

  }

  static Future<int?> getLoginMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("loginMode");
  }
}