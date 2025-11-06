import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String TOKEN_KEY = 'authToken';
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setString(key, value);
      print('LocalStorage: Setting $key with value: $value');
      return result;
    } catch (e) {
      print('LocalStorage: Error setting $key: $e');
      return false;
    }
  }

  static Future<String?> getString(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(key);
      print('LocalStorage: Getting $key - retrieved value: $value');
      return value;
    } catch (e) {
      print('LocalStorage: Error getting $key: $e');
      return null;
    }
  }

  // Token specific methods
  static Future<bool> saveToken(String token) async {
    final result = await setString(TOKEN_KEY, token);
    print('LocalStorage: Token save result: $result');
    return result;
  }

  static Future<String?> getToken() async {
    final token = await getString(TOKEN_KEY);
    print('LocalStorage: Retrieved token: $token');
    return token;
  }

  // Boolean operations
  static Future<bool?> getBool(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(key) ? prefs.getBool(key) : null;
    } catch (e) {
      print('LocalStorage: Error getting bool $key: $e');
      return null;
    }
  }

  static Future<bool> setBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setBool(key, value);
      print('LocalStorage: Setting bool $key to $value');
      return result;
    } catch (e) {
      print('LocalStorage: Error setting bool $key: $e');
      return false;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.remove(key);
      print('LocalStorage: Removed key: $key');
      return result;
    } catch (e) {
      print('LocalStorage: Error removing $key: $e');
      return false;
    }
  }

  // Clear all data
  static Future<bool> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.clear();
      print('LocalStorage: Cleared all data');
      return result;
    } catch (e) {
      print('LocalStorage: Error clearing data: $e');
      return false;
    }
  }
}
