import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _localeKey = "locale";

  static Future<String> getLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey) ?? 'en';
  }

  static Future<bool> setLocale(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_localeKey, value);
  }
}