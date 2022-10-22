import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {

  static void saveToken({String? tokenString}) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', tokenString!);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }


}