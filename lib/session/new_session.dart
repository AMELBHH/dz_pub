import 'package:shared_preferences/shared_preferences.dart';

class   NewSession {
  static late SharedPreferences sp;

  static Future<void> init() async {
    sp = await SharedPreferences.getInstance();
  }
// Hypothetical example:
//   static Future<void> save(String key, String value) async {
//     // Implementation
//   }
  static Future<void> save<T>(String key, T value) async {
    if (value is String) {
      sp.setString(key, value);
    } else if (value is int) {
      sp.setInt(key, value);
    } else if (value is double) {
      sp.setDouble(key, value);
    } else if (value is bool) {
      sp.setBool(key, value);
    } else if (value is List<String>) {
      sp.setStringList(key, value); // This already handles List<String>
    } else {
      throw ArgumentError('Unsupported type');
    }
  }

  static T get<T>(String key, T def) {
    if (def is String) {
      return (sp.getString(key) ?? def) as T;
    } else if (def is int) {
      return (sp.getInt(key) ?? def) as T;
    } else if (def is double) {
      return (sp.getDouble(key) ?? def) as T;
    } else if (def is bool) {
      return (sp.getBool(key) ?? def) as T;
    } else if (def is List<String>) {
      return (sp.getStringList(key) ?? def) as T;
    } else {
      throw ArgumentError('Unsupported type');
    }
  }

  static void remove(String key) {
    sp.remove(key);
  }
}
