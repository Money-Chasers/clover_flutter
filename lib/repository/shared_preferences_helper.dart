import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _localeKey = "locale";
  static const String _darkModeKey = "darkMode";

  static Future<Map<String, dynamic>> get getSettings async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'locale': prefs.getString(_localeKey) ?? 'en',
      'darkMode': prefs.getBool(_darkModeKey) ?? false,
    };
  }

  static Future<bool> setLocale(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_localeKey, value);
  }

  static Future<bool> setDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_darkModeKey, value);
  }
}
